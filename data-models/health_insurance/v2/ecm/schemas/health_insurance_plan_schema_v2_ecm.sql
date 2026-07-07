-- Schema for Domain: plan | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`plan` COMMENT 'Single source of truth for all health plan products and benefit designs — HMO, PPO, EPO, POS, HDHP, QHP, and government plans (Medicare Advantage, Medicaid). Owns benefit structures, cost-sharing rules (deductibles, copays, coinsurance, OOP, MOOP), formulary tiers, SBC documents, plan-year configurations, and regulatory classifications. Supports ACA compliance, CMS plan submissions, and benefits configuration in core administration platforms (Facets, QNXT).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` (
    `health_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the health plan record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for budgeting and expense tracking of each health plan; finance cost center reports aggregate plan costs.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Maps each health plan to its primary general ledger account for recording premiums, claims, and administrative expenses.',
    `formulary_id` BIGINT COMMENT 'Reference to the formulary that defines drug tiering and coverage for the plan.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network associated with the plan.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Required for underwriting and risk‑adjustment calculations linking each health plan to its associated risk pool, used in actuarial models and regulatory reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Required for PBM vendor assignment per health plan to manage formulary and meet ACA reporting.',
    `benefit_design_version` STRING COMMENT 'Version identifier for the benefit design configuration.',
    `cms_plan_code` STRING COMMENT 'CMS plan identifier used for regulatory reporting.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays after deductible is met.',
    `copay_primary_care` DECIMAL(18,2) COMMENT 'Fixed copayment amount for a primary care office visit.',
    `copay_specialist` DECIMAL(18,2) COMMENT 'Fixed copayment amount for a specialist office visit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_family` DECIMAL(18,2) COMMENT 'Annual amount a family must pay before cost‑sharing begins.',
    `deductible_individual` DECIMAL(18,2) COMMENT 'Annual amount an individual member must pay before cost‑sharing begins.',
    `effective_date` DATE COMMENT 'Date the plan becomes binding for members.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `enrollment_end_date` DATE COMMENT 'Last date members may enroll in the plan for the plan year.',
    `enrollment_start_date` DATE COMMENT 'First date members may enroll in the plan for the plan year.',
    `fhir_coverage_plan_resource_identifier` STRING COMMENT 'FHIR resource identifier for interoperability',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hcc_score` DECIMAL(18,2) COMMENT 'Aggregated HCC score for the plan population used in risk adjustment.',
    `hios_plan_code` STRING COMMENT 'CMS‑assigned HIOS identifier for the plan.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_exempt_from_mlr` BOOLEAN COMMENT 'Indicates whether the plan is exempt from Medical Loss Ratio reporting requirements.',
    `last_review_date` DATE COMMENT 'Date the plan design was last reviewed for compliance or pricing updates.',
    `line_of_business` STRING COMMENT 'Broad business segment the plan belongs to, such as commercial or government.. Valid values are `commercial|government`',
    `market_segment` STRING COMMENT 'Target market for the plan: individual, small group, large group, Medicare, or Medicaid.. Valid values are `individual|small_group|large_group|medicare|medicaid`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_tier` STRING COMMENT 'Tier classification of the network (e.g., Tier1, Tier2).. Valid values are `tier1|tier2|tier3|tier4`',
    `out_of_pocket_max_family` DECIMAL(18,2) COMMENT 'Maximum amount a family pays in a year before the plan pays 100% of covered services.',
    `out_of_pocket_max_individual` DECIMAL(18,2) COMMENT 'Maximum amount an individual pays in a year before the plan pays 100% of covered services.',
    `plan_aca_compliant` BOOLEAN COMMENT 'True if the plan meets all Affordable Care Act regulatory requirements.',
    `plan_category` STRING COMMENT 'High‑level category indicating commercial, government, or special market plans.. Valid values are `commercial|government|special`',
    `plan_code` STRING COMMENT 'Business identifier code used in core administration platforms to reference the plan.',
    `plan_description` STRING COMMENT 'Narrative description of the plans benefits and target audience.',
    `plan_marketplace_eligible` BOOLEAN COMMENT 'Indicates if the plan can be sold on the ACA Health Insurance Marketplace.',
    `plan_name` STRING COMMENT 'Human‑readable name of the health plan as marketed to members.',
    `plan_region` STRING COMMENT 'Geographic region (e.g., Northeast, Midwest) for reporting and network adequacy.',
    `plan_state` STRING COMMENT 'Two‑letter US state abbreviation where the plan is offered.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `active|inactive|suspended|pending|terminated`',
    `plan_type` STRING COMMENT 'Classification of the plan product (e.g., HMO, PPO, EPO, POS, HDHP, QHP, Medicare Advantage, Medicaid).',
    `plan_year` STRING COMMENT 'Calendar year for which the plan design is effective.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Base premium amount charged to the member or group for the plan year.',
    `premium_currency` STRING COMMENT 'ISO 4217 currency code for the premium amount.',
    `premium_frequency` STRING COMMENT 'Billing frequency for the premium (monthly, quarterly, annually).. Valid values are `monthly|quarterly|annually`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_classification` STRING COMMENT 'Regulatory category of the plan (e.g., ACA, Medicare, Medicaid).',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk‑adjusted payments under CMS risk adjustment models.',
    `sbc_document_url` STRING COMMENT 'Link to the electronic Summary of Benefits and Coverage document for the plan.',
    `termination_date` DATE COMMENT 'Date the plan is terminated or expires; null if open‑ended.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan record.',
    `fhir_coverage_plan_resource_id` STRING COMMENT '',
    CONSTRAINT pk_health_plan PRIMARY KEY(`health_plan_id`)
) COMMENT 'Master catalog of all health plan products offered by the insurer — HMO, PPO, EPO, POS, HDHP, QHP, Medicare Advantage, and Medicaid managed care plans. Serves as the SSOT for plan identity, plan type classification, line of business (LOB), market segment (individual, small group, large group, Medicare, Medicaid), regulatory classification, CMS plan ID, HIOS plan ID, plan-year lifecycle, and provider network configuration (network ID, tiered network designations, access type, out-of-network coverage rules, network adequacy standards). Foundational entity for all benefit configuration, enrollment, and claims adjudication in Facets/QNXT.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` (
    `benefit_package_id` BIGINT COMMENT 'System-generated unique identifier for the benefit package record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: A benefit package is defined for a specific health plan. Adding health_plan_id to benefit_package creates the necessary parent relationship and prevents the package from being a silo.',
    `formulary_id` BIGINT COMMENT 'Identifier of the drug formulary linked to this benefit package.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Normalizes pharmacy_vendor name to vendor reference for PBM contract tracking and cost analysis.',
    `actuarial_value_pct` DECIMAL(18,2) COMMENT 'Percentage of total average costs the plan is expected to cover, expressed as a percent.',
    `benefit_package_status` STRING COMMENT 'Current lifecycle status of the benefit package.. Valid values are `active|inactive|pending|retired`',
    `coinsurance_inpatient` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays for inpatient services after deductible.',
    `coinsurance_outpatient` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays for outpatient services after deductible.',
    `copay_primary_care` DECIMAL(18,2) COMMENT 'Fixed dollar copay for a primary care office visit.',
    `copay_specialist` DECIMAL(18,2) COMMENT 'Fixed dollar copay for a specialist office visit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit package record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_type` STRING COMMENT 'Indicates whether the deductible is embedded (per member) or aggregate (family).. Valid values are `embedded|aggregate`',
    `effective_end_date` DATE COMMENT 'Date on which the benefit package expires or is superseded (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the benefit package becomes effective.',
    `family_deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount a family must pay before cost‑sharing begins for the family unit.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.coverage.benefit)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `generic_substitution_required` BOOLEAN COMMENT 'Indicates whether generic substitution is mandatory when a generic equivalent is available.',
    `individual_deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount an individual must pay before cost‑sharing begins.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `mail_order_copay_brand` DECIMAL(18,2) COMMENT 'Fixed copay for brand‑name drugs dispensed via mail‑order.',
    `mail_order_copay_generic` DECIMAL(18,2) COMMENT 'Fixed copay for generic drugs dispensed via mail‑order.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `metal_tier` STRING COMMENT 'ACA metal tier designation indicating the level of coverage.. Valid values are `bronze|silver|gold|platinum`',
    `network_designation` STRING COMMENT 'Indicates whether the benefit package applies to in‑network or out‑of‑network providers.. Valid values are `in_network|out_of_network`',
    `out_of_pocket_max_family` DECIMAL(18,2) COMMENT 'Maximum amount a family will pay in a plan year for covered services.',
    `out_of_pocket_max_individual` DECIMAL(18,2) COMMENT 'Maximum amount an individual will pay in a plan year for covered services.',
    `package_code` STRING COMMENT 'External business code or number used to identify the benefit package in plan documents and communications.',
    `package_name` STRING COMMENT 'Human‑readable name of the benefit package (e.g., "Silver 2024 PPO").',
    `plan_type` STRING COMMENT 'Classification of the health plan product type.. Valid values are `HMO|PPO|EPO|POS|HDHP|QHP`',
    `prior_auth_required` BOOLEAN COMMENT 'Indicates whether a prior authorization is required for services covered under this package.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `retail_copay_brand` DECIMAL(18,2) COMMENT 'Fixed copay for brand‑name drugs dispensed at retail pharmacies.',
    `retail_copay_generic` DECIMAL(18,2) COMMENT 'Fixed copay for generic drugs dispensed at retail pharmacies.',
    `specialty_copay` DECIMAL(18,2) COMMENT 'Fixed copay for specialty pharmacy drugs.',
    `specialty_drug_management_program` STRING COMMENT 'Name or description of the management program applied to specialty drugs (e.g., step therapy, limited distribution).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the benefit package record.',
    CONSTRAINT pk_benefit_package PRIMARY KEY(`benefit_package_id`)
) COMMENT 'Defines the structured benefit package associated with a health plan and plan year, grouping all covered services into a coherent benefit design. Captures package name, effective dates, plan-year, benefit tier (Bronze, Silver, Gold, Platinum for ACA QHPs), actuarial value percentage, metal tier classification, embedded vs. aggregate deductible design, and full pharmacy benefit configuration — PBM vendor, formulary ID, retail vs. mail-order copay differentials, specialty pharmacy requirements, 90-day supply rules, mandatory generic substitution flags, specialty drug management programs, and retail/mail-order/specialty pharmacy network designations. One health plan may have multiple benefit packages across plan years. Sourced from benefits administration and PBM integration (RxClaim/Argus).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`benefit` (
    `benefit_id` BIGINT COMMENT 'Unique surrogate key for each benefit record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which this benefit belongs.',
    `accumulation_rule` STRING COMMENT 'Rule governing how limits accumulate across periods.. Valid values are `cumulative|reset_annually|none`',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether the benefit requires prior authorization.',
    `authorization_type` STRING COMMENT 'Timing of the required authorization relative to service delivery.. Valid values are `pre|concurrent|post|none`',
    `benefit_group` STRING COMMENT 'Member group to which the benefit applies.. Valid values are `employee|spouse|dependent|family|individual`',
    `benefit_status` STRING COMMENT 'Current lifecycle status of the benefit record.. Valid values are `active|inactive|suspended|pending`',
    `benefit_category` STRING COMMENT 'High‑level classification of the benefit type. [ENUM-REF-CANDIDATE: medical|dental|vision|pharmacy|behavioral|dme|snf|home_health|wellness|ancillary — 10 candidates stripped; promote to reference product]',
    `benefit_code` STRING COMMENT 'Business identifier or code used in core administration platforms to reference the benefit.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount for copay or deductible (if applicable).',
    `cost_sharing_frequency` STRING COMMENT 'Frequency at which cost‑sharing applies.. Valid values are `per_visit|per_month|annual|lifetime`',
    `cost_sharing_percent` DECIMAL(18,2) COMMENT 'Percentage for coinsurance (e.g., 20.00 for 20%).',
    `cost_sharing_type` STRING COMMENT 'Mechanism by which the member shares cost (deductible, copay, coinsurance, or none).. Valid values are `deductible|copay|coinsurance|none`',
    `coverage_type` STRING COMMENT 'Indicates whether the benefit applies to in‑network, out‑of‑network, or both provider sets.. Valid values are `in_network|out_of_network|both`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `diagnosis_code` STRING COMMENT 'Diagnosis code that may trigger the benefit or exclusion.',
    `drug_ndc` STRING COMMENT 'NDC identifier for pharmacy benefits, when applicable.',
    `effective_end_date` DATE COMMENT 'Date when the benefit ceases to be active; null for open‑ended benefits.',
    `effective_start_date` DATE COMMENT 'Date when the benefit becomes active for the plan year.',
    `ehb_classification` STRING COMMENT 'Flag indicating if the benefit satisfies ACA Essential Health Benefit requirements.. Valid values are `yes|no`',
    `exclusion_code` STRING COMMENT 'Code identifying the specific excluded service (e.g., CPT, HCPCS, NDC).',
    `exclusion_reason` STRING COMMENT 'Narrative reason for the exclusion (e.g., "experimental", "non‑covered diagnosis").',
    `exclusion_type` STRING COMMENT 'Category of service that is excluded from coverage.. Valid values are `service|diagnosis|provider|none`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.coverage.benefit)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `formulary_tier` STRING COMMENT 'Tier classification within the drug formulary.. Valid values are `generic|preferred|non_preferred|specialty`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_exempt` BOOLEAN COMMENT 'True if the benefit is exempt from certain regulations or cost‑sharing.',
    `is_mandatory` BOOLEAN COMMENT 'True if the benefit is required by law or contract.',
    `limit_period` STRING COMMENT 'Timeframe over which the limit applies.. Valid values are `per_year|per_lifetime|per_month`',
    `limit_type` STRING COMMENT 'Type of utilization limit (e.g., number of visits, days, dollar amount).. Valid values are `visit|day|dollar|none`',
    `limit_value` DECIMAL(18,2) COMMENT 'Numeric value associated with the limit type.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `moop_max_amount` DECIMAL(18,2) COMMENT 'Maximum out‑of‑pocket expense for the entire plan year, including deductibles and copays.',
    `benefit_name` STRING COMMENT 'Human‑readable name of the benefit (e.g., "Office Visit", "Generic Drug Tier 1").',
    `oop_max_amount` DECIMAL(18,2) COMMENT 'Maximum out‑of‑pocket expense a member can incur in a benefit year.',
    `plan_year` STRING COMMENT 'Calendar year to which the benefit configuration applies.',
    `preventive_service_flag` BOOLEAN COMMENT 'True if the benefit is classified as a preventive service under ACA.',
    `prior_auth_review_level` STRING COMMENT 'Level of review required for the authorization (e.g., provider, clinical, pharmacy).. Valid values are `provider|clinical|pharmacy|none`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_classification` STRING COMMENT 'Regulatory category governing the benefit (ACA Essential Health Benefit, state‑specific, etc.).. Valid values are `ACA_EHB|non_EHB|state_specific|federal`',
    `service_code` STRING COMMENT 'Procedure or service code associated with the benefit.',
    `tier` STRING COMMENT 'Tier designation used in formulary or cost‑sharing structures.. Valid values are `tier1|tier2|tier3|tier4`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the benefit record.',
    `wellness_mandate_flag` BOOLEAN COMMENT 'True if the benefit is mandated by wellness legislation or employer policy.',
    CONSTRAINT pk_benefit PRIMARY KEY(`benefit_id`)
) COMMENT 'Granular catalog of individual covered benefits within a benefit package — medical, dental, vision, behavioral health, pharmacy, DME, SNF, home health, preventive, wellness, and ancillary services. Each benefit record captures the benefit category, CPT/HCPCS service category, coverage type (in-network, out-of-network), and serves as the anchor for child-level structures: benefit limits (visit limits, day limits, dollar limits as child arrays), exclusions and non-covered service rules (as child arrays), ACA Essential Health Benefit (EHB) classification, wellness/preventive mandate flags, and prior authorization requirement indicators. Directly drives claims adjudication rules in Facets/QNXT. Sub-entities modeled as child arrays: benefit_limit (limit_type, limit_value, limit_period, accumulation_rule), benefit_exclusion (exclusion_type, exclusion_code, exclusion_reason), and benefit_authorization_flag (auth_required, auth_type, review_level).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` (
    `cost_share_rule_id` BIGINT COMMENT 'System-generated unique identifier for the cost share rule.',
    `benefit_id` BIGINT COMMENT 'Identifier of the specific benefit (e.g., office visit) that the rule applies to.',
    `benefit_package_id` BIGINT COMMENT 'Identifier of the benefit package (group of benefits) containing the rule.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which the rule belongs.',
    `accumulator_threshold` DECIMAL(18,2) COMMENT 'Threshold amount that triggers a change in cost‑share (e.g., after $1,000 of spend).',
    `accumulator_unit` STRING COMMENT 'Unit of measure for the accumulator threshold.. Valid values are `dollar|visit|day|procedure|service|unit`',
    `after_deductible` BOOLEAN COMMENT 'True if the cost‑share applies after the deductible is satisfied.',
    `applies_to_ancillary` BOOLEAN COMMENT 'True if the rule applies to ancillary services (lab, imaging).',
    `applies_to_drug` BOOLEAN COMMENT 'True if the rule applies to prescription drug services.',
    `applies_to_procedure` BOOLEAN COMMENT 'True if the rule applies to medical procedures (CPT/HCPCS).',
    `applies_to_service_category` STRING COMMENT 'Service categories to which the rule applies.. Valid values are `inpatient|outpatient|emergency|pharmacy|dental|vision`',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays after deductible (in‑network).',
    `coinsurance_rate_out_of_network` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays after deductible (out‑of‑network).',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar copay applied to a service when in‑network.',
    `copay_amount_out_of_network` DECIMAL(18,2) COMMENT 'Fixed dollar copay applied to a service when out‑of‑network.',
    `cost_share_category` STRING COMMENT 'Logical grouping of the rule relative to deductible and out‑of‑pocket phases.. Valid values are `preventive_exempt|before_deductible|after_deductible|post_moop`',
    `cost_share_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|pending|retired|draft`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_aggregate_flag` BOOLEAN COMMENT 'True if the deductible aggregates across multiple services or members.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the deductible that must be satisfied before cost‑share applies.',
    `deductible_embedded_flag` BOOLEAN COMMENT 'True if the deductible is embedded within the cost‑share rule (e.g., for HDHPs).',
    `cost_share_rule_description` STRING COMMENT 'Free‑form description of the rules purpose and application.',
    `effective_end_date` DATE COMMENT 'Date when the rule expires (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the rule becomes effective.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hsa_compatible` BOOLEAN COMMENT 'True if the rule is compatible with a Health Savings Account (HDHP).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_default_rule` BOOLEAN COMMENT 'True if this rule is the default for its benefit when no other rule matches.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount payable under this rule per service occurrence.',
    `max_benefit_units` STRING COMMENT 'Maximum number of units (e.g., visits) payable under this rule per benefit period.',
    `member_tier` STRING COMMENT 'Member classification for which the rule applies (individual, family, or group).. Valid values are `individual|family|group`',
    `network_type` STRING COMMENT 'Indicates whether the rule applies to in‑network, out‑of‑network, or both provider networks.. Valid values are `in_network|out_of_network|both`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Maximum amount an individual member can pay out of pocket in a plan year.',
    `out_of_pocket_max_family` DECIMAL(18,2) COMMENT 'Maximum amount a family can pay out of pocket in a plan year.',
    `prior_to_deductible` BOOLEAN COMMENT 'True if the cost‑share applies before the deductible is satisfied.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_classification` STRING COMMENT 'Regulatory framework governing the rule (e.g., ACA, CMS).. Valid values are `ACA|CMS|HIPAA|NAIC|state|federal`',
    `rule_code` STRING COMMENT 'Business code used to reference the rule in downstream systems.',
    `rule_name` STRING COMMENT 'Human‑readable name of the cost‑share rule.',
    `rule_type` STRING COMMENT 'Category of cost‑share rule (e.g., deductible, copay, coinsurance).. Valid values are `deductible|copay|coinsurance|out_of_pocket_max|accumulator|other`',
    `rule_version` STRING COMMENT 'Incremental version number for change management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule.',
    CONSTRAINT pk_cost_share_rule PRIMARY KEY(`cost_share_rule_id`)
) COMMENT 'Defines cost-sharing parameters for a specific benefit within a benefit package — deductibles, copays, coinsurance rates, out-of-pocket maximums (MOOP), and accumulator threshold definitions. Captures in-network vs. out-of-network differentials, individual vs. family tier logic, embedded vs. aggregate deductible flags, HSA-compatibility indicators for HDHP plans, cost-share tier (preventive exempt, before-deductible, after-deductible), and whether cost share applies before or after deductible satisfaction. Authoritative source for member cost-sharing design used in EOB generation and claims adjudication configuration.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`year` (
    `year_id` BIGINT COMMENT 'Unique surrogate key for each plan year configuration record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key reference to the master health plan that this year configuration belongs to.',
    `aca_compliance_indicator` BOOLEAN COMMENT 'True if the plan year meets Affordable Care Act reporting requirements.',
    `accumulator_reset_date` DATE COMMENT 'Date on which annual benefit accumulators (e.g., deductibles) are reset.',
    `cms_plan_submission_deadline` DATE COMMENT 'Final date to submit plan year details to Centers for Medicare & Medicaid Services.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan year record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency for premium amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date on which the plan year becomes legally effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date on which the plan year ceases to be effective (nullable for open‑ended plans).',
    `end_date` DATE COMMENT 'Last day of the plan year coverage period.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grace_period_days` STRING COMMENT 'Number of days after premium due date before coverage is terminated.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `open_enrollment_end_date` DATE COMMENT 'Last day of the open enrollment window for this plan year.',
    `open_enrollment_start_date` DATE COMMENT 'First day members may enroll or make changes for this plan year.',
    `plan_year_budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for the plan year (used for internal financial planning).',
    `plan_year_code` STRING COMMENT 'Business identifier or code assigned to the plan year (e.g., FY2024-01).',
    `plan_year_coverage_type` STRING COMMENT 'Design of the health plan offering for the year.. Valid values are `HMO|PPO|EPO|POS|HDHP|QHP`',
    `plan_year_description` STRING COMMENT 'Narrative description of the plan year configuration.',
    `plan_year_market_segment` STRING COMMENT 'Target market segment for the plan year (e.g., individual, group, government).. Valid values are `individual|group|government`',
    `plan_year_notes` STRING COMMENT 'Free‑form notes or comments entered by administrators.',
    `plan_year_premium_rate` DECIMAL(18,2) COMMENT 'Base premium rate applied to members for this plan year.',
    `plan_year_regulatory_classification` STRING COMMENT 'Regulatory category governing the plan year.. Valid values are `Medicare Advantage|Medicaid|Marketplace|Employer Sponsored`',
    `plan_year_state` STRING COMMENT 'Two‑letter state abbreviation where the plan year is offered.. Valid values are `^[A-Z]{2}$`',
    `plan_year_type` STRING COMMENT 'Classification of the plan year calendar basis: calendar year, fiscal year, or custom.. Valid values are `calendar|fiscal|custom`',
    `premium_effective_date` DATE COMMENT 'Date when the premium amount for the plan year takes effect.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether a regulatory filing is required for this plan year.',
    `revision_number` STRING COMMENT 'Revision identifier for changes made within a version.',
    `run_out_period_days` STRING COMMENT 'Days after plan year end during which claims can still be submitted.',
    `special_enrollment_period_rules` STRING COMMENT 'Textual rules governing qualifying life events and special enrollment periods.',
    `start_date` DATE COMMENT 'First day of the plan year coverage period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan year record.',
    `version_number` STRING COMMENT 'Sequential version number for the plan year configuration.',
    `year_status` STRING COMMENT 'Current lifecycle status of the plan year configuration.. Valid values are `active|inactive|pending|closed|draft`',
    CONSTRAINT pk_year PRIMARY KEY(`year_id`)
) COMMENT 'Defines the plan year configuration for each health plan — plan year start and end dates, open enrollment window, special enrollment period rules, grace period duration, run-out period, and plan year type (calendar year vs. non-calendar year). Governs accumulator reset logic, benefit renewal, and premium rate effective dates. Supports ACA plan year compliance and CMS reporting requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` (
    `sbc_document_id` BIGINT COMMENT 'System-generated unique identifier for each SBC document record.',
    `health_plan_id` BIGINT COMMENT 'Foreign‑key reference to the health‑plan to which this SBC belongs.',
    `approval_date` DATE COMMENT 'Date the regulator approved the SBC for public distribution.',
    `author` STRING COMMENT 'Name of the internal team or individual that authored the SBC.',
    `checksum_sha256` STRING COMMENT 'Cryptographic hash used to verify document integrity.. Valid values are `^[a-fA-F0-9]{64}$`',
    `cost_sharing_highlights` STRING COMMENT 'Key cost‑sharing figures (deductible, copay, coinsurance, OOP, MOOP) summarized for quick reference.',
    `coverage_example` STRING COMMENT 'Standardized example scenario (e.g., having a baby) used in the SBC to illustrate cost sharing.. Valid values are `birth|chronic|surgery|preventive|mental_health`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SBC record was first created in the data lake.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `document_category` STRING COMMENT 'Category of plan to which the SBC applies (individual, group, or government).. Valid values are `individual|group|government`',
    `document_number` STRING COMMENT 'Business identifier assigned by the core administration platform for tracking SBC versions.',
    `document_size_bytes` BIGINT COMMENT 'File size of the SBC document in bytes.',
    `document_title` STRING COMMENT 'Human‑readable title of the SBC document, typically the plan name and year.',
    `document_type` STRING COMMENT 'Classification of the SBC document (base SBC, amendment, or translated version).. Valid values are `sbc|sbc_amendment|sbc_translation`',
    `document_url` STRING COMMENT 'Web address or storage path where the SBC file can be retrieved.',
    `effective_date` DATE COMMENT 'Date on which the SBC terms become effective for members.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date on which the SBC document is superseded or expires; null if open‑ended.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: DocumentReference)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `format` STRING COMMENT 'File format in which the SBC is stored.. Valid values are `pdf|html|xml`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this version is the active SBC for the plan year.',
    `language` STRING COMMENT 'ISO language code of the SBC document version.. Valid values are `en|es|fr|zh|ar`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `plan_year` STRING COMMENT 'Calendar year for which the SBC applies.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_submission_status` STRING COMMENT 'Status of the SBCs submission to CMS/ACA compliance pipelines.. Valid values are `not_submitted|submitted|approved|rejected`',
    `revision_number` STRING COMMENT 'Incremental revision identifier used for internal change tracking.',
    `sbc_document_status` STRING COMMENT 'Current lifecycle state of the SBC document.. Valid values are `draft|active|archived|retracted`',
    `sbc_version` STRING COMMENT 'Alphanumeric version code (e.g., 2023Q1) used in external disclosures.',
    `submission_date` DATE COMMENT 'Date the SBC was submitted to the regulator.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the SBC record.',
    `version_number` STRING COMMENT 'Sequential version number for the SBC document within a plan year.',
    CONSTRAINT pk_sbc_document PRIMARY KEY(`sbc_document_id`)
) COMMENT 'Summary of Benefits and Coverage (SBC) document record for each health plan and plan year, as mandated by ACA Section 2715. Captures the SBC version, effective date, plan year, language, format (PDF, HTML), CMS-standardized coverage examples (having a baby, managing a chronic condition), key cost-sharing highlights, and regulatory submission status. Supports ACA compliance, CMS plan submissions, and member disclosure obligations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`rate` (
    `rate_id` BIGINT COMMENT 'Unique surrogate key for each plan rate record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which this rate applies.',
    `age_rated_premium` DECIMAL(18,2) COMMENT 'Premium amount after applying the age factor to the base rate.',
    `base_rate` DECIMAL(18,2) COMMENT 'Base premium amount before age or family adjustments, expressed in the plan currency.',
    `change_reason` STRING COMMENT 'Free‑text explanation for why the rate was created or modified.',
    `rate_code` STRING COMMENT 'External code used by actuarial systems to identify the rate.',
    `cost_sharing_rule_code` STRING COMMENT 'Code that identifies the cost‑sharing rule (deductible, copay, coinsurance) associated with the plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the premium amounts (e.g., USD).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the rate becomes effective for enrollment.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `family_tier` STRING COMMENT 'Category of coverage for the enrollee: employee only, employee + spouse, employee + child, or family.. Valid values are `employee_only|employee_spouse|employee_child|family`',
    `family_tier_premium` DECIMAL(18,2) COMMENT 'Premium amount for the specified family tier.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.plan.specificCost)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_reference` STRING COMMENT 'Reference number for the filing submitted to the Department of Insurance.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_tobacco_surcharge_applicable` BOOLEAN COMMENT 'Indicates if a tobacco surcharge is applied to this rate.',
    `market_segment` STRING COMMENT 'Segment of the market the rate applies to: individual, small group, or large group.. Valid values are `individual|small_group|large_group`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_age` STRING COMMENT 'Inclusive upper bound of the age band for this rate.',
    `min_age` STRING COMMENT 'Inclusive lower bound of the age band for this rate.',
    `rate_name` STRING COMMENT 'Human‑readable name for the rate definition.',
    `plan_designation` STRING COMMENT 'Type of health plan product (e.g., HMO, PPO).. Valid values are `HMO|PPO|EPO|POS|HDHP|QHP`',
    `plan_year` STRING COMMENT 'Calendar year for which the rate is effective.',
    `premium_type` STRING COMMENT 'Frequency at which the premium is billed.. Valid values are `monthly|quarterly|annual`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the rate.. Valid values are `active|inactive|pending|retired`',
    `rating_area_code` STRING COMMENT 'Three‑character code representing the geographic rating area defined by CMS.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_filing_type` STRING COMMENT 'Regulatory body for which the rate filing is submitted.. Valid values are `DOI|CMS|ACA`',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Monetary amount added to the premium for tobacco users.',
    `termination_date` DATE COMMENT 'Date on which the rate is no longer valid; null if open‑ended.',
    `tobacco_use_indicator` STRING COMMENT 'Indicates whether the member uses tobacco (yes) or not (no).. Valid values are `yes|no`',
    `underwriting_class_code` STRING COMMENT 'Code representing the underwriting class applied to the rate.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate record.',
    `version` STRING COMMENT 'Version identifier for the rate definition (e.g., v1, v2).',
    CONSTRAINT pk_rate PRIMARY KEY(`rate_id`)
) COMMENT 'Premium rate table for each health plan by rating factors — age band, geographic rating area, tobacco use, plan year, and market segment (individual, small group, large group). Captures the base rate, age-rated premium, family tier premium (employee only, employee + spouse, employee + child, family), rating area code, effective and termination dates, and rate filing reference. Supports premium billing, quoting, and DOI rate filing compliance. Sourced from actuarial rate-setting and pricing systems.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`submission` (
    `submission_id` BIGINT COMMENT 'Unique identifier for the plan submission record.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Tracks the vendor invoice for filing fees associated with a plan submission, enabling AP reconciliation.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan product being submitted.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or entity submitting the plan.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the internal reviewer who evaluated the submission.',
    `approval_date` DATE COMMENT 'Date the submission was approved by the regulator.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the submitted plan coverage begins.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date on which the submitted plan coverage ends.',
    `fee_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the filing fee (e.g., USD).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_fee_adjustment` DECIMAL(18,2) COMMENT 'Adjustments (discounts, penalties) applied to the filing fee.',
    `filing_fee_gross` DECIMAL(18,2) COMMENT 'Total filing fee charged before any adjustments.',
    `filing_fee_net` DECIMAL(18,2) COMMENT 'Net filing fee after adjustments.',
    `filing_reference_number` STRING COMMENT 'Regulator-assigned reference number for tracking the filing.',
    `hpms_plan_code` STRING COMMENT 'Health Plan Management System identifier for Medicare Advantage bids.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_annual_filing` BOOLEAN COMMENT 'Indicates whether the submission is part of the annual filing cycle.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional free‑form notes captured at the time of filing.',
    `plan_type` STRING COMMENT 'Classification of the health plan (e.g., HMO, PPO, EPO, POS, HDHP, QHP).',
    `plan_year` STRING COMMENT 'Calendar year for which the plan is effective.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_body` STRING COMMENT 'Governing authority to which the submission is made (CMS, State Department of Insurance, or other).. Valid values are `cms|state_doi|other`',
    `regulatory_submission_deadline` DATE COMMENT 'Final date by which the filing must be submitted to the regulator.',
    `rejection_date` DATE COMMENT 'Date the submission was rejected by the regulator.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the regulator for a rejected submission.',
    `reviewer_comments` STRING COMMENT 'Free‑form comments entered by the reviewer during evaluation.',
    `submission_date` DATE COMMENT 'Date the submission was filed with the regulator.',
    `submission_number` STRING COMMENT 'External reference number assigned to the submission by the organization.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the submission.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `submission_type` STRING COMMENT 'Category of the regulatory filing (e.g., Qualified Health Plan, Medicare Advantage, Medicaid, State Bid, Rate Filing).. Valid values are `qhp|medicare_advantage|medicaid|state_bid|rate_filing`',
    `submitter_role` STRING COMMENT 'Role of the submitter relative to the organization.. Valid values are `internal|external|broker|agency`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the submission record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `withdrawal_date` DATE COMMENT 'Date the submitter withdrew the filing.',
    `withdrawal_reason` STRING COMMENT 'Reason supplied for withdrawing the submission.',
    `created_by` STRING COMMENT 'User identifier of the person who created the submission record.',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Tracks regulatory plan submissions to CMS and state DOIs — QHP certification submissions, Medicare Advantage bid submissions (HPMS), Medicaid managed care contract submissions, annual rate filings, and service area filings. Captures submission type, submission date, regulatory body (CMS, state DOI), submission status (draft, submitted, approved, rejected, withdrawn), HPMS plan ID, filing reference number, approval/rejection details, and reviewer comments. Supports ACA compliance, CMS audit readiness, and DOI market conduct examinations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` (
    `hsa_hra_config_id` BIGINT COMMENT 'System-generated unique identifier for the HSA/HRA configuration record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which this HSA/HRA configuration applies.',
    `vendor_id` BIGINT COMMENT 'Internal or external identifier for the custodian (e.g., NPI‑like code).',
    `account_type` STRING COMMENT 'Specifies the type of tax‑advantaged health account covered by this configuration.. Valid values are `HSA|HRA|FSA|LPFSA`',
    `catch_up_contribution_amount` DECIMAL(18,2) COMMENT 'Additional contribution amount allowed for eligible participants.',
    `catch_up_contribution_eligible` BOOLEAN COMMENT 'True if participants age 55 or older may make catch‑up contributions.',
    `contribution_frequency` STRING COMMENT 'How often contributions are made to the account.. Valid values are `monthly|quarterly|annually`',
    `contribution_limit_amount` DECIMAL(18,2) COMMENT 'Monetary amount defining the contribution ceiling based on the limit type.',
    `contribution_limit_type` STRING COMMENT 'Whether the contribution limit is expressed per year or per month.. Valid values are `per_year|per_month`',
    `contribution_method` STRING COMMENT 'Tax treatment of contributions (pre‑tax, post‑tax, or after‑tax).. Valid values are `pre_tax|post_tax|after_tax`',
    `contribution_source` STRING COMMENT 'Origin of contributions to the account.. Valid values are `employer|employee|both`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the configuration record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `hsa_hra_config_description` STRING COMMENT 'Free‑form text describing special rules or notes for this configuration.',
    `effective_end_date` DATE COMMENT 'Date when this configuration ceases to be effective (null if ongoing).',
    `effective_start_date` DATE COMMENT 'Date when this configuration becomes effective for the plan.',
    `eligibility_hdpp` BOOLEAN COMMENT 'Indicates whether the associated plan qualifies as a High‑Deductible Health Plan for HSA eligibility (true/false).',
    `employee_contribution_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount an employee may contribute per plan year.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employer contributes to the account each contribution period.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: QuestionnaireResponse)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grace_period_option` BOOLEAN COMMENT 'Indicates whether a grace period is offered for eligible expenses after plan year end.',
    `hsa_hra_config_status` STRING COMMENT 'Current lifecycle status of the configuration record.. Valid values are `active|inactive|pending|retired`',
    `irs_minimum_deductible` DECIMAL(18,2) COMMENT 'IRS‑mandated minimum deductible amount (in plan currency) required for HSA eligibility.',
    `irs_out_of_pocket_max` DECIMAL(18,2) COMMENT 'IRS‑mandated maximum out‑of‑pocket amount (in plan currency) for HSA eligibility.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `plan_year_end_date` DATE COMMENT 'Last day of the plan year for this configuration (nullable for open‑ended).',
    `plan_year_start_date` DATE COMMENT 'First day of the plan year to which this configuration applies.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True when the configuration meets all IRS Section 223 requirements for HSA eligibility.',
    `rollover_allowed` BOOLEAN COMMENT 'Indicates whether unused balances may be rolled over to the next plan year.',
    `rollover_limit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount that may be rolled over (if limited).',
    `trustee_custodian_name` STRING COMMENT 'Name of the financial institution or custodian that holds the HSA/HRA assets.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the configuration record.',
    `use_it_or_lose_it_flag` BOOLEAN COMMENT 'True if the account follows a use‑it‑or‑lose‑it rule (applicable to FSA).',
    CONSTRAINT pk_hsa_hra_config PRIMARY KEY(`hsa_hra_config_id`)
) COMMENT 'Configuration record for tax-advantaged health accounts associated with a health plan — HSA (Health Savings Account), HRA (Health Reimbursement Arrangement), FSA (Flexible Spending Account), and LPFSA (Limited Purpose FSA). Captures IRS minimum deductible threshold, IRS out-of-pocket maximum threshold (per IRS Revenue Procedure annual updates), employer contribution amount, employee contribution limit, catch-up contribution eligibility (age 55+), rollover rules (HSA unlimited, HRA employer-defined, FSA $610 carryover limit), use-it-or-lose-it flag, grace period option, plan year alignment, and HSA trustee/custodian information. Ensures HDHP plans meet IRS Section 223 HSA eligibility requirements and supports benefits administration integration with HSA custodians (Optum Bank, Fidelity, HealthEquity).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` (
    `rx_benefit_config_id` BIGINT COMMENT 'System‑generated unique identifier for the pharmacy benefit configuration record.',
    `formulary_id` BIGINT COMMENT 'Unique identifier of the drug formulary associated with this configuration.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which this pharmacy benefit configuration applies.',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'Coinsurance rate expressed as a percentage of the allowed amount.',
    `cost_sharing_method` STRING COMMENT 'Method used to calculate member cost‑sharing (copay, coinsurance, or percentage).. Valid values are `copay|coinsurance|percentage`',
    `coverage_limit_per_prescription` DECIMAL(18,2) COMMENT 'Maximum reimbursable amount for a single prescription fill.',
    `coverage_limit_per_year` DECIMAL(18,2) COMMENT 'Annual dollar limit on pharmacy benefit coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the pharmacy deductible.',
    `deductible_applicable` BOOLEAN COMMENT 'Indicates whether the plan deductible applies to pharmacy benefits.',
    `drug_category_exclusions` STRING COMMENT 'Comma‑separated list of drug categories that are excluded from coverage.',
    `effective_end_date` DATE COMMENT 'Date when this pharmacy benefit configuration expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when this pharmacy benefit configuration becomes effective.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.coverage.benefit)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `formulary_version` STRING COMMENT 'Version string of the formulary to support change tracking and audits.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_biologic_preferred` BOOLEAN COMMENT 'True if biologic drugs are preferred within the formulary.',
    `is_biosimilar_preferred` BOOLEAN COMMENT 'True if biosimilar drugs are preferred over reference biologics.',
    `is_exempt_from_mlr` BOOLEAN COMMENT 'True if the plan is exempt from MLR reporting requirements for this pharmacy benefit.',
    `is_specialty_drug_excluded` BOOLEAN COMMENT 'Indicates whether specialty drugs are excluded from coverage.',
    `last_review_date` DATE COMMENT 'Date when the configuration was last reviewed for compliance or policy changes.',
    `mail_order_network_type` STRING COMMENT 'Classification of the mail‑order pharmacy network.. Valid values are `in_network|out_of_network`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_coverage_amount` DECIMAL(18,2) COMMENT 'Upper limit on total pharmacy benefit coverage per benefit period.',
    `ninety_day_supply_allowed` BOOLEAN COMMENT 'True if a 90‑day supply of medication is permitted under this benefit configuration.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special instructions.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Maximum out‑of‑pocket expense a member can incur for pharmacy benefits.',
    `pbm_vendor` STRING COMMENT 'Name of the PBM vendor that administers the formulary and pharmacy benefits.',
    `prior_auth_exemption_drugs` STRING COMMENT 'List of NDCs for which prior authorization is waived.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_classification` STRING COMMENT 'Regulatory category (e.g., Medicare Advantage, Medicaid, QHP) applicable to this benefit configuration.',
    `retail_network_type` STRING COMMENT 'Classification of the retail pharmacy network (e.g., in‑network or out‑of‑network).. Valid values are `in_network|out_of_network`',
    `rx_benefit_config_status` STRING COMMENT 'Current lifecycle status of the benefit configuration.. Valid values are `active|inactive|retired|pending`',
    `specialty_pharmacy_network` STRING COMMENT 'Name or code of the specialty pharmacy network used for high‑cost drugs.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step‑therapy (sequential drug use) is required for covered drugs.',
    `therapeutic_class_limit` STRING COMMENT 'Maximum number of distinct therapeutic classes allowed per member per year.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Incremental version number for change management.',
    CONSTRAINT pk_rx_benefit_config PRIMARY KEY(`rx_benefit_config_id`)
) COMMENT 'Pharmacy benefit configuration record linking a health plan to its PBM formulary and defining pharmacy-specific cost-sharing rules — retail vs. mail-order copay differentials, specialty pharmacy requirements, 90-day supply rules, mandatory generic substitution flags, and specialty drug management programs. Captures the PBM vendor, formulary ID, retail network type, mail-order network, specialty pharmacy network, and drug management program flags. Sourced from RxClaim/Argus PBM integration.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`network_config` (
    `network_config_id` BIGINT COMMENT 'System-generated unique identifier for each plan‑network configuration record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier of the health plan to which this network configuration applies.',
    `provider_network_id` BIGINT COMMENT 'Unique identifier of the provider network associated with the plan.',
    `access_type` STRING COMMENT 'Access model of the plan for this network (e.g., HMO closed, PPO open).. Valid values are `HMO_closed|PPO_open|EPO_exclusive|POS|HDHP`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Date when this plan‑network configuration ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when this plan‑network configuration becomes effective.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_adequacy_measure` STRING COMMENT 'Metric or description used to assess network adequacy (e.g., provider‑to‑member ratio).',
    `network_adequacy_standard_code` STRING COMMENT 'Code referencing the CMS‑defined adequacy standard applied to this network.',
    `network_config_status` STRING COMMENT 'Current lifecycle status of the configuration record.. Valid values are `active|inactive|pending|terminated`',
    `network_contract_number` STRING COMMENT 'Identifier of the contractual agreement governing the provider network.',
    `network_coverage_type` STRING COMMENT 'Extent of coverage provided by the network for the plan (full, partial, or none).. Valid values are `full|partial|none`',
    `network_designation` STRING COMMENT 'Overall designation of the network relative to the plan (in‑network, out‑of‑network, or partial).. Valid values are `in_network|out_of_network|partial`',
    `network_exclusion_description` STRING COMMENT 'Textual description of exclusions when the exclusion flag is true.',
    `network_exclusion_flag` BOOLEAN COMMENT 'Indicates whether the network has any excluded providers or services.',
    `network_geography_region` STRING COMMENT 'Geographic region code (e.g., Northeast, Midwest) where the network operates.',
    `network_provider_count` STRING COMMENT 'Total number of active providers participating in the network for the plan.',
    `network_state` STRING COMMENT 'Two‑letter state abbreviation for the primary state of the network.',
    `network_tier` STRING COMMENT 'Tier designation of the network for the plan (e.g., Tier 1 preferred, Tier 2 standard).. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `network_zip_code` STRING COMMENT 'Primary ZIP code associated with the networks main service area.',
    `out_of_network_benefit_type` STRING COMMENT 'Type of benefit applied to out‑of‑network services (copay, coinsurance, or none).. Valid values are `copay|coinsurance|none`',
    `out_of_network_coinsurance_pct` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays for out‑of‑network services when benefit type is coinsurance.',
    `out_of_network_copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar copay amount for out‑of‑network services when benefit type is copay.',
    `out_of_network_coverage_flag` BOOLEAN COMMENT 'Indicates whether the plan provides any benefit for out‑of‑network services.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `tier_priority` STRING COMMENT 'Numeric priority used to order tiers when multiple tiers exist.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration record.',
    CONSTRAINT pk_network_config PRIMARY KEY(`network_config_id`)
) COMMENT 'Associates a health plan with its provider network configuration — defining which provider networks are in-network for the plan, tiered network designations (Tier 1 preferred, Tier 2 standard), out-of-network coverage rules, and network adequacy standards. Captures the network ID, network tier, access type (HMO closed, PPO open, EPO exclusive), out-of-network benefit flag, and effective dates. Links the plan domain to the network domain for claims adjudication and member directory services.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` (
    `crosswalk_id` BIGINT COMMENT 'System-generated unique identifier for each plan crosswalk record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan being discontinued or replaced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the crosswalk record was first created in the system.',
    `crosswalk_status` STRING COMMENT 'Current lifecycle state of the crosswalk record.. Valid values are `active|inactive|pending|retired`',
    `crosswalk_type` STRING COMMENT 'Classification of how the crosswalk was created: automatic renewal, member‑initiated change, or CMS‑mandated mapping.. Valid values are `auto_renewal|member_directed|cms_mandated`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Date on which the crosswalk ceases to be valid (nullable for open‑ended mappings).',
    `effective_start_date` DATE COMMENT 'Date on which the successor plan becomes effective for members linked via this crosswalk.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_mandatory` BOOLEAN COMMENT 'True if the crosswalk is required by CMS or other regulatory bodies.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_notification_required` BOOLEAN COMMENT 'Indicates whether members must be notified about this plan change.',
    `notes` STRING COMMENT 'Additional free‑form comments or internal remarks about the crosswalk.',
    `notification_method` STRING COMMENT 'Channel used to notify members of the crosswalk (email, postal mail, member portal, or phone).. Valid values are `email|mail|portal|phone`',
    `notification_sent_date` DATE COMMENT 'Date the member notification was dispatched.',
    `plan_year` STRING COMMENT 'Plan year to which this crosswalk applies (e.g., 2024).',
    `reason` STRING COMMENT 'Free‑text explanation for why the crosswalk was created (e.g., plan discontinuation, regulatory change).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `region` STRING COMMENT 'Geographic region or market segment for the crosswalk (e.g., Northeast, Southwest).',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this crosswalk must be included in CMS QHP or Medicare Advantage submissions.',
    `sequence` STRING COMMENT 'Ordinal number to order multiple crosswalks for the same prior plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the crosswalk record.',
    CONSTRAINT pk_crosswalk PRIMARY KEY(`crosswalk_id`)
) COMMENT 'Maps health plans across plan years for renewal and continuity — crosswalking discontinued plans to successor plans during annual open enrollment. Captures prior plan ID (FK to health_plan), successor plan ID (FK to health_plan), crosswalk type (auto-renewal, member-directed, CMS-mandated), effective date, member notification requirement, and crosswalk reason. Required for ACA QHP auto-enrollment crosswalk submissions to CMS/state exchanges and Medicare Advantage plan consolidations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`status_history` (
    `status_history_id` BIGINT COMMENT 'System-generated unique identifier for each plan status transition record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who manually initiated the status change, if applicable.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan whose status change is recorded.',
    `audit_created_by` STRING COMMENT 'Identifier of the process or user that created the audit record.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the lakehouse.',
    `audit_source_system` STRING COMMENT 'Source system that supplied the status change data.',
    `comments` STRING COMMENT 'Optional free‑text notes related to the status change.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the transition required a compliance or regulatory review.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_legacy` BOOLEAN COMMENT 'Flag indicating whether the status change originated from a legacy system.',
    `market_segment` STRING COMMENT 'Market segment the plan serves (individual, group, government).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `new_status` STRING COMMENT 'Status of the plan after the transition. [ENUM-REF-CANDIDATE: draft|filed|approved|active|suspended|discontinued|withdrawn — promote to reference product]',
    `plan_type` STRING COMMENT 'Type of health plan (e.g., HMO, PPO, EPO, POS, HDHP, QHP, Medicare Advantage, Medicaid).',
    `plan_year` STRING COMMENT 'Plan year code (e.g., 2024) associated with the status transition.',
    `prior_status` STRING COMMENT 'Status of the plan before the transition. [ENUM-REF-CANDIDATE: draft|filed|approved|active|suspended|discontinued|withdrawn — promote to reference product]',
    `reason_code` STRING COMMENT 'Standardized code indicating why the plan status changed.. Valid values are `regulatory_action|market_withdrawal|merger|non_renewal|compliance_suspension|other`',
    `reason_description` STRING COMMENT 'Free‑text explanation of the reason for the status transition.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `region` STRING COMMENT 'Broad geographic region (e.g., Northeast, Midwest) for reporting purposes.',
    `regulatory_action_reference` STRING COMMENT 'Reference identifier for the regulatory document (e.g., CMS letter, DOI order) that triggered the status change.',
    `state_code` STRING COMMENT 'Two‑letter US state code where the plan is offered.',
    `transition_effective_date` DATE COMMENT 'Date on which the new status becomes effective for the plan.',
    `transition_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the status change event was recorded in the source system.',
    `triggered_by` STRING COMMENT 'Indicates whether the status change was initiated by a system process, a user, or an automated workflow.. Valid values are `system|user|automated_process`',
    `triggered_by_system_name` STRING COMMENT 'Name of the system or application that performed the status transition (e.g., Facets, QNXT).',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Immutable audit trail of health plan lifecycle status transitions — draft, filed, approved, active, suspended, discontinued, and withdrawn. Each record captures the plan ID (FK to health_plan), prior status, new status, effective date of transition, reason code (regulatory action, market withdrawal, merger, non-renewal, compliance suspension), regulatory action reference (CMS letter, DOI order), the user or system that triggered the change, and timestamp. Supports CMS audit readiness (HPMS plan status validation), state DOI market conduct examinations, SOX-compliant plan lifecycle governance, and historical plan status reconstruction for claims adjudication lookback.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`offering` (
    `offering_id` BIGINT COMMENT 'Primary key for the plan_offering association',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer_group',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to health_plan',
    `offering_code` STRING COMMENT 'Business identifier for the specific plan offering',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Fixed contribution amount per employee',
    `contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of premium contributed by employer',
    `contribution_tier` STRING COMMENT 'Tiered contribution rule identifier',
    `contribution_type` STRING COMMENT 'Method of employer contribution (e.g., fixed amount, percentage)',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date the offering becomes active',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date the offering ends',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for employee coverage',
    `family_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for family coverage',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `offering_name` STRING COMMENT 'Human‑readable name of the offering',
    `offering_status` STRING COMMENT 'Current lifecycle status of the offering',
    `offering_type` STRING COMMENT 'Type of offering (e.g., standard, pilot)',
    `open_enrollment_end_date` DATE COMMENT 'End date for open enrollment period',
    `open_enrollment_start_date` DATE COMMENT 'Start date for open enrollment period',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_offering PRIMARY KEY(`offering_id`)
) COMMENT 'This association product represents the contract between a health plan and an employer group. It captures the specific terms of the offering, such as contribution rules, enrollment windows, and status, linking one health_plan to one employer_group.. Existence Justification: An employer group can be offered multiple health plans and a health plan can be offered to multiple employer groups. The contract between them (the plan offering) is actively created, updated, and terminated by business users and carries its own attributes such as effective dates, contribution rules, and status.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` (
    `program_coverage_id` BIGINT COMMENT '',
    `program_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT '',
    `benefit_id` BIGINT COMMENT '',
    `coverage_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `coverage_effective_date` DATE COMMENT '',
    `coverage_end_date` DATE COMMENT '',
    `scope_description` STRING COMMENT '',
    `copay_waiver_flag` BOOLEAN COMMENT '',
    `additional_benefits_text` STRING COMMENT '',
    CONSTRAINT pk_program_coverage PRIMARY KEY(`program_coverage_id`)
) COMMENT 'Represents the coverage assignment of care programs under health plans, capturing the effective period during which a specific program is available to members of a plan.. Existence Justification: A health_plan can include multiple care_programs, and a care_program can be offered under multiple health_plans. The insurer actively configures which programs are covered by each plan, tracking effective start and end dates for each coverage assignment. This relationship is managed as a distinct business entity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` (
    `plan_amendment2_id` BIGINT COMMENT 'System-generated unique identifier for the plan amendment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who created the amendment record.',
    `amendment_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the internal user who last modified the amendment record.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the user who approved the amendment.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which this amendment applies.',
    `contract_amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Needed to trace which contract amendment triggered a plan amendment; regulatory audit of plan changes requires linking plan_amendment to the underlying contract amendment.',
    `sbc_document_id` BIGINT COMMENT 'Identifier of the generated Summary of Benefits and Coverage document, if created.',
    `amendment_number` STRING COMMENT 'Business-assigned amendment number or code used for tracking and reporting.',
    `amendment_type` STRING COMMENT 'Classification of the amendment indicating what aspect of the plan is being changed.. Valid values are `benefit_change|cost_share_change|network_change|service_area_change|formulary_update`',
    `approval_comment` STRING COMMENT 'Comments entered by the approver during the approval process.',
    `change_summary` STRING COMMENT 'Concise summary of the changes introduced by the amendment.',
    `cms_filing_reference` STRING COMMENT 'Reference identifier for the filing submitted to CMS, if required.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the amendment complies with all applicable regulatory requirements.',
    `cost_share_change_details` STRING COMMENT 'Explanation of changes to deductibles, copays, coinsurance, OOP, or MOOP.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `doi_filing_reference` STRING COMMENT 'Reference identifier for the filing submitted to the state Department of Insurance.',
    `effective_date` DATE COMMENT 'Date on which the amendment becomes effective for members.',
    `effective_end_date` DATE COMMENT 'Optional date when the amendment ceases to be effective, if applicable.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_year` STRING COMMENT 'Plan year to which the amendment is applied.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `formulary_change_details` STRING COMMENT 'Details of formulary tier or drug coverage changes resulting from the amendment.',
    `impact_estimated_cost` DECIMAL(18,2) COMMENT 'Projected total financial impact of the amendment on the plans cost structure.',
    `impact_estimated_member_cost` DECIMAL(18,2) COMMENT 'Projected impact of the amendment on member out‑of‑pocket costs.',
    `impact_estimated_provider_cost` DECIMAL(18,2) COMMENT 'Projected impact of the amendment on provider reimbursement costs.',
    `impacted_benefit_package_ids` STRING COMMENT 'Comma‑separated list of benefit package identifiers affected by the amendment.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_notification_date` DATE COMMENT 'Date on which the member communication is scheduled or was sent.',
    `member_notification_required` BOOLEAN COMMENT 'Indicates whether members must be notified about this amendment.',
    `network_change_details` STRING COMMENT 'Free‑text details describing any network configuration changes introduced by the amendment.',
    `plan_amendment_description` STRING COMMENT 'Detailed narrative describing the nature and rationale of the amendment.',
    `plan_amendment_status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `draft|pending|approved|denied|implemented|retracted`',
    `reason_code` STRING COMMENT 'Standardized code representing the business reason for the amendment.',
    `reason_description` STRING COMMENT 'Human‑readable explanation of why the amendment was initiated.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_approval_date` DATE COMMENT 'Date on which regulatory approval was granted or denied.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory review and approval for the amendment.. Valid values are `pending|approved|denied`',
    `review_deadline` DATE COMMENT 'Date by which the amendment must be reviewed and approved.',
    `service_area_change_details` STRING COMMENT 'Description of any geographic service‑area modifications.',
    `status_reason` STRING COMMENT 'Explanation for the current status of the amendment (e.g., reason for denial).',
    `triggers_sbc_generation` BOOLEAN COMMENT 'True if the amendment requires generation of a new Summary of Benefits and Coverage (SBC) document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the amendment record.',
    `version` STRING COMMENT 'Version number of the amendment for tracking revisions.',
    CONSTRAINT pk_plan_amendment2 PRIMARY KEY(`plan_amendment2_id`)
) COMMENT 'Records mid-year or annual amendments to health plan benefit designs, cost-sharing rules, network configurations, service area modifications, or formulary changes. Each amendment captures the amendment type (benefit change, cost-share change, network change, service area change, formulary update), effective date, detailed description of change, regulatory approval status (pending, approved, denied), impacted benefit packages (as FK array), member notification requirement and notification date, CMS/DOI filing reference, amendment reason code, and whether the amendment triggers a new SBC document generation. Supports regulatory compliance with ACA mid-year change rules, member communication obligations under ERISA Section 104, and benefit configuration change management in Facets/QNXT.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` (
    `provider_contract_link_id` BIGINT COMMENT 'Primary key for the plan_provider_contract association',
    `fee_schedule_id` BIGINT COMMENT 'Associated fee schedule for this provider contract',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to the health_plan entity',
    `par_agreement_id` BIGINT COMMENT '',
    `provider_contract_id` BIGINT COMMENT 'SSOT reference to canonical provider_contract master contract.contract_provider_contract',
    `provider_network_participation2_id` BIGINT COMMENT 'Identifier of the provider network applicable to this plan‑contract relationship',
    `tertiary_provider_contract_id` BIGINT COMMENT 'SSOT reference to canonical provider_contract in contract.contract_provider_contract',
    `auto_renew_flag` BOOLEAN COMMENT '',
    `auto_renewal_flag` BOOLEAN COMMENT 'Whether the contract auto-renews at term end',
    `capitation_flag` BOOLEAN COMMENT '',
    `contract_number` STRING COMMENT '',
    `contract_role` STRING COMMENT 'Role of plan in the contract.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract for this pairing (e.g., Active, Pending, Terminated)',
    `contract_type` STRING COMMENT 'Type of provider contract',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credentialing_required_flag` BOOLEAN COMMENT 'Whether provider credentialing is required under this contract',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date the contract becomes effective for this plan‑provider pairing',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_term_months` STRING COMMENT 'Contract term in months.',
    `end_date` DATE COMMENT 'Date the record ends.',
    `fee_schedule_type` STRING COMMENT 'Fee schedule type',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_capitated` BOOLEAN COMMENT '',
    `is_par` BOOLEAN COMMENT '',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_panel_size` STRING COMMENT 'Maximum patient panel size allowed under this contract',
    `network_tier` STRING COMMENT 'Associated network tier.',
    `notes` STRING COMMENT 'Free-text notes.',
    `notice_period_days` STRING COMMENT 'Number of days notice required for termination',
    `payment_methodology_code` STRING COMMENT '',
    `plan_provider_contract_status` STRING COMMENT 'Lifecycle status of the record.',
    `primary_contract_flag` BOOLEAN COMMENT '',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reimbursement_method` STRING COMMENT 'Reimbursement method.',
    `reimbursement_methodology` STRING COMMENT '',
    `reimbursement_terms` STRING COMMENT 'Summary of reimbursement terms governing the provider contract under this plan.',
    `renewal_term_months` STRING COMMENT '',
    `status_code` STRING COMMENT '',
    `termination_date` DATE COMMENT 'Date the contract ends for this plan‑provider pairing',
    `tier_assignment` STRING COMMENT 'Network tier assignment for the provider under this plan contract.',
    `tier_level` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_provider_contract_link PRIMARY KEY(`provider_contract_link_id`)
) COMMENT 'Represents the contractual relationship between a health plan and a provider contract. Each record captures the effective and termination dates, current status, and the network context for the specific plan‑provider pairing.. Existence Justification: A health plan can be linked to many provider contracts, each representing an agreement with a specific provider. Conversely, a single provider can have contracts with multiple health plans. The relationship is managed as a distinct business entity that records effective dates, termination dates, status, and network context for each plan‑provider pairing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` (
    `regulatory_obligation_link_id` BIGINT COMMENT 'Primary key for the plan_regulatory_obligation association',
    `employee_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to the health_plan entity',
    `primary_legacy_compliance_regulatory_obligation_id` BIGINT COMMENT 'SSOT reference to canonical regulatory_obligation master compliance.compliance_regulatory_obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'SSOT reference to canonical regulatory_obligation in compliance.compliance_regulatory_obligation',
    `attestation_due_date` DATE COMMENT '',
    `citation_reference` STRING COMMENT 'Regulatory citation reference.',
    `compliance_date` DATE COMMENT 'Date when compliance with the obligation was achieved.',
    `compliance_deadline` DATE COMMENT 'Compliance deadline',
    `compliance_status` STRING COMMENT 'Current compliance state for this plan‑obligation pair',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `due_date` DATE COMMENT 'Obligation due date.',
    `effective_date` DATE COMMENT 'Date the record becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'Date the record ends.',
    `evidence_document_reference` STRING COMMENT 'Reference to supporting compliance evidence documentation',
    `evidence_document_url` STRING COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filing_frequency` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `jurisdiction` STRING COMMENT '',
    `last_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment for this plan‑obligation pair',
    `last_attested_date` DATE COMMENT '',
    `last_review_date` DATE COMMENT 'Last review date',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_due_date` DATE COMMENT 'Date by which the next compliance action is required for this plan‑obligation pair',
    `next_review_date` DATE COMMENT 'Next scheduled review',
    `notes` STRING COMMENT 'Free-text notes.',
    `obligation_code` STRING COMMENT '',
    `obligation_description` STRING COMMENT 'Description of obligation',
    `obligation_name` STRING COMMENT '',
    `obligation_status` STRING COMMENT 'Current status of the regulatory obligation (e.g., compliant, non-compliant, pending review).',
    `obligation_status_code` STRING COMMENT '',
    `obligation_type` STRING COMMENT 'Type of regulatory obligation.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty for non-compliance with this obligation',
    `penalty_description` STRING COMMENT '',
    `plan_regulatory_obligation_status` STRING COMMENT 'Lifecycle status of the record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulator` STRING COMMENT 'Regulatory body.',
    `regulatory_authority` STRING COMMENT '',
    `regulatory_body` STRING COMMENT 'Regulatory body name',
    `regulatory_citation` STRING COMMENT '',
    `remediation_deadline` DATE COMMENT 'Deadline for correcting non-compliance',
    `remediation_notes` STRING COMMENT '',
    `remediation_plan` STRING COMMENT '',
    `responsible_party` STRING COMMENT '',
    `review_frequency` STRING COMMENT 'How often compliance is reviewed (annual, quarterly, monthly)',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_regulatory_obligation_link PRIMARY KEY(`regulatory_obligation_link_id`)
) COMMENT 'This association captures the compliance relationship between a health plan and a regulatory obligation. It records the compliance status and key dates for each plan‑obligation pair, enabling the business to monitor and report on regulatory adherence.. Existence Justification: Each health plan must satisfy multiple regulatory obligations, and each regulatory obligation applies to many health plans. The compliance status, last assessment date, and next due date are tracked per plan‑obligation pair, forming a managed entity that business users maintain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` (
    `plan_service_area_id` BIGINT COMMENT 'Unique surrogate key for the plan service area record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with this service area.',
    `sbc_document_id` BIGINT COMMENT 'Identifier for the SBC document associated with this service area.',
    `county` STRING COMMENT 'County name within the state for the service area.',
    `coverage_type` STRING COMMENT 'Type of health plan coverage associated with this service area.. Valid values are `HMO|PPO|EPO|POS|HDHP|QHP`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service area record was created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Date when the service area ceases to be effective (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the service area becomes effective for enrollment.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of members that can be enrolled in this service area.',
    `exchange_market` STRING COMMENT 'Name of the ACA exchange market (if applicable) where the plan is offered.',
    `exchange_market_code` STRING COMMENT 'Unique identifier for the exchange market.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_region_code` STRING COMMENT 'Standard code representing the broader geographic region for the service area.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the service area is exclusive to this plan (True) or shared (False).',
    `is_federal_funded` BOOLEAN COMMENT 'Indicates whether the service area receives federal funding.',
    `is_medicaid_eligible` BOOLEAN COMMENT 'Indicates if the service area is eligible for Medicaid plans.',
    `is_medicare_eligible` BOOLEAN COMMENT 'Indicates if the service area is eligible for Medicare Advantage plans.',
    `is_regulatory_compliant` BOOLEAN COMMENT 'Indicates whether the service area meets all regulatory requirements.',
    `is_state_funded` BOOLEAN COMMENT 'Indicates whether the service area receives state funding.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the service area record.. Valid values are `active|inactive|pending|terminated`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_type` STRING COMMENT 'Specifies if the service area applies to in‑network or out‑of‑network coverage.. Valid values are `in_network|out_of_network`',
    `notes` STRING COMMENT 'Free‑text notes regarding the service area.',
    `plan_category` STRING COMMENT 'Broad category of the plan associated with the service area.. Valid values are `individual|group|government|exchange`',
    `plan_year` STRING COMMENT 'Plan year for which the service area configuration applies.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval for the service area.. Valid values are `pending|approved|rejected`',
    `regulatory_filing_number` STRING COMMENT 'Reference number for the regulatory filing associated with this service area.',
    `service_area_code` STRING COMMENT 'Unique identifier assigned by CMS for the service area.',
    `service_area_name` STRING COMMENT 'Human‑readable name of the geographic service area.',
    `service_area_type` STRING COMMENT 'Geographic granularity of the service area.. Valid values are `state|county|zip|region`',
    `state` STRING COMMENT 'Two‑letter US state abbreviation where the service area is located.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service area record.',
    `version_number` STRING COMMENT 'Version of the service area record for change tracking.',
    `zip_codes_excluded` STRING COMMENT 'Comma‑separated list of ZIP codes excluded from the service area.',
    `zip_codes_included` STRING COMMENT 'Comma‑separated list of ZIP codes included in the service area.',
    CONSTRAINT pk_plan_service_area PRIMARY KEY(`plan_service_area_id`)
) COMMENT 'Defines the geographic service area in which a health plan is authorized to enroll members and provide coverage. Captures the service area name, state, county, zip code inclusions/exclusions, CMS service area ID, effective dates, and regulatory approval status. Required for CMS QHP submissions, Medicare Advantage service area filings, and state DOI market conduct compliance. Governs member eligibility for plan enrollment based on residence.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` (
    `plan_provider_contract_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT '',
    `provider_contract_id` BIGINT COMMENT '',
    `par_agreement_id` BIGINT COMMENT '',
    `contract_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `status_code` STRING COMMENT '',
    `primary_contract_flag` BOOLEAN COMMENT '',
    `payment_methodology_code` STRING COMMENT '',
    CONSTRAINT pk_plan_provider_contract PRIMARY KEY(`plan_provider_contract_id`)
) COMMENT 'Links health plans to provider contracts with participation agreements';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` (
    `plan_amendment_id` BIGINT COMMENT 'Primary key for plan_amendment',
    `contract_amendment_id` BIGINT COMMENT '',
    CONSTRAINT pk_plan_amendment PRIMARY KEY(`plan_amendment_id`)
) COMMENT 'Plan-design-specific amendment subtype';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` (
    `plan_regulatory_obligation_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT '',
    `obligation_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `compliance_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `obligation_status_code` STRING COMMENT '',
    `attestation_due_date` DATE COMMENT '',
    `last_attested_date` DATE COMMENT '',
    `evidence_document_url` STRING COMMENT '',
    CONSTRAINT pk_plan_regulatory_obligation PRIMARY KEY(`plan_regulatory_obligation_id`)
) COMMENT 'Tracks regulatory obligations and compliance requirements applicable to health plans';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ADD CONSTRAINT `fk_plan_year_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ADD CONSTRAINT `fk_plan_sbc_document_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ADD CONSTRAINT `fk_plan_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ADD CONSTRAINT `fk_plan_hsa_hra_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ADD CONSTRAINT `fk_plan_crosswalk_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ADD CONSTRAINT `fk_plan_status_history_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ADD CONSTRAINT `fk_plan_offering_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` ADD CONSTRAINT `fk_plan_program_coverage_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` ADD CONSTRAINT `fk_plan_program_coverage_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ADD CONSTRAINT `fk_plan_plan_amendment2_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ADD CONSTRAINT `fk_plan_plan_amendment2_sbc_document_id` FOREIGN KEY (`sbc_document_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`sbc_document`(`sbc_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ADD CONSTRAINT `fk_plan_provider_contract_link_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ADD CONSTRAINT `fk_plan_regulatory_obligation_link_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ADD CONSTRAINT `fk_plan_plan_service_area_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ADD CONSTRAINT `fk_plan_plan_service_area_sbc_document_id` FOREIGN KEY (`sbc_document_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`sbc_document`(`sbc_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` ADD CONSTRAINT `fk_plan_plan_provider_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` ADD CONSTRAINT `fk_plan_plan_regulatory_obligation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`plan` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`plan` SET TAGS ('pii_domain' = 'plan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_subdomain' = 'product_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_skip_batch_p208_p211_processed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Formulary Identifier (FORMULARY_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Identifier (NETWORK_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `benefit_design_version` SET TAGS ('pii_business_glossary_term' = 'Benefit Design Version (BENEFIT_DESIGN_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `cms_plan_code` SET TAGS ('pii_business_glossary_term' = 'CMS Plan Identifier (CMS_PLAN_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `cms_plan_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Percentage (COINSURANCE_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `copay_primary_care` SET TAGS ('pii_business_glossary_term' = 'Primary Care Copayment (COPAY_PRIMARY_CARE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `copay_specialist` SET TAGS ('pii_business_glossary_term' = 'Specialist Copayment (COPAY_SPECIALIST)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `deductible_family` SET TAGS ('pii_business_glossary_term' = 'Family Deductible Amount (DEDUCTIBLE_FAMILY)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `deductible_individual` SET TAGS ('pii_business_glossary_term' = 'Individual Deductible Amount (DEDUCTIBLE_INDIVIDUAL)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `enrollment_end_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment End Date (ENROLL_END_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `enrollment_start_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Start Date (ENROLL_START_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `hcc_score` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category Score (HCC_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `hios_plan_code` SET TAGS ('pii_business_glossary_term' = 'Health Insurance Oversight System (HIOS) Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `hios_plan_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `is_exempt_from_mlr` SET TAGS ('pii_business_glossary_term' = 'MLR Exemption Flag (MLR_EXEMPT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|government');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment (MARKET_SEGMENT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'individual|small_group|large_group|medicare|medicaid');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier (NETWORK_TIER)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `out_of_pocket_max_family` SET TAGS ('pii_business_glossary_term' = 'Family Out‑of‑Pocket Maximum (OOP_MAX_FAMILY)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `out_of_pocket_max_individual` SET TAGS ('pii_business_glossary_term' = 'Individual Out‑of‑Pocket Maximum (OOP_MAX_INDIVIDUAL)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_aca_compliant` SET TAGS ('pii_business_glossary_term' = 'ACA Compliance Flag (ACA_COMPLIANT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_category` SET TAGS ('pii_business_glossary_term' = 'Plan Category (PLAN_CATEGORY)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_category` SET TAGS ('pii_value_regex' = 'commercial|government|special');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Plan Code (PLAN_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_description` SET TAGS ('pii_business_glossary_term' = 'Plan Description (PLAN_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_marketplace_eligible` SET TAGS ('pii_business_glossary_term' = 'Marketplace Eligibility Flag (MARKETPLACE_ELIGIBLE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Plan Name (PLAN_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_region` SET TAGS ('pii_business_glossary_term' = 'Plan Region (PLAN_REGION)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_state` SET TAGS ('pii_business_glossary_term' = 'Plan State (PLAN_STATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Plan Status (PLAN_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type (PLAN_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year (PLAN_YEAR)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Premium Amount (PREMIUM_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `premium_currency` SET TAGS ('pii_business_glossary_term' = 'Premium Currency (PREMIUM_CURR)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `premium_frequency` SET TAGS ('pii_business_glossary_term' = 'Premium Frequency (PREMIUM_FREQ)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `premium_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `regulatory_classification` SET TAGS ('pii_business_glossary_term' = 'Regulatory Classification (REG_CLASS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `sbc_document_url` SET TAGS ('pii_business_glossary_term' = 'Summary of Benefits and Coverage Document URL (SBC_URL)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date (TERMINATION_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `fhir_coverage_plan_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_subdomain' = 'product_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.coverage.benefit');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `benefit_package_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Package Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `actuarial_value_pct` SET TAGS ('pii_business_glossary_term' = 'Actuarial Value Percentage (AV%)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `benefit_package_status` SET TAGS ('pii_business_glossary_term' = 'Benefit Package Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `benefit_package_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `coinsurance_inpatient` SET TAGS ('pii_business_glossary_term' = 'Inpatient Coinsurance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `coinsurance_outpatient` SET TAGS ('pii_business_glossary_term' = 'Outpatient Coinsurance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `copay_primary_care` SET TAGS ('pii_business_glossary_term' = 'Primary Care Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `copay_specialist` SET TAGS ('pii_business_glossary_term' = 'Specialist Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `deductible_type` SET TAGS ('pii_business_glossary_term' = 'Deductible Design Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `deductible_type` SET TAGS ('pii_value_regex' = 'embedded|aggregate');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `family_deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Family Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `generic_substitution_required` SET TAGS ('pii_business_glossary_term' = 'Generic Substitution Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `individual_deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Individual Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `mail_order_copay_brand` SET TAGS ('pii_business_glossary_term' = 'Mail‑Order Brand Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `mail_order_copay_generic` SET TAGS ('pii_business_glossary_term' = 'Mail‑Order Generic Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `metal_tier` SET TAGS ('pii_business_glossary_term' = 'Metal Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `metal_tier` SET TAGS ('pii_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `network_designation` SET TAGS ('pii_business_glossary_term' = 'Network Designation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `network_designation` SET TAGS ('pii_value_regex' = 'in_network|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `out_of_pocket_max_family` SET TAGS ('pii_business_glossary_term' = 'Family Out‑of‑Pocket Maximum');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `out_of_pocket_max_individual` SET TAGS ('pii_business_glossary_term' = 'Individual Out‑of‑Pocket Maximum');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `package_code` SET TAGS ('pii_business_glossary_term' = 'Benefit Package Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `package_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `package_name` SET TAGS ('pii_business_glossary_term' = 'Benefit Package Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type (HMO, PPO, etc.)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP|QHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `prior_auth_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `retail_copay_brand` SET TAGS ('pii_business_glossary_term' = 'Retail Brand Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `retail_copay_generic` SET TAGS ('pii_business_glossary_term' = 'Retail Generic Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `specialty_copay` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `specialty_drug_management_program` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Management Program');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_subdomain' = 'product_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_fhir_resource' = 'Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `accumulation_rule` SET TAGS ('pii_business_glossary_term' = 'Benefit Accumulation Rule');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `accumulation_rule` SET TAGS ('pii_value_regex' = 'cumulative|reset_annually|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `authorization_type` SET TAGS ('pii_business_glossary_term' = 'Authorization Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `authorization_type` SET TAGS ('pii_value_regex' = 'pre|concurrent|post|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_group` SET TAGS ('pii_business_glossary_term' = 'Benefit Group');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_group` SET TAGS ('pii_value_regex' = 'employee|spouse|dependent|family|individual');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_status` SET TAGS ('pii_business_glossary_term' = 'Benefit Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_category` SET TAGS ('pii_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_code` SET TAGS ('pii_business_glossary_term' = 'Benefit Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_amount` SET TAGS ('pii_business_glossary_term' = 'Cost‑Sharing Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_frequency` SET TAGS ('pii_business_glossary_term' = 'Cost‑Sharing Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_frequency` SET TAGS ('pii_value_regex' = 'per_visit|per_month|annual|lifetime');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_percent` SET TAGS ('pii_business_glossary_term' = 'Cost‑Sharing Percent');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_type` SET TAGS ('pii_business_glossary_term' = 'Cost‑Sharing Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_type` SET TAGS ('pii_value_regex' = 'deductible|copay|coinsurance|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|both');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `drug_ndc` SET TAGS ('pii_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `ehb_classification` SET TAGS ('pii_business_glossary_term' = 'Essential Health Benefit Classification');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `ehb_classification` SET TAGS ('pii_value_regex' = 'yes|no');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `exclusion_code` SET TAGS ('pii_business_glossary_term' = 'Benefit Exclusion Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `exclusion_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `exclusion_reason` SET TAGS ('pii_business_glossary_term' = 'Benefit Exclusion Reason');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `exclusion_type` SET TAGS ('pii_business_glossary_term' = 'Benefit Exclusion Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `exclusion_type` SET TAGS ('pii_value_regex' = 'service|diagnosis|provider|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `formulary_tier` SET TAGS ('pii_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `formulary_tier` SET TAGS ('pii_value_regex' = 'generic|preferred|non_preferred|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `is_exempt` SET TAGS ('pii_business_glossary_term' = 'Exempt Benefit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Mandatory Benefit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_period` SET TAGS ('pii_business_glossary_term' = 'Benefit Limit Period');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_period` SET TAGS ('pii_value_regex' = 'per_year|per_lifetime|per_month');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_type` SET TAGS ('pii_business_glossary_term' = 'Benefit Limit Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_type` SET TAGS ('pii_value_regex' = 'visit|day|dollar|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_value` SET TAGS ('pii_business_glossary_term' = 'Benefit Limit Value');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `moop_max_amount` SET TAGS ('pii_business_glossary_term' = 'Maximum Out‑of‑Pocket (MOOP) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('pii_business_glossary_term' = 'Benefit Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `oop_max_amount` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Pocket Maximum Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `preventive_service_flag` SET TAGS ('pii_business_glossary_term' = 'Preventive Service Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `prior_auth_review_level` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Review Level');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `prior_auth_review_level` SET TAGS ('pii_value_regex' = 'provider|clinical|pharmacy|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `regulatory_classification` SET TAGS ('pii_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `regulatory_classification` SET TAGS ('pii_value_regex' = 'ACA_EHB|non_EHB|state_specific|federal');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `service_code` SET TAGS ('pii_business_glossary_term' = 'Service Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `tier` SET TAGS ('pii_business_glossary_term' = 'Benefit Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `tier` SET TAGS ('pii_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `wellness_mandate_flag` SET TAGS ('pii_business_glossary_term' = 'Wellness Mandate Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_subdomain' = 'product_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_rule_id` SET TAGS ('pii_business_glossary_term' = 'Cost Share Rule Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `benefit_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `benefit_package_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Package Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `accumulator_threshold` SET TAGS ('pii_business_glossary_term' = 'Accumulator Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `accumulator_unit` SET TAGS ('pii_business_glossary_term' = 'Accumulator Unit');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `accumulator_unit` SET TAGS ('pii_value_regex' = 'dollar|visit|day|procedure|service|unit');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `after_deductible` SET TAGS ('pii_business_glossary_term' = 'Applies After Deductible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_ancillary` SET TAGS ('pii_business_glossary_term' = 'Ancillary Service Applicability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_drug` SET TAGS ('pii_business_glossary_term' = 'Drug Applicability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_procedure` SET TAGS ('pii_business_glossary_term' = 'Procedure Applicability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_service_category` SET TAGS ('pii_business_glossary_term' = 'Service Category Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_service_category` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|emergency|pharmacy|dental|vision');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `coinsurance_rate` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Rate (In‑Network)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `coinsurance_rate_out_of_network` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Rate (Out‑of‑Network)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Amount (In‑Network)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `copay_amount_out_of_network` SET TAGS ('pii_business_glossary_term' = 'Copay Amount (Out‑of‑Network)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_category` SET TAGS ('pii_business_glossary_term' = 'Cost Share Category');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_category` SET TAGS ('pii_value_regex' = 'preventive_exempt|before_deductible|after_deductible|post_moop');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_rule_status` SET TAGS ('pii_business_glossary_term' = 'Cost Share Rule Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_rule_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|retired|draft');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `deductible_aggregate_flag` SET TAGS ('pii_business_glossary_term' = 'Aggregate Deductible Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `deductible_embedded_flag` SET TAGS ('pii_business_glossary_term' = 'Embedded Deductible Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_rule_description` SET TAGS ('pii_business_glossary_term' = 'Cost Share Rule Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `hsa_compatible` SET TAGS ('pii_business_glossary_term' = 'HSA Compatibility Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `is_default_rule` SET TAGS ('pii_business_glossary_term' = 'Default Rule Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `max_benefit_amount` SET TAGS ('pii_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `max_benefit_units` SET TAGS ('pii_business_glossary_term' = 'Maximum Benefit Units');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `member_tier` SET TAGS ('pii_business_glossary_term' = 'Member Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `member_tier` SET TAGS ('pii_value_regex' = 'individual|family|group');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `network_type` SET TAGS ('pii_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `network_type` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|both');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `out_of_pocket_max` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Pocket Maximum (Individual)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `out_of_pocket_max_family` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Pocket Maximum (Family)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `prior_to_deductible` SET TAGS ('pii_business_glossary_term' = 'Applies Prior to Deductible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `regulatory_classification` SET TAGS ('pii_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `regulatory_classification` SET TAGS ('pii_value_regex' = 'ACA|CMS|HIPAA|NAIC|state|federal');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_code` SET TAGS ('pii_business_glossary_term' = 'Cost Share Rule Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_business_glossary_term' = 'Cost Share Rule Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_type` SET TAGS ('pii_business_glossary_term' = 'Cost Share Rule Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_type` SET TAGS ('pii_value_regex' = 'deductible|copay|coinsurance|out_of_pocket_max|accumulator|other');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_version` SET TAGS ('pii_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_subdomain' = 'product_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `year_id` SET TAGS ('pii_business_glossary_term' = 'Plan Year Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `aca_compliance_indicator` SET TAGS ('pii_business_glossary_term' = 'ACA Compliance Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `accumulator_reset_date` SET TAGS ('pii_business_glossary_term' = 'Accumulator Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `cms_plan_submission_deadline` SET TAGS ('pii_business_glossary_term' = 'CMS Plan Submission Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Plan Year End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `grace_period_days` SET TAGS ('pii_business_glossary_term' = 'Grace Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `grace_period_days` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `grace_period_days` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Plan Year Budget Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_code` SET TAGS ('pii_business_glossary_term' = 'Plan Year Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_coverage_type` SET TAGS ('pii_business_glossary_term' = 'Plan Year Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_coverage_type` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP|QHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_description` SET TAGS ('pii_business_glossary_term' = 'Plan Year Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_market_segment` SET TAGS ('pii_business_glossary_term' = 'Plan Year Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_market_segment` SET TAGS ('pii_value_regex' = 'individual|group|government');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_notes` SET TAGS ('pii_business_glossary_term' = 'Plan Year Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_premium_rate` SET TAGS ('pii_business_glossary_term' = 'Plan Year Premium Rate');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_regulatory_classification` SET TAGS ('pii_business_glossary_term' = 'Plan Year Regulatory Classification');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_regulatory_classification` SET TAGS ('pii_value_regex' = 'Medicare Advantage|Medicaid|Marketplace|Employer Sponsored');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_state` SET TAGS ('pii_business_glossary_term' = 'Plan Year State');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_type` SET TAGS ('pii_business_glossary_term' = 'Plan Year Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_type` SET TAGS ('pii_value_regex' = 'calendar|fiscal|custom');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `premium_effective_date` SET TAGS ('pii_business_glossary_term' = 'Premium Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `regulatory_filing_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `revision_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `run_out_period_days` SET TAGS ('pii_business_glossary_term' = 'Run‑Out Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `special_enrollment_period_rules` SET TAGS ('pii_business_glossary_term' = 'Special Enrollment Period Rules');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Plan Year Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `year_status` SET TAGS ('pii_business_glossary_term' = 'Plan Year Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `year_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|closed|draft');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `sbc_document_id` SET TAGS ('pii_business_glossary_term' = 'Summary of Benefits and Coverage (SBC) Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'SBC Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `author` SET TAGS ('pii_business_glossary_term' = 'SBC Author');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `checksum_sha256` SET TAGS ('pii_business_glossary_term' = 'SBC SHA‑256 Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `checksum_sha256` SET TAGS ('pii_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `cost_sharing_highlights` SET TAGS ('pii_business_glossary_term' = 'SBC Cost‑Sharing Highlights');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `coverage_example` SET TAGS ('pii_business_glossary_term' = 'SBC Coverage Example');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `coverage_example` SET TAGS ('pii_value_regex' = 'birth|chronic|surgery|preventive|mental_health');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'SBC Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `document_category` SET TAGS ('pii_business_glossary_term' = 'SBC Document Category');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `document_category` SET TAGS ('pii_value_regex' = 'individual|group|government');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'SBC Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `document_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `document_size_bytes` SET TAGS ('pii_business_glossary_term' = 'SBC Document Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `document_title` SET TAGS ('pii_business_glossary_term' = 'SBC Document Title');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'SBC Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `document_type` SET TAGS ('pii_value_regex' = 'sbc|sbc_amendment|sbc_translation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'SBC Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'SBC Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'SBC Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `format` SET TAGS ('pii_business_glossary_term' = 'SBC Document Format');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `format` SET TAGS ('pii_value_regex' = 'pdf|html|xml');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `is_current` SET TAGS ('pii_business_glossary_term' = 'SBC Current Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'SBC Language');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `language` SET TAGS ('pii_value_regex' = 'en|es|fr|zh|ar');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `regulatory_submission_status` SET TAGS ('pii_business_glossary_term' = 'SBC Regulatory Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `regulatory_submission_status` SET TAGS ('pii_value_regex' = 'not_submitted|submitted|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'SBC Revision Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `revision_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `sbc_document_status` SET TAGS ('pii_business_glossary_term' = 'SBC Document Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `sbc_document_status` SET TAGS ('pii_value_regex' = 'draft|active|archived|retracted');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `sbc_version` SET TAGS ('pii_business_glossary_term' = 'SBC Version Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'SBC Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'SBC Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'SBC Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_subdomain' = 'pricing_rating');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.plan.specificCost');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_id` SET TAGS ('pii_business_glossary_term' = 'Plan Rate ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `age_rated_premium` SET TAGS ('pii_business_glossary_term' = 'Age‑Rated Premium');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `base_rate` SET TAGS ('pii_business_glossary_term' = 'Base Rate');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `change_reason` SET TAGS ('pii_business_glossary_term' = 'Rate Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_code` SET TAGS ('pii_business_glossary_term' = 'Rate Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `cost_sharing_rule_code` SET TAGS ('pii_business_glossary_term' = 'Cost Sharing Rule Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `cost_sharing_rule_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `family_tier` SET TAGS ('pii_business_glossary_term' = 'Family Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `family_tier` SET TAGS ('pii_value_regex' = 'employee_only|employee_spouse|employee_child|family');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `family_tier_premium` SET TAGS ('pii_business_glossary_term' = 'Family Tier Premium');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `filing_reference` SET TAGS ('pii_business_glossary_term' = 'Rate Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `is_tobacco_surcharge_applicable` SET TAGS ('pii_business_glossary_term' = 'Tobacco Surcharge Applicable');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `market_segment` SET TAGS ('pii_value_regex' = 'individual|small_group|large_group');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `max_age` SET TAGS ('pii_business_glossary_term' = 'Maximum Age');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `min_age` SET TAGS ('pii_business_glossary_term' = 'Minimum Age');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_name` SET TAGS ('pii_business_glossary_term' = 'Rate Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `plan_designation` SET TAGS ('pii_business_glossary_term' = 'Plan Designation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `plan_designation` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP|QHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `premium_type` SET TAGS ('pii_business_glossary_term' = 'Premium Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `premium_type` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_status` SET TAGS ('pii_business_glossary_term' = 'Rate Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rating_area_code` SET TAGS ('pii_business_glossary_term' = 'Rating Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rating_area_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `regulatory_filing_type` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `regulatory_filing_type` SET TAGS ('pii_value_regex' = 'DOI|CMS|ACA');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `surcharge_amount` SET TAGS ('pii_business_glossary_term' = 'Tobacco Surcharge Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('pii_business_glossary_term' = 'Tobacco Use Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('pii_value_regex' = 'yes|no');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `underwriting_class_code` SET TAGS ('pii_business_glossary_term' = 'Underwriting Class Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `underwriting_class_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Rate Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Plan Submission ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `ap_invoice_id` SET TAGS ('pii_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Submitter ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Plan Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fee_currency_code` SET TAGS ('pii_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fee_currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `filing_fee_adjustment` SET TAGS ('pii_business_glossary_term' = 'Filing Fee Adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `filing_fee_gross` SET TAGS ('pii_business_glossary_term' = 'Filing Fee Gross Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `filing_fee_net` SET TAGS ('pii_business_glossary_term' = 'Filing Fee Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `filing_reference_number` SET TAGS ('pii_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `filing_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `hpms_plan_code` SET TAGS ('pii_business_glossary_term' = 'HPMS Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `hpms_plan_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `is_annual_filing` SET TAGS ('pii_business_glossary_term' = 'Is Annual Filing');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Submission Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'cms|state_doi|other');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `regulatory_submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `rejection_date` SET TAGS ('pii_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `reviewer_comments` SET TAGS ('pii_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submission_number` SET TAGS ('pii_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submission_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submission_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submission_type` SET TAGS ('pii_value_regex' = 'qhp|medicare_advantage|medicaid|state_bid|rate_filing');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submitter_role` SET TAGS ('pii_business_glossary_term' = 'Submitter Role');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `submitter_role` SET TAGS ('pii_value_regex' = 'internal|external|broker|agency');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `withdrawal_date` SET TAGS ('pii_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `withdrawal_reason` SET TAGS ('pii_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_subdomain' = 'product_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_fhir_resource' = 'QuestionnaireResponse');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `hsa_hra_config_id` SET TAGS ('pii_business_glossary_term' = 'Health Savings Account / Health Reimbursement Arrangement Configuration ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Trustee / Custodian Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Account Type (HSA/HRA/FSA/LPFSA)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `account_type` SET TAGS ('pii_value_regex' = 'HSA|HRA|FSA|LPFSA');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `catch_up_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Catch‑Up Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `catch_up_contribution_eligible` SET TAGS ('pii_business_glossary_term' = 'Catch‑Up Contribution Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `contribution_frequency` SET TAGS ('pii_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `contribution_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `contribution_limit_amount` SET TAGS ('pii_business_glossary_term' = 'Contribution Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `contribution_limit_type` SET TAGS ('pii_business_glossary_term' = 'Contribution Limit Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `contribution_limit_type` SET TAGS ('pii_value_regex' = 'per_year|per_month');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `contribution_method` SET TAGS ('pii_business_glossary_term' = 'Contribution Method');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `contribution_method` SET TAGS ('pii_value_regex' = 'pre_tax|post_tax|after_tax');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `contribution_source` SET TAGS ('pii_business_glossary_term' = 'Contribution Source');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `contribution_source` SET TAGS ('pii_value_regex' = 'employer|employee|both');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `hsa_hra_config_description` SET TAGS ('pii_business_glossary_term' = 'Configuration Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `eligibility_hdpp` SET TAGS ('pii_business_glossary_term' = 'HDHP Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `employee_contribution_limit` SET TAGS ('pii_business_glossary_term' = 'Employee Contribution Limit');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `employer_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `grace_period_option` SET TAGS ('pii_business_glossary_term' = 'Grace Period Option');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `grace_period_option` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `grace_period_option` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `hsa_hra_config_status` SET TAGS ('pii_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `hsa_hra_config_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `irs_minimum_deductible` SET TAGS ('pii_business_glossary_term' = 'IRS Minimum Deductible Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `irs_out_of_pocket_max` SET TAGS ('pii_business_glossary_term' = 'IRS Out‑of‑Pocket Maximum Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `plan_year_end_date` SET TAGS ('pii_business_glossary_term' = 'Plan Year End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `plan_year_start_date` SET TAGS ('pii_business_glossary_term' = 'Plan Year Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `rollover_allowed` SET TAGS ('pii_business_glossary_term' = 'Rollover Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `rollover_limit_amount` SET TAGS ('pii_business_glossary_term' = 'Rollover Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `trustee_custodian_name` SET TAGS ('pii_business_glossary_term' = 'Trustee / Custodian Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `use_it_or_lose_it_flag` SET TAGS ('pii_business_glossary_term' = 'Use‑It‑Or‑Lose‑It Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_subdomain' = 'product_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.coverage.benefit');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `rx_benefit_config_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Configuration ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coinsurance_rate` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Rate Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `cost_sharing_method` SET TAGS ('pii_business_glossary_term' = 'Cost Sharing Method');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `cost_sharing_method` SET TAGS ('pii_value_regex' = 'copay|coinsurance|percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Per Prescription');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_year` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Per Year');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `deductible_applicable` SET TAGS ('pii_business_glossary_term' = 'Deductible Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `drug_category_exclusions` SET TAGS ('pii_business_glossary_term' = 'Drug Category Exclusions');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `formulary_version` SET TAGS ('pii_business_glossary_term' = 'Formulary Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `is_biologic_preferred` SET TAGS ('pii_business_glossary_term' = 'Biologic Preferred Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `is_biosimilar_preferred` SET TAGS ('pii_business_glossary_term' = 'Biosimilar Preferred Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `is_exempt_from_mlr` SET TAGS ('pii_business_glossary_term' = 'Exempt from Medical Loss Ratio (MLR) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `is_specialty_drug_excluded` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Excluded Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `mail_order_network_type` SET TAGS ('pii_business_glossary_term' = 'Mail‑Order Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `mail_order_network_type` SET TAGS ('pii_value_regex' = 'in_network|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `max_coverage_amount` SET TAGS ('pii_business_glossary_term' = 'Maximum Coverage Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `ninety_day_supply_allowed` SET TAGS ('pii_business_glossary_term' = '90‑Day Supply Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `out_of_pocket_max` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Pocket Maximum Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `pbm_vendor` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Vendor');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `prior_auth_exemption_drugs` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Exemption Drugs List');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `regulatory_classification` SET TAGS ('pii_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `retail_network_type` SET TAGS ('pii_business_glossary_term' = 'Retail Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `retail_network_type` SET TAGS ('pii_value_regex' = 'in_network|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `rx_benefit_config_status` SET TAGS ('pii_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `rx_benefit_config_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `specialty_pharmacy_network` SET TAGS ('pii_business_glossary_term' = 'Specialty Pharmacy Network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `therapeutic_class_limit` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Class Limit');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_subdomain' = 'product_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_config_id` SET TAGS ('pii_business_glossary_term' = 'Plan Network Configuration Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `access_type` SET TAGS ('pii_business_glossary_term' = 'Access Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `access_type` SET TAGS ('pii_value_regex' = 'HMO_closed|PPO_open|EPO_exclusive|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_adequacy_measure` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Measure');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_adequacy_standard_code` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Standard Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_adequacy_standard_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_config_status` SET TAGS ('pii_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_config_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_contract_number` SET TAGS ('pii_business_glossary_term' = 'Network Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_coverage_type` SET TAGS ('pii_business_glossary_term' = 'Network Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_coverage_type` SET TAGS ('pii_value_regex' = 'full|partial|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_designation` SET TAGS ('pii_business_glossary_term' = 'Network Designation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_designation` SET TAGS ('pii_value_regex' = 'in_network|out_of_network|partial');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_exclusion_description` SET TAGS ('pii_business_glossary_term' = 'Network Exclusion Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_exclusion_flag` SET TAGS ('pii_business_glossary_term' = 'Network Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_geography_region` SET TAGS ('pii_business_glossary_term' = 'Network Geography Region');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_provider_count` SET TAGS ('pii_business_glossary_term' = 'Network Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_state` SET TAGS ('pii_business_glossary_term' = 'Network State');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_zip_code` SET TAGS ('pii_business_glossary_term' = 'Network ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_benefit_type` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Network Benefit Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_benefit_type` SET TAGS ('pii_value_regex' = 'copay|coinsurance|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_coinsurance_pct` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Network Coinsurance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_copay_amount` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Network Copay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Network Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `tier_priority` SET TAGS ('pii_business_glossary_term' = 'Tier Priority Order');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_subdomain' = 'pricing_rating');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `crosswalk_id` SET TAGS ('pii_business_glossary_term' = 'Plan Crosswalk Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Prior Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `crosswalk_status` SET TAGS ('pii_business_glossary_term' = 'Crosswalk Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `crosswalk_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `crosswalk_type` SET TAGS ('pii_business_glossary_term' = 'Crosswalk Type (Auto‑Renewal, Member‑Directed, CMS‑Mandated)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `crosswalk_type` SET TAGS ('pii_value_regex' = 'auto_renewal|member_directed|cms_mandated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Crosswalk Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Crosswalk Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Regulatory Mandatory Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `member_notification_required` SET TAGS ('pii_business_glossary_term' = 'Member Notification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Crosswalk Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Member Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `notification_method` SET TAGS ('pii_value_regex' = 'email|mail|portal|phone');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `notification_sent_date` SET TAGS ('pii_business_glossary_term' = 'Member Notification Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Crosswalk Reason');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `sequence` SET TAGS ('pii_business_glossary_term' = 'Crosswalk Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_subdomain' = 'pricing_rating');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('pii_business_glossary_term' = 'Plan Status History ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Triggering User ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `audit_created_by` SET TAGS ('pii_business_glossary_term' = 'Audit Created By');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `audit_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `audit_source_system` SET TAGS ('pii_business_glossary_term' = 'Audit Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Required');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `is_legacy` SET TAGS ('pii_business_glossary_term' = 'Is Legacy Transition');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `new_status` SET TAGS ('pii_business_glossary_term' = 'New Plan Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `prior_status` SET TAGS ('pii_business_glossary_term' = 'Prior Plan Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `reason_code` SET TAGS ('pii_value_regex' = 'regulatory_action|market_withdrawal|merger|non_renewal|compliance_suspension|other');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `regulatory_action_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Action Reference');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `transition_effective_date` SET TAGS ('pii_business_glossary_term' = 'Transition Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transition Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `triggered_by` SET TAGS ('pii_business_glossary_term' = 'Triggered By');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `triggered_by` SET TAGS ('pii_value_regex' = 'system|user|automated_process');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `triggered_by_system_name` SET TAGS ('pii_business_glossary_term' = 'Triggering System Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_subdomain' = 'market_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_association_edges' = 'plan.health_plan,employer.employer_group');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `offering_id` SET TAGS ('pii_business_glossary_term' = 'Plan Offering - Plan Offering Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Plan Offering - Employer Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Offering - Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `offering_code` SET TAGS ('pii_business_glossary_term' = 'Offering Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `offering_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `contribution_percent` SET TAGS ('pii_business_glossary_term' = 'Contribution Percent');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `contribution_tier` SET TAGS ('pii_business_glossary_term' = 'Contribution Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `contribution_type` SET TAGS ('pii_business_glossary_term' = 'Contribution Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `employee_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Employee Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `family_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Family Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `offering_name` SET TAGS ('pii_business_glossary_term' = 'Offering Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `offering_status` SET TAGS ('pii_business_glossary_term' = 'Offering Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `offering_type` SET TAGS ('pii_business_glossary_term' = 'Offering Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment End');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment Start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_subdomain' = 'market_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_association_edges' = 'plan.health_plan,care.care_program');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_fhir_resource' = 'Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_ssot_source_domain' = 'plan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_ssot_duplicate_of' = 'contract.amendment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_ssot_alias_of' = 'contract.amendment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_ssot_canonical' = 'contract.amendment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_ssot_master' = 'contract.amendment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_ssot_concept' = 'plan_amendment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `plan_amendment2_id` SET TAGS ('pii_business_glossary_term' = 'Plan Amendment Identifier (PLAN_AMENDMENT_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (CREATED_BY_USER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `amendment_updated_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User Identifier (UPDATED_BY_USER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `amendment_updated_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `amendment_updated_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `approver_employee_id` SET TAGS ('pii_business_glossary_term' = 'Amendment Approval User Identifier (APPROVAL_USER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `approver_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `approver_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Identifier (PLAN_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `contract_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Contract Amendment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `sbc_document_id` SET TAGS ('pii_business_glossary_term' = 'SBC Document Identifier (SBC_DOC_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number (AMENDMENT_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `amendment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `amendment_type` SET TAGS ('pii_business_glossary_term' = 'Amendment Type (AMENDMENT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `amendment_type` SET TAGS ('pii_value_regex' = 'benefit_change|cost_share_change|network_change|service_area_change|formulary_update');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `approval_comment` SET TAGS ('pii_business_glossary_term' = 'Amendment Approval Comment (APPROVAL_COMMENT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `change_summary` SET TAGS ('pii_business_glossary_term' = 'Amendment Change Summary (CHANGE_SUMMARY)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `cms_filing_reference` SET TAGS ('pii_business_glossary_term' = 'CMS Filing Reference (CMS_FILING_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag (COMPLIANCE_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `cost_share_change_details` SET TAGS ('pii_business_glossary_term' = 'Cost Share Change Details (COST_SHARE_CHANGE_DETAILS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `doi_filing_reference` SET TAGS ('pii_business_glossary_term' = 'Department of Insurance Filing Reference (DOI_FILING_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `effective_year` SET TAGS ('pii_business_glossary_term' = 'Amendment Effective Plan Year (EFFECTIVE_PLAN_YEAR)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `formulary_change_details` SET TAGS ('pii_business_glossary_term' = 'Formulary Change Details (FORMULARY_CHANGE_DETAILS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `impact_estimated_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Total Cost Impact (ESTIMATED_COST_IMPACT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `impact_estimated_member_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Member Cost Impact (ESTIMATED_MEMBER_COST_IMPACT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `impact_estimated_provider_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Provider Cost Impact (ESTIMATED_PROVIDER_COST_IMPACT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `impacted_benefit_package_ids` SET TAGS ('pii_business_glossary_term' = 'Impacted Benefit Package Identifiers (IMPACTED_BENEFIT_PKG_IDS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `member_notification_date` SET TAGS ('pii_business_glossary_term' = 'Member Notification Date (MEMBER_NOTIFICATION_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `member_notification_required` SET TAGS ('pii_business_glossary_term' = 'Member Notification Required Flag (MEMBER_NOTIFICATION_REQ)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `network_change_details` SET TAGS ('pii_business_glossary_term' = 'Network Change Details (NETWORK_CHANGE_DETAILS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `plan_amendment_description` SET TAGS ('pii_business_glossary_term' = 'Amendment Description (AMENDMENT_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `plan_amendment_status` SET TAGS ('pii_business_glossary_term' = 'Amendment Lifecycle Status (AMENDMENT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `plan_amendment_status` SET TAGS ('pii_value_regex' = 'draft|pending|approved|denied|implemented|retracted');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason Code (AMENDMENT_REASON_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason Description (AMENDMENT_REASON_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `regulatory_approval_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Date (REG_APPROVAL_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `review_deadline` SET TAGS ('pii_business_glossary_term' = 'Amendment Review Deadline (REVIEW_DEADLINE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `service_area_change_details` SET TAGS ('pii_business_glossary_term' = 'Service Area Change Details (SERVICE_AREA_CHANGE_DETAILS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Status Reason (STATUS_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `triggers_sbc_generation` SET TAGS ('pii_business_glossary_term' = 'Triggers SBC Document Generation Flag (TRIGGERS_SBC_GEN)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment2` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Amendment Version Number (AMENDMENT_VERSION)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_subdomain' = 'market_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_association_edges' = 'plan.health_plan,contract.provider_contract');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ssot_ref' = 'contract.contract_provider_contract');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ssot_source_domain' = 'plan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ssot_duplicate_of' = 'contract.contract_provider_contract');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ssot_alias_of' = 'contract.contract_provider_contract');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ssot_canonical' = 'contract.contract_provider_contract');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ssot_master' = 'contract.contract_provider_contract');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_ssot_concept' = 'plan_provider_contract');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `provider_contract_link_id` SET TAGS ('pii_business_glossary_term' = 'Plan Provider Contract - Plan Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Provider Contract - Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Contract Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_ssot_canonical' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `provider_network_participation2_id` SET TAGS ('pii_business_glossary_term' = 'Network Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `tertiary_provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Ssot Provider Contract Ref Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `tertiary_provider_contract_id` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `auto_renew_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Renewal');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `capitation_flag` SET TAGS ('pii_business_glossary_term' = 'Capitation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `contract_role` SET TAGS ('pii_business_glossary_term' = 'Contract Role');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `contract_status` SET TAGS ('pii_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `credentialing_required_flag` SET TAGS ('pii_business_glossary_term' = 'Credentialing Required');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `effective_term_months` SET TAGS ('pii_business_glossary_term' = 'Effective Term Months');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fee_schedule_type` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `is_capitated` SET TAGS ('pii_business_glossary_term' = 'Is Capitated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `is_par` SET TAGS ('pii_business_glossary_term' = 'Is Par');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `max_panel_size` SET TAGS ('pii_business_glossary_term' = 'Max Panel Size');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `notice_period_days` SET TAGS ('pii_business_glossary_term' = 'Notice Period');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `plan_provider_contract_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `reimbursement_method` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Method');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `reimbursement_methodology` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `reimbursement_terms` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Terms');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `renewal_term_months` SET TAGS ('pii_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `tier_assignment` SET TAGS ('pii_business_glossary_term' = 'Tier Assignment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `tier_level` SET TAGS ('pii_business_glossary_term' = 'Tier Level');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract_link` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_association_edges' = 'plan.health_plan,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_ssot_source_domain' = 'plan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_ssot_duplicate_of' = 'compliance.compliance_regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_ssot_alias_of' = 'compliance.compliance_regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_ssot_canonical' = 'compliance.compliance_regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_ssot_master' = 'compliance.compliance_regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_ssot_concept' = 'plan_regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `regulatory_obligation_link_id` SET TAGS ('pii_business_glossary_term' = 'Plan Regulatory Obligation - Plan Regulatory Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Regulatory Obligation - Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `primary_legacy_compliance_regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Compliance Regulatory Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `primary_legacy_compliance_regulatory_obligation_id` SET TAGS ('pii_ssot_canonical' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Ssot Regulatory Obligation Ref Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `citation_reference` SET TAGS ('pii_business_glossary_term' = 'Citation Reference');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `compliance_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `compliance_deadline` SET TAGS ('pii_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `evidence_document_reference` SET TAGS ('pii_business_glossary_term' = 'Evidence Document');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `evidence_reference` SET TAGS ('pii_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `filing_frequency` SET TAGS ('pii_business_glossary_term' = 'Filing Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `last_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `next_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `obligation_code` SET TAGS ('pii_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `obligation_description` SET TAGS ('pii_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `obligation_name` SET TAGS ('pii_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `obligation_status` SET TAGS ('pii_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `obligation_type` SET TAGS ('pii_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `penalty_description` SET TAGS ('pii_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `plan_regulatory_obligation_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `regulator` SET TAGS ('pii_business_glossary_term' = 'Regulator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `regulatory_authority` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `remediation_deadline` SET TAGS ('pii_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `remediation_notes` SET TAGS ('pii_business_glossary_term' = 'Remediation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `remediation_plan` SET TAGS ('pii_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `review_frequency` SET TAGS ('pii_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`regulatory_obligation_link` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_subdomain' = 'market_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_demo_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `plan_service_area_id` SET TAGS ('pii_business_glossary_term' = 'Plan Service Area ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `sbc_document_id` SET TAGS ('pii_business_glossary_term' = 'Summary of Benefits and Coverage Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `county` SET TAGS ('pii_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type (Plan Type)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'HMO|PPO|EPO|POS|HDHP|QHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `enrollment_capacity` SET TAGS ('pii_business_glossary_term' = 'Enrollment Capacity (Maximum Members)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `exchange_market` SET TAGS ('pii_business_glossary_term' = 'Exchange Market');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `exchange_market_code` SET TAGS ('pii_business_glossary_term' = 'Exchange Market Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `exchange_market_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `geographic_region_code` SET TAGS ('pii_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `geographic_region_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_exclusive` SET TAGS ('pii_business_glossary_term' = 'Exclusive Service Area Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_federal_funded` SET TAGS ('pii_business_glossary_term' = 'Federal Funding Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_medicaid_eligible` SET TAGS ('pii_business_glossary_term' = 'Medicaid Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_medicare_eligible` SET TAGS ('pii_business_glossary_term' = 'Medicare Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_regulatory_compliant` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_state_funded` SET TAGS ('pii_business_glossary_term' = 'State Funding Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `network_type` SET TAGS ('pii_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `network_type` SET TAGS ('pii_value_regex' = 'in_network|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `plan_category` SET TAGS ('pii_business_glossary_term' = 'Plan Category');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `plan_category` SET TAGS ('pii_value_regex' = 'individual|group|government|exchange');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `regulatory_approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `regulatory_filing_number` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `regulatory_filing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_code` SET TAGS ('pii_business_glossary_term' = 'CMS Service Area Identifier (CMS ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_name` SET TAGS ('pii_business_glossary_term' = 'Service Area Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_type` SET TAGS ('pii_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_type` SET TAGS ('pii_value_regex' = 'state|county|zip|region');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State (US State Code)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `state` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_excluded` SET TAGS ('pii_business_glossary_term' = 'Excluded ZIP Codes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_excluded` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_excluded` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_included` SET TAGS ('pii_business_glossary_term' = 'Included ZIP Codes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_included` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_included` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` SET TAGS ('pii_subdomain' = 'market_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` SET TAGS ('pii_demo_testing_candidate' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ALTER COLUMN `plan_amendment_id` SET TAGS ('pii_business_glossary_term' = 'plan_amendment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
