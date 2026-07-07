-- Schema for Domain: risk | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`risk` COMMENT 'Manages actuarial risk assessment, underwriting, and risk adjustment programs — RAF scoring, HCC mapping, RAPS/EDPS submissions to CMS, RBC calculations, IBNR reserve estimation, and rate-setting inputs. Owns risk scores at the member level, underwriting decisions for group and individual markets, reinsurance/stop-loss arrangements, and premium rate development. Source system: Milliman MG-ALFA and actuarial models.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` (
    `member_risk_score_id` BIGINT COMMENT 'System-generated unique identifier for the member risk score record.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the risk score applies.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Member risk scores are calculated within the context of a risk pool.',
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
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: HCC mappings are applied per risk pool to reflect pool‑specific model versions.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who initiated the RAPS submission.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier of the health plan (contract) associated with the RAPS submission.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: RAPS submissions are filed for a specific risk pools members.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` (
    `rate_development_id` BIGINT COMMENT 'System-generated unique identifier for each rate development record.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Rate development factors are defined per risk pool; linking to pool enables aggregation and eliminates duplicated pool attributes.',
    `administrative_loading` DECIMAL(18,2) COMMENT 'Percentage added to cover administrative expenses.',
    `age_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor based on member age.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate was formally approved for use.',
    `base_rate` DECIMAL(18,2) COMMENT 'Fundamental rate before any rating factors are applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate development record was first created.',
    `credibility_factor` DECIMAL(18,2) COMMENT 'Weighting factor blending experience data with credibility.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `development_number` STRING COMMENT 'External reference number assigned to the rate development for tracking and regulatory filing.',
    `effective_date` DATE COMMENT 'Date when the approved rate becomes effective for premium calculations.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the rate ceases to be effective (nullable for open‑ended rates).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.plan.specificCost)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `final_approved_rate` DECIMAL(18,2) COMMENT 'Rate after all factors, loadings, and regulatory adjustments are applied.',
    `gender_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor based on member gender.',
    `geographic_factor` DECIMAL(18,2) COMMENT 'Factor reflecting cost differences across rating areas.',
    `group_size_factor` DECIMAL(18,2) COMMENT 'Factor based on the size of the employer group.',
    `industry_factor` DECIMAL(18,2) COMMENT 'Factor derived from the employers industry classification.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Business segment to which the rate applies (e.g., health, dental).. Valid values are `health|dental|vision|life|disability`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mlr_target` DECIMAL(18,2) COMMENT 'Regulatory MLR target percentage for the product.',
    `notes` STRING COMMENT 'Free‑form comments or rationale entered by actuaries.',
    `plan_type` STRING COMMENT 'Type of insurance plan for which the rate is calculated.. Valid values are `HMO|PPO|EPO|POS|HDHP`',
    `plan_type_loading` DECIMAL(18,2) COMMENT 'Additional loading applied for specific plan designs.',
    `profit_margin` DECIMAL(18,2) COMMENT 'Target profit margin applied to the rate.',
    `rate_development_status` STRING COMMENT 'Current lifecycle status of the rate development record.. Valid values are `draft|pending|approved|rejected|active|inactive`',
    `rate_methodology` STRING COMMENT 'Method used to calculate the rate (e.g., community rating, experience rating, blended).. Valid values are `community|experience|blended`',
    `rating_area` STRING COMMENT 'Geographic region used in rating calculations.',
    `rating_period_end` DATE COMMENT 'Last day of the rating period for which the rate is being developed.',
    `rating_period_start` DATE COMMENT 'First day of the rating period for which the rate is being developed.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_filing_reference` STRING COMMENT 'Identifier of the state or federal filing associated with this rate.',
    `tobacco_factor` DECIMAL(18,2) COMMENT 'Factor applied for tobacco use status.',
    `trend_factor` DECIMAL(18,2) COMMENT 'Factor used to project future cost trends.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate development record.',
    `version_number` STRING COMMENT 'Sequential version of the rate development record for change tracking.',
    CONSTRAINT pk_rate_development PRIMARY KEY(`rate_development_id`)
) COMMENT 'Captures actuarial rate development records and their constituent rating factors for premium rate-setting across plan types, market segments, and rating areas. Stores rate development ID, rating period, LOB, plan type, geographic rating area, base rate, and all applicable rating factors (age/gender, geographic area, tobacco use, group size, industry, plan-type loading). Includes trend factor application, credibility-weighted experience blending, administrative loading, profit margin, MLR target, final approved rate, and regulatory filing reference. Supports ACA community rating and experience rating methodologies. Source: Milliman MG-ALFA rate-setting models. Links to state DOI rate filings.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` (
    `ibnr_reserve_id` BIGINT COMMENT 'Primary key for ibnr_reserve',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: IBNR reserve estimates are calculated per risk pool; linking provides context and allows roll‑up.',
    `actuarial_confidence_level` DECIMAL(18,2) COMMENT 'Confidence level (e.g., 0.95) associated with the interval.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the actuarial confidence interval for the IBNR estimate.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the actuarial confidence interval for the IBNR estimate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reserve record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score indicating quality of input data used for reserve.',
    `development_factor` DECIMAL(18,2) COMMENT 'Factor applied to projected losses to estimate ultimate cost.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expected_loss_ratio` DECIMAL(18,2) COMMENT 'Projected loss ratio used in reserve calculation.',
    `external_reserve_code` STRING COMMENT 'Identifier used by external actuarial systems to reference this reserve.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `forecast_horizon_months` STRING COMMENT 'Number of months ahead the reserve projection covers.',
    `hcc_weighted_amount` DECIMAL(18,2) COMMENT 'IBNR amount weighted by Hierarchical Condition Category risk scores.',
    `ibnr_amount` DECIMAL(18,2) COMMENT 'Estimated Incurred But Not Reported reserve amount in USD.',
    `ibnr_pmpm` DECIMAL(18,2) COMMENT 'IBNR reserve expressed on a per member per month basis.',
    `ibnr_reserve_status` STRING COMMENT 'Current lifecycle status of the reserve estimate.. Valid values are `draft|approved|finalized|revised`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT 'Code representing the line of business for which the reserve is calculated.. Valid values are `Medical|Dental|Vision|Pharmacy|Behavioral`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free-text comments or rationale for the reserve estimate.',
    `plan_type` STRING COMMENT 'Type of health insurance plan associated with the reserve.. Valid values are `HMO|PPO|EPO|POS|HDHP`',
    `raps_submission_flag` BOOLEAN COMMENT 'Indicates if the reserve is included in RAPS submission to CMS.',
    `rbc_impact_amount` DECIMAL(18,2) COMMENT 'Impact of the reserve on Risk Based Capital calculations.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the reserve is required for regulatory reporting (e.g., GAAP, RBC).',
    `reserve_adequacy_flag` STRING COMMENT 'Assessment of whether the reserve is adequate.. Valid values are `adequate|marginal|inadequate`',
    `reserve_methodology` STRING COMMENT 'Actuarial method used to calculate the IBNR reserve.. Valid values are `chain_ladder|bornhuetter_ferguson|cape_cod|frequency_severity`',
    `reserve_name` STRING COMMENT 'Human‑readable name or label for the reserve estimate.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor applied to adjust reserve for risk considerations.',
    `service_month` DATE COMMENT 'Month of service for which the IBNR reserve is estimated (first day of month).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reserve record.',
    `valuation_date` DATE COMMENT 'Date on which the reserve estimate was calculated.',
    `version_number` STRING COMMENT 'Version of the reserve estimate for the same valuation date.',
    CONSTRAINT pk_ibnr_reserve PRIMARY KEY(`ibnr_reserve_id`)
) COMMENT 'Stores Incurred But Not Reported (IBNR) reserve estimates by LOB, plan type, service month, and valuation date. Captures reserve methodology (chain-ladder, Bornhuetter-Ferguson, Cape Cod), development factors, expected loss ratios, IBNR amount, IBNR PMPM, actuarial confidence interval, and reserve adequacy assessment. Generated from Milliman MG-ALFA reserving models. Critical for financial close, SAP/GAAP reporting, and RBC calculations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` (
    `reinsurance_arrangement_id` BIGINT COMMENT 'System-generated unique identifier for the reinsurance arrangement record.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the reinsurer in the master party table.',
    `aggregate_attachment_amount` DECIMAL(18,2) COMMENT 'Monetary threshold for aggregate stop‑loss coverage.',
    `aggregate_attachment_factor` DECIMAL(18,2) COMMENT 'Percentage of aggregate losses that must be reached before the reinsurer pays.',
    `arrangement_number` STRING COMMENT 'External contract number assigned by the insurer or reinsurer to identify the treaty.',
    `attachment_point` DECIMAL(18,2) COMMENT 'Loss amount threshold at which the reinsurer begins to pay.',
    `attachment_point_currency` STRING COMMENT 'ISO 4217 currency code for the attachment point amount.. Valid values are `^[A-Z]{3}$`',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Proportion of losses the reinsurer pays after the attachment point.',
    `corridor_percentage` DECIMAL(18,2) COMMENT 'Percentage range defining the corridor where losses are shared between insurer and reinsurer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reinsurance arrangement record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the reinsurance coverage becomes binding.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the reinsurance coverage terminates; null for open‑ended treaties.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_coverage` STRING COMMENT 'Business line(s) to which the reinsurance treaty applies.. Valid values are `medical|dental|vision|pharmacy|hospital|rx`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `maximum_liability` DECIMAL(18,2) COMMENT 'Upper limit of the reinsurers liability under the treaty.',
    `maximum_recovery_limit` DECIMAL(18,2) COMMENT 'Cap on the total amount the insurer can recover from the reinsurer.',
    `premium_ceded` DECIMAL(18,2) COMMENT 'Premium amount transferred to the reinsurer for the treaty.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reinsurance_arrangement_status` STRING COMMENT 'Current lifecycle state of the reinsurance treaty.. Valid values are `draft|active|suspended|terminated|expired`',
    `reinsurer_name` STRING COMMENT 'Legal name of the reinsurer party to the arrangement.',
    `specific_deductible` DECIMAL(18,2) COMMENT 'Deductible applied to each individual claim under a specific stop‑loss treaty.',
    `stop_loss_deductible` DECIMAL(18,2) COMMENT 'Deductible applied before stop‑loss coverage becomes payable.',
    `stop_loss_limit` DECIMAL(18,2) COMMENT 'Maximum amount the reinsurer will pay under the stop‑loss arrangement.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'Loss amount that triggers stop‑loss coverage.',
    `stop_loss_type` STRING COMMENT 'Indicates whether the stop‑loss is specific per‑member or aggregate across a group.. Valid values are `specific|aggregate`',
    `treaty_terms` STRING COMMENT 'Narrative description of the treatys contractual terms and conditions.',
    `treaty_type` STRING COMMENT 'Type of reinsurance treaty governing the risk transfer.. Valid values are `quota_share|excess_of_loss|aggregate_stop_loss|specific_stop_loss`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reinsurance arrangement record.',
    CONSTRAINT pk_reinsurance_arrangement PRIMARY KEY(`reinsurance_arrangement_id`)
) COMMENT 'Master record for reinsurance and stop-loss arrangements protecting the health plan against catastrophic or excess losses. Captures treaty type (quota share, excess of loss, aggregate stop-loss, specific stop-loss), reinsurer name, attachment point, specific deductible amount, aggregate attachment factor and amount, corridor percentage, maximum liability, coinsurance percentage, maximum recovery limit, premium ceded, effective and expiration dates, LOB coverage, and treaty terms. Includes stop-loss threshold parameters for self-insured employer groups. Supports both individual specific stop-loss and aggregate stop-loss for self-insured groups.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` (
    `reinsurance_claim_id` BIGINT COMMENT 'System-generated unique identifier for the reinsurance claim record.',
    `header_id` BIGINT COMMENT '',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the claimant (member or group) for whom the reinsurance claim is filed.',
    `reinsurance_arrangement_id` BIGINT COMMENT 'Foreign key linking to risk.reinsurance_arrangement. Business justification: Reinsurance claims belong to a specific reinsurance arrangement; replace free‑text reference with FK.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the reinsurer acknowledged receipt of the claim.',
    `attachment_point_amount` DECIMAL(18,2) COMMENT 'Attachment point amount applied to the loss before reinsurance coverage kicks in.',
    `claim_number` STRING COMMENT 'External claim number assigned by the reinsurer.',
    `claim_status` STRING COMMENT 'Current processing status of the reinsurance claim.. Valid values are `open|closed|cancelled|pending`',
    `claim_type` STRING COMMENT 'Type of reinsurance claim: stop‑loss (aggregate) or specific loss.. Valid values are `stop_loss|specific`',
    `claimant_type` STRING COMMENT 'Indicates whether the claimant is an individual member or an employer group.. Valid values are `member|group`',
    `covered_end_date` DATE COMMENT 'End date of the coverage period for which the loss occurred.',
    `covered_start_date` DATE COMMENT 'Start date of the coverage period for which the loss occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_aggregated` BOOLEAN COMMENT 'Indicates whether this claim aggregates multiple underlying losses (true) or represents a single loss (false).',
    `loss_category` STRING COMMENT 'Category of loss underlying the claim.. Valid values are `medical|dental|vision|pharmacy|hospital|other`',
    `loss_description` STRING COMMENT 'Narrative description of the loss event leading to the reinsurance claim.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes entered by claims adjusters.',
    `payment_received_timestamp` TIMESTAMP COMMENT 'Date and time when payment was received from the reinsurer.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recoverable_amount` DECIMAL(18,2) COMMENT 'Amount recoverable from the reinsurer after applying attachment point and limits.',
    `recovery_status` STRING COMMENT 'Status of the recovery payment from the reinsurer.. Valid values are `pending|approved|rejected|paid`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Flag indicating if the claim must be reported to regulatory bodies (e.g., CMS).',
    `reporting_period` STRING COMMENT 'Financial reporting period associated with the claim.. Valid values are `Q1|Q2|Q3|Q4|Annual`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the reinsurance claim was submitted to the reinsurer.',
    `total_incurred_amount` DECIMAL(18,2) COMMENT 'Total incurred loss amount before applying reinsurance terms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim record.',
    CONSTRAINT pk_reinsurance_claim PRIMARY KEY(`reinsurance_claim_id`)
) COMMENT 'Transactional record of reinsurance recoveries and stop-loss claims submitted to reinsurers. Captures reinsurance claim number, arrangement reference, claimant (member or group), covered period, total incurred amount, attachment point applied, recoverable amount, submission date, reinsurer acknowledgment, payment received date, and recovery status. Tracks both specific and aggregate stop-loss recovery transactions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` (
    `rbc_calculation_id` BIGINT COMMENT 'System-generated unique identifier for each RBC calculation record.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: RBC calculations are performed per risk pool; FK creates proper hierarchy.',
    `action_threshold_status` STRING COMMENT 'Indicator of which regulatory threshold category the calculated RBC falls into.. Valid values are `no_action|company_action|regulatory_action|authorized_control|mandatory_control`',
    `authorized_control_level_rbc` DECIMAL(18,2) COMMENT 'RBC amount threshold that triggers authorized control actions by regulators.',
    `calculation_method` STRING COMMENT 'Methodology used for the RBC calculation (standard NAIC formula or custom adaptation).. Valid values are `standard|custom`',
    `calculation_number` STRING COMMENT 'External business reference number assigned to the RBC calculation for reporting and audit purposes.',
    `calculation_period_end_date` DATE COMMENT 'Last day of the regulatory reporting period covered by this RBC calculation.',
    `calculation_period_start_date` DATE COMMENT 'First day of the regulatory reporting period covered by this RBC calculation.',
    `calculation_timestamp` TIMESTAMP COMMENT 'Exact date and time when the RBC calculation was performed.',
    `company_action_level_rbc` DECIMAL(18,2) COMMENT 'RBC amount threshold at which the company must take corrective action.',
    `company_code` BIGINT COMMENT 'Identifier of the insurance company for which the RBC calculation is performed.',
    `covariance_adjustment` DECIMAL(18,2) COMMENT 'Adjustment applied to account for covariance among risk components.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RBC calculation record was first created in the data warehouse.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `h0_asset_risk` DECIMAL(18,2) COMMENT 'Risk charge component for asset risk (H0) as defined by NAIC.',
    `h1_underwriting_risk` DECIMAL(18,2) COMMENT 'Risk charge component for underwriting/insurance risk (H1).',
    `h2_credit_risk` DECIMAL(18,2) COMMENT 'Risk charge component for credit risk (H2).',
    `h3_business_risk` DECIMAL(18,2) COMMENT 'Risk charge component for business risk (H3).',
    `h4_admin_expense_risk` DECIMAL(18,2) COMMENT 'Risk charge component for administrative expense risk (H4).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free-text field for any additional comments or explanations related to the calculation.',
    `rbc_ratio` DECIMAL(18,2) COMMENT 'Ratio of total risk charges to total adjusted capital, expressed as a decimal.',
    `rbc_status` STRING COMMENT 'Regulatory status resulting from the RBC calculation indicating required action level.. Valid values are `no_action|company_action|regulatory_action|authorized_control|mandatory_control`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `total_adjusted_capital` DECIMAL(18,2) COMMENT 'Aggregate adjusted capital amount used as the denominator in the RBC ratio.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the RBC calculation record.',
    CONSTRAINT pk_rbc_calculation PRIMARY KEY(`rbc_calculation_id`)
) COMMENT 'Risk-Based Capital (RBC) calculation records per NAIC RBC formula for health organizations (HRBC). Captures calculation period, company action level RBC, authorized control level RBC, total adjusted capital (TAC), RBC ratio, component risk charges (H0 asset risk, H1 insurance/underwriting risk, H2 credit risk, H3 business risk, H4 administrative expense risk), covariance adjustment, and regulatory action threshold status (no action, company action, regulatory action, authorized control, mandatory control). Required for annual state DOI regulatory reporting and NAIC financial statement filing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` (
    `adjustment_payment_id` BIGINT COMMENT 'Primary key for adjustment_payment',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Adjustment payments must be approved by a finance employee; approval audit requires linking to employee.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan or contract associated with the payment.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose risk adjustment is being recorded.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Adjustment payments are associated with the pool that generated the risk score; linking enables pool‑level reporting.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Amount of any adjustments, fees, or offsets applied to the gross payment.',
    `adjustment_reason_code` STRING COMMENT 'Standard code indicating why an adjustment was made (e.g., coding error, audit correction).',
    `adjustment_reason_description` STRING COMMENT 'Human‑readable description of the adjustment reason.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Exact timestamp of the business event that generated the payment record.',
    `cms_notification_date` DATE COMMENT 'Date CMS notified the payer of the risk adjustment amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the payment (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PaymentReconciliation)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before any adjustments or fees.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the payment record.. Valid values are `draft|submitted|processed|closed|cancelled`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after adjustments; the amount actually transferred or charged.',
    `payment_effective_date` DATE COMMENT 'Date the payment becomes effective for accounting and reporting.',
    `payment_method` STRING COMMENT 'Mechanism used to transfer the payment.. Valid values are `electronic_fund_transfer|check|wire`',
    `payment_source` STRING COMMENT 'Entity that originated the payment.. Valid values are `CMS|Internal|Third_Party`',
    `payment_status` STRING COMMENT 'Current processing status of the payment.. Valid values are `pending|received|reconciled|rejected|adjusted`',
    `payment_type` STRING COMMENT 'Indicates whether the record represents a receipt (inflow) or a charge (outflow).. Valid values are `receipt|charge`',
    `payment_year` STRING COMMENT 'Calendar year for which the risk adjustment payment applies.',
    `processing_date` DATE COMMENT 'Date the payment was processed in the internal system.',
    `program_type` STRING COMMENT 'CMS program under which the payment is made: ACA risk adjustment, Medicare Advantage, reinsurance, or cost sharing reduction.. Valid values are `ACA_Risk_Adjustment|Medicare_Advantage|Reinsurance|CSR`',
    `reconciliation_flag` BOOLEAN COMMENT 'True if the payment has been reconciled with accounting records.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk adjustment score (e.g., RAF) used to calculate the payment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_adjustment_payment PRIMARY KEY(`adjustment_payment_id`)
) COMMENT 'Records CMS risk adjustment transfer payments and charges for ACA marketplace and Medicare Advantage programs. Captures payment year, program type (ACA RA, MA risk adjustment, reinsurance, CSR), plan/contract identifier, risk score used, transfer payment amount (receipt or charge), CMS notification date, payment effective date, and reconciliation status. Tracks both interim and final risk adjustment settlements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` (
    `prospective_risk_model_id` BIGINT COMMENT 'System-generated unique identifier for each prospective risk model configuration record.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the business unit or individual responsible for the model.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Prospective risk model runs are scoped to a specific risk pool.',
    `cms_model_year` STRING COMMENT 'Calendar year of the CMS model specification that the risk model implements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the model record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `prospective_risk_model_description` STRING COMMENT 'Free‑text description of the model purpose, assumptions, and scope.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the model configuration becomes effective for scoring.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the model configuration is retired or superseded (nullable).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `input_period_end` DATE COMMENT 'Last calendar date of the source data window used for the model run.',
    `input_period_start` DATE COMMENT 'First calendar date of the source data window used for the model run.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_production` BOOLEAN COMMENT 'Indicates whether the model is approved for production use.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this model configuration.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `model_category` STRING COMMENT 'Higher‑level grouping of the model (e.g., actuarial, underwriting, risk‑adjustment).',
    `model_code` STRING COMMENT 'Business identifier or catalog code assigned to the model for reference in downstream systems.',
    `model_name` STRING COMMENT 'Human‑readable name of the risk model (e.g., "CMS HCC 2024 Model").',
    `model_status` STRING COMMENT 'Current lifecycle status of the model configuration.. Valid values are `active|inactive|draft|pending|deprecated`',
    `normalization_factor` DECIMAL(18,2) COMMENT 'Scalar applied to model outputs to align with enterprise scoring conventions.',
    `population_segment` STRING COMMENT 'Target member segment for which the model is run.. Valid values are `Medicare|Medicaid|Commercial|EmployerGroup`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_model_type` STRING COMMENT 'Classification of the actuarial model methodology.. Valid values are `CMS-HCC|RxHCC|HHS-HCC|CDPS`',
    `risk_score_max` DECIMAL(18,2) COMMENT 'Upper bound of the score range produced by the model.',
    `risk_score_min` DECIMAL(18,2) COMMENT 'Lower bound of the score range produced by the model.',
    `run_date` DATE COMMENT 'Date on which the model execution was initiated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the model record.',
    `version_number` STRING COMMENT 'Version string of the model configuration (e.g., "v1.3.0").',
    CONSTRAINT pk_prospective_risk_model PRIMARY KEY(`prospective_risk_model_id`)
) COMMENT 'Stores prospective risk model configurations and run parameters used to generate member-level risk scores. Captures model name, model version, CMS model year, risk model type (CMS-HCC, RxHCC, HHS-HCC, CDPS), population segment (Medicare, Medicaid, Commercial), run date, input data period, normalization factor, and model status. Manages the actuarial model catalog used in Milliman MG-ALFA for risk score production runs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`score_run` (
    `score_run_id` BIGINT COMMENT 'Primary key for score_run',
    `employee_id` BIGINT COMMENT 'Identifier of the actuarial professional who approved the run.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Score runs are executed for a specific risk pool; linking enables traceability.',
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
    `employee_id` BIGINT COMMENT 'User identifier of the analyst who created the audit record.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose records were sampled for the audit.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: RADV audits are performed on members within a risk pool; linking provides pool context.',
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
    `contract_number` STRING COMMENT 'Identifier of the Medicare Advantage contract subject to the RADV audit.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`pool` (
    `pool_id` BIGINT COMMENT 'Primary key for pool',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each risk pool must comply with defined regulatory obligations (e.g., ACA, state regulations); compliance reporting tracks this link.',
    `reinsurance_arrangement_id` BIGINT COMMENT 'Identifier of the reinsurance or stop‑loss arrangement linked to the pool.',
    `aca_compliance_flag` BOOLEAN COMMENT 'Indicates whether the pool meets ACA 45 CFR 156.80 single‑risk‑pool requirements.',
    `average_risk_score` DECIMAL(18,2) COMMENT 'Mean risk score (e.g., RAF) for members in the pool.',
    `pool_code` STRING COMMENT 'Business code used to reference the risk pool in external systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the risk‑pool record was first created in the source system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_source_timestamp` TIMESTAMP COMMENT 'Timestamp of the source record in the originating system.',
    `effective_date` DATE COMMENT 'Date on which the risk pool becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_scope` STRING COMMENT 'Three‑letter country code representing the geographic coverage of the pool.. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_excluded_from_mlr` BOOLEAN COMMENT 'True if the pool is excluded from Medical Loss Ratio calculations.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or actuarial review of the pool.',
    `line_of_business` STRING COMMENT 'Business line to which the pool belongs.. Valid values are `individual|group|medicare|medicaid|exchange`',
    `market_segment` STRING COMMENT 'Segment of the market that the pool serves.. Valid values are `commercial|government|individual|small_group|large_group`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_months` BIGINT COMMENT 'Cumulative member‑months contributed to the pool during its life.',
    `pool_name` STRING COMMENT 'Descriptive name of the risk pool.',
    `notes` STRING COMMENT 'Free‑form comments or annotations about the pool.',
    `pmpm` DECIMAL(18,2) COMMENT 'Average cost per member per month for the pool.',
    `pool_status` STRING COMMENT 'Current lifecycle status of the risk pool.. Valid values are `active|inactive|closed|pending|suspended`',
    `pool_type` STRING COMMENT 'Classification of the pool based on composition and market segment.. Valid values are `single|merged|small_group|large_group|individual`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_basis` STRING COMMENT 'Regulatory framework governing the pool (e.g., ACA, CMS, State law).. Valid values are `ACA|CMS|State`',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor applied for risk‑adjustment calculations (e.g., RAF multiplier).',
    `risk_pool_version` STRING COMMENT 'Version number for the pool definition, incremented on each change.',
    `risk_score_stddev` DECIMAL(18,2) COMMENT 'Statistical dispersion of risk scores within the pool.',
    `state_code` STRING COMMENT 'Two‑letter state abbreviation for pools limited to a single state.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date on which the risk pool is terminated or expires (nullable).',
    `total_incurred_claims` DECIMAL(18,2) COMMENT 'Aggregate dollar amount of claims incurred by members in the pool.',
    `total_paid_claims` DECIMAL(18,2) COMMENT 'Aggregate dollar amount of claims paid out from the pool.',
    `total_reserve_amount` DECIMAL(18,2) COMMENT 'Reserve dollars set aside for future claim payments within the pool.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the risk‑pool record.',
    `created_by` STRING COMMENT 'User or process that created the risk‑pool record.',
    CONSTRAINT pk_pool PRIMARY KEY(`pool_id`)
) COMMENT 'Defines risk pools used for rate development, experience rating, MLR calculation, and ACA risk adjustment transfer calculations. Captures pool name, pool type (single risk pool, merged market, small group, large group, individual), LOB, market segment, geographic scope, effective date, member months, total incurred claims, pool PMPM, and regulatory basis. Tracks ACA single risk pool compliance per 45 CFR 156.80. Supports state-level market reform pool configurations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` (
    `actuarial_assumption_set_id` BIGINT COMMENT 'System-generated unique identifier for each actuarial assumption set.',
    `rate_development_id` BIGINT COMMENT 'add column rate_development_id (BIGINT) with FK to risk.rate_development.rate_development_id - assumptions drive rate development',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Actuarial assumption sets are often defined per risk pool for rate development.',
    `actuarial_assumption_set_status` STRING COMMENT 'Current lifecycle state of the assumption set.. Valid values are `draft|active|inactive|retired|pending_approval`',
    `actuarial_assumption_set_type` STRING COMMENT 'Category of assumptions contained in the set.. Valid values are `trend|loss_development|credibility|mortality|lapse|pharmacy_trend`',
    `actuarial_signoff_date` DATE COMMENT 'Date the senior actuary signed off on the assumptions.',
    `actuarial_signoff_name` STRING COMMENT 'Name of the senior actuary who approved the assumption set.',
    `approval_date` DATE COMMENT 'Date the assumption set received final governance approval.',
    `actuarial_assumption_set_code` STRING COMMENT 'External code used in reporting and model documentation to reference the assumption set.',
    `compound_trend_factor` DECIMAL(18,2) COMMENT 'Combined factor that incorporates medical cost, utilization, and pharmacy trends.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the lakehouse.',
    `credibility_weight` DECIMAL(18,2) COMMENT 'Weight applied to experience data when blending with industry benchmarks.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_source` STRING COMMENT 'Origin of the underlying data used to derive the assumptions (e.g., Milliman MG‑ALFA, CMS, internal claims data).',
    `effective_date` DATE COMMENT 'Date on which the assumptions become effective for actuarial calculations.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date on which the assumptions cease to be valid; null for open‑ended sets.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_peer_reviewed` BOOLEAN COMMENT 'True when the peer‑review process has been completed and approved.',
    `is_regulatory_compliant` BOOLEAN COMMENT 'True if the assumption set meets all applicable CMS, NAIC, and HHS regulatory requirements.',
    `lapse_rate` DECIMAL(18,2) COMMENT 'Projected proportion of policies that will lapse each year.',
    `loss_development_factor_age_to_age` DECIMAL(18,2) COMMENT 'Factor used to project losses from one age band to the next.',
    `loss_development_factor_cumulative` DECIMAL(18,2) COMMENT 'Factor that aggregates loss development across all development periods.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `methodology_description` STRING COMMENT 'Narrative description of the actuarial methods and statistical techniques applied.',
    `mortality_rate` DECIMAL(18,2) COMMENT 'Annual mortality assumption used for life‑related reserves.',
    `actuarial_assumption_set_name` STRING COMMENT 'Human‑readable name describing the purpose or focus of the assumption set.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the assumption set.',
    `peer_review_status` STRING COMMENT 'Current status of the peer‑review process for the assumption set.. Valid values are `not_started|in_progress|completed|rejected`',
    `purpose` STRING COMMENT 'Business reason for creating the set (e.g., rate development, IBNR reserving, RBC calculation).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `trend_rate_medical_cost` DECIMAL(18,2) COMMENT 'Annual percentage change applied to projected medical costs.',
    `trend_rate_pharmacy` DECIMAL(18,2) COMMENT 'Annual percentage change applied to pharmacy spend forecasts.',
    `trend_rate_utilization` DECIMAL(18,2) COMMENT 'Annual percentage change applied to service utilization volumes.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Sequential version number incremented on each change to the set.',
    `created_by` STRING COMMENT 'User identifier of the person who initially created the record.',
    CONSTRAINT pk_actuarial_assumption_set PRIMARY KEY(`actuarial_assumption_set_id`)
) COMMENT 'Versioned, governed set of all actuarial assumptions and factors used across risk domain calculations. Includes trend rates (medical cost, utilization, unit cost, pharmacy) by service category and LOB, loss development factors (age-to-age, cumulative, tail, selected) by development period, credibility weights and factors (Bühlmann, limited fluctuation) by group size threshold, lapse rates, mortality assumptions, and compound trend factors. Captures assumption set name, version, effective date, purpose, data sources, factor selection methodology, actuarial sign-off, peer review status, and approval date. Provides governance, audit trail, and single source of truth for all actuarial model inputs used in Milliman MG-ALFA for rate development, IBNR reserving, RBC calculations, and financial projections.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` (
    `risk_underwriting_case_id` BIGINT COMMENT 'System-generated unique identifier for the underwriting case record.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Underwriting cases are subject to audit engagements; audit reports reference the specific case audited.',
    `delegated_entity_id` BIGINT COMMENT 'Foreign key linking to credential.delegated_entity. Business justification: Underwriting cases are processed per delegated credentialing entity; linking supports reporting of underwriting outcomes by delegated entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the underwriter who made the decision.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Underwriting case must reference the employer group to calculate premiums and satisfy ACA/ERISA reporting requirements.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the applicant (member or group) for which the underwriting case is created.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Underwriting cases are evaluated for a particular risk pool.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Underwriting cases may be outsourced to external underwriting vendors; linking enables vendor performance tracking and compliance reporting.',
    `age_gender_distribution_index` DECIMAL(18,2) COMMENT 'Statistical index representing the age and gender mix of the applicant population.',
    `applicant_type` STRING COMMENT 'Classification of the applicant as individual, small group, large group, etc.. Valid values are `individual|group|small_group|large_group`',
    `chronic_condition_prevalence_rate` DECIMAL(18,2) COMMENT 'Rate of chronic conditions among the applicant population.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the underwriting case record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for premium amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_rationale` STRING COMMENT 'Narrative explanation of the underwriting decision.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the underwriting decision was rendered.',
    `effective_date` DATE COMMENT 'Date when the underwriting decision becomes effective for coverage.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expected_claims_pmpm` DECIMAL(18,2) COMMENT 'Projected claims cost per member per month for the upcoming period.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gross_premium_amount` DECIMAL(18,2) COMMENT 'Total premium before adjustments.',
    `industry_risk_factor` DECIMAL(18,2) COMMENT 'Adjustment factor based on the applicants industry risk profile.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_self_insured` BOOLEAN COMMENT 'Indicates whether the applicant is self‑insured (ASO) or fully‑insured.',
    `large_claimant_count` STRING COMMENT 'Number of members with high-cost claims in the group.',
    `lob` STRING COMMENT 'Business line (e.g., medical, dental, vision) to which the underwriting case applies.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_underwriting_status` STRING COMMENT 'Result of medical underwriting review.. Valid values are `cleared|pending|exempt|rejected`',
    `morbidity_factor` DECIMAL(18,2) COMMENT 'Factor reflecting expected morbidity based on health status and demographics.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Final premium after adjustments.',
    `overall_group_risk_score` DECIMAL(18,2) COMMENT 'Composite risk score derived from all risk factors for the group.',
    `premium_adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of discounts, fees, or other adjustments applied to the gross premium.',
    `premium_rate` DECIMAL(18,2) COMMENT 'Base premium rate applied to the applicant.',
    `premium_rate_type` STRING COMMENT 'Method used to calculate the premium (fixed amount, per member, per employee).. Valid values are `fixed|per_member|per_employee`',
    `prior_year_claims_pmpm` DECIMAL(18,2) COMMENT 'Claims cost per member per month from the prior year.',
    `rate_effective_date` DATE COMMENT 'Date when the premium rate becomes effective.',
    `rate_expiration_date` DATE COMMENT 'Date when the premium rate expires (null for open‑ended).',
    `rating_period` STRING COMMENT 'Period (e.g., FY2024) used for rating calculations.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_submission_status` STRING COMMENT 'Status of required regulatory filings (e.g., CMS, NAIC).. Valid values are `not_submitted|submitted|accepted|rejected`',
    `reinsurance_flag` BOOLEAN COMMENT 'True if the case includes reinsurance or stop‑loss pricing.',
    `review_deadline` DATE COMMENT 'Date by which the underwriting case must be reviewed or decided.',
    `risk_classification` STRING COMMENT 'Overall risk classification assigned to the applicant.. Valid values are `low|medium|high|very_high`',
    `risk_underwriting_case_status` STRING COMMENT 'Current lifecycle status of the underwriting case.. Valid values are `pending|approved|declined|rated|withdrawn`',
    `stop_loss_arrangement` STRING COMMENT 'Code or description of any stop‑loss coverage attached to the case.',
    `submission_date` DATE COMMENT 'Date the underwriting case was submitted to regulators.',
    `total_member_months` STRING COMMENT 'Aggregate member-months for the group applicant during the rating period.',
    `underwriting_case_number` STRING COMMENT 'External case number assigned to the underwriting decision, used for tracking and communication.',
    `underwriting_rule_set` STRING COMMENT 'Identifier of the rule set applied during underwriting.',
    `underwriting_tier` STRING COMMENT 'Tier level used in underwriting risk segmentation.. Valid values are `tier1|tier2|tier3|tier4`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the underwriting case record.',
    CONSTRAINT pk_risk_underwriting_case PRIMARY KEY(`risk_underwriting_case_id`)
) COMMENT 'Represents an underwriting decision record for group or individual market applicants, including the group-level risk profile used in underwriting evaluation and renewal rating. Captures underwriting case number, applicant type (group/individual/small group/large group), LOB, underwriting tier, risk classification, medical underwriting status, final decision (approved/declined/rated), effective date, underwriter ID, decision rationale, and applicable underwriting rules/criteria. For group cases, includes aggregate risk profile: rating period, total member months, age/gender distribution index, morbidity factor, industry risk factor, prior year claims PMPM, expected claims PMPM, large claimant count, chronic condition prevalence rates, and overall group risk score. Supports fully-insured and self-insured (ASO) underwriting workflows, group renewal underwriting, and stop-loss pricing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` (
    `risk_cms_submission_id` BIGINT COMMENT 'Primary key for cms_submission',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: CMS risk‑adjustment submissions must be linked to the governing regulatory obligation; reporting dashboards require this association.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or process that initiated the submission.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with the risk adjustment data.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: CMS risk adjustment submissions are associated with a risk pool.',
    `accepted_record_count` BIGINT COMMENT 'Number of records that CMS accepted without error.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total monetary adjustments (e.g., discounts, penalties) applied to the claim total.',
    `cms_acknowledgment_status` STRING COMMENT 'CMSs acknowledgment of the submission batch.. Valid values are `received|processed|accepted|rejected|pending`',
    `contract_number` STRING COMMENT 'Identifier of the contract or Provider Benefit Package (PBP) associated with the submission.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary fields.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `encounter_type` STRING COMMENT 'Category of the clinical encounter data included in the batch.. Valid values are `inpatient|outpatient|professional|pharmacy|other`',
    `error_disposition` STRING COMMENT 'Textual description of any errors returned by CMS for the batch.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net dollar amount after adjustments, representing the amount CMS will reimburse.',
    `payment_year` STRING COMMENT 'Calendar year for which CMS payment is being calculated.',
    `record_count` BIGINT COMMENT 'Total number of individual risk adjustment records submitted in the batch.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rejected_record_count` BIGINT COMMENT 'Number of records that CMS rejected due to validation errors.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Aggregated Hierarchical Condition Category (HCC) factor for the batch.',
    `risk_adjustment_score` DECIMAL(18,2) COMMENT 'Risk Adjustment Factor (RAF) score calculated for the batch.',
    `service_year` STRING COMMENT 'Year of the services/encounters represented in the submission.',
    `submission_batch_number` STRING COMMENT 'Business identifier assigned to the batch of records submitted to CMS.',
    `submission_checksum` STRING COMMENT 'MD5 checksum of the submission file for integrity verification.',
    `submission_comment` STRING COMMENT 'Free‑text notes entered at submission time.',
    `submission_file_name` STRING COMMENT 'File name of the electronic submission payload.',
    `submission_file_size` BIGINT COMMENT 'Size of the submission file in bytes.',
    `submission_source_system` STRING COMMENT 'Name of the source system that generated the submission (e.g., Milliman MG‑ALFA).',
    `submission_status` STRING COMMENT 'Current lifecycle status of the CMS submission batch.. Valid values are `pending|submitted|accepted|rejected|error`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the batch was transmitted to CMS.',
    `submission_type` STRING COMMENT 'Indicates whether the batch was submitted via the Risk Adjustment Processing System (RAPS) or Encounter Data Processing System (EDPS).. Valid values are `RAPS|EDPS`',
    `submission_user_role` STRING COMMENT 'Role of the submitter (e.g., actuarial_analyst, system_process).',
    `total_claim_amount` DECIMAL(18,2) COMMENT 'Aggregate dollar amount of all claims included in the submission.',
    `transition_flag` BOOLEAN COMMENT 'Indicates whether the batch complies with the RAPS‑to‑EDPS transition requirements (true = compliant).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    CONSTRAINT pk_risk_cms_submission PRIMARY KEY(`risk_cms_submission_id`)
) COMMENT 'Tracks CMS risk adjustment data submissions for Medicare Advantage via both RAPS (Risk Adjustment Processing System) and EDPS (Encounter Data Processing System) channels. Captures submission batch ID, submission type (RAPS/EDPS), submission date, contract/PBP number, payment year, service year, encounter type, record counts, accepted/rejected counts, CMS acknowledgment status, error disposition, and RAPS-to-EDPS transition compliance flags. Each record represents a batch transaction submitted to CMS for risk adjustment processing. Supports RADV audit readiness and CMS reconciliation. Note: This product should be renamed to cms_submission after the RAPS+EDPS merge.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_score_run_id` FOREIGN KEY (`score_run_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`score_run`(`score_run_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ADD CONSTRAINT `fk_risk_hcc_mapping_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ADD CONSTRAINT `fk_risk_hcc_mapping_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ADD CONSTRAINT `fk_risk_rate_development_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ADD CONSTRAINT `fk_risk_ibnr_reserve_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ADD CONSTRAINT `fk_risk_rbc_calculation_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ADD CONSTRAINT `fk_risk_adjustment_payment_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ADD CONSTRAINT `fk_risk_prospective_risk_model_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ADD CONSTRAINT `fk_risk_score_run_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ADD CONSTRAINT `fk_risk_pool_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ADD CONSTRAINT `fk_risk_actuarial_assumption_set_rate_development_id` FOREIGN KEY (`rate_development_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`rate_development`(`rate_development_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ADD CONSTRAINT `fk_risk_actuarial_assumption_set_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ADD CONSTRAINT `fk_risk_risk_cms_submission_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('pii_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('pii_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('pii_fhir_resource' = 'RiskAssessment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `member_risk_score_id` SET TAGS ('pii_business_glossary_term' = 'Member Risk Score ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `member_risk_score_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `audit_user` SET TAGS ('pii_business_glossary_term' = 'Audit User');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_published_score` SET TAGS ('pii_business_glossary_term' = 'CMS Published RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('pii_business_glossary_term' = 'CMS Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('pii_value_regex' = 'submitted|accepted|rejected|pending');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `corrective_action` SET TAGS ('pii_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `demographic_factor_score` SET TAGS ('pii_business_glossary_term' = 'Demographic Factor Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_timestamp` SET TAGS ('pii_business_glossary_term' = 'Score Effective Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Score Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `hcc_codes` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC) Codes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `is_manual_override` SET TAGS ('pii_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `manual_override_reason` SET TAGS ('pii_business_glossary_term' = 'Manual Override Reason');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_name` SET TAGS ('pii_business_glossary_term' = 'Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_version` SET TAGS ('pii_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `payment_year` SET TAGS ('pii_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `plan_calculated_score` SET TAGS ('pii_business_glossary_term' = 'Plan Calculated RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `resubmission_reference` SET TAGS ('pii_business_glossary_term' = 'Resubmission Reference');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_adjustment_factor_category` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_code` SET TAGS ('pii_business_glossary_term' = 'Risk Score Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_confidence_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score Confidence Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_label` SET TAGS ('pii_business_glossary_term' = 'Risk Score Label');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_notes` SET TAGS ('pii_business_glossary_term' = 'Risk Score Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_source` SET TAGS ('pii_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_source` SET TAGS ('pii_value_regex' = 'encounter|claims|pharmacy|utilization');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_status` SET TAGS ('pii_business_glossary_term' = 'Risk Score Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_status` SET TAGS ('pii_value_regex' = 'pending_review|finalized');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_type` SET TAGS ('pii_business_glossary_term' = 'Risk Score Type (Prospective/Concurrent/Final)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_type` SET TAGS ('pii_value_regex' = 'prospective|concurrent|final');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_value` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF) Score Value');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_components` SET TAGS ('pii_business_glossary_term' = 'Score Components Detail');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_effective_date` SET TAGS ('pii_business_glossary_term' = 'Score Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_variance` SET TAGS ('pii_business_glossary_term' = 'Score Variance (Plan vs CMS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('pii_business_glossary_term' = 'Variance Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('pii_value_regex' = 'missing_diagnoses|hierarchy_diff|demographic|other');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('pii_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_id` SET TAGS ('pii_business_glossary_term' = 'Hcc Mapping Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `age_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Age Adjustment Factor (AGE_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `coefficient` SET TAGS ('pii_business_glossary_term' = 'HCC Coefficient (COEF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `demographic_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Demographic Adjustment Factor (DEMOG_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `disease_interaction_group` SET TAGS ('pii_business_glossary_term' = 'Disease Interaction Group (DI_GROUP)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Gender Adjustment Factor (GENDER_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_code` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category Code (HCC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_description` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category Description (HCC_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('pii_business_glossary_term' = 'Mapping Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level (HIER_LEVEL)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('pii_business_glossary_term' = 'ICD-10 Diagnosis Code (ICD10)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('pii_value_regex' = '^[A-TV-Z][0-9][0-9A-Z](.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_description` SET TAGS ('pii_business_glossary_term' = 'ICD-10 Diagnosis Description (ICD10_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `interaction_flag` SET TAGS ('pii_business_glossary_term' = 'Disease Interaction Flag (INTERACT_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `interaction_flag` SET TAGS ('pii_value_regex' = 'yes|no');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_excluded` SET TAGS ('pii_business_glossary_term' = 'Is Excluded Flag (EXCLUDED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_mapped` SET TAGS ('pii_business_glossary_term' = 'Is Mapped Flag (MAPPED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date (REVIEW_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By (UPDATED_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('pii_business_glossary_term' = 'Mapping Source (MAP_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('pii_value_regex' = 'CMS|Milliman|Custom');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `model_year` SET TAGS ('pii_business_glossary_term' = 'Model Year (MODEL_YEAR)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `parent_hcc_code` SET TAGS ('pii_business_glossary_term' = 'Parent HCC Code (PARENT_HCC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `parent_hcc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `plan_type_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Plan Type Adjustment Factor (PLAN_TYPE_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `region_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Region Adjustment Factor (REGION_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status (REVIEW_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `risk_score_weight` SET TAGS ('pii_business_glossary_term' = 'Risk Score Weight (RS_WEIGHT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `source_version` SET TAGS ('pii_business_glossary_term' = 'Source Version (SRC_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('pii_subdomain' = 'regulatory_submission');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_id` SET TAGS ('pii_business_glossary_term' = 'RAPS Submission Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Submission User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('pii_business_glossary_term' = 'Accepted Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'CMS Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('pii_value_regex' = 'received|processed|accepted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `error_disposition` SET TAGS ('pii_business_glossary_term' = 'Error Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `payment_year` SET TAGS ('pii_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_contract_number` SET TAGS ('pii_business_glossary_term' = 'Plan Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'hmo|ppo|epo|pos|hdhp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('pii_value_regex' = 'pending|submitted|acknowledged|rejected|error');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `rejected_record_count` SET TAGS ('pii_business_glossary_term' = 'Rejected Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_year` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_checksum` SET TAGS ('pii_business_glossary_term' = 'Submission File Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_name` SET TAGS ('pii_business_glossary_term' = 'Submission File Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('pii_business_glossary_term' = 'Submission User Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `total_record_count` SET TAGS ('pii_business_glossary_term' = 'Total Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('pii_subdomain' = 'actuarial_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.plan.specificCost');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_development_id` SET TAGS ('pii_business_glossary_term' = 'Rate Development Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `administrative_loading` SET TAGS ('pii_business_glossary_term' = 'Administrative Loading');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `age_factor` SET TAGS ('pii_business_glossary_term' = 'Age Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Rate Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `base_rate` SET TAGS ('pii_business_glossary_term' = 'Base Rate (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `credibility_factor` SET TAGS ('pii_business_glossary_term' = 'Credibility Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `development_number` SET TAGS ('pii_business_glossary_term' = 'Rate Development Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `development_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Rate Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `final_approved_rate` SET TAGS ('pii_business_glossary_term' = 'Final Approved Rate (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('pii_business_glossary_term' = 'Gender Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `geographic_factor` SET TAGS ('pii_business_glossary_term' = 'Geographic Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `group_size_factor` SET TAGS ('pii_business_glossary_term' = 'Group Size Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `industry_factor` SET TAGS ('pii_business_glossary_term' = 'Industry Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'health|dental|vision|life|disability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `mlr_target` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio (MLR) Target');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Rate Development Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `plan_type_loading` SET TAGS ('pii_business_glossary_term' = 'Plan Type Loading');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `profit_margin` SET TAGS ('pii_business_glossary_term' = 'Profit Margin');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_development_status` SET TAGS ('pii_business_glossary_term' = 'Rate Development Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_development_status` SET TAGS ('pii_value_regex' = 'draft|pending|approved|rejected|active|inactive');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_methodology` SET TAGS ('pii_business_glossary_term' = 'Rate Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_methodology` SET TAGS ('pii_value_regex' = 'community|experience|blended');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_area` SET TAGS ('pii_business_glossary_term' = 'Geographic Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_period_end` SET TAGS ('pii_business_glossary_term' = 'Rating Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_period_start` SET TAGS ('pii_business_glossary_term' = 'Rating Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `tobacco_factor` SET TAGS ('pii_business_glossary_term' = 'Tobacco Use Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `trend_factor` SET TAGS ('pii_business_glossary_term' = 'Trend Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_subdomain' = 'reinsurance_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_mvm_grouper' = 'core');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_mvm_priority' = 'critical');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_mvm_scope' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_scope' = 'mvm');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_id` SET TAGS ('pii_business_glossary_term' = 'Ibnr Reserve Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_id` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `pool_id` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `actuarial_confidence_level` SET TAGS ('pii_business_glossary_term' = 'Actuarial Confidence Level');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `actuarial_confidence_level` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `confidence_interval_lower` SET TAGS ('pii_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `confidence_interval_lower` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `confidence_interval_upper` SET TAGS ('pii_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `confidence_interval_upper` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `currency_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `data_quality_score` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `development_factor` SET TAGS ('pii_business_glossary_term' = 'Development Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `development_factor` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `effective_end_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `effective_start_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `expected_loss_ratio` SET TAGS ('pii_business_glossary_term' = 'Expected Loss Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `expected_loss_ratio` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `external_reserve_code` SET TAGS ('pii_business_glossary_term' = 'External Reserve Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `external_reserve_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `external_reserve_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `forecast_horizon_months` SET TAGS ('pii_business_glossary_term' = 'Forecast Horizon (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `forecast_horizon_months` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `hcc_weighted_amount` SET TAGS ('pii_business_glossary_term' = 'HCC Weighted IBNR Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `hcc_weighted_amount` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_amount` SET TAGS ('pii_business_glossary_term' = 'IBNR Reserve Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_amount` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_pmpm` SET TAGS ('pii_business_glossary_term' = 'IBNR Per Member Per Month');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_pmpm` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_status` SET TAGS ('pii_business_glossary_term' = 'Reserve Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_status` SET TAGS ('pii_value_regex' = 'draft|approved|finalized|revised');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_status` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `is_active` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'Medical|Dental|Vision|Pharmacy|Behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `lob_code` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `notes` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `plan_type` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `raps_submission_flag` SET TAGS ('pii_business_glossary_term' = 'RAPS Submission Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `raps_submission_flag` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `rbc_impact_amount` SET TAGS ('pii_business_glossary_term' = 'RBC Impact Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `rbc_impact_amount` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_created_at` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_source_system` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_status` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_updated_at` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `record_version` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_adequacy_flag` SET TAGS ('pii_business_glossary_term' = 'Reserve Adequacy Assessment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_adequacy_flag` SET TAGS ('pii_value_regex' = 'adequate|marginal|inadequate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_adequacy_flag` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_methodology` SET TAGS ('pii_business_glossary_term' = 'Reserve Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_methodology` SET TAGS ('pii_value_regex' = 'chain_ladder|bornhuetter_ferguson|cape_cod|frequency_severity');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_methodology` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_name` SET TAGS ('pii_business_glossary_term' = 'Reserve Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_name` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `service_month` SET TAGS ('pii_business_glossary_term' = 'Service Month');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `service_month` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `valuation_date` SET TAGS ('pii_business_glossary_term' = 'Valuation Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `valuation_date` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `version_number` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('pii_subdomain' = 'reinsurance_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Arrangement Identifier (RA_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Reinsurer Identifier (REINSURER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_amount` SET TAGS ('pii_business_glossary_term' = 'Aggregate Attachment Amount (AGG_ATTACH_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_factor` SET TAGS ('pii_business_glossary_term' = 'Aggregate Attachment Factor Percentage (AGG_ATTACH_FACTOR)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_factor` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Arrangement Number (RA_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point` SET TAGS ('pii_business_glossary_term' = 'Attachment Point Amount (ATTACHMENT_POINT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point_currency` SET TAGS ('pii_business_glossary_term' = 'Attachment Point Currency Code (ATTACHMENT_CURR)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Percentage (COINSURANCE_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `corridor_percentage` SET TAGS ('pii_business_glossary_term' = 'Corridor Percentage (CORRIDOR_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `corridor_percentage` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective Date (EFF_FROM)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Expiration Date (EXPIRY_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `lob_coverage` SET TAGS ('pii_business_glossary_term' = 'Line of Business Coverage (LOB_COVERAGE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `lob_coverage` SET TAGS ('pii_value_regex' = 'medical|dental|vision|pharmacy|hospital|rx');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_liability` SET TAGS ('pii_business_glossary_term' = 'Maximum Liability Amount (MAX_LIAB)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_liability` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_recovery_limit` SET TAGS ('pii_business_glossary_term' = 'Maximum Recovery Limit (MAX_RECOVERY)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_recovery_limit` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `premium_ceded` SET TAGS ('pii_business_glossary_term' = 'Ceded Premium Amount (PREMIUM_CED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `premium_ceded` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_status` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Arrangement Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurer_name` SET TAGS ('pii_business_glossary_term' = 'Reinsurer Name (REINSURER_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurer_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `specific_deductible` SET TAGS ('pii_business_glossary_term' = 'Specific Deductible Amount (SPEC_DED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `specific_deductible` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_deductible` SET TAGS ('pii_business_glossary_term' = 'Stop‑Loss Deductible Amount (STOP_LOSS_DED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_deductible` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_limit` SET TAGS ('pii_business_glossary_term' = 'Stop‑Loss Limit Amount (STOP_LOSS_LIMIT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_limit` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_threshold` SET TAGS ('pii_business_glossary_term' = 'Stop‑Loss Threshold Amount (STOP_LOSS_THRESHOLD)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_threshold` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_type` SET TAGS ('pii_business_glossary_term' = 'Stop‑Loss Type (STOP_LOSS_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_type` SET TAGS ('pii_value_regex' = 'specific|aggregate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_terms` SET TAGS ('pii_business_glossary_term' = 'Treaty Terms Description (TREATY_TERMS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_terms` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_type` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Treaty Type (TREATY_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_type` SET TAGS ('pii_value_regex' = 'quota_share|excess_of_loss|aggregate_stop_loss|specific_stop_loss');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('pii_subdomain' = 'reinsurance_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('pii_fhir_resource' = 'Claim');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `reinsurance_claim_id` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Claimant Identifier (CLAIMANT_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Timestamp (ACKNOWLEDGMENT_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `attachment_point_amount` SET TAGS ('pii_business_glossary_term' = 'Attachment Point Amount (ATTACHMENT_POINT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_number` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Claim Number (CLAIM_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Claim Status (CLAIM_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_status` SET TAGS ('pii_value_regex' = 'open|closed|cancelled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_type` SET TAGS ('pii_business_glossary_term' = 'Claim Type (CLAIM_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_type` SET TAGS ('pii_value_regex' = 'stop_loss|specific');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claimant_type` SET TAGS ('pii_business_glossary_term' = 'Claimant Type (CLAIMANT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claimant_type` SET TAGS ('pii_value_regex' = 'member|group');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `covered_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date (COVERED_END_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `covered_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date (COVERED_START_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `is_aggregated` SET TAGS ('pii_business_glossary_term' = 'Is Aggregated (IS_AGGREGATED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `loss_category` SET TAGS ('pii_business_glossary_term' = 'Loss Category (LOSS_CATEGORY)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `loss_category` SET TAGS ('pii_value_regex' = 'medical|dental|vision|pharmacy|hospital|other');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `loss_description` SET TAGS ('pii_business_glossary_term' = 'Loss Description (LOSS_DESCRIPTION)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Adjuster Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `payment_received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Payment Received Timestamp (PAYMENT_RECEIVED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `recoverable_amount` SET TAGS ('pii_business_glossary_term' = 'Recoverable Amount (RECOVERABLE_AMOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `recovery_status` SET TAGS ('pii_business_glossary_term' = 'Recovery Status (RECOVERY_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `recovery_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|paid');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag (REGULATORY_REPORTING)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `reporting_period` SET TAGS ('pii_business_glossary_term' = 'Reporting Period (REPORTING_PERIOD)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `reporting_period` SET TAGS ('pii_value_regex' = 'Q1|Q2|Q3|Q4|Annual');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp (SUBMISSION_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `total_incurred_amount` SET TAGS ('pii_business_glossary_term' = 'Total Incurred Amount (TOTAL_INCURRED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('pii_subdomain' = 'actuarial_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `rbc_calculation_id` SET TAGS ('pii_business_glossary_term' = 'Risk-Based Capital (RBC) Calculation ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `action_threshold_status` SET TAGS ('pii_business_glossary_term' = 'Action Threshold Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `action_threshold_status` SET TAGS ('pii_value_regex' = 'no_action|company_action|regulatory_action|authorized_control|mandatory_control');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `authorized_control_level_rbc` SET TAGS ('pii_business_glossary_term' = 'Authorized Control Level RBC');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_method` SET TAGS ('pii_business_glossary_term' = 'RBC Calculation Method');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_method` SET TAGS ('pii_value_regex' = 'standard|custom');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_number` SET TAGS ('pii_business_glossary_term' = 'RBC Calculation Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Calculation Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Calculation Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_timestamp` SET TAGS ('pii_business_glossary_term' = 'RBC Calculation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `company_action_level_rbc` SET TAGS ('pii_business_glossary_term' = 'Company Action Level RBC');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `company_code` SET TAGS ('pii_business_glossary_term' = 'Company ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `company_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `covariance_adjustment` SET TAGS ('pii_business_glossary_term' = 'Covariance Adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h0_asset_risk` SET TAGS ('pii_business_glossary_term' = 'H0 Asset Risk Charge');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h1_underwriting_risk` SET TAGS ('pii_business_glossary_term' = 'H1 Underwriting Risk Charge');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h2_credit_risk` SET TAGS ('pii_business_glossary_term' = 'H2 Credit Risk Charge');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h3_business_risk` SET TAGS ('pii_business_glossary_term' = 'H3 Business Risk Charge');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h4_admin_expense_risk` SET TAGS ('pii_business_glossary_term' = 'H4 Administrative Expense Risk Charge');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'RBC Calculation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `rbc_ratio` SET TAGS ('pii_business_glossary_term' = 'RBC Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `rbc_status` SET TAGS ('pii_business_glossary_term' = 'RBC Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `rbc_status` SET TAGS ('pii_value_regex' = 'no_action|company_action|regulatory_action|authorized_control|mandatory_control');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `total_adjusted_capital` SET TAGS ('pii_business_glossary_term' = 'Total Adjusted Capital (TAC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('pii_subdomain' = 'regulatory_submission');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('pii_fhir_resource' = 'PaymentReconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_payment_id` SET TAGS ('pii_business_glossary_term' = 'Adjustment Payment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Contract Identifier (PCI)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (Member_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount (AA)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Code (ARC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_reason_description` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Description (ARD)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `business_event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Business Event Timestamp (BET)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `cms_notification_date` SET TAGS ('pii_business_glossary_term' = 'CMS Notification Date (CMSND)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Payment Amount (GPA)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `gross_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status (LFS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'draft|submitted|processed|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Payment Amount (NPA)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `net_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_effective_date` SET TAGS ('pii_business_glossary_term' = 'Payment Effective Date (PED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method (PMTH)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'electronic_fund_transfer|check|wire');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_source` SET TAGS ('pii_business_glossary_term' = 'Payment Source (PSRC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_source` SET TAGS ('pii_value_regex' = 'CMS|Internal|Third_Party');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status (PS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'pending|received|reconciled|rejected|adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type (PTYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'receipt|charge');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_year` SET TAGS ('pii_business_glossary_term' = 'Payment Year (PY)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `processing_date` SET TAGS ('pii_business_glossary_term' = 'Processing Date (PD)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Program Type (PT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `program_type` SET TAGS ('pii_value_regex' = 'ACA_Risk_Adjustment|Medicare_Advantage|Reinsurance|CSR');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `reconciliation_flag` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Flag (RF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score (RS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('pii_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `prospective_risk_model_id` SET TAGS ('pii_business_glossary_term' = 'Prospective Risk Model Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Model Owner');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `cms_model_year` SET TAGS ('pii_business_glossary_term' = 'CMS Model Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `prospective_risk_model_description` SET TAGS ('pii_business_glossary_term' = 'Model Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `input_period_end` SET TAGS ('pii_business_glossary_term' = 'Input Data Period End');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `input_period_start` SET TAGS ('pii_business_glossary_term' = 'Input Data Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `is_production` SET TAGS ('pii_business_glossary_term' = 'Production Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `last_run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Model Run Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_category` SET TAGS ('pii_business_glossary_term' = 'Model Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_code` SET TAGS ('pii_business_glossary_term' = 'Risk Model Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_name` SET TAGS ('pii_business_glossary_term' = 'Risk Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_status` SET TAGS ('pii_business_glossary_term' = 'Model Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_status` SET TAGS ('pii_value_regex' = 'active|inactive|draft|pending|deprecated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `normalization_factor` SET TAGS ('pii_business_glossary_term' = 'Normalization Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `population_segment` SET TAGS ('pii_business_glossary_term' = 'Population Segment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `population_segment` SET TAGS ('pii_value_regex' = 'Medicare|Medicaid|Commercial|EmployerGroup');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `risk_model_type` SET TAGS ('pii_business_glossary_term' = 'Risk Model Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `risk_model_type` SET TAGS ('pii_value_regex' = 'CMS-HCC|RxHCC|HHS-HCC|CDPS');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `risk_score_max` SET TAGS ('pii_business_glossary_term' = 'Maximum Expected Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `risk_score_min` SET TAGS ('pii_business_glossary_term' = 'Minimum Expected Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `run_date` SET TAGS ('pii_business_glossary_term' = 'Model Run Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Model Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('pii_subdomain' = 'score_management');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `score_run_id` SET TAGS ('pii_business_glossary_term' = 'Score Run Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Actuarial Sign‑off User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `actuarial_signoff_date` SET TAGS ('pii_business_glossary_term' = 'Actuarial Sign‑off Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `average_raf_score` SET TAGS ('pii_business_glossary_term' = 'Average RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `cms_model_year` SET TAGS ('pii_business_glossary_term' = 'CMS Model Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_value_regex' = 'good|questionable|bad');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_snapshot_date` SET TAGS ('pii_business_glossary_term' = 'Data Snapshot Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `input_data_period_end` SET TAGS ('pii_business_glossary_term' = 'Input Data Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `input_data_period_start` SET TAGS ('pii_business_glossary_term' = 'Input Data Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `member_population_count` SET TAGS ('pii_business_glossary_term' = 'Member Population Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_name` SET TAGS ('pii_business_glossary_term' = 'Risk Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_status` SET TAGS ('pii_business_glossary_term' = 'Model Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_version` SET TAGS ('pii_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `normalization_factor` SET TAGS ('pii_business_glossary_term' = 'Normalization Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `population_segment` SET TAGS ('pii_business_glossary_term' = 'Population Segment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `population_segment` SET TAGS ('pii_value_regex' = 'Medicare|Medicaid|Commercial|DualEligible');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `risk_model_type` SET TAGS ('pii_business_glossary_term' = 'Risk Model Type (CMS-HCC, RxHCC, HHS-HCC, CDPS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `risk_model_type` SET TAGS ('pii_value_regex' = 'CMS-HCC|RxHCC|HHS-HCC|CDPS');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_code` SET TAGS ('pii_business_glossary_term' = 'Run Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_date` SET TAGS ('pii_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_description` SET TAGS ('pii_business_glossary_term' = 'Run Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_status` SET TAGS ('pii_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_status` SET TAGS ('pii_value_regex' = 'pending|running|completed|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_type` SET TAGS ('pii_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_type` SET TAGS ('pii_value_regex' = 'production|test|reconciliation');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `score_distribution_summary` SET TAGS ('pii_business_glossary_term' = 'Score Distribution Summary');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `total_raf_score` SET TAGS ('pii_business_glossary_term' = 'Total RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('pii_subdomain' = 'regulatory_submission');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `radv_audit_id` SET TAGS ('pii_business_glossary_term' = 'RADV Audit ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Audit Created By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `appeal_status` SET TAGS ('pii_value_regex' = 'none|filed|under_review|resolved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_error_description` SET TAGS ('pii_business_glossary_term' = 'Audit Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_error_flag` SET TAGS ('pii_business_glossary_term' = 'Audit Error Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_source` SET TAGS ('pii_business_glossary_term' = 'Audit Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_source` SET TAGS ('pii_value_regex' = 'CMS|internal');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit Start Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Lifecycle Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_value_regex' = 'open|in_progress|closed|appealed|settled');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'initial|follow_up');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_updated_by` SET TAGS ('pii_business_glossary_term' = 'Audit Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_year` SET TAGS ('pii_business_glossary_term' = 'Audit Year (YR)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `cms_findings` SET TAGS ('pii_business_glossary_term' = 'CMS Findings');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'CMS Contract Number (CN)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `extrapolated_payment_error` SET TAGS ('pii_business_glossary_term' = 'Extrapolated Payment Error (EPE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `final_settlement_amount` SET TAGS ('pii_business_glossary_term' = 'Final Settlement Amount (FSA)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `hcc_mapping_version` SET TAGS ('pii_business_glossary_term' = 'HCC Mapping Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('pii_business_glossary_term' = 'Medical Record Receipt Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('pii_business_glossary_term' = 'Medical Record Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('pii_value_regex' = 'pending|requested|received|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_created` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_updated` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `sampled_member_count` SET TAGS ('pii_business_glossary_term' = 'Sampled Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `validated_hcc_count` SET TAGS ('pii_business_glossary_term' = 'Validated HCC Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('pii_subdomain' = 'actuarial_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Pool Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Arrangement Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `aca_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'ACA Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `average_risk_score` SET TAGS ('pii_business_glossary_term' = 'Average Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_code` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `data_source_timestamp` SET TAGS ('pii_business_glossary_term' = 'Data Source Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `geographic_scope` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `is_excluded_from_mlr` SET TAGS ('pii_business_glossary_term' = 'MLR Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'individual|group|medicare|medicaid|exchange');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'commercial|government|individual|small_group|large_group');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `member_months` SET TAGS ('pii_business_glossary_term' = 'Member Months');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_name` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pmpm` SET TAGS ('pii_business_glossary_term' = 'Pool Per Member Per Month (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_status` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|pending|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_type` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_type` SET TAGS ('pii_value_regex' = 'single|merged|small_group|large_group|individual');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `regulatory_basis` SET TAGS ('pii_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `regulatory_basis` SET TAGS ('pii_value_regex' = 'ACA|CMS|State');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `risk_pool_version` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `risk_score_stddev` SET TAGS ('pii_business_glossary_term' = 'Risk Score Standard Deviation');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code (ISO 3166-2)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `total_incurred_claims` SET TAGS ('pii_business_glossary_term' = 'Total Incurred Claims Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `total_paid_claims` SET TAGS ('pii_business_glossary_term' = 'Total Paid Claims Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `total_reserve_amount` SET TAGS ('pii_business_glossary_term' = 'Total Reserve Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('pii_subdomain' = 'actuarial_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_id` SET TAGS ('pii_business_glossary_term' = 'Actuarial Assumption Set Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_status` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_status` SET TAGS ('pii_value_regex' = 'draft|active|inactive|retired|pending_approval');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_type` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_type` SET TAGS ('pii_value_regex' = 'trend|loss_development|credibility|mortality|lapse|pharmacy_trend');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_signoff_date` SET TAGS ('pii_business_glossary_term' = 'Actuarial Sign‑off Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_signoff_name` SET TAGS ('pii_business_glossary_term' = 'Actuarial Sign‑off Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_signoff_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_signoff_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_code` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `compound_trend_factor` SET TAGS ('pii_business_glossary_term' = 'Compound Trend Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `credibility_weight` SET TAGS ('pii_business_glossary_term' = 'Credibility Weight');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `is_peer_reviewed` SET TAGS ('pii_business_glossary_term' = 'Peer Review Completed Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `is_regulatory_compliant` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `lapse_rate` SET TAGS ('pii_business_glossary_term' = 'Policy Lapse Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `loss_development_factor_age_to_age` SET TAGS ('pii_business_glossary_term' = 'Age‑to‑Age Loss Development Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `loss_development_factor_cumulative` SET TAGS ('pii_business_glossary_term' = 'Cumulative Loss Development Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `methodology_description` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `mortality_rate` SET TAGS ('pii_business_glossary_term' = 'Mortality Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_name` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `peer_review_status` SET TAGS ('pii_business_glossary_term' = 'Peer Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `peer_review_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `purpose` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Purpose');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_medical_cost` SET TAGS ('pii_business_glossary_term' = 'Medical Cost Trend Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_medical_cost` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_medical_cost` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_pharmacy` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Trend Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_utilization` SET TAGS ('pii_business_glossary_term' = 'Utilization Trend Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `updated_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `updated_by` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Assumption Set Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `created_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `created_by` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('pii_subdomain' = 'reinsurance_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('pii_business_glossary_term' = 'Risk Underwriting Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `audit_engagement_id` SET TAGS ('pii_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `delegated_entity_id` SET TAGS ('pii_business_glossary_term' = 'Delegated Credentialing Entity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Underwriter Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('pii_business_glossary_term' = 'Age/Gender Distribution Index');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `applicant_type` SET TAGS ('pii_business_glossary_term' = 'Applicant Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `applicant_type` SET TAGS ('pii_value_regex' = 'individual|group|small_group|large_group');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `chronic_condition_prevalence_rate` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Prevalence Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `decision_rationale` SET TAGS ('pii_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `decision_timestamp` SET TAGS ('pii_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `expected_claims_pmpm` SET TAGS ('pii_business_glossary_term' = 'Expected Claims PMPM');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `gross_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `industry_risk_factor` SET TAGS ('pii_business_glossary_term' = 'Industry Risk Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `is_self_insured` SET TAGS ('pii_business_glossary_term' = 'Self-Insured Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `large_claimant_count` SET TAGS ('pii_business_glossary_term' = 'Large Claimant Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('pii_business_glossary_term' = 'Medical Underwriting Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('pii_value_regex' = 'cleared|pending|exempt|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `morbidity_factor` SET TAGS ('pii_business_glossary_term' = 'Morbidity Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `net_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `overall_group_risk_score` SET TAGS ('pii_business_glossary_term' = 'Overall Group Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Premium Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_rate` SET TAGS ('pii_business_glossary_term' = 'Premium Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_rate_type` SET TAGS ('pii_business_glossary_term' = 'Premium Rate Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_rate_type` SET TAGS ('pii_value_regex' = 'fixed|per_member|per_employee');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `prior_year_claims_pmpm` SET TAGS ('pii_business_glossary_term' = 'Prior Year Claims PMPM');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `rate_effective_date` SET TAGS ('pii_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `rate_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Rate Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `rating_period` SET TAGS ('pii_business_glossary_term' = 'Rating Period');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `regulatory_submission_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `regulatory_submission_status` SET TAGS ('pii_value_regex' = 'not_submitted|submitted|accepted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `reinsurance_flag` SET TAGS ('pii_business_glossary_term' = 'Reinsurance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `reinsurance_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `reinsurance_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `review_deadline` SET TAGS ('pii_business_glossary_term' = 'Review Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_classification` SET TAGS ('pii_business_glossary_term' = 'Risk Classification');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_classification` SET TAGS ('pii_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_underwriting_case_status` SET TAGS ('pii_business_glossary_term' = 'Underwriting Case Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_underwriting_case_status` SET TAGS ('pii_value_regex' = 'pending|approved|declined|rated|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `stop_loss_arrangement` SET TAGS ('pii_business_glossary_term' = 'Stop‑Loss Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `total_member_months` SET TAGS ('pii_business_glossary_term' = 'Total Member Months');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_case_number` SET TAGS ('pii_business_glossary_term' = 'Underwriting Case Number (UCN)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_case_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_rule_set` SET TAGS ('pii_business_glossary_term' = 'Underwriting Rule Set');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_tier` SET TAGS ('pii_business_glossary_term' = 'Underwriting Tier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_tier` SET TAGS ('pii_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('pii_subdomain' = 'regulatory_submission');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `risk_cms_submission_id` SET TAGS ('pii_business_glossary_term' = 'Cms Submission Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Submission User ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('pii_business_glossary_term' = 'Accepted Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'CMS Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('pii_value_regex' = 'received|processed|accepted|rejected|pending');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract / PBP Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `encounter_type` SET TAGS ('pii_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `encounter_type` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|professional|pharmacy|other');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `error_disposition` SET TAGS ('pii_business_glossary_term' = 'Error Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `payment_year` SET TAGS ('pii_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `record_count` SET TAGS ('pii_business_glossary_term' = 'Total Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `rejected_record_count` SET TAGS ('pii_business_glossary_term' = 'Rejected Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (HCC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `risk_adjustment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Score (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `service_year` SET TAGS ('pii_business_glossary_term' = 'Service Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_batch_number` SET TAGS ('pii_business_glossary_term' = 'Submission Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_checksum` SET TAGS ('pii_business_glossary_term' = 'Submission Checksum (MD5)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_comment` SET TAGS ('pii_business_glossary_term' = 'Submission Comment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_file_name` SET TAGS ('pii_business_glossary_term' = 'Submission File Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_file_size` SET TAGS ('pii_business_glossary_term' = 'Submission File Size (bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_source_system` SET TAGS ('pii_business_glossary_term' = 'Submission Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_status` SET TAGS ('pii_value_regex' = 'pending|submitted|accepted|rejected|error');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type (RAPS/EDPS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_value_regex' = 'RAPS|EDPS');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_user_role` SET TAGS ('pii_business_glossary_term' = 'Submission User Role');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `total_claim_amount` SET TAGS ('pii_business_glossary_term' = 'Total Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `transition_flag` SET TAGS ('pii_business_glossary_term' = 'RAPS-to-EDPS Transition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
