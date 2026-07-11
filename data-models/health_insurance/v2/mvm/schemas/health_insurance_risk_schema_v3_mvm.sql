-- Schema for Domain: risk | Business: Health_Insurance | Version: v3_mvm
-- Generated on: 2026-07-10 22:45:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`risk` COMMENT 'Manages actuarial risk assessment, underwriting, and risk adjustment programs — RAF scoring, HCC mapping, RAPS/EDPS submissions to CMS, RBC calculations, IBNR reserve estimation, and rate-setting inputs. Owns risk scores at the member level, underwriting decisions for group and individual markets, reinsurance/stop-loss arrangements, and premium rate development. Source system: Milliman MG-ALFA and actuarial models.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` (
    `member_risk_score_id` BIGINT COMMENT 'System-generated unique identifier for the member risk score record.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the risk score applies.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.service_area. Business justification: Risk scores vary by geographic service area for actuarial rate development and risk pool analysis. Required for geographic risk stratification, county-level risk reporting, and service area adequacy o',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Risk scores are calculated per plan year for CMS risk adjustment payment cycles. Linking member_risk_score to plan.year enables joining scores to plan year configurations, accumulator reset dates, and',
    `audit_user` STRING COMMENT 'User ID of the person who performed the most recent audit action.',
    `cms_published_score` DECIMAL(18,2) COMMENT 'RAF score value as published by CMS after reconciliation.',
    `cms_submission_status` STRING COMMENT 'Current status of the scores submission to CMS.. Valid values are `submitted|accepted|rejected|pending`',
    `corrective_action` STRING COMMENT 'Description of actions taken to resolve score variance (e.g., code addendum, data correction).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk score record was first created in the data lake.',
    `demographic_factor_score` DECIMAL(18,2) COMMENT 'Score component derived from member demographics (age, gender, Medicaid status).',
    `diagnosis_count` STRING COMMENT 'Number of distinct diagnoses captured for the member in the scoring period.',
    `effective_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the risk score became effective.',
    `expiration_date` DATE COMMENT 'Date after which the risk score is no longer valid for payment.',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether the score was manually overridden.',
    `manual_override_reason` STRING COMMENT 'Reason provided for a manual override of the risk score.',
    `model_name` STRING COMMENT 'Name of the risk adjustment model (e.g., "CMS‑HCC", "RxHCC", "HHS‑HCC").',
    `model_version` STRING COMMENT 'Version identifier of the actuarial model used to generate the score (e.g., "CMS‑HCC v2023").',
    `payment_year` STRING COMMENT 'Calendar year for which the risk score is used in CMS payment calculations.',
    `plan_calculated_score` DECIMAL(18,2) COMMENT 'RAF score calculated internally by the health plan prior to CMS submission.',
    `record_status` STRING COMMENT 'Lifecycle status of the risk score record.. Valid values are `active|inactive|archived`',
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
    `score_variance` DECIMAL(18,2) COMMENT 'Numeric difference between the plan‑calculated score and the CMS‑published score.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk score record.',
    `variance_category` STRING COMMENT 'Root‑cause classification for any variance between plan and CMS scores.. Valid values are `missing_diagnoses|hierarchy_diff|demographic|other`',
    CONSTRAINT pk_member_risk_score PRIMARY KEY(`member_risk_score_id`)
) COMMENT 'Authoritative member-level risk score record and reconciliation tracker. Captures RAF (Risk Adjustment Factor) scores, HCC (Hierarchical Condition Category) mappings, CMS reconciliation outcomes, and plan-vs-CMS variance analysis. Stores prospective and concurrent RAF scores derived from actuarial models and encounter data, including score effective dates, payment year, model version (CMS-HCC, RxHCC, HHS-HCC, PACE), score components, CMS submission status, plan-calculated vs. CMS-published RAF variance, root cause category (missing diagnoses, HCC hierarchy differences, demographic factors), corrective actions, and resubmission references. Core SSOT for member-level risk in Medicare Advantage, ACA, and Medicaid risk adjustment programs. Subsumes RAF reconciliation tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` (
    `hcc_mapping_id` BIGINT COMMENT 'Primary key for hcc_mapping',
    `age_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier adjusting the HCC coefficient based on member age.',
    `coefficient` DECIMAL(18,2) COMMENT 'Weighting coefficient used in RAF score calculations for the HCC.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mapping record was first loaded into the lakehouse.',
    `demographic_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor adjusting the HCC weight for demographic characteristics (age, gender, etc.).',
    `disease_interaction_group` STRING COMMENT 'Identifier for a group of diagnoses that have interaction effects.',
    `effective_date` DATE COMMENT 'Date when this mapping becomes effective.',
    `expiration_date` DATE COMMENT 'Date when this mapping expires or is superseded; null if still active.',
    `gender_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier adjusting the HCC coefficient based on member gender.',
    `hcc_code` STRING COMMENT 'CMS-assigned HCC identifier linked to the diagnosis.',
    `hcc_description` STRING COMMENT 'Human‑readable description of the HCC.',
    `hcc_mapping_status` STRING COMMENT 'Current lifecycle status of the mapping record.. Valid values are `active|inactive|retired`',
    `hierarchy_level` STRING COMMENT 'Depth of the HCC within the hierarchical structure (0 = top level).',
    `icd10_code` STRING COMMENT 'Standard ICD-10 diagnosis code associated with the mapping.. Valid values are `^[A-TV-Z][0-9][0-9A-Z](.[0-9A-Z]{1,4})?$`',
    `icd10_description` STRING COMMENT 'Full textual description of the ICD-10 diagnosis.',
    `interaction_flag` BOOLEAN COMMENT 'Indicates whether the diagnosis interacts with other HCCs (yes) or not (no).',
    `is_excluded` BOOLEAN COMMENT 'Indicates whether the diagnosis is excluded from the current model year.',
    `is_mapped` BOOLEAN COMMENT 'True if the ICD‑10 code has a valid HCC mapping in this version.',
    `last_review_date` DATE COMMENT 'Date when the mapping was last reviewed for accuracy.',
    `last_updated_by` STRING COMMENT 'Identifier of the user or process that performed the last update.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the mapping record.',
    `mapping_source` STRING COMMENT 'Origin of the mapping data.. Valid values are `CMS|Milliman|Custom`',
    `model_year` STRING COMMENT 'Calendar year of the CMS HCC model version to which the mapping applies.',
    `notes` STRING COMMENT 'Free‑form comments or audit notes regarding the mapping.',
    `parent_hcc_code` STRING COMMENT 'Code of the immediate parent HCC in the hierarchy, if applicable.',
    `plan_type_adjustment_factor` DECIMAL(18,2) COMMENT 'Adjustment factor for the HCC based on the members health plan type (e.g., HMO, PPO).',
    `region_adjustment_factor` DECIMAL(18,2) COMMENT 'Adjustment factor reflecting geographic cost variations.',
    `review_status` STRING COMMENT 'Current status of the most recent review process.. Valid values are `pending|approved|rejected`',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Weight applied to the HCC when aggregating RAF scores.',
    `source_version` STRING COMMENT 'Version identifier of the source CMS model (e.g., V24, V28).',
    CONSTRAINT pk_hcc_mapping PRIMARY KEY(`hcc_mapping_id`)
) COMMENT 'Maps ICD-10 diagnosis codes to Hierarchical Condition Categories (HCCs) per CMS model version. Stores the ICD-to-HCC crosswalk, HCC hierarchy relationships (parent/child HCC hierarchies), coefficient values by model year, disease interaction flags, and demographic adjustment factors. Supports RAF score calculation, RAPS/EDPS submission validation, and RADV audit defense. Reference entity managed per CMS annual model updates (V24, V28 transition). Source: CMS annual HCC model release files.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` (
    `raps_submission_id` BIGINT COMMENT 'System-generated unique identifier for each RAPS submission batch record.',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Group practices are billing entities in risk adjustment — RAPS submissions are often aggregated at the group practice level. Linking raps_submission to group_practice supports group-level risk adjustm',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: RAPS submissions are tied to specific renewal cycles for CMS risk adjustment reconciliation and payment year rate setting. Actuaries and compliance teams need to track which renewal period each RAPS b',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: RAPS submissions contain diagnosis codes attributed to rendering providers. Linking raps_submission to provider enables provider-level risk adjustment analytics, error rate tracking, and supports CMS ',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: RAPS submissions are filed per plan year payment cycle. Linking to plan.year allows joining submissions to plan year configurations, CMS submission deadlines, and open enrollment periods for risk adju',
    `accepted_record_count` STRING COMMENT 'Number of records that CMS accepted without error in this submission.',
    `batch_number` STRING COMMENT 'External batch identifier assigned by the source system for the RAPS submission.',
    `cms_acknowledgment_status` STRING COMMENT 'Acknowledgment status returned by CMS for the submitted batch.. Valid values are `received|processed|accepted|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the data warehouse.',
    `error_disposition` STRING COMMENT 'Textual description of any errors or rejections returned by CMS for this batch.',
    `payment_year` STRING COMMENT 'Calendar year for which the risk adjustment payment is being calculated.',
    `plan_contract_number` STRING COMMENT 'Contract number of the plan submitted to CMS for risk adjustment.',
    `plan_type` STRING COMMENT 'Type of health plan associated with the submission (e.g., HMO, PPO).. Valid values are `hmo|ppo|epo|pos|hdhp`',
    `raps_submission_status` STRING COMMENT 'Current processing status of the RAPS submission within the CMS workflow.. Valid values are `pending|submitted|acknowledged|rejected|error`',
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
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Rate development outputs feed directly into renewal pricing calculations. Actuaries develop rates for specific renewal cycles, incorporating trend factors and experience rating. Required for renewal p',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.service_area. Business justification: Rates are developed by service area (rating area) as required by ACA and state insurance regulations. Geographic rating is mandatory for regulatory filings. Service area demographics, provider costs, ',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Rate filings are regulatory submissions to state insurance departments. Business process: Actuarial rate development results must be filed with DOI; regulatory_submission tracks filing status, due dat',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Rate development is performed per plan year for regulatory filing and actuarial certification. Linking rate_development to plan.year enables joining actuarial assumptions to plan year open enrollment ',
    `administrative_loading` DECIMAL(18,2) COMMENT 'Percentage added to cover administrative expenses.',
    `age_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor based on member age.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate was formally approved for use.',
    `base_rate` DECIMAL(18,2) COMMENT 'Fundamental rate before any rating factors are applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate development record was first created.',
    `credibility_factor` DECIMAL(18,2) COMMENT 'Weighting factor blending experience data with credibility.',
    `development_number` STRING COMMENT 'External reference number assigned to the rate development for tracking and regulatory filing.',
    `effective_date` DATE COMMENT 'Date when the approved rate becomes effective for premium calculations.',
    `expiration_date` DATE COMMENT 'Date when the rate ceases to be effective (nullable for open‑ended rates).',
    `final_approved_rate` DECIMAL(18,2) COMMENT 'Rate after all factors, loadings, and regulatory adjustments are applied.',
    `gender_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor based on member gender.',
    `geographic_factor` DECIMAL(18,2) COMMENT 'Factor reflecting cost differences across rating areas.',
    `group_size_factor` DECIMAL(18,2) COMMENT 'Factor based on the size of the employer group.',
    `industry_factor` DECIMAL(18,2) COMMENT 'Factor derived from the employers industry classification.',
    `line_of_business` STRING COMMENT 'Business segment to which the rate applies (e.g., health, dental).. Valid values are `health|dental|vision|life|disability`',
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
    `regulatory_filing_reference` STRING COMMENT 'Identifier of the state or federal filing associated with this rate.',
    `tobacco_factor` DECIMAL(18,2) COMMENT 'Factor applied for tobacco use status.',
    `trend_factor` DECIMAL(18,2) COMMENT 'Factor used to project future cost trends.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate development record.',
    `version_number` STRING COMMENT 'Sequential version of the rate development record for change tracking.',
    CONSTRAINT pk_rate_development PRIMARY KEY(`rate_development_id`)
) COMMENT 'Captures actuarial rate development records and their constituent rating factors for premium rate-setting across plan types, market segments, and rating areas. Stores rate development ID, rating period, LOB, plan type, geographic rating area, base rate, and all applicable rating factors (age/gender, geographic area, tobacco use, group size, industry, plan-type loading). Includes trend factor application, credibility-weighted experience blending, administrative loading, profit margin, MLR target, final approved rate, and regulatory filing reference. Supports ACA community rating and experience rating methodologies. Source: Milliman MG-ALFA rate-setting models. Links to state DOI rate filings.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` (
    `ibnr_reserve_id` BIGINT COMMENT 'Primary key for ibnr_reserve',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: IBNR reserve estimates are calculated per risk pool; linking provides context and allows roll‑up.',
    `stop_loss_policy_id` BIGINT COMMENT 'Foreign key linking to employer.stop_loss_policy. Business justification: IBNR reserves inform stop-loss attachment point decisions and premium calculations for self-funded groups. Actuaries use IBNR estimates to assess group financial exposure and set appropriate stop-loss',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: IBNR reserves are calculated per plan year for financial close, MLR reporting, and RBC filings. Linking ibnr_reserve to plan.year enables joining reserve amounts to plan year budget amounts, premium e',
    `actuarial_confidence_level` DECIMAL(18,2) COMMENT 'Confidence level (e.g., 0.95) associated with the interval.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the actuarial confidence interval for the IBNR estimate.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the actuarial confidence interval for the IBNR estimate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reserve record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score indicating quality of input data used for reserve.',
    `development_factor` DECIMAL(18,2) COMMENT 'Factor applied to projected losses to estimate ultimate cost.',
    `expected_loss_ratio` DECIMAL(18,2) COMMENT 'Projected loss ratio used in reserve calculation.',
    `external_reserve_code` STRING COMMENT 'Identifier used by external actuarial systems to reference this reserve.',
    `forecast_horizon_months` STRING COMMENT 'Number of months ahead the reserve projection covers.',
    `hcc_weighted_amount` DECIMAL(18,2) COMMENT 'IBNR amount weighted by Hierarchical Condition Category risk scores.',
    `ibnr_amount` DECIMAL(18,2) COMMENT 'Estimated Incurred But Not Reported reserve amount in USD.',
    `ibnr_pmpm` DECIMAL(18,2) COMMENT 'IBNR reserve expressed on a per member per month basis.',
    `ibnr_reserve_status` STRING COMMENT 'Current lifecycle status of the reserve estimate.. Valid values are `draft|approved|finalized|revised`',
    `lob_code` STRING COMMENT 'Code representing the line of business for which the reserve is calculated.. Valid values are `Medical|Dental|Vision|Pharmacy|Behavioral`',
    `notes` STRING COMMENT 'Free-text comments or rationale for the reserve estimate.',
    `plan_type` STRING COMMENT 'Type of health insurance plan associated with the reserve.. Valid values are `HMO|PPO|EPO|POS|HDHP`',
    `raps_submission_flag` BOOLEAN COMMENT 'Indicates if the reserve is included in RAPS submission to CMS.',
    `rbc_impact_amount` DECIMAL(18,2) COMMENT 'Impact of the reserve on Risk Based Capital calculations.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the reserve is required for regulatory reporting (e.g., GAAP, RBC).',
    `reserve_adequacy_flag` BOOLEAN COMMENT 'Assessment of whether the reserve is adequate.',
    `reserve_methodology` STRING COMMENT 'Actuarial method used to calculate the IBNR reserve.. Valid values are `chain_ladder|bornhuetter_ferguson|cape_cod|frequency_severity`',
    `reserve_name` STRING COMMENT 'Human‑readable name or label for the reserve estimate.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor applied to adjust reserve for risk considerations.',
    `service_month` DATE COMMENT 'Month of service for which the IBNR reserve is estimated (first day of month).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reserve record.',
    `valuation_date` DATE COMMENT 'Date on which the reserve estimate was calculated.',
    `version_number` STRING COMMENT 'Version of the reserve estimate for the same valuation date.',
    CONSTRAINT pk_ibnr_reserve PRIMARY KEY(`ibnr_reserve_id`)
) COMMENT 'Stores Incurred But Not Reported (IBNR) reserve estimates by LOB, plan type, service month, and valuation date. Captures reserve methodology (chain-ladder, Bornhuetter-Ferguson, Cape Cod), development factors, expected loss ratios, IBNR amount, IBNR PMPM, actuarial confidence interval, and reserve adequacy assessment. Generated from Milliman MG-ALFA reserving models. Critical for financial close, SAP/GAAP reporting, and RBC calculations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` (
    `radv_audit_id` BIGINT COMMENT 'Unique surrogate key for each RADV audit record.',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: CMS RADV audits are conducted at the group practice level to validate diagnosis submissions. Linking radv_audit to group_practice enables group-level audit tracking, extrapolated payment error calcula',
    `cms_submission_id` BIGINT COMMENT 'Foreign key linking to enrollment.cms_submission. Business justification: RADV audits validate CMS risk adjustment submissions; direct link provides traceability from audit findings to original submission, supports error correction workflows, and enables reconciliation of v',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.eligibility_span. Business justification: RADV audits validate HCC codes against medical records for a specific coverage period. The eligibility_span defines the exact enrollment window in scope for the audit year. CMS RADV audit protocols re',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: RADV audits are conducted at the health plan/contract level. CMS RADV findings, extrapolated payment errors, and final settlements must be reconciled against the specific health plan. contract_number ',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: RADV (Risk Adjustment Data Validation) audits are CMS-initiated audits that directly validate the accuracy of member-level risk scores submitted for Medicare Advantage payment. Each radv_audit record ',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose records were sampled for the audit.',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: RADV audits trace to specific provider participation agreements for medical record retrieval rights and audit cooperation obligations. PAR agreements define provider responsibilities for audit support',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: RADV audits validate HCC codes against enrollment records; linking to plan election enables audit scope determination, member eligibility verification during audit period, and ensures audited diagnose',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: RADV audits validate risk scores against medical records from specific network providers. Network context is required for audit sample stratification, provider documentation quality assessment, and me',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: RADV audits are performed on members within a risk pool; linking provides pool context.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: RADV audits require medical record retrieval from the facility where care was rendered. Linking radv_audit to facility enables auditors to contact the correct facility for record requests and supports',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: CMS RADV audits validate HCC codes from specific provider-submitted diagnoses. Auditors must identify the rendering provider whose medical records are under review to request documentation and track p',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: RADV audits are scoped to specific plan years (audit_year). Linking to plan.year enables joining audit findings to plan year regulatory filing deadlines, CMS submission windows, and annual risk adjust',
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
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `extrapolated_payment_error` DECIMAL(18,2) COMMENT 'Estimated monetary error in payments derived from audit findings, before final settlement.',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'Monetary amount finally paid or recovered after audit resolution.',
    `hcc_mapping_version` STRING COMMENT 'Version of the HCC mapping algorithm used for validation.',
    `medical_record_receipt_date` DATE COMMENT 'Date on which the requested medical records were received.',
    `medical_record_request_status` STRING COMMENT 'Current status of the request for medical records from providers.. Valid values are `pending|requested|received|rejected`',
    `record_created` TIMESTAMP COMMENT 'Timestamp when this audit record was first captured in the data warehouse.',
    `record_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this audit record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'RAF score applied to the member cohort for this audit.',
    `sampled_member_count` STRING COMMENT 'Number of members selected for review in this audit.',
    `validated_hcc_count` STRING COMMENT 'Number of Hierarchical Condition Categories confirmed as accurate after audit.',
    CONSTRAINT pk_radv_audit PRIMARY KEY(`radv_audit_id`)
) COMMENT 'Manages CMS Risk Adjustment Data Validation (RADV) audit records for Medicare Advantage contracts. Captures audit year, contract number, sampled member list, medical record request status, medical record receipt date, CMS audit findings, validated HCC count, extrapolated payment error, appeal status, and final settlement amount. Tracks the full RADV audit lifecycle from CMS notification through final payment reconciliation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` (
    `member_hcc_assignment_id` BIGINT COMMENT 'System-generated unique identifier for the member HCC assignment record.',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to the HCC mapping record (ICD-10 to HCC crosswalk) that applies to this assignment.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to the member risk score record to which this HCC contributes.',
    `coefficient_applied` DECIMAL(18,2) COMMENT 'The actual coefficient value from the hcc_mapping that was applied in this assignment. Stored redundantly to support historical analysis when model coefficients change year-over-year.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HCC assignment record was first created in the data lake.',
    `diagnosis_source` STRING COMMENT 'Source system or data collection method from which the diagnosis (and thus the HCC) was captured. Critical for RADV audit defense and data completeness tracking.',
    `effective_date` DATE COMMENT 'Date when this HCC assignment became effective for the members risk score calculation. May differ from the member_risk_score effective_timestamp if HCCs are added/removed during reconciliation.',
    `hcc_codes` STRING COMMENT 'Pipe‑separated list of HCC codes contributing to the score. [Moved from member_risk_score: This pipe-separated STRING field on member_risk_score is a denormalized representation of the M:N relationship. By normalizing into member_hcc_assignment, each HCC code becomes a separate record with its own contribution_amount, status, and source. This enables proper HCC-level analytics and eliminates the need to parse delimited strings.]',
    `hcc_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric RAF score contribution from this specific HCC to the members total risk score. This is the product of the HCC coefficient and any applicable adjustment factors.',
    `hcc_status` STRING COMMENT 'Current processing status of this HCC assignment. Tracks whether the HCC is actively contributing to the RAF score, suppressed by hierarchy rules, excluded by CMS, or pending validation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this HCC assignment record.',
    `model_version` STRING COMMENT 'Version identifier of the CMS risk adjustment model used for this HCC assignment (e.g., V24, V28). Must match the model_version on the parent member_risk_score.',
    CONSTRAINT pk_member_hcc_assignment PRIMARY KEY(`member_hcc_assignment_id`)
) COMMENT 'This association product represents the assignment of Hierarchical Condition Categories (HCCs) to member risk scores in CMS risk adjustment programs. It captures the operational linkage between a members RAF score calculation and the specific HCC codes that contribute to that score. Each record links one member_risk_score to one hcc_mapping with attributes that exist only in the context of this relationship: the coefficient applied, the contribution amount to the RAF score, the diagnosis source, and the HCC validation status. This is the normalized representation of the denormalized hcc_codes STRING field currently stored on member_risk_score, enabling HCC-level analytics, RADV audit defense, and CMS submission accuracy tracking.. Existence Justification: In Medicare Advantage risk adjustment, a members RAF score is calculated as the sum of contributions from multiple HCC codes, and each HCC code (via its ICD-10 mapping) contributes to many member risk scores across the population. The business actively manages these HCC assignments through diagnosis capture, coding validation, CMS submission, and RADV audit processes. The relationship has operational data (contribution amounts, effective dates, validation status, diagnosis source) that belongs to neither the member risk score nor the HCC mapping alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ADD CONSTRAINT `fk_risk_member_hcc_assignment_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ADD CONSTRAINT `fk_risk_member_hcc_assignment_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `audit_user` SET TAGS ('dbx_business_glossary_term' = 'Audit User');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_published_score` SET TAGS ('dbx_business_glossary_term' = 'CMS Published RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('dbx_value_regex' = 'submitted|accepted|rejected|pending');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `demographic_factor_score` SET TAGS ('dbx_business_glossary_term' = 'Demographic Factor Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Score Effective Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Score Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `manual_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Reason');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `plan_calculated_score` SET TAGS ('dbx_business_glossary_term' = 'Plan Calculated RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `resubmission_reference` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reference');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_adjustment_factor_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Code');
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
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('dbx_value_regex' = 'missing_diagnoses|hierarchy_diff|demographic|other');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `age_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Age Adjustment Factor (AGE_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `coefficient` SET TAGS ('dbx_business_glossary_term' = 'HCC Coefficient (COEF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `demographic_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Demographic Adjustment Factor (DEMOG_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `disease_interaction_group` SET TAGS ('dbx_business_glossary_term' = 'Disease Interaction Group (DI_GROUP)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Gender Adjustment Factor (GENDER_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Code (HCC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Description (HCC_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (HIER_LEVEL)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Diagnosis Code (ICD10)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('dbx_value_regex' = '^[A-TV-Z][0-9][0-9A-Z](.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_description` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Diagnosis Description (ICD10_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `interaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Disease Interaction Flag (INTERACT_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Is Excluded Flag (EXCLUDED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_mapped` SET TAGS ('dbx_business_glossary_term' = 'Is Mapped Flag (MAPPED)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (REVIEW_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By (UPDATED_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('dbx_business_glossary_term' = 'Mapping Source (MAP_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('dbx_value_regex' = 'CMS|Milliman|Custom');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MODEL_YEAR)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `parent_hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Parent HCC Code (PARENT_HCC)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `plan_type_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Plan Type Adjustment Factor (PLAN_TYPE_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `region_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Region Adjustment Factor (REGION_ADJ)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status (REVIEW_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight (RS_WEIGHT)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `source_version` SET TAGS ('dbx_business_glossary_term' = 'Source Version (SRC_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_id` SET TAGS ('dbx_business_glossary_term' = 'RAPS Submission Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('dbx_business_glossary_term' = 'Accepted Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'received|processed|accepted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `error_disposition` SET TAGS ('dbx_business_glossary_term' = 'Error Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|acknowledged|rejected|error');
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
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('dbx_subdomain' = 'actuarial_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_development_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Development Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `administrative_loading` SET TAGS ('dbx_business_glossary_term' = 'Administrative Loading');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `age_factor` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `credibility_factor` SET TAGS ('dbx_business_glossary_term' = 'Credibility Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `development_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Development Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `final_approved_rate` SET TAGS ('dbx_business_glossary_term' = 'Final Approved Rate (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('dbx_business_glossary_term' = 'Gender Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `geographic_factor` SET TAGS ('dbx_business_glossary_term' = 'Geographic Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `group_size_factor` SET TAGS ('dbx_business_glossary_term' = 'Group Size Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `industry_factor` SET TAGS ('dbx_business_glossary_term' = 'Industry Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'health|dental|vision|life|disability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `mlr_target` SET TAGS ('dbx_business_glossary_term' = 'Medical Loss Ratio (MLR) Target');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Development Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `plan_type_loading` SET TAGS ('dbx_business_glossary_term' = 'Plan Type Loading');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `profit_margin` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_development_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Development Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_development_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|active|inactive');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rate Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_methodology` SET TAGS ('dbx_value_regex' = 'community|experience|blended');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_area` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_period_end` SET TAGS ('dbx_business_glossary_term' = 'Rating Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_period_end` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_period_start` SET TAGS ('dbx_business_glossary_term' = 'Rating Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_period_start` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `tobacco_factor` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Use Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `trend_factor` SET TAGS ('dbx_business_glossary_term' = 'Trend Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('dbx_subdomain' = 'actuarial_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ibnr Reserve Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `stop_loss_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `actuarial_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Confidence Level');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `development_factor` SET TAGS ('dbx_business_glossary_term' = 'Development Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `expected_loss_ratio` SET TAGS ('dbx_business_glossary_term' = 'Expected Loss Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `external_reserve_code` SET TAGS ('dbx_business_glossary_term' = 'External Reserve Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `forecast_horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `hcc_weighted_amount` SET TAGS ('dbx_business_glossary_term' = 'HCC Weighted IBNR Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_amount` SET TAGS ('dbx_business_glossary_term' = 'IBNR Reserve Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_pmpm` SET TAGS ('dbx_business_glossary_term' = 'IBNR Per Member Per Month');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_status` SET TAGS ('dbx_value_regex' = 'draft|approved|finalized|revised');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `lob_code` SET TAGS ('dbx_value_regex' = 'Medical|Dental|Vision|Pharmacy|Behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `raps_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'RAPS Submission Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `rbc_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'RBC Impact Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_adequacy_flag` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Assessment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_methodology` SET TAGS ('dbx_business_glossary_term' = 'Reserve Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_methodology` SET TAGS ('dbx_value_regex' = 'chain_ladder|bornhuetter_ferguson|cape_cod|frequency_severity');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_name` SET TAGS ('dbx_business_glossary_term' = 'Reserve Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `service_month` SET TAGS ('dbx_business_glossary_term' = 'Service Month');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `radv_audit_id` SET TAGS ('dbx_business_glossary_term' = 'RADV Audit ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Group Practice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `cms_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Cms Submission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
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
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `extrapolated_payment_error` SET TAGS ('dbx_business_glossary_term' = 'Extrapolated Payment Error (EPE)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Amount (FSA)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `hcc_mapping_version` SET TAGS ('dbx_business_glossary_term' = 'HCC Mapping Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Receipt Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_value_regex' = 'pending|requested|received|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `sampled_member_count` SET TAGS ('dbx_business_glossary_term' = 'Sampled Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `validated_hcc_count` SET TAGS ('dbx_business_glossary_term' = 'Validated HCC Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` SET TAGS ('dbx_association_edges' = 'risk.member_risk_score,risk.hcc_mapping');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `member_hcc_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Member HCC Assignment ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Member Hcc Assignment - Hcc Mapping Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Hcc Assignment - Member Risk Score Id');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `coefficient_applied` SET TAGS ('dbx_business_glossary_term' = 'Coefficient Applied');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'HCC Assignment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `hcc_codes` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Codes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `hcc_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'HCC Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `hcc_status` SET TAGS ('dbx_business_glossary_term' = 'HCC Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_hcc_assignment` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
