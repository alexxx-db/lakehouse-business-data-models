-- Schema for Domain: franchise | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-01 14:08:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`franchise` COMMENT 'SSOT for franchise partner identity, FDD agreements, territory management, royalty rate calculations, franchise fees, compliance tracking, NRO (New Restaurant Opening) pipeline, franchisee performance metrics, and development lifecycle via FranConnect. Ensures adherence to brand standards, IFA best practices, and FTC Franchise Rule.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` (
    `franchisee_id` BIGINT COMMENT 'System-generated unique identifier for the franchise partner.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Franchisee belongs to a geographic territory; linking franchisee to territory via territory_id enables proper reporting and eliminates reliance on free‑text codes.',
    `address_line1` STRING COMMENT 'First line of the franchisees primary business address.',
    `address_line2` STRING COMMENT 'Second line of the franchisees primary business address, if applicable.',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Reported annual gross revenue of the franchisee.',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Average sales volume per unit for the franchisee.',
    `city` STRING COMMENT 'City of the franchisees primary business address.',
    `compliance_status` STRING COMMENT 'Overall compliance status with brand standards and regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the franchisees primary business address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the franchisee record was first created in the system.',
    `credit_rating` STRING COMMENT 'Credit rating assigned to the franchisee by a rating agency. [ENUM-REF-CANDIDATE: aaa|aa|a|bbb|bb|b|ccc|cc|c|d — promote to reference product]',
    `dba_name` STRING COMMENT 'Trade name under which the franchisee operates, if different from the legal name.',
    `established_date` DATE COMMENT 'Date the franchisee entity was legally formed.',
    `fdd_disclosure_status` STRING COMMENT 'Status of the Franchise Disclosure Document compliance for the franchisee.. Valid values are `disclosed|pending|exempt`',
    `food_safety_certified` BOOLEAN COMMENT 'Indicates whether the franchisee holds a current food safety certification (e.g., ServSafe).',
    `franchise_fee_amount` DECIMAL(18,2) COMMENT 'Initial fee paid by the franchisee for the franchise rights.',
    `franchisee_number` STRING COMMENT 'Unique business identifier assigned to the franchisee for internal tracking.',
    `franchisee_status` STRING COMMENT 'Current lifecycle status of the franchisee partnership.. Valid values are `active|inactive|terminated|pending`',
    `franchisee_type` STRING COMMENT 'Legal structure of the franchisee entity.. Valid values are `individual|llc|corporation|partnership`',
    `ifa_membership_status` STRING COMMENT 'International Franchise Association membership status of the franchisee.. Valid values are `member|non_member|pending`',
    `industry_segment` STRING COMMENT 'Segment of the restaurant industry the franchisee operates in.. Valid values are `qsr|casual|fine_dining`',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the current insurance policy.',
    `insurance_policy_number` STRING COMMENT 'Policy number for the franchisees liability and property insurance.',
    `legal_name` STRING COMMENT 'Full legal name of the franchisee entity as registered with government authorities.',
    `next_renewal_date` DATE COMMENT 'Scheduled date for the next franchise agreement renewal.',
    `number_of_units` STRING COMMENT 'Total number of restaurant locations operated by the franchisee.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the franchisees primary business address.',
    `royalty_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of royalty fees calculated for a reporting period.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Percentage of gross sales payable to the brand as royalty.',
    `state_province` STRING COMMENT 'State or province of the franchisees primary business address.',
    `state_tax_number` DECIMAL(18,2) COMMENT 'State-level tax identification number for the franchisee.',
    `tax_id_ein` DECIMAL(18,2) COMMENT 'Federal tax identification number for the franchisee.',
    `termination_date` DATE COMMENT 'Date the franchise agreement was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the franchisee record.',
    CONSTRAINT pk_franchisee PRIMARY KEY(`franchisee_id`)
) COMMENT 'Master record for each franchise partner entity — the legal business entity (individual, LLC, corporation) that holds one or more franchise agreements with the brand. Captures franchisee identity, legal structure, ownership details, contact information, financial standing, FDD disclosure status, IFA membership, and FranConnect system ID. SSOT for franchise partner identity across the enterprise.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`agreement` (
    `agreement_id` BIGINT COMMENT 'System-generated unique identifier for the franchise agreement record.',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchisee party.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Franchise agreements in restaurant operations specify which loyalty program the franchisee must participate in, including POS integration requirements and royalty treatment of loyalty discounts. This ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: A franchise agreement is tied to a specific geographic territory; adding territory_id FK normalizes territory data and removes redundant code/description fields.',
    `agreement_number` STRING COMMENT 'External business identifier assigned to the agreement (e.g., FA-2023-001).',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `active|inactive|terminated|pending|draft`',
    `agreement_type` STRING COMMENT 'Classifies the agreement as initial, renewal, transfer, or amendment.. Valid values are `initial|renewal|transfer|amendment`',
    `amendment_effective_date` DATE COMMENT 'Date when the amendment becomes effective.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment applied to the agreement.',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Projected average sales per unit location for the franchisee.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance audit of the agreement.',
    `compliance_status` STRING COMMENT 'Result of the latest compliance review.. Valid values are `compliant|non_compliant|pending`',
    `contract_version` STRING COMMENT 'Version identifier for the agreement (e.g., v1, v2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Scheduled expiration date of the agreement (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the agreement becomes legally binding.',
    `ftc_compliance_attestation_flag` BOOLEAN COMMENT 'Attestation that the agreement complies with FTC Franchise Rule disclosures.',
    `initial_fee_amount` DECIMAL(18,2) COMMENT 'Up‑front fee paid by the franchisee to obtain the franchise rights.',
    `marketing_fee_percent` DECIMAL(18,2) COMMENT 'Percentage of sales contributed to the brand‑wide marketing fund.',
    `notes` STRING COMMENT 'Free‑form text for additional comments, special conditions, or observations.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Fee payable by the franchisee to renew the agreement for the next term.',
    `renewal_term_years` STRING COMMENT 'Number of years for each renewal period after the initial term.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Ongoing royalty percentage of gross sales payable to the franchisor.',
    `sales_target_amount` DECIMAL(18,2) COMMENT 'Target gross sales amount the franchisee commits to achieve during the term.',
    `signed_date` DATE COMMENT 'Date the agreement was signed by both parties.',
    `termination_date` DATE COMMENT 'Actual date the agreement was terminated prior to its scheduled end.',
    `transfer_rights_flag` BOOLEAN COMMENT 'Indicates whether the franchisee may transfer the agreement to another party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Authoritative record of each franchise agreement between the franchisor and a franchisee, encompassing the full agreement lifecycle from execution through renewal, transfer, or termination. Captures agreement type (initial, renewal, transfer, successor), effective and expiration dates, territory grant, initial franchise fee, royalty rate and basis, marketing fund contribution rate, renewal terms, and agreement status. Owns all lifecycle event records including: transfers (transferor/transferee, ROFR exercise, approval, transfer conditions, effective date), renewals (updated terms, FDD re-disclosure, renewal fee, execution date), and terminations (type, default notice, cure period, de-identification, post-termination obligations, non-compete). SSOT for all contractual franchise obligations and their complete lifecycle history. Supports FTC Franchise Rule Items 5, 6, 17 disclosure requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory.',
    `area_sq_miles` DECIMAL(18,2) COMMENT 'Total land area of the territory in square miles.',
    `assignment_status` STRING COMMENT 'Current status of the territory assignment process.. Valid values are `assigned|unassigned|pending`',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Average sales per unit (AUV) across locations in the territory (USD).',
    `city` STRING COMMENT 'Primary city associated with the territory.',
    `territory_code` STRING COMMENT 'Business identifier code assigned to the territory.',
    `compliance_status` STRING COMMENT 'Current food‑safety and regulatory compliance status of the territory.. Valid values are `compliant|non_compliant|under_review`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the territory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was created.',
    `territory_description` STRING COMMENT 'Free‑form description of the territorys characteristics.',
    `dma` STRING COMMENT 'DMA region identifier for the territory.',
    `effective_end_date` DATE COMMENT 'Date when the territory expires or is terminated (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the territory became effective for the franchisee.',
    `franchise_fee` DECIMAL(18,2) COMMENT 'One‑time fee charged to the franchisee for the territory grant.',
    `geometry_wkt` STRING COMMENT 'Well‑Known Text representation of the territorys polygon boundary.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection for the territory.',
    `median_income` DECIMAL(18,2) COMMENT 'Median household income for the territory (USD).',
    `territory_name` STRING COMMENT 'Human‑readable name of the territory.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the territory.',
    `number_of_locations` STRING COMMENT 'Count of restaurant units operating within the territory.',
    `population` STRING COMMENT 'Estimated resident population within the territory.',
    `radius_miles` DECIMAL(18,2) COMMENT 'Radius in miles for circular territories (if applicable).',
    `region` STRING COMMENT 'Two‑letter state or province code for the territory.. Valid values are `^[A-Z]{2}$`',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Royalty percentage applied to franchisee sales within the territory.',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory.. Valid values are `active|inactive|pending|closed`',
    `territory_type` STRING COMMENT 'Classification of the territorys exclusivity rights.. Valid values are `exclusive|protected|non_exclusive`',
    `trade_area_classification` STRING COMMENT 'Business classification of the trade area based on demographics and spend.. Valid values are `high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the territory record.',
    `zip_codes` STRING COMMENT 'List of ZIP codes included in the territory, separated by commas.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Defines the protected or exclusive geographic territory granted to a franchisee under a franchise agreement. Captures territory boundaries (polygon, zip codes, DMA, radius), territory type (exclusive, protected, non-exclusive), population count, trade area classification, territory status, and assignment history. Supports territory conflict resolution and development pipeline planning.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`billing` (
    `billing_id` BIGINT COMMENT 'Primary key for billing',
    `agreement_id` BIGINT COMMENT 'Connect franchise.billing by adding column agreement_id (BIGINT) with an FK to franchise.agreement.agreement_id because franchise billing must reference the governing agreement. P17: connect_table: franchise.billing** - add column agreement',
    `fee_schedule_id` DECIMAL(18,2) COMMENT 'Foreign key linking to franchise.fee_schedule. Business justification: Each billing record is generated according to a specific fee schedule that defines the applicable rates, fee types, and calculation methods. Linking billing to fee_schedule provides a direct audit tra',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchise billing records are generated per franchisee; linking to franchisee provides ownership and enables reporting.',
    `sales_report_id` BIGINT COMMENT 'Foreign key linking to franchise.sales_report. Business justification: Billing records for royalty and marketing fees are generated directly from franchisee-submitted sales reports — the gross_sales_amount on billing is derived from the corresponding sales report. Linkin',
    `amount_paid` DECIMAL(18,2) COMMENT 'The amount paid attribute storing relevant data for the billing in the franchise domain',
    `balance_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric balance value associated with this billing',
    `billing_date` DATE COMMENT 'The date and time when the billing event occurred for this billing',
    `billing_number` STRING COMMENT 'The billing number attribute storing relevant data for the billing in the franchise domain',
    `billing_status` STRING COMMENT 'The current status indicator for billing within the billing context',
    `billing_type` STRING COMMENT 'The classification type for billing within the billing context',
    `created_at` TIMESTAMP COMMENT 'The date and time when the created event occurred for this billing',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute storing relevant data for the billing in the franchise domain',
    `currency_code` STRING COMMENT 'The standardized code representing the currency classification for this billing',
    `due_date` DATE COMMENT 'The date and time when the due event occurred for this billing',
    `fee_amount` DECIMAL(18,2) COMMENT 'Calculated fee amount for this billing period',
    `fee_rate_pct` DECIMAL(18,2) COMMENT 'Fee rate percentage applied',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric gross sales value associated with this billing',
    `invoice_date` DATE COMMENT 'The date and time when the invoice event occurred for this billing',
    `invoice_number` STRING COMMENT 'The invoice number attribute storing relevant data for the billing in the franchise domain',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric late fee value associated with this billing',
    `marketing_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric marketing fee value associated with this billing',
    `notes` STRING COMMENT 'Free-form notes and additional comments related to this billing record',
    `paid_at` TIMESTAMP COMMENT 'The date and time when the paid event occurred for this billing',
    `paid_date` DATE COMMENT 'Date payment was received',
    `payment_date` DECIMAL(18,2) COMMENT 'The date and time when the payment event occurred for this billing',
    `payment_status` DECIMAL(18,2) COMMENT 'The current status indicator for payment within the billing context',
    `period` STRING COMMENT 'The period attribute storing relevant data for the billing in the franchise domain',
    `period_end` DATE COMMENT 'The period end attribute storing relevant data for the billing in the franchise domain',
    `period_start` DATE COMMENT 'The period start attribute storing relevant data for the billing in the franchise domain',
    `royalty_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric royalty value associated with this billing',
    `royalty_rate` DECIMAL(18,2) COMMENT 'The percentage or rate value for royalty in this billing',
    `technology_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric technology fee value associated with this billing',
    `total_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric total value associated with this billing',
    `total_amount_due` DECIMAL(18,2) COMMENT 'The total amount due attribute storing relevant data for the billing in the franchise domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute storing relevant data for the billing in the franchise domain',
    CONSTRAINT pk_billing PRIMARY KEY(`billing_id`)
) COMMENT 'Transactional record of all periodic franchise fees billed to a franchisee for a specific reporting period, including royalties, marketing fund contributions, technology fees, and other recurring charges. Captures billing period, gross sales reported, rates applied, line-item amounts (royalty, marketing fund, technology, other), total amount billed, payment due date, payment status, and variance from prior period. Source of truth for franchise revenue recognition, AR aging, and marketing fund governance. Supports FDD Item 6 and Item 11 disclosure compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` (
    `sales_report_id` BIGINT COMMENT 'System-generated unique identifier for the sales report record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: A sales report is submitted under a specific franchise agreement that governs the royalty rates, marketing fee percentages, and reporting obligations for that period. Linking sales_report directly to ',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchise partner submitting the report.',
    `performance_scorecard_id` BIGINT COMMENT 'Foreign key linking to franchise.performance_scorecard. Business justification: Performance scorecards aggregate KPIs (total_sales_amount, same_store_sales_growth_pct, royalty_payment_timeliness_pct) from individual sales reports submitted during the evaluation period. Linking ea',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location to which the sales data applies.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Identifies the employee submitting the sales report, providing audit trail, accountability, and performance monitoring for franchisee reporting.',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Sum of discounts, taxes, and other adjustments applied to gross sales.',
    `audit_trail` STRING COMMENT 'Chronological log of key actions performed on the report (e.g., submissions, approvals).',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average dollar amount per transaction for the reporting period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales report record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `daypart_sales_breakdown` STRING COMMENT 'JSON string summarizing sales by daypart (e.g., breakfast, lunch, dinner).',
    `franchise_fee` DECIMAL(18,2) COMMENT 'Fixed fee charged to the franchisee for brand usage during the period.',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total gross sales reported for the period before any deductions.',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Net sales after adjustments; basis for royalty calculations.',
    `notes` STRING COMMENT 'Free‑form comments entered by the franchisee or reviewer.',
    `report_number` STRING COMMENT 'External reference number assigned to the sales report by the franchisee.',
    `reporting_period_end` DATE COMMENT 'Last calendar date of the reporting period covered by the sales report.',
    `reporting_period_start` DATE COMMENT 'First calendar date of the reporting period covered by the sales report.',
    `reporting_period_type` STRING COMMENT 'Granularity of the reporting period (e.g., weekly, monthly).. Valid values are `weekly|monthly|quarterly|yearly`',
    `royalty_amount` DECIMAL(18,2) COMMENT 'Calculated royalty amount based on royalty_rate and net_sales_amount.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to net sales to calculate royalty owed.',
    `sales_report_status` STRING COMMENT 'Current lifecycle status of the sales report.. Valid values are `draft|submitted|validated|rejected`',
    `same_store_sales` DECIMAL(18,2) COMMENT 'Comparable sales metric for existing stores, used for performance benchmarking.',
    `submission_method` STRING COMMENT 'Channel used by the franchisee to submit the report.. Valid values are `portal|email|ftp|api`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the franchisee submitted the sales report.',
    `transaction_count` BIGINT COMMENT 'Total number of individual transactions (average transaction count) recorded in the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sales report record.',
    `validation_status` STRING COMMENT 'Result of the automated/manual validation process.. Valid values are `pending|passed|failed`',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the variance when variance_flag is true.',
    `variance_flag` BOOLEAN COMMENT 'Indicates whether reported figures deviate beyond predefined thresholds.',
    CONSTRAINT pk_sales_report PRIMARY KEY(`sales_report_id`)
) COMMENT 'Franchisee-submitted periodic gross sales report used as the basis for royalty and marketing fund calculation, SSS (Same-Store Sales) tracking, and operational benchmarking. Captures reporting period (weekly, monthly), reported gross sales by daypart, net sales, transaction count (ATC), average check value (ACV), submission date, submission method (POS auto-pull, manual entry, EDI), validation status, and variance flags. Supports royalty billing, comp sales analysis, franchisee performance benchmarking, and FDD Item 19 financial performance representation validation.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` (
    `compliance_audit_id` BIGINT COMMENT 'System‑generated unique identifier for each compliance audit record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: Compliance audits enforce brand standards as defined in the franchise agreement. Linking compliance_audit to the governing agreement allows auditors and analysts to verify which agreement versions st',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Compliance audits are conducted at a specific restaurant unit. Linking audit records to the audited unit enables corrective action tracking, re-audit scheduling, and brand standards enforcement report',
    `employee_id` BIGINT COMMENT 'Unique identifier of the internal or external auditor who performed the audit.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Compliance audits measure adherence to a specific brand standard version. Linking to brand_standard enables audit scores to be tied to the exact standard being evaluated, supporting version-controlled',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Franchise Food Safety Compliance Audit process: auditors review the active HACCP plan as a required component of brand-standards audits. Linking compliance_audit to haccp_plan_id identifies which plan',
    `health_inspection_id` BIGINT COMMENT 'Foreign key linking to foodsafety.health_inspection. Business justification: Franchise Compliance Monitoring process: franchisors correlate official regulatory health inspection results with internal brand-standard audits. Linking compliance_audit to health_inspection_id allow',
    `performance_scorecard_id` BIGINT COMMENT 'Foreign key linking to franchise.performance_scorecard. Business justification: Performance scorecards include compliance_audit_average_score, which is aggregated from individual compliance audits conducted during the evaluation period. Linking each compliance_audit to its govern',
    `primary_compliance_employee_id` BIGINT COMMENT 'Unique identifier of the internal or external auditor who performed the audit.',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchised restaurant unit subject to the audit.',
    `sanitation_schedule_id` BIGINT COMMENT 'Foreign key linking to foodsafety.sanitation_schedule. Business justification: Brand Standards Audit — Sanitation Review process: franchise compliance audits evaluate adherence to the units sanitation schedule as a scored dimension. Linking compliance_audit to sanitation_schedu',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Compliance audits are conducted at restaurant units located within specific franchise territories. Linking compliance_audit to territory enables geographic analysis of brand standards compliance, supp',
    `audit_disposition` STRING COMMENT 'Final outcome of the audit after any follow‑up actions.. Valid values are `pass|conditional_pass|fail`',
    `audit_notes` STRING COMMENT 'Free‑form comments and observations recorded by the auditor.',
    `audit_number` STRING COMMENT 'External audit reference number used in franchise compliance reporting.',
    `audit_source_system` STRING COMMENT 'Name of the source system that supplied the audit data (e.g., Zenput, FranConnect).',
    `audit_timestamp` TIMESTAMP COMMENT 'Date and time when the audit was performed on site.',
    `audit_type` STRING COMMENT 'Classification of the audit execution method.. Valid values are `scheduled|unannounced|follow_up`',
    `brand_standards_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Brand Standards section.',
    `cleanliness_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Cleanliness section.',
    `compliance_audit_status` STRING COMMENT 'Current processing state of the audit record.. Valid values are `pending|in_progress|completed|cancelled`',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether any corrective actions must be taken as a result of the audit.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the audit record was first created.',
    `critical_violations_count` STRING COMMENT 'Number of critical compliance violations identified during the audit.',
    `equipment_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Equipment section.',
    `food_safety_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Food Safety section.',
    `non_critical_violations_count` STRING COMMENT 'Number of non‑critical compliance violations identified during the audit.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated compliance percentage across all audit sections (0‑100).',
    `service_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Service section.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the audit record.',
    CONSTRAINT pk_compliance_audit PRIMARY KEY(`compliance_audit_id`)
) COMMENT 'Records the results of brand standards compliance audits conducted at franchised restaurant units. Captures audit date, audit type (scheduled, unannounced, follow-up), auditor identity, overall compliance score, section scores (food safety, cleanliness, service, brand standards, equipment), critical and non-critical violation counts, corrective action required flag, and audit disposition (pass, conditional pass, fail). Supports franchise agreement compliance enforcement and performance scorecard inputs.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` (
    `fee_schedule_id` DECIMAL(18,2) COMMENT 'Primary key for fee_schedule',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.franchise_agreement. Business justification: Fee schedule entries are defined by a specific franchise agreement; linking to agreement captures contractual context.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Fee schedule fees are charged to a particular franchisee; linking provides financial attribution.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Fee schedule rates vary by territory; linking to territory enables territorial reporting and compliance.',
    `billing_frequency` STRING COMMENT 'The billing frequency attribute storing relevant data for the fee schedule in the franchise domain',
    `calculation_basis` STRING COMMENT 'Basis for fee calculation (gross sales, net sales, per transaction)',
    `calculation_method` STRING COMMENT 'The calculation method attribute storing relevant data for the fee schedule in the franchise domain',
    `fee_schedule_code` DECIMAL(18,2) COMMENT 'The standardized code representing the fee schedule classification for this fee schedule',
    `created_at` TIMESTAMP COMMENT 'The date and time when the created event occurred for this fee schedule',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute storing relevant data for the fee schedule in the franchise domain',
    `currency_code` STRING COMMENT 'The standardized code representing the currency classification for this fee schedule',
    `fee_schedule_description` STRING COMMENT 'Detailed textual description of the fee schedule for this fee schedule record',
    `effective_date` DATE COMMENT 'The date and time when the effective event occurred for this fee schedule',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this fee schedule',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this fee schedule',
    `expiry_date` DATE COMMENT 'The date and time when the expiry event occurred for this fee schedule',
    `fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric fee value associated with this fee schedule',
    `fee_category` DECIMAL(18,2) COMMENT 'The fee category attribute storing relevant data for the fee schedule in the franchise domain',
    `fee_name` DECIMAL(18,2) COMMENT 'The display name or label for the fee associated with this fee schedule',
    `fee_percent` DECIMAL(18,2) COMMENT 'The percentage or rate value for fee in this fee schedule',
    `fee_rate_pct` DECIMAL(18,2) COMMENT 'The fee rate pct attribute storing relevant data for the fee schedule in the franchise domain',
    `fee_schedule_number` DECIMAL(18,2) COMMENT 'The fee schedule number attribute storing relevant data for the fee schedule in the franchise domain',
    `fee_schedule_status` DECIMAL(18,2) COMMENT 'The current status indicator for fee schedule within the fee schedule context',
    `fee_status` DECIMAL(18,2) COMMENT 'The current status indicator for fee within the fee schedule context',
    `fee_type` DECIMAL(18,2) COMMENT 'The classification type for fee within the fee schedule context',
    `flat_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount for flat fees',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric flat fee value associated with this fee schedule',
    `frequency` STRING COMMENT 'The frequency attribute storing relevant data for the fee schedule in the franchise domain',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active condition for this fee schedule',
    `marketing_fee_rate` DECIMAL(18,2) COMMENT 'The percentage or rate value for marketing fee in this fee schedule',
    `marketing_fee_rate_pct` DECIMAL(18,2) COMMENT 'The marketing fee rate pct attribute storing relevant data for the fee schedule in the franchise domain',
    `maximum_amount` DECIMAL(18,2) COMMENT 'Maximum fee cap amount',
    `maximum_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric maximum fee value associated with this fee schedule',
    `minimum_amount` DECIMAL(18,2) COMMENT 'Minimum fee amount regardless of calculation',
    `minimum_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric minimum fee value associated with this fee schedule',
    `fee_schedule_name` DECIMAL(18,2) COMMENT 'The display name or label for the fee schedule associated with this fee schedule',
    `notes` STRING COMMENT 'Free-form notes and additional comments related to this fee schedule record',
    `rate_pct` DECIMAL(18,2) COMMENT 'Percentage rate for percentage-based fees',
    `rate_percent` DECIMAL(18,2) COMMENT 'The percentage or rate value for rate in this fee schedule',
    `royalty_rate` DECIMAL(18,2) COMMENT 'The percentage or rate value for royalty in this fee schedule',
    `royalty_rate_pct` DECIMAL(18,2) COMMENT 'The royalty rate pct attribute storing relevant data for the fee schedule in the franchise domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute storing relevant data for the fee schedule in the franchise domain',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Records all one-time and recurring franchise fees charged to franchisees beyond royalties, including initial franchise fees, renewal fees, transfer fees, training fees, technology fees, and marketing fund contributions. Captures fee type, fee amount, billing trigger event, payment status, waiver or discount applied, and associated agreement. Complements royalty_invoice which handles periodic royalty billing specifically.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` (
    `performance_scorecard_id` BIGINT COMMENT 'System-generated unique identifier for each franchisee performance scorecard record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: Performance scorecards evaluate franchisee performance against the KPIs and targets defined in the franchise agreement (e.g., sales_target_amount, royalty_rate_percent, compliance_review_date). Linkin',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Franchise performance scorecards are conducted by a franchise business consultant or regional manager (employee). Linking the evaluating employee enables accountability reporting, evaluator workload t',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchisee to which this scorecard applies.',
    `health_inspection_id` BIGINT COMMENT 'Foreign key linking to foodsafety.health_inspection. Business justification: Franchise Performance Evaluation process: health inspection grades and scores are a standard scored dimension in franchisee performance scorecards. The existing plain attribute food_safety_score is a ',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Average weekly sales per restaurant unit for the franchisee, expressed in local currency.',
    `compliance_audit_average_score` DECIMAL(18,2) COMMENT 'Average score from all compliance audits performed during the period, on a 0‑100 scale.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the scorecard record was first created.',
    `customer_satisfaction_score` DECIMAL(18,2) COMMENT 'Average customer satisfaction rating collected from surveys, on a 0‑100 scale.',
    `evaluation_month` STRING COMMENT 'Numeric month (1‑12) of the evaluation period.',
    `evaluation_period_end` DATE COMMENT 'Last day of the evaluation period covered by the scorecard.',
    `evaluation_period_start` DATE COMMENT 'First day of the evaluation period covered by the scorecard.',
    `evaluation_status` STRING COMMENT 'Current processing status of the scorecard record.. Valid values are `pending|completed|reviewed`',
    `evaluation_type` STRING COMMENT 'Frequency classification of the scorecard (e.g., annual, quarterly, monthly).. Valid values are `annual|quarterly|monthly`',
    `evaluation_year` STRING COMMENT 'Calendar year in which the evaluation period falls.',
    `net_promoter_score` STRING COMMENT 'Net promoter score for the franchisee, ranging from -100 to 100.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the scorecard.',
    `number_of_restaurants` STRING COMMENT 'Count of active restaurant units owned or operated by the franchisee.',
    `overall_performance_tier` STRING COMMENT 'Tier classification of franchisee performance for the period.. Valid values are `platinum|gold|silver|at_risk`',
    `region_code` STRING COMMENT 'Three‑letter ISO code representing the primary geographic region of the franchisee.. Valid values are `[A-Z]{3}`',
    `royalty_payment_timeliness_pct` DECIMAL(18,2) COMMENT 'Percentage of royalty invoices paid on or before the due date during the period.',
    `same_store_sales_growth_pct` DECIMAL(18,2) COMMENT 'Year‑over‑year percentage change in same‑store sales for the franchisee portfolio.',
    `total_royalty_amount` DECIMAL(18,2) COMMENT 'Total royalty fees accrued for the franchisee during the period.',
    `total_sales_amount` DECIMAL(18,2) COMMENT 'Aggregate gross sales across all franchisee locations for the evaluation period.',
    `training_completion_rate_pct` DECIMAL(18,2) COMMENT 'Proportion of required franchisee staff training modules completed on schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the scorecard record.',
    CONSTRAINT pk_performance_scorecard PRIMARY KEY(`performance_scorecard_id`)
) COMMENT 'Periodic franchisee performance evaluation record aggregating key operational and financial KPIs for a franchisee across their restaurant portfolio. Captures evaluation period, AUV (Average Unit Volume), SSS (Same-Store Sales) growth, CSAT score, NPS, compliance audit average score, royalty payment timeliness, training completion rate, food safety score, and overall performance tier (platinum, gold, silver, at-risk). Supports franchisee recognition programs and remediation prioritization.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_sales_report_id` FOREIGN KEY (`sales_report_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`sales_report`(`sales_report_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_performance_scorecard_id` FOREIGN KEY (`performance_scorecard_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`performance_scorecard`(`performance_scorecard_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_performance_scorecard_id` FOREIGN KEY (`performance_scorecard_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`performance_scorecard`(`performance_scorecard_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ADD CONSTRAINT `fk_franchise_performance_scorecard_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ADD CONSTRAINT `fk_franchise_performance_scorecard_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`franchise` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`franchise` SET TAGS ('dbx_domain' = 'franchise');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Address Line 1)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Address Line 2)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue (Annual Revenue)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (City)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance Status)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (Country Code)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (Record Created Timestamp)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating (Credit Rating)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name (DBA Name)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date (Established Date)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `fdd_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'FDD Disclosure Status (FDD Disclosure Status)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `fdd_disclosure_status` SET TAGS ('dbx_value_regex' = 'disclosed|pending|exempt');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `food_safety_certified` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certified (Food Safety Certified)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchise_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Amount (Franchise Fee Amount)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_number` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Number (Franchisee Number)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_status` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Status (Franchisee Status)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_type` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Type (Franchisee Type)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_type` SET TAGS ('dbx_value_regex' = 'individual|llc|corporation|partnership');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `ifa_membership_status` SET TAGS ('dbx_business_glossary_term' = 'IFA Membership Status (IFA Membership Status)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `ifa_membership_status` SET TAGS ('dbx_value_regex' = 'member|non_member|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment (Industry Segment)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `industry_segment` SET TAGS ('dbx_value_regex' = 'qsr|casual|fine_dining');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date (Insurance Expiry Date)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number (Insurance Policy Number)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name (Legal Name)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date (Next Renewal Date)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Units (Number of Units)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (Postal Code)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `royalty_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Fee Amount (Royalty Fee Amount)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate (Royalty Rate)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province (State/Province)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_tax_number` SET TAGS ('dbx_business_glossary_term' = 'State Tax ID (State Tax ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Termination Date)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (Record Updated Timestamp)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending|draft');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|transfer|amendment');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `ftc_compliance_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Attestation Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `initial_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Franchise Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `marketing_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Contribution Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Years');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `sales_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `transfer_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Rights Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `area_sq_miles` SET TAGS ('dbx_business_glossary_term' = 'Territory Area (Square Miles)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|unassigned|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV) for Territory');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Territory City Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `city` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `dma` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `franchise_fee` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Amount for Territory');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Territory Geographic Boundary (WKT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `median_income` SET TAGS ('dbx_business_glossary_term' = 'Territory Median Household Income');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `median_income` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes on Territory');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `number_of_locations` SET TAGS ('dbx_business_glossary_term' = 'Number of Restaurant Locations in Territory');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `population` SET TAGS ('dbx_business_glossary_term' = 'Territory Population Count');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Territory Radius (Miles)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Territory State/Province Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage for Territory');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Lifecycle Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type (Exclusive/Protected/Non‑Exclusive)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'exclusive|protected|non_exclusive');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `trade_area_classification` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Classification');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `trade_area_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `zip_codes` SET TAGS ('dbx_business_glossary_term' = 'Territory ZIP Codes (Comma‑Separated)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `zip_codes` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` SET TAGS ('dbx_subdomain' = 'financial_performance');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `sales_report_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Report Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `fee_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Paid Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` SET TAGS ('dbx_subdomain' = 'financial_performance');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `sales_report_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Report ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (ACV)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `daypart_sales_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Daypart Sales Breakdown');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `franchise_fee` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Report Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|yearly');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `sales_report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `sales_report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|validated|rejected');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `same_store_sales` SET TAGS ('dbx_business_glossary_term' = 'Same‑Store Sales (SSS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'portal|email|ftp|api');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count (ATC)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` SET TAGS ('dbx_subdomain' = 'financial_performance');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier (FRANCHISE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `sanitation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_disposition` SET TAGS ('dbx_business_glossary_term' = 'Audit Disposition (DISPOSITION)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_disposition` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Audit Source System (SOURCE_SYS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Timestamp (AUDIT_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'scheduled|unannounced|follow_up');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `brand_standards_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Standards Section Score (BRAND_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `cleanliness_score` SET TAGS ('dbx_business_glossary_term' = 'Cleanliness Section Score (CLN_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Lifecycle Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag (CORR_ACT_REQ)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Violations Count (CRIT_VIOL_CNT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `equipment_score` SET TAGS ('dbx_business_glossary_term' = 'Equipment Section Score (EQP_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `food_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Section Score (FS_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `non_critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑Critical Violations Count (NONCRIT_VIOL_CNT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Score (OVERALL_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `service_score` SET TAGS ('dbx_business_glossary_term' = 'Service Section Score (SRV_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` SET TAGS ('dbx_subdomain' = 'partner_agreements');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `fee_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `flat_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `maximum_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `minimum_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` SET TAGS ('dbx_subdomain' = 'financial_performance');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `compliance_audit_average_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Average Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_month` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Month');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'pending|completed|reviewed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_year` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Year');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `net_promoter_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `number_of_restaurants` SET TAGS ('dbx_business_glossary_term' = 'Number of Restaurants');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `overall_performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Tier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `overall_performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|at_risk');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `royalty_payment_timeliness_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Timeliness Percentage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `same_store_sales_growth_pct` SET TAGS ('dbx_business_glossary_term' = 'Same‑Store Sales Growth Percentage (SSS Growth)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `total_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Royalty Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `total_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `training_completion_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
