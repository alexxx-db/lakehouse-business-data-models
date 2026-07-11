-- Schema for Domain: plan | Business: Health_Insurance | Version: v3_mvm
-- Generated on: 2026-07-10 22:45:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`plan` COMMENT 'Single source of truth for all health plan products and benefit designs — HMO, PPO, EPO, POS, HDHP, QHP, and government plans (Medicare Advantage, Medicaid). Owns benefit structures, cost-sharing rules (deductibles, copays, coinsurance, OOP, MOOP), formulary tiers, SBC documents, plan-year configurations, and regulatory classifications. Supports ACA compliance, CMS plan submissions, and benefits configuration in core administration platforms (Facets, QNXT).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` (
    `health_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the health plan record.',
    `formulary_id` BIGINT COMMENT 'Reference to the formulary that defines drug tiering and coverage for the plan.',
    `benefit_design_version` STRING COMMENT 'Version identifier for the benefit design configuration.',
    `cms_plan_code` STRING COMMENT 'CMS plan identifier used for regulatory reporting.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays after deductible is met.',
    `copay_primary_care` DECIMAL(18,2) COMMENT 'Fixed copayment amount for a primary care office visit.',
    `copay_specialist` DECIMAL(18,2) COMMENT 'Fixed copayment amount for a specialist office visit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was first created in the system.',
    `deductible_family` DECIMAL(18,2) COMMENT 'Annual amount a family must pay before cost‑sharing begins.',
    `deductible_individual` DECIMAL(18,2) COMMENT 'Annual amount an individual member must pay before cost‑sharing begins.',
    `effective_date` DATE COMMENT 'Date the plan becomes binding for members.',
    `enrollment_end_date` DATE COMMENT 'Last date members may enroll in the plan for the plan year.',
    `enrollment_start_date` DATE COMMENT 'First date members may enroll in the plan for the plan year.',
    `hcc_score` DECIMAL(18,2) COMMENT 'Aggregated HCC score for the plan population used in risk adjustment.',
    `hios_plan_code` STRING COMMENT 'CMS‑assigned HIOS identifier for the plan.',
    `is_exempt_from_mlr` BOOLEAN COMMENT 'Indicates whether the plan is exempt from Medical Loss Ratio reporting requirements.',
    `last_review_date` DATE COMMENT 'Date the plan design was last reviewed for compliance or pricing updates.',
    `line_of_business` STRING COMMENT 'Broad business segment the plan belongs to, such as commercial or government.. Valid values are `commercial|government`',
    `market_segment` STRING COMMENT 'Target market for the plan: individual, small group, large group, Medicare, or Medicaid.. Valid values are `individual|small_group|large_group|medicare|medicaid`',
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
    `regulatory_classification` STRING COMMENT 'Regulatory category of the plan (e.g., ACA, Medicare, Medicaid).',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk‑adjusted payments under CMS risk adjustment models.',
    `sbc_document_url` STRING COMMENT 'Link to the electronic Summary of Benefits and Coverage document for the plan.',
    `termination_date` DATE COMMENT 'Date the plan is terminated or expires; null if open‑ended.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan record.',
    CONSTRAINT pk_health_plan PRIMARY KEY(`health_plan_id`)
) COMMENT 'Master catalog of all health plan products offered by the insurer — HMO, PPO, EPO, POS, HDHP, QHP, Medicare Advantage, and Medicaid managed care plans. Serves as the SSOT for plan identity, plan type classification, line of business (LOB), market segment (individual, small group, large group, Medicare, Medicaid), regulatory classification, CMS plan ID, HIOS plan ID, plan-year lifecycle, and provider network configuration (network ID, tiered network designations, access type, out-of-network coverage rules, network adequacy standards). Foundational entity for all benefit configuration, enrollment, and claims adjudication in Facets/QNXT.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` (
    `benefit_package_id` BIGINT COMMENT 'System-generated unique identifier for the benefit package record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: A benefit package is defined for a specific health plan. Adding health_plan_id to benefit_package creates the necessary parent relationship and prevents the package from being a silo.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Benefit packages must comply with ACA metal tier actuarial value requirements, EHB mandates, and state benefit mandates. Linking benefit_package to regulatory_obligation enables package-level mandate ',
    `actuarial_value_pct` DECIMAL(18,2) COMMENT 'Percentage of total average costs the plan is expected to cover, expressed as a percent.',
    `benefit_package_status` STRING COMMENT 'Current lifecycle status of the benefit package.. Valid values are `active|inactive|pending|retired`',
    `coinsurance_inpatient` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays for inpatient services after deductible.',
    `coinsurance_outpatient` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays for outpatient services after deductible.',
    `copay_primary_care` DECIMAL(18,2) COMMENT 'Fixed dollar copay for a primary care office visit.',
    `copay_specialist` DECIMAL(18,2) COMMENT 'Fixed dollar copay for a specialist office visit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit package record was first created in the system.',
    `deductible_type` STRING COMMENT 'Indicates whether the deductible is embedded (per member) or aggregate (family).. Valid values are `embedded|aggregate`',
    `effective_end_date` DATE COMMENT 'Date on which the benefit package expires or is superseded (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the benefit package becomes effective.',
    `family_deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount a family must pay before cost‑sharing begins for the family unit.',
    `generic_substitution_required` BOOLEAN COMMENT 'Indicates whether generic substitution is mandatory when a generic equivalent is available.',
    `individual_deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount an individual must pay before cost‑sharing begins.',
    `mail_order_copay_brand` DECIMAL(18,2) COMMENT 'Fixed copay for brand‑name drugs dispensed via mail‑order.',
    `mail_order_copay_generic` DECIMAL(18,2) COMMENT 'Fixed copay for generic drugs dispensed via mail‑order.',
    `metal_tier` STRING COMMENT 'ACA metal tier designation indicating the level of coverage.. Valid values are `bronze|silver|gold|platinum`',
    `network_designation` STRING COMMENT 'Indicates whether the benefit package applies to in‑network or out‑of‑network providers.. Valid values are `in_network|out_of_network`',
    `out_of_pocket_max_family` DECIMAL(18,2) COMMENT 'Maximum amount a family will pay in a plan year for covered services.',
    `out_of_pocket_max_individual` DECIMAL(18,2) COMMENT 'Maximum amount an individual will pay in a plan year for covered services.',
    `package_code` STRING COMMENT 'External business code or number used to identify the benefit package in plan documents and communications.',
    `package_name` STRING COMMENT 'Human‑readable name of the benefit package (e.g., "Silver 2024 PPO").',
    `plan_type` STRING COMMENT 'Classification of the health plan product type.. Valid values are `HMO|PPO|EPO|POS|HDHP|QHP`',
    `prior_auth_required` BOOLEAN COMMENT 'Indicates whether a prior authorization is required for services covered under this package.',
    `retail_copay_brand` DECIMAL(18,2) COMMENT 'Fixed copay for brand‑name drugs dispensed at retail pharmacies.',
    `retail_copay_generic` DECIMAL(18,2) COMMENT 'Fixed copay for generic drugs dispensed at retail pharmacies.',
    `specialty_copay` DECIMAL(18,2) COMMENT 'Fixed copay for specialty pharmacy drugs.',
    `specialty_drug_management_program` STRING COMMENT 'Name or description of the management program applied to specialty drugs (e.g., step therapy, limited distribution).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the benefit package record.',
    CONSTRAINT pk_benefit_package PRIMARY KEY(`benefit_package_id`)
) COMMENT 'Defines the structured benefit package associated with a health plan and plan year, grouping all covered services into a coherent benefit design. Captures package name, effective dates, plan-year, benefit tier (Bronze, Silver, Gold, Platinum for ACA QHPs), actuarial value percentage, metal tier classification, embedded vs. aggregate deductible design, and full pharmacy benefit configuration — PBM vendor, formulary ID, retail vs. mail-order copay differentials, specialty pharmacy requirements, 90-day supply rules, mandatory generic substitution flags, specialty drug management programs, and retail/mail-order/specialty pharmacy network designations. One health plan may have multiple benefit packages across plan years. Sourced from benefits administration and PBM integration (RxClaim/Argus).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`benefit` (
    `benefit_id` BIGINT COMMENT 'Unique surrogate key for each benefit record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: A benefit is defined within a specific benefit package — one benefit_package contains many individual benefits. While benefit already references health_plan directly, the more precise organizational u',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which this benefit belongs.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Individual benefits are mandated by specific regulatory obligations (ACA EHB mandates, state benefit mandates, EPSDT requirements). The existing regulatory_classification plain column is a denormalize',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Specialty-specific benefit design is a real business pattern in health insurance: mental health benefits tied to psychiatry/psychology specialties, preventive care benefits tied to PCP specialties, sp',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: benefit has a denormalized plan_year INT column. The year table is the authoritative plan year configuration record for each health plan. Replacing plan_year INT with a year_id FK normalizes temporal ',
    `accumulation_rule` STRING COMMENT 'Rule governing how limits accumulate across periods.. Valid values are `cumulative|reset_annually|none`',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether the benefit requires prior authorization.',
    `authorization_type` STRING COMMENT 'Timing of the required authorization relative to service delivery.. Valid values are `pre|concurrent|post|none`',
    `benefit_status` STRING COMMENT 'Current lifecycle status of the benefit record.. Valid values are `active|inactive|suspended|pending`',
    `benefit_category` STRING COMMENT 'High‑level classification of the benefit type. [ENUM-REF-CANDIDATE: medical|dental|vision|pharmacy|behavioral|dme|snf|home_health|wellness|ancillary — 10 candidates stripped; promote to reference product]',
    `benefit_code` STRING COMMENT 'Business identifier or code used in core administration platforms to reference the benefit.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount for copay or deductible (if applicable).',
    `cost_sharing_frequency` STRING COMMENT 'Frequency at which cost‑sharing applies.. Valid values are `per_visit|per_month|annual|lifetime`',
    `cost_sharing_percent` DECIMAL(18,2) COMMENT 'Percentage for coinsurance (e.g., 20.00 for 20%).',
    `cost_sharing_type` STRING COMMENT 'Mechanism by which the member shares cost (deductible, copay, coinsurance, or none).. Valid values are `deductible|copay|coinsurance|none`',
    `coverage_type` STRING COMMENT 'Indicates whether the benefit applies to in‑network, out‑of‑network, or both provider sets.. Valid values are `in_network|out_of_network|both`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit record was first created in the system.',
    `diagnosis_code` STRING COMMENT 'Diagnosis code that may trigger the benefit or exclusion.',
    `drug_ndc` STRING COMMENT 'NDC identifier for pharmacy benefits, when applicable.',
    `effective_end_date` DATE COMMENT 'Date when the benefit ceases to be active; null for open‑ended benefits.',
    `effective_start_date` DATE COMMENT 'Date when the benefit becomes active for the plan year.',
    `ehb_classification` STRING COMMENT 'Flag indicating if the benefit satisfies ACA Essential Health Benefit requirements.. Valid values are `yes|no`',
    `exclusion_code` STRING COMMENT 'Code identifying the specific excluded service (e.g., CPT, HCPCS, NDC).',
    `exclusion_reason` STRING COMMENT 'Narrative reason for the exclusion (e.g., "experimental", "non‑covered diagnosis").',
    `exclusion_type` STRING COMMENT 'Category of service that is excluded from coverage.. Valid values are `service|diagnosis|provider|none`',
    `formulary_tier` STRING COMMENT 'Tier classification within the drug formulary.. Valid values are `generic|preferred|non_preferred|specialty`',
    `group` STRING COMMENT 'Member group to which the benefit applies.. Valid values are `employee|spouse|dependent|family|individual`',
    `is_exempt` BOOLEAN COMMENT 'True if the benefit is exempt from certain regulations or cost‑sharing.',
    `is_mandatory` BOOLEAN COMMENT 'True if the benefit is required by law or contract.',
    `limit_period` STRING COMMENT 'Timeframe over which the limit applies.. Valid values are `per_year|per_lifetime|per_month`',
    `limit_type` STRING COMMENT 'Type of utilization limit (e.g., number of visits, days, dollar amount).. Valid values are `visit|day|dollar|none`',
    `limit_value` DECIMAL(18,2) COMMENT 'Numeric value associated with the limit type.',
    `moop_max_amount` DECIMAL(18,2) COMMENT 'Maximum out‑of‑pocket expense for the entire plan year, including deductibles and copays.',
    `benefit_name` STRING COMMENT 'Human‑readable name of the benefit (e.g., "Office Visit", "Generic Drug Tier 1").',
    `oop_max_amount` DECIMAL(18,2) COMMENT 'Maximum out‑of‑pocket expense a member can incur in a benefit year.',
    `preventive_service_flag` BOOLEAN COMMENT 'True if the benefit is classified as a preventive service under ACA.',
    `prior_auth_review_level` STRING COMMENT 'Level of review required for the authorization (e.g., provider, clinical, pharmacy).. Valid values are `provider|clinical|pharmacy|none`',
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
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Cost-sharing rules must implement specific regulatory obligations (ACA out-of-pocket maximum limits, MHPAEA parity requirements, HSA-compatible HDHP rules). Linking cost_share_rule to regulatory_oblig',
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
    `deductible_aggregate_flag` BOOLEAN COMMENT 'True if the deductible aggregates across multiple services or members.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the deductible that must be satisfied before cost‑share applies.',
    `deductible_embedded_flag` BOOLEAN COMMENT 'True if the deductible is embedded within the cost‑share rule (e.g., for HDHPs).',
    `cost_share_rule_description` STRING COMMENT 'Free‑form description of the rules purpose and application.',
    `effective_end_date` DATE COMMENT 'Date when the rule expires (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the rule becomes effective.',
    `hsa_compatible` BOOLEAN COMMENT 'True if the rule is compatible with a Health Savings Account (HDHP).',
    `is_default_rule` BOOLEAN COMMENT 'True if this rule is the default for its benefit when no other rule matches.',
    `max_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount payable under this rule per service occurrence.',
    `max_benefit_units` STRING COMMENT 'Maximum number of units (e.g., visits) payable under this rule per benefit period.',
    `member_tier` STRING COMMENT 'Member classification for which the rule applies (individual, family, or group).. Valid values are `individual|family|group`',
    `network_type` STRING COMMENT 'Indicates whether the rule applies to in‑network, out‑of‑network, or both provider networks.. Valid values are `in_network|out_of_network|both`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Maximum amount an individual member can pay out of pocket in a plan year.',
    `out_of_pocket_max_family` DECIMAL(18,2) COMMENT 'Maximum amount a family can pay out of pocket in a plan year.',
    `prior_to_deductible` BOOLEAN COMMENT 'True if the cost‑share applies before the deductible is satisfied.',
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
    `effective_from` DATE COMMENT 'Date on which the plan year becomes legally effective.',
    `effective_until` DATE COMMENT 'Date on which the plan year ceases to be effective (nullable for open‑ended plans).',
    `end_date` DATE COMMENT 'Last day of the plan year coverage period.',
    `grace_period_days` STRING COMMENT 'Number of days after premium due date before coverage is terminated.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`rate` (
    `rate_id` BIGINT COMMENT 'Unique surrogate key for each plan rate record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which this rate applies.',
    `rate_development_id` BIGINT COMMENT 'Foreign key linking to risk.rate_development. Business justification: Actuarial rate development produces the base rates, age factors, and trend factors that populate plan.rate records. Linking plan.rate to risk.rate_development enables actuarial audit trails, regulator',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Rate filings must comply with specific regulatory obligations (state rate review requirements, ACA rate increase justification thresholds, CMS rate filing deadlines). Linking rate to regulatory_obliga',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: rate has a denormalized plan_year INT column. Premium rates are defined per plan year, and the year table is the authoritative plan year record. Replacing plan_year INT with a year_id FK normalizes th',
    `age_rated_premium` DECIMAL(18,2) COMMENT 'Premium amount after applying the age factor to the base rate.',
    `base_rate` DECIMAL(18,2) COMMENT 'Base premium amount before age or family adjustments, expressed in the plan currency.',
    `change_reason` STRING COMMENT 'Free‑text explanation for why the rate was created or modified.',
    `rate_code` STRING COMMENT 'External code used by actuarial systems to identify the rate.',
    `cost_sharing_rule_code` STRING COMMENT 'Code that identifies the cost‑sharing rule (deductible, copay, coinsurance) associated with the plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the premium amounts (e.g., USD).',
    `effective_date` DATE COMMENT 'Date on which the rate becomes effective for enrollment.',
    `family_tier` STRING COMMENT 'Category of coverage for the enrollee: employee only, employee + spouse, employee + child, or family.. Valid values are `employee_only|employee_spouse|employee_child|family`',
    `family_tier_premium` DECIMAL(18,2) COMMENT 'Premium amount for the specified family tier.',
    `filing_reference` STRING COMMENT 'Reference number for the filing submitted to the Department of Insurance.',
    `is_tobacco_surcharge_applicable` BOOLEAN COMMENT 'Indicates if a tobacco surcharge is applied to this rate.',
    `market_segment` STRING COMMENT 'Segment of the market the rate applies to: individual, small group, or large group.. Valid values are `individual|small_group|large_group`',
    `max_age` STRING COMMENT 'Inclusive upper bound of the age band for this rate.',
    `min_age` STRING COMMENT 'Inclusive lower bound of the age band for this rate.',
    `rate_name` STRING COMMENT 'Human‑readable name for the rate definition.',
    `plan_designation` STRING COMMENT 'Type of health plan product (e.g., HMO, PPO).. Valid values are `HMO|PPO|EPO|POS|HDHP|QHP`',
    `premium_type` STRING COMMENT 'Frequency at which the premium is billed.. Valid values are `monthly|quarterly|annual`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the rate.. Valid values are `active|inactive|pending|retired`',
    `rating_area_code` STRING COMMENT 'Three‑character code representing the geographic rating area defined by CMS.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Monetary amount added to the premium for tobacco users.',
    `termination_date` DATE COMMENT 'Date on which the rate is no longer valid; null if open‑ended.',
    `tobacco_use_indicator` STRING COMMENT 'Indicates whether the member uses tobacco (yes) or not (no).. Valid values are `yes|no`',
    `underwriting_class_code` STRING COMMENT 'Code representing the underwriting class applied to the rate.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate record.',
    `version` STRING COMMENT 'Version identifier for the rate definition (e.g., v1, v2).',
    CONSTRAINT pk_rate PRIMARY KEY(`rate_id`)
) COMMENT 'Premium rate table for each health plan by rating factors — age band, geographic rating area, tobacco use, plan year, and market segment (individual, small group, large group). Captures the base rate, age-rated premium, family tier premium (employee only, employee + spouse, employee + child, family), rating area code, effective and termination dates, and rate filing reference. Supports premium billing, quoting, and DOI rate filing compliance. Sourced from actuarial rate-setting and pricing systems.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` (
    `plan_service_area_id` BIGINT COMMENT 'Unique surrogate key for the plan service area record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with this service area.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Service area definitions must comply with network adequacy and geographic coverage regulatory obligations (CMS network adequacy standards, state geographic coverage mandates). Linking plan_service_are',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: plan_service_area has a denormalized plan_year INT column. Service area authorizations are defined per plan year — a health plans geographic coverage may change year over year. Replacing plan_year IN',
    `county` STRING COMMENT 'County name within the state for the service area.',
    `coverage_type` STRING COMMENT 'Type of health plan coverage associated with this service area.. Valid values are `HMO|PPO|EPO|POS|HDHP|QHP`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service area record was created.',
    `effective_end_date` DATE COMMENT 'Date when the service area ceases to be effective (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the service area becomes effective for enrollment.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of members that can be enrolled in this service area.',
    `exchange_market` STRING COMMENT 'Name of the ACA exchange market (if applicable) where the plan is offered.',
    `exchange_market_code` STRING COMMENT 'Unique identifier for the exchange market.',
    `geographic_region_code` STRING COMMENT 'Standard code representing the broader geographic region for the service area.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the service area is exclusive to this plan (True) or shared (False).',
    `is_federal_funded` BOOLEAN COMMENT 'Indicates whether the service area receives federal funding.',
    `is_medicaid_eligible` BOOLEAN COMMENT 'Indicates if the service area is eligible for Medicaid plans.',
    `is_medicare_eligible` BOOLEAN COMMENT 'Indicates if the service area is eligible for Medicare Advantage plans.',
    `is_regulatory_compliant` BOOLEAN COMMENT 'Indicates whether the service area meets all regulatory requirements.',
    `is_state_funded` BOOLEAN COMMENT 'Indicates whether the service area receives state funding.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the service area record.. Valid values are `active|inactive|pending|terminated`',
    `network_type` STRING COMMENT 'Specifies if the service area applies to in‑network or out‑of‑network coverage.. Valid values are `in_network|out_of_network`',
    `notes` STRING COMMENT 'Free‑text notes regarding the service area.',
    `plan_category` STRING COMMENT 'Broad category of the plan associated with the service area.. Valid values are `individual|group|government|exchange`',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` (
    `rx_benefit_config_id` BIGINT COMMENT 'System‑generated unique identifier for the pharmacy benefit configuration record.',
    `formulary_id` BIGINT COMMENT 'Unique identifier of the drug formulary associated with this configuration.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which this pharmacy benefit configuration applies.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Rx benefit configurations must comply with ACA preventive drug mandates (USPSTF A/B rated drugs at $0 cost-sharing), state drug coverage mandates, and CMS formulary requirements. Linking rx_benefit_co',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'Coinsurance rate expressed as a percentage of the allowed amount.',
    `cost_sharing_method` STRING COMMENT 'Method used to calculate member cost‑sharing (copay, coinsurance, or percentage).. Valid values are `copay|coinsurance|percentage`',
    `coverage_limit_per_prescription` DECIMAL(18,2) COMMENT 'Maximum reimbursable amount for a single prescription fill.',
    `coverage_limit_per_year` DECIMAL(18,2) COMMENT 'Annual dollar limit on pharmacy benefit coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the pharmacy deductible.',
    `deductible_applicable` BOOLEAN COMMENT 'Indicates whether the plan deductible applies to pharmacy benefits.',
    `drug_category_exclusions` STRING COMMENT 'Comma‑separated list of drug categories that are excluded from coverage.',
    `effective_end_date` DATE COMMENT 'Date when this pharmacy benefit configuration expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when this pharmacy benefit configuration becomes effective.',
    `formulary_version` STRING COMMENT 'Version string of the formulary to support change tracking and audits.',
    `is_biologic_preferred` BOOLEAN COMMENT 'True if biologic drugs are preferred within the formulary.',
    `is_biosimilar_preferred` BOOLEAN COMMENT 'True if biosimilar drugs are preferred over reference biologics.',
    `is_exempt_from_mlr` BOOLEAN COMMENT 'True if the plan is exempt from MLR reporting requirements for this pharmacy benefit.',
    `is_specialty_drug_excluded` BOOLEAN COMMENT 'Indicates whether specialty drugs are excluded from coverage.',
    `last_review_date` DATE COMMENT 'Date when the configuration was last reviewed for compliance or policy changes.',
    `mail_order_network_type` STRING COMMENT 'Classification of the mail‑order pharmacy network.. Valid values are `in_network|out_of_network`',
    `max_coverage_amount` DECIMAL(18,2) COMMENT 'Upper limit on total pharmacy benefit coverage per benefit period.',
    `ninety_day_supply_allowed` BOOLEAN COMMENT 'True if a 90‑day supply of medication is permitted under this benefit configuration.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special instructions.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Maximum out‑of‑pocket expense a member can incur for pharmacy benefits.',
    `pbm_vendor` STRING COMMENT 'Name of the PBM vendor that administers the formulary and pharmacy benefits.',
    `prior_auth_exemption_drugs` STRING COMMENT 'List of NDCs for which prior authorization is waived.',
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
    `effective_end_date` DATE COMMENT 'Date when this plan‑network configuration ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when this plan‑network configuration becomes effective.',
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
    `tier_priority` STRING COMMENT 'Numeric priority used to order tiers when multiple tiers exist.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration record.',
    CONSTRAINT pk_network_config PRIMARY KEY(`network_config_id`)
) COMMENT 'Associates a health plan with its provider network configuration — defining which provider networks are in-network for the plan, tiered network designations (Tier 1 preferred, Tier 2 standard), out-of-network coverage rules, and network adequacy standards. Captures the network ID, network tier, access type (HMO closed, PPO open, EPO exclusive), out-of-network benefit flag, and effective dates. Links the plan domain to the network domain for claims adjudication and member directory services.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ADD CONSTRAINT `fk_plan_year_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ADD CONSTRAINT `fk_plan_plan_service_area_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ADD CONSTRAINT `fk_plan_plan_service_area_year_id` FOREIGN KEY (`year_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`year`(`year_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`plan` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`plan` SET TAGS ('dbx_domain' = 'plan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Formulary Identifier (FORMULARY_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `benefit_design_version` SET TAGS ('dbx_business_glossary_term' = 'Benefit Design Version (BENEFIT_DESIGN_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `cms_plan_code` SET TAGS ('dbx_business_glossary_term' = 'CMS Plan Identifier (CMS_PLAN_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage (COINSURANCE_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `copay_primary_care` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Copayment (COPAY_PRIMARY_CARE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `copay_specialist` SET TAGS ('dbx_business_glossary_term' = 'Specialist Copayment (COPAY_SPECIALIST)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `deductible_family` SET TAGS ('dbx_business_glossary_term' = 'Family Deductible Amount (DEDUCTIBLE_FAMILY)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `deductible_individual` SET TAGS ('dbx_business_glossary_term' = 'Individual Deductible Amount (DEDUCTIBLE_INDIVIDUAL)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date (ENROLL_END_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date (ENROLL_START_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Score (HCC_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `hios_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Oversight System (HIOS) Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `is_exempt_from_mlr` SET TAGS ('dbx_business_glossary_term' = 'MLR Exemption Flag (MLR_EXEMPT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'commercial|government');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (MARKET_SEGMENT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'individual|small_group|large_group|medicare|medicaid');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier (NETWORK_TIER)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `out_of_pocket_max_family` SET TAGS ('dbx_business_glossary_term' = 'Family Out‑of‑Pocket Maximum (OOP_MAX_FAMILY)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `out_of_pocket_max_individual` SET TAGS ('dbx_business_glossary_term' = 'Individual Out‑of‑Pocket Maximum (OOP_MAX_INDIVIDUAL)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_aca_compliant` SET TAGS ('dbx_business_glossary_term' = 'ACA Compliance Flag (ACA_COMPLIANT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Plan Category (PLAN_CATEGORY)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_value_regex' = 'commercial|government|special');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code (PLAN_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description (PLAN_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_marketplace_eligible` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Eligibility Flag (MARKETPLACE_ELIGIBLE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name (PLAN_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_region` SET TAGS ('dbx_business_glossary_term' = 'Plan Region (PLAN_REGION)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_state` SET TAGS ('dbx_business_glossary_term' = 'Plan State (PLAN_STATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status (PLAN_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type (PLAN_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year (PLAN_YEAR)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount (PREMIUM_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency (PREMIUM_CURR)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Frequency (PREMIUM_FREQ)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification (REG_CLASS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `sbc_document_url` SET TAGS ('dbx_business_glossary_term' = 'Summary of Benefits and Coverage Document URL (SBC_URL)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TERMINATION_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `actuarial_value_pct` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Value Percentage (AV%)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `benefit_package_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `benefit_package_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `coinsurance_inpatient` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Coinsurance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `coinsurance_outpatient` SET TAGS ('dbx_business_glossary_term' = 'Outpatient Coinsurance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `copay_primary_care` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `copay_specialist` SET TAGS ('dbx_business_glossary_term' = 'Specialist Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `deductible_type` SET TAGS ('dbx_business_glossary_term' = 'Deductible Design Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `deductible_type` SET TAGS ('dbx_value_regex' = 'embedded|aggregate');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `family_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Family Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `generic_substitution_required` SET TAGS ('dbx_business_glossary_term' = 'Generic Substitution Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `individual_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Individual Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `mail_order_copay_brand` SET TAGS ('dbx_business_glossary_term' = 'Mail‑Order Brand Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `mail_order_copay_generic` SET TAGS ('dbx_business_glossary_term' = 'Mail‑Order Generic Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `metal_tier` SET TAGS ('dbx_business_glossary_term' = 'Metal Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `metal_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `network_designation` SET TAGS ('dbx_business_glossary_term' = 'Network Designation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `network_designation` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `out_of_pocket_max_family` SET TAGS ('dbx_business_glossary_term' = 'Family Out‑of‑Pocket Maximum');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `out_of_pocket_max_individual` SET TAGS ('dbx_business_glossary_term' = 'Individual Out‑of‑Pocket Maximum');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type (HMO, PPO, etc.)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP|QHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `prior_auth_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `retail_copay_brand` SET TAGS ('dbx_business_glossary_term' = 'Retail Brand Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `retail_copay_generic` SET TAGS ('dbx_business_glossary_term' = 'Retail Generic Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `specialty_copay` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Copayment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `specialty_drug_management_program` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Management Program');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `accumulation_rule` SET TAGS ('dbx_business_glossary_term' = 'Benefit Accumulation Rule');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `accumulation_rule` SET TAGS ('dbx_value_regex' = 'cumulative|reset_annually|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `authorization_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `authorization_type` SET TAGS ('dbx_value_regex' = 'pre|concurrent|post|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Sharing Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Sharing Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_frequency` SET TAGS ('dbx_value_regex' = 'per_visit|per_month|annual|lifetime');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_percent` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Sharing Percent');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_type` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Sharing Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `cost_sharing_type` SET TAGS ('dbx_value_regex' = 'deductible|copay|coinsurance|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|both');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `drug_ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `ehb_classification` SET TAGS ('dbx_business_glossary_term' = 'Essential Health Benefit Classification');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `ehb_classification` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `exclusion_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Exclusion Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Benefit Exclusion Reason');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `exclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Exclusion Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `exclusion_type` SET TAGS ('dbx_value_regex' = 'service|diagnosis|provider|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_value_regex' = 'generic|preferred|non_preferred|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `group` SET TAGS ('dbx_business_glossary_term' = 'Benefit Group');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `group` SET TAGS ('dbx_value_regex' = 'employee|spouse|dependent|family|individual');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Exempt Benefit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Benefit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_period` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Period');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_period` SET TAGS ('dbx_value_regex' = 'per_year|per_lifetime|per_month');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'visit|day|dollar|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Value');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `moop_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Out‑of‑Pocket (MOOP) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `oop_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Maximum Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `preventive_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventive Service Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `prior_auth_review_level` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Review Level');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `prior_auth_review_level` SET TAGS ('dbx_value_regex' = 'provider|clinical|pharmacy|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Benefit Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `wellness_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Wellness Mandate Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `accumulator_threshold` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `accumulator_unit` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Unit');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `accumulator_unit` SET TAGS ('dbx_value_regex' = 'dollar|visit|day|procedure|service|unit');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `after_deductible` SET TAGS ('dbx_business_glossary_term' = 'Applies After Deductible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_ancillary` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Applicability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_drug` SET TAGS ('dbx_business_glossary_term' = 'Drug Applicability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_procedure` SET TAGS ('dbx_business_glossary_term' = 'Procedure Applicability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `applies_to_service_category` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|pharmacy|dental|vision');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Rate (In‑Network)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `coinsurance_rate_out_of_network` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Rate (Out‑of‑Network)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount (In‑Network)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `copay_amount_out_of_network` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount (Out‑of‑Network)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Category');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_category` SET TAGS ('dbx_value_regex' = 'preventive_exempt|before_deductible|after_deductible|post_moop');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|draft');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `deductible_aggregate_flag` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Deductible Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `deductible_embedded_flag` SET TAGS ('dbx_business_glossary_term' = 'Embedded Deductible Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `cost_share_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `hsa_compatible` SET TAGS ('dbx_business_glossary_term' = 'HSA Compatibility Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `is_default_rule` SET TAGS ('dbx_business_glossary_term' = 'Default Rule Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `max_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `max_benefit_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Units');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `member_tier` SET TAGS ('dbx_business_glossary_term' = 'Member Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `member_tier` SET TAGS ('dbx_value_regex' = 'individual|family|group');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|both');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Maximum (Individual)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `out_of_pocket_max_family` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Maximum (Family)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `prior_to_deductible` SET TAGS ('dbx_business_glossary_term' = 'Applies Prior to Deductible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'ACA|CMS|HIPAA|NAIC|state|federal');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'deductible|copay|coinsurance|out_of_pocket_max|accumulator|other');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `aca_compliance_indicator` SET TAGS ('dbx_business_glossary_term' = 'ACA Compliance Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `accumulator_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `cms_plan_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'CMS Plan Submission Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Budget Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_coverage_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP|QHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_market_segment` SET TAGS ('dbx_value_regex' = 'individual|group|government');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_premium_rate` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Premium Rate');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Regulatory Classification');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_regulatory_classification` SET TAGS ('dbx_value_regex' = 'Medicare Advantage|Medicaid|Marketplace|Employer Sponsored');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_state` SET TAGS ('dbx_business_glossary_term' = 'Plan Year State');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_type` SET TAGS ('dbx_value_regex' = 'calendar|fiscal|custom');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `premium_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `run_out_period_days` SET TAGS ('dbx_business_glossary_term' = 'Run‑Out Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `special_enrollment_period_rules` SET TAGS ('dbx_business_glossary_term' = 'Special Enrollment Period Rules');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `year_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `year_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|draft');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('dbx_subdomain' = 'pricing_geography');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rate ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_development_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Development Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `age_rated_premium` SET TAGS ('dbx_business_glossary_term' = 'Age‑Rated Premium');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `cost_sharing_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Rule Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `family_tier` SET TAGS ('dbx_business_glossary_term' = 'Family Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `family_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_child|family');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `family_tier_premium` SET TAGS ('dbx_business_glossary_term' = 'Family Tier Premium');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `is_tobacco_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Surcharge Applicable');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'individual|small_group|large_group');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `max_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `min_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `plan_designation` SET TAGS ('dbx_business_glossary_term' = 'Plan Designation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `plan_designation` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP|QHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `premium_type` SET TAGS ('dbx_business_glossary_term' = 'Premium Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `premium_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rating_area_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rating_area_code` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Surcharge Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Use Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `underwriting_class_code` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `underwriting_class_code` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('dbx_subdomain' = 'pricing_geography');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `plan_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Service Area ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type (Plan Type)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP|QHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity (Maximum Members)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `exchange_market` SET TAGS ('dbx_business_glossary_term' = 'Exchange Market');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `exchange_market_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Market Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Service Area Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_federal_funded` SET TAGS ('dbx_business_glossary_term' = 'Federal Funding Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_medicaid_eligible` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_medicare_eligible` SET TAGS ('dbx_business_glossary_term' = 'Medicare Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_regulatory_compliant` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_state_funded` SET TAGS ('dbx_business_glossary_term' = 'State Funding Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Plan Category');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `plan_category` SET TAGS ('dbx_value_regex' = 'individual|group|government|exchange');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `regulatory_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_code` SET TAGS ('dbx_business_glossary_term' = 'CMS Service Area Identifier (CMS ID)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_name` SET TAGS ('dbx_business_glossary_term' = 'Service Area Name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_type` SET TAGS ('dbx_value_regex' = 'state|county|zip|region');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State (US State Code)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_excluded` SET TAGS ('dbx_business_glossary_term' = 'Excluded ZIP Codes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_excluded` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_included` SET TAGS ('dbx_business_glossary_term' = 'Included ZIP Codes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_included` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `rx_benefit_config_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Configuration ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Rate Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `cost_sharing_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Method');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `cost_sharing_method` SET TAGS ('dbx_value_regex' = 'copay|coinsurance|percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Per Prescription');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_year` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Per Year');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `deductible_applicable` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `drug_category_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Drug Category Exclusions');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `formulary_version` SET TAGS ('dbx_business_glossary_term' = 'Formulary Version');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `is_biologic_preferred` SET TAGS ('dbx_business_glossary_term' = 'Biologic Preferred Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `is_biosimilar_preferred` SET TAGS ('dbx_business_glossary_term' = 'Biosimilar Preferred Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `is_exempt_from_mlr` SET TAGS ('dbx_business_glossary_term' = 'Exempt from Medical Loss Ratio (MLR) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `is_specialty_drug_excluded` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Excluded Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `mail_order_network_type` SET TAGS ('dbx_business_glossary_term' = 'Mail‑Order Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `mail_order_network_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `max_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Coverage Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `ninety_day_supply_allowed` SET TAGS ('dbx_business_glossary_term' = '90‑Day Supply Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Pocket Maximum Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `pbm_vendor` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Vendor');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `prior_auth_exemption_drugs` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Exemption Drugs List');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `retail_network_type` SET TAGS ('dbx_business_glossary_term' = 'Retail Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `retail_network_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `rx_benefit_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `rx_benefit_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `specialty_pharmacy_network` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Network');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `therapeutic_class_limit` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class Limit');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_config_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Network Configuration Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `access_type` SET TAGS ('dbx_value_regex' = 'HMO_closed|PPO_open|EPO_exclusive|POS|HDHP');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_adequacy_measure` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Measure');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_adequacy_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Standard Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Network Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Network Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_coverage_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_designation` SET TAGS ('dbx_business_glossary_term' = 'Network Designation');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_designation` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|partial');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_exclusion_description` SET TAGS ('dbx_business_glossary_term' = 'Network Exclusion Description');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_geography_region` SET TAGS ('dbx_business_glossary_term' = 'Network Geography Region');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_state` SET TAGS ('dbx_business_glossary_term' = 'Network State');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Network ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Network Benefit Type');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_benefit_type` SET TAGS ('dbx_value_regex' = 'copay|coinsurance|none');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_coinsurance_pct` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Network Coinsurance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Network Copay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Network Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `tier_priority` SET TAGS ('dbx_business_glossary_term' = 'Tier Priority Order');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
