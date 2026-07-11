-- Schema for Domain: franchise | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`franchise` COMMENT 'SSOT for franchise partner identity, FDD agreements, territory management, royalty rate calculations, franchise fees, compliance tracking, NRO (New Restaurant Opening) pipeline, franchisee performance metrics, and development lifecycle via FranConnect. Ensures adherence to brand standards, IFA best practices, and FTC Franchise Rule.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` (
    `franchisee_id` BIGINT COMMENT 'System-generated unique identifier for the franchise partner.',
    `area_representative_id` BIGINT COMMENT 'Foreign key linking to franchise.area_representative. Business justification: A franchisee is managed by a single Area Representative; linking franchisee to area_representative enables reporting of franchisee assignments and eliminates need for separate mapping tables.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Royalty payment processing requires linking each franchisee to its bank account for ACH transfers; experts expect a direct bank_account_id FK.',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_center. Business justification: Assigning each franchisee to a primary distribution center supports logistics planning and delivery scheduling reports.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Enables franchisee to assign a specific loyalty program for its restaurants, required for franchise‑level program performance reporting.',
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
    `state_tax_number` STRING COMMENT 'State-level tax identification number for the franchisee.',
    `tax_id_ein` STRING COMMENT 'Federal tax identification number for the franchisee.',
    `termination_date` DATE COMMENT 'Date the franchise agreement was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the franchisee record.',
    CONSTRAINT pk_franchisee PRIMARY KEY(`franchisee_id`)
) COMMENT 'Master record for each franchise partner entity — the legal business entity (individual, LLC, corporation) that holds one or more franchise agreements with the brand. Captures franchisee identity, legal structure, ownership details, contact information, financial standing, FDD disclosure status, IFA membership, and FranConnect system ID. SSOT for franchise partner identity across the enterprise.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`agreement` (
    `agreement_id` BIGINT COMMENT 'System-generated unique identifier for the franchise agreement record.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier of the franchisor (company) party.',
    `agreement_legal_entity_id` BIGINT COMMENT 'Unique identifier of the franchisor (company) party.',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchisee party.',
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
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_center. Business justification: Territory‑level supply routing uses a designated DC; needed for regional supply‑chain optimization and KPI dashboards.',
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
    `agreement_id` BIGINT COMMENT 'add column agreement_id (BIGINT) with FK to franchise.agreement.agreement_id - franchise billing must reference the governing agreement for fee calculation',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchise billing records are generated per franchisee; linking to franchisee provides ownership and enables reporting.',
    CONSTRAINT pk_billing PRIMARY KEY(`billing_id`)
) COMMENT 'Transactional record of all periodic franchise fees billed to a franchisee for a specific reporting period, including royalties, marketing fund contributions, technology fees, and other recurring charges. Captures billing period, gross sales reported, rates applied, line-item amounts (royalty, marketing fund, technology, other), total amount billed, payment due date, payment status, and variance from prior period. Source of truth for franchise revenue recognition, AR aging, and marketing fund governance. Supports FDD Item 6 and Item 11 disclosure compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` (
    `sales_report_id` BIGINT COMMENT 'System-generated unique identifier for the sales report record.',
    `financial_period_id` BIGINT COMMENT 'add column financial_period_id (BIGINT) with FK to finance.financial_period.financial_period_id - franchise sales reports need period context for royalty calculations',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchise partner submitting the report.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location to which the sales data applies.',
    `sales_unit_id` BIGINT COMMENT 'Identifier of the restaurant location to which the sales data applies.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` (
    `nro_pipeline_id` BIGINT COMMENT 'System-generated unique identifier for each NRO pipeline record.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee responsible for the new restaurant.',
    `employee_id` BIGINT COMMENT 'Identifier of the development consultant assigned to the project.',
    `nro_employee_id` BIGINT COMMENT 'Identifier of the development consultant assigned to the project.',
    `actual_capex_spent` DECIMAL(18,2) COMMENT 'Cumulative capital expenditures incurred to date.',
    `actual_open_date` DATE COMMENT 'Date the restaurant actually opened for business.',
    `actual_opex_spent` DECIMAL(18,2) COMMENT 'Cumulative operating expenses incurred to date.',
    `brand` STRING COMMENT 'Brand classification of the restaurant (e.g., Quick-Service, Casual, Fine Dining).. Valid values are `QSR|Casual|Fine_Dining`',
    `budget_capex` DECIMAL(18,2) COMMENT 'Approved capital expenditure budget for the project.',
    `budget_opex` DECIMAL(18,2) COMMENT 'Approved operating expense budget for the pre‑opening period.',
    `capital_investment_estimate` DECIMAL(18,2) COMMENT 'Projected capital expenditure required to open the restaurant, in USD.',
    `compliance_status` STRING COMMENT 'Current status of regulatory and brand compliance for the project.. Valid values are `compliant|non_compliant|pending`',
    `construction_complete_flag` BOOLEAN COMMENT 'True when construction is finished.',
    `construction_start_flag` BOOLEAN COMMENT 'True when construction work has commenced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the NRO pipeline record was first created.',
    `development_type` STRING COMMENT 'Category of the restaurant development: new build, conversion of existing location, or remodel.. Valid values are `new_build|conversion|remodel`',
    `effective_from` DATE COMMENT 'Date the NRO agreement becomes effective (typically the target open date).',
    `effective_until` DATE COMMENT 'Date the NRO agreement ends or is superseded; null if open‑ended.',
    `expected_acuv` DECIMAL(18,2) COMMENT 'Forecasted average transaction value (USD) for the new restaurant.',
    `expected_cogs_percent` DECIMAL(18,2) COMMENT 'Projected Cost of Goods Sold as a percentage of sales.',
    `expected_labor_percent` DECIMAL(18,2) COMMENT 'Projected labor cost as a percentage of sales.',
    `expected_roi` DECIMAL(18,2) COMMENT 'Forecasted ROI for the new restaurant over a 12‑month horizon.',
    `expected_traffic_volume` STRING COMMENT 'Projected daily customer count for the first 30 days after opening.',
    `health_inspection_score` STRING COMMENT 'Score from the most recent health inspection (0‑100).',
    `last_milestone_date` DATE COMMENT 'Date when the most recent project milestone was achieved.',
    `last_milestone_name` STRING COMMENT 'Name of the most recent milestone (e.g., "Construction Complete").',
    `notes` STRING COMMENT 'Free‑form notes or comments about the project.',
    `opening_announced_flag` BOOLEAN COMMENT 'True when the grand opening has been publicly announced.',
    `permits_obtained_flag` BOOLEAN COMMENT 'Indicates whether all required permits have been secured.',
    `project_code` STRING COMMENT 'External business identifier for the NRO project, used in reporting and contracts.. Valid values are `^NRO-[A-Z0-9]{6}$`',
    `project_name` STRING COMMENT 'Descriptive name of the NRO development project.',
    `project_status` STRING COMMENT 'Overall status of the NRO project.. Valid values are `active|on_hold|cancelled|completed`',
    `risk_level` STRING COMMENT 'Assessed risk category for the project.. Valid values are `low|medium|high`',
    `stage` STRING COMMENT 'Current lifecycle stage of the NRO project. [ENUM-REF-CANDIDATE: site_identified|loi_signed|lease_executed|permits_obtained|construction_started|construction_complete|training_complete|opened|closed — 9 candidates stripped; promote to reference product]',
    `stage_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the project moved into the current stage.',
    `target_open_date` DATE COMMENT 'Planned date for the restaurant to begin operations.',
    `territory_code` STRING COMMENT 'Geographic territory code where the new restaurant will be located.',
    `training_complete_flag` BOOLEAN COMMENT 'True when staff training is completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the NRO pipeline record.',
    CONSTRAINT pk_nro_pipeline PRIMARY KEY(`nro_pipeline_id`)
) COMMENT 'Tracks all franchise capital construction and development projects from initiation through completion, including New Restaurant Openings (NROs), remodels, reimaging, refreshes, and conversions. Captures project type (new build, conversion, full remodel, refresh, reimaging, ADA compliance), project stage (site identified, LOI signed, lease executed, permits obtained, construction started, construction complete, training complete, opened/completed), target and actual completion dates, development type, assigned development consultant, capital investment estimate, approved contractor, permit and inspection status, brand approval status, contractual obligation source, and milestone completion dates. SSOT for the franchise development and facility lifecycle in FranConnect.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` (
    `development_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the franchise development schedule.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee to whom the development schedule is assigned.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - development schedules should link to the unit being developed once assigned',
    `territory_id` BIGINT COMMENT 'Geographic territory identifier governing the development schedule.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the franchisee against the development schedule.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the development schedule record was first created in the system.',
    `cure_period_months` STRING COMMENT 'Number of months granted to the franchisee to cure a schedule breach before penalties apply.',
    `development_phase` STRING COMMENT 'Current phase of the development schedule lifecycle.. Valid values are `planning|execution|monitoring|closed`',
    `development_schedule_status` STRING COMMENT 'Current lifecycle state of the schedule (active, inactive, suspended, completed, default).. Valid values are `active|inactive|suspended|completed|default`',
    `end_date` DATE COMMENT 'Date when the development schedule expires if the required units are not opened.',
    `last_compliance_check` DATE COMMENT 'Date of the most recent compliance review for the development schedule.',
    `notes` STRING COMMENT 'Free-text field for additional comments, exceptions, or special conditions related to the schedule.',
    `schedule_number` STRING COMMENT 'External reference number assigned to the development schedule, used in franchise contracts and reporting.',
    `schedule_type` STRING COMMENT 'Category of the development agreement (e.g., Multi-Unit Development Agreement, single-unit, renewal).. Valid values are `MUDA|single_unit|renewal`',
    `schedule_version` STRING COMMENT 'Version number of the schedule record to track revisions.',
    `start_date` DATE COMMENT 'Date when the development schedule becomes effective and the franchisee may begin opening units.',
    `target_units_year_1` STRING COMMENT 'Number of units the franchisee must open in the first calendar year of the schedule.',
    `target_units_year_2` STRING COMMENT 'Number of units the franchisee must open in the second calendar year of the schedule.',
    `target_units_year_3` STRING COMMENT 'Number of units the franchisee must open in the third calendar year of the schedule.',
    `total_units_committed` STRING COMMENT 'Total number of restaurant units the franchisee has agreed to open under the schedule.',
    `units_opened_to_date` STRING COMMENT 'Cumulative count of units the franchisee has opened to date under this schedule.',
    `units_remaining` STRING COMMENT 'Number of units still required to meet the schedule commitment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the development schedule record.',
    CONSTRAINT pk_development_schedule PRIMARY KEY(`development_schedule_id`)
) COMMENT 'Contractual development schedule committing a franchisee to open a specified number of restaurants within defined time windows under a multi-unit development agreement (MUDA). Captures total units committed, units opened to date, units remaining, development period start and end dates, annual opening targets by year, cure period terms, and schedule compliance status. Supports franchise development pipeline forecasting and default tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` (
    `compliance_audit_id` BIGINT COMMENT 'System‑generated unique identifier for each compliance audit record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the internal or external auditor who performed the audit.',
    `compliance_employee_id` BIGINT COMMENT 'Unique identifier of the internal or external auditor who performed the audit.',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchised restaurant unit subject to the audit.',
    `compliance_franchisee_id` BIGINT COMMENT 'Unique identifier of the franchised restaurant unit subject to the audit.',
    `audit_disposition` STRING COMMENT 'Final outcome of the audit after any follow‑up actions.. Valid values are `pass|conditional_pass|fail`',
    `audit_location_code` STRING COMMENT 'Identifier of the restaurant location where the audit was performed.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` (
    `franchise_corrective_action_id` BIGINT COMMENT 'Unique identifier for the franchise_corrective_action data product (auto-inserted pre-linking).',
    `compliance_audit_id` BIGINT COMMENT 'add column compliance_audit_id (BIGINT) with FK to franchise.compliance_audit.compliance_audit_id - corrective actions should trace back to the audit that identified the issue',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Corrective actions issued to a franchisee need to be tied to that franchisee for tracking and compliance.',
    CONSTRAINT pk_franchise_corrective_action PRIMARY KEY(`franchise_corrective_action_id`)
) COMMENT 'Tracks corrective action plans (CAPs) issued to franchisees following compliance audit failures, brand standards violations, or contractual defaults. Captures violation description, severity level, corrective action required, due date, responsible party, resolution status, follow-up audit date, escalation level, and cure period expiration. Supports IFA best practices for franchisee remediation and FTC Franchise Rule default notice requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` (
    `fee_schedule_id` BIGINT COMMENT 'Primary key for fee_schedule',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.franchise_agreement. Business justification: Fee schedule entries are defined by a specific franchise agreement; linking to agreement captures contractual context.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Fee schedule fees are charged to a particular franchisee; linking provides financial attribution.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Fee schedule rates vary by territory; linking to territory enables territorial reporting and compliance.',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Records all one-time and recurring franchise fees charged to franchisees beyond royalties, including initial franchise fees, renewal fees, transfer fees, training fees, technology fees, and marketing fund contributions. Captures fee type, fee amount, billing trigger event, payment status, waiver or discount applied, and associated agreement. Complements royalty_invoice which handles periodic royalty billing specifically.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for the training enrollment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the franchisee or manager who is enrolled in the training.',
    `training_employee_id` BIGINT COMMENT 'Identifier of the franchisee or manager who is enrolled in the training.',
    `training_trainer_employee_id` BIGINT COMMENT 'Identifier of the trainer or instructor responsible for the training.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant or site where the training took place (if in‑restaurant).',
    `actual_completion_date` DATE COMMENT 'Actual date when the trainee completed the training.',
    `certification_expiration_date` DATE COMMENT 'Expiration date of the issued certification, if applicable.',
    `certification_issued` BOOLEAN COMMENT 'Indicates whether a certification was issued upon successful completion.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the enrollment satisfies regulatory compliance requirements (e.g., ServSafe).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was created in the system.',
    `effective_until` DATE COMMENT 'Date when the enrollment agreement ends (typically the scheduled completion date or certification expiration).',
    `enrollment_date` TIMESTAMP COMMENT 'Date and time when the trainee was enrolled in the training program.',
    `enrollment_number` STRING COMMENT 'Unique enrollment reference number assigned by the system.',
    `hours_completed` DECIMAL(18,2) COMMENT 'Number of training hours the trainee has completed.',
    `hours_required` DECIMAL(18,2) COMMENT 'Total number of training hours required for completion.',
    `notes` STRING COMMENT 'Free‑text notes regarding the enrollment, special accommodations, or observations.',
    `pass_fail_status` STRING COMMENT 'Result of the training assessment.. Valid values are `pass|fail|not_applicable`',
    `scheduled_completion_date` DATE COMMENT 'Planned date by which the trainee should complete the training.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved in the training assessment (0‑100).',
    `training_enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `enrolled|completed|failed|cancelled|in-progress`',
    `training_type` STRING COMMENT 'Mode of delivery for the training.. Valid values are `classroom|online|in-restaurant`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Tracks franchisee and designated manager enrollment and completion of required brand training programs (initial training, refresher, new product, food safety certification). Captures trainee identity, training program name, training type (classroom, online, in-restaurant), enrollment date, scheduled completion date, actual completion date, pass/fail status, certification issued, and expiration date. Supports compliance tracking for brand standards and ServSafe/NRA certification requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` (
    `franchise_remodel_project_id` BIGINT COMMENT 'Unique identifier for the franchise_remodel_project data product (auto-inserted pre-linking).',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Remodel projects are owned by a franchisee; linking provides ownership and financial responsibility.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - remodel projects must specify which unit is being remodeled',
    CONSTRAINT pk_franchise_remodel_project PRIMARY KEY(`franchise_remodel_project_id`)
) COMMENT 'Tracks mandatory and voluntary restaurant remodel and reimaging projects for franchised units. Captures remodel type (full remodel, refresh, reimaging, ADA compliance), contractual obligation source (franchise agreement, remodel rider), required completion date, actual completion date, estimated CapEx, approved contractor, permit status, inspection status, and brand approval status. Supports facility lifecycle management and franchise agreement compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` (
    `transfer_event_id` BIGINT COMMENT 'System-generated unique identifier for the transfer event record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the underlying franchise agreement being transferred.',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchisee transferring ownership.',
    `employee_id` BIGINT COMMENT 'System identifier of the user who approved the transfer.',
    `transfer_employee_id` BIGINT COMMENT 'System identifier of the user who approved the transfer.',
    `compliance_review_date` DATE COMMENT 'Date when the transfer compliance review was performed.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the transfer with FTC and franchise regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer event record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|AUD|JPY|CHF|CNY|MXN|BRL — promote to reference product]',
    `effective_transfer_date` DATE COMMENT 'Date the ownership transfer becomes legally effective.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer event was recorded in the system.',
    `fdd_redisclosure_date` DATE COMMENT 'Date the Franchise Disclosure Document was re‑disclosed to the transferee as required by FTC.',
    `franchisor_approval_date` DATE COMMENT 'Date the franchisor approved the transfer request.',
    `marketing_fee_percent` DECIMAL(18,2) COMMENT 'Post‑transfer marketing fee percentage payable by the new franchisee.',
    `new_territory_code` STRING COMMENT 'Code representing the geographic territory assigned to the transferee after the transfer.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations about the transfer.',
    `previous_territory_code` STRING COMMENT 'Code of the territory previously held by the transferor.',
    `right_of_first_refusal_exercised_flag` BOOLEAN COMMENT 'Indicates whether the franchisor or existing franchisee exercised a right of first refusal.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Post‑transfer royalty percentage the new franchisee must pay to the franchisor.',
    `total_transfer_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary amount of the transfer (fee plus tax).',
    `transfer_conditions` STRING COMMENT 'Free‑text description of any special conditions, covenants, or contingencies attached to the transfer.',
    `transfer_event_status` STRING COMMENT 'Current processing state of the transfer event.. Valid values are `pending|approved|rejected|completed|cancelled`',
    `transfer_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged for the franchise transfer, before tax.',
    `transfer_fee_due_date` DATE COMMENT 'Date by which the transfer fee must be paid.',
    `transfer_fee_paid_flag` BOOLEAN COMMENT 'Indicates whether the transfer fee has been fully paid.',
    `transfer_fee_tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the transfer fee.',
    `transfer_number` STRING COMMENT 'External reference number assigned to the transfer event for tracking and audit purposes.',
    `transfer_reason` STRING COMMENT 'Business reason prompting the franchise transfer.. Valid values are `retirement|sale|bankruptcy|strategic|other`',
    `transfer_type` STRING COMMENT 'Category of the franchise transfer (e.g., sale, inheritance, estate, corporate acquisition, internal reassignment).. Valid values are `sale|inheritance|estate|corporate_acquisition|internal_reassignment`',
    `units_transferred` STRING COMMENT 'Count of restaurant units (stores) included in the transfer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the transfer event record.',
    CONSTRAINT pk_transfer_event PRIMARY KEY(`transfer_event_id`)
) COMMENT 'Records the transfer of a franchise agreement or restaurant unit from one franchisee to another, including ownership changes, estate transfers, and corporate acquisitions. Captures transfer type, transferor franchisee, transferee franchisee, units transferred, transfer fee paid, FDD re-disclosure date, franchisor approval date, effective transfer date, right of first refusal exercise status, and transfer conditions. Supports FTC Franchise Rule transfer disclosure requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` (
    `renewal_event_id` BIGINT COMMENT 'System-generated unique identifier for the renewal event.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee party involved in the renewal.',
    `agreement_id` BIGINT COMMENT 'Identifier of the franchise agreement that is being renewed.',
    `compliance_review_flag` BOOLEAN COMMENT 'Indicates whether the renewal has passed internal compliance review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the renewal event record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the renewed franchise agreement becomes effective.',
    `effective_until` DATE COMMENT 'Date when the renewed franchise agreement expires (nullable for open‑ended).',
    `fdd_redisclosure_timestamp` TIMESTAMP COMMENT 'Date‑time when the Franchise Disclosure Document was re‑disclosed to the franchisee.',
    `franchisor_approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the franchisor approved the renewal.',
    `ftc_compliance_attestation_flag` BOOLEAN COMMENT 'Indicates franchisor’s attestation that the renewal complies with FTC franchise rule.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the renewal.',
    `renewal_application_timestamp` TIMESTAMP COMMENT 'Date‑time when the franchise submitted the renewal application.',
    `renewal_event_status` STRING COMMENT 'Current lifecycle status of the renewal event.. Valid values are `pending|approved|rejected|completed|cancelled`',
    `renewal_execution_timestamp` TIMESTAMP COMMENT 'Date‑time when the renewal agreement was executed and signed.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged for the franchise renewal.',
    `renewal_fee_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the renewal fee.. Valid values are `[A-Z]{3}`',
    `renewal_fee_paid_flag` BOOLEAN COMMENT 'True if the renewal fee has been received.',
    `renewal_fee_payment_date` DATE COMMENT 'Date on which the renewal fee payment was recorded.',
    `renewal_number` STRING COMMENT 'Unique human‑readable code assigned to the renewal event.. Valid values are `RN-[0-9]{8}`',
    `renewal_term_years` STRING COMMENT 'Number of years for the renewed franchise term.',
    `updated_royalty_rate_percent` DECIMAL(18,2) COMMENT 'New royalty rate percentage applied after renewal.',
    `updated_territory_code` STRING COMMENT 'Code representing the revised franchise territory after renewal.. Valid values are `[A-Z0-9]{3,10}`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the renewal event record.',
    CONSTRAINT pk_renewal_event PRIMARY KEY(`renewal_event_id`)
) COMMENT 'Records franchise agreement renewal transactions including renewal application, FDD re-disclosure, updated terms negotiation, renewal fee payment, and executed renewal agreement. Captures original agreement reference, renewal term length, renewal fee, updated royalty rate, updated territory terms, renewal application date, FDD re-disclosure date, franchisor approval date, and renewal execution date. Supports franchise lifecycle management and revenue forecasting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` (
    `termination_event_id` BIGINT COMMENT 'System-generated unique identifier for the termination event record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the franchise agreement that is being terminated.',
    `compliance_review_date` DATE COMMENT 'Date when compliance review of the termination was performed.',
    `compliance_status` STRING COMMENT 'Result of the compliance review.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the termination event record was created.',
    `cure_period_end_date` DATE COMMENT 'Date when the cure period expires, after which termination becomes effective if not remedied.',
    `effective_termination_date` DATE COMMENT 'Date the termination legally takes effect.',
    `ftc_compliance_attestation_flag` BOOLEAN COMMENT 'Flag indicating franchisee attested to FTC compliance for termination disclosure.',
    `legal_dispute_flag` BOOLEAN COMMENT 'Indicates whether a legal dispute is associated with the termination.',
    `notes` STRING COMMENT 'Additional free-form notes related to the termination event.',
    `notice_date` DATE COMMENT 'Date the termination notice was delivered to the franchisee.',
    `outstanding_royalty_balance` DECIMAL(18,2) COMMENT 'Total royalty amount owed at termination.',
    `outstanding_royalty_currency_code` STRING COMMENT 'Three-letter ISO currency code for the outstanding royalty balance.. Valid values are `[A-Z]{3}`',
    `post_termination_obligation` STRING COMMENT 'Obligation required after termination, such as data de-identification or non-compete.. Valid values are `de_identification|non_compete|none`',
    `termination_cure_period_days` STRING COMMENT 'Number of days allocated for the franchisee to cure any default before termination.',
    `termination_event_status` STRING COMMENT 'Current processing status of the termination event.. Valid values are `pending|approved|executed|closed|rejected`',
    `termination_fee_amount` DECIMAL(18,2) COMMENT 'Any fee charged to the franchisee as part of the termination.',
    `termination_fee_currency_code` STRING COMMENT 'ISO currency code for the termination fee.. Valid values are `[A-Z]{3}`',
    `termination_notice_method` STRING COMMENT 'Method used to deliver the termination notice.. Valid values are `email|postal|fax|in_person`',
    `termination_reason` STRING COMMENT 'Free-text reason provided for the termination.',
    `termination_type` STRING COMMENT 'Category of termination: voluntary, default, non-renewal, or abandonment.. Valid values are `voluntary|default|non_renewal|abandonment`',
    `units_affected` STRING COMMENT 'Number of restaurant units impacted by the termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the termination event record.',
    CONSTRAINT pk_termination_event PRIMARY KEY(`termination_event_id`)
) COMMENT 'Records franchise agreement termination and non-renewal events including voluntary terminations, defaults, and forced closures. Captures termination type (voluntary, default, non-renewal, abandonment), notice date, cure period expiration, effective termination date, units affected, outstanding royalty balance, post-termination obligations (de-identification, non-compete), and legal dispute flag. Supports FTC Franchise Rule Item 17 disclosure and franchise portfolio management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` (
    `performance_scorecard_id` BIGINT COMMENT 'System-generated unique identifier for each franchisee performance scorecard record.',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchisee to which this scorecard applies.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - performance scorecards should be traceable to specific units, not just franchisees',
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
    `food_safety_score` DECIMAL(18,2) COMMENT 'Composite score from food safety inspections and audits, on a 0‑100 scale.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` (
    `fdd_disclosure_id` BIGINT COMMENT 'System-generated unique identifier for each FDD disclosure record.',
    `prospect_id` BIGINT COMMENT 'Foreign‑key reference to the franchisee or prospect receiving the disclosure.',
    `fdd_recipient_prospect_id` BIGINT COMMENT 'Foreign‑key reference to the franchisee or prospect receiving the disclosure.',
    `acknowledgment_received_date` DATE COMMENT 'Date the recipient signed or otherwise confirmed receipt of the disclosure.',
    `compliance_review_date` DATE COMMENT 'Calendar date the compliance team completed its review.',
    `compliance_review_status` STRING COMMENT 'Indicates whether the disclosure has passed FTC Franchise Rule compliance review.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the disclosure record was entered into the system.',
    `delivery_date` DATE COMMENT 'The calendar date the FDD was provided to the prospect or franchisee.',
    `document_title` STRING COMMENT 'Descriptive title of the FDD document (e.g., "2023 Franchise Disclosure Document").',
    `document_type` STRING COMMENT 'Classifies the document as an initial disclosure, an amendment, or a supplemental update.. Valid values are `initial|amendment|supplement`',
    `expiration_date` DATE COMMENT 'The date on which the disclosed version expires and must be superseded.',
    `fdd_disclosure_status` STRING COMMENT 'Indicates whether the disclosure is in draft, has been issued to a recipient, archived, or revoked.. Valid values are `draft|issued|archived|revoked`',
    `fdd_document_url` STRING COMMENT 'Secure URL or path where the electronic copy of the disclosure is stored.',
    `fdd_version_number` STRING COMMENT 'Internal version code (e.g., "2023‑01") assigned to the disclosure document.',
    `material_change_description` STRING COMMENT 'Narrative explaining the nature of any material change flagged.',
    `material_change_flag` BOOLEAN COMMENT 'True if the disclosed document contains material changes that could affect the prospects decision.',
    `notes` STRING COMMENT 'Additional comments or observations related to the disclosure.',
    `recipient_type` STRING COMMENT 'Identifies whether the recipient is a new prospect, an existing franchisee, or a prospective franchisee.. Valid values are `prospect|existing_franchisee|prospective_franchisee`',
    `state_code` STRING COMMENT 'ISO‑3166‑2 style two‑letter code of the US state for registration status.. Valid values are `^[A-Z]{2}$`',
    `state_registration_status` STRING COMMENT 'Indicates whether the disclosure has been registered with the state regulatory authority.. Valid values are `registered|not_registered|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the disclosure record.',
    `version_year` STRING COMMENT 'Calendar year associated with the specific version of the FDD.',
    `waiting_period_end_date` DATE COMMENT 'Date when the 14‑day waiting period ends, after which the prospect may sign agreements.',
    `waiting_period_start_date` DATE COMMENT 'Date when the 14‑day waiting period begins after delivery of the disclosure.',
    CONSTRAINT pk_fdd_disclosure PRIMARY KEY(`fdd_disclosure_id`)
) COMMENT 'Tracks each Franchise Disclosure Document (FDD) version issued to prospective and existing franchisees in compliance with FTC Franchise Rule. Captures FDD version year, state-specific registration status (for registration states), disclosure delivery date, recipient franchisee or prospect, 14-day waiting period start and end dates, acknowledgment receipt date, and material change flags. SSOT for FTC Franchise Rule pre-sale disclosure compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`prospect` (
    `prospect_id` BIGINT COMMENT 'System-generated unique identifier for the franchise development prospect.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal development consultant responsible for the prospect.',
    `prospect_employee_id` BIGINT COMMENT 'Identifier of the internal development consultant responsible for the prospect.',
    `address_line1` STRING COMMENT 'First line of the prospects mailing address.',
    `address_line2` STRING COMMENT 'Second line of the prospects mailing address, if applicable.',
    `application_status` STRING COMMENT 'Current status of the franchise application.. Valid values are `not_submitted|submitted|under_review|approved|rejected`',
    `application_submitted_date` DATE COMMENT 'Date the prospect submitted the franchise application.',
    `background_check_date` DATE COMMENT 'Date when the background check was completed.',
    `background_check_status` STRING COMMENT 'Result of the prospects background screening.. Valid values are `pending|cleared|failed`',
    `city` STRING COMMENT 'City component of the prospects mailing address.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the prospect has attested to required FTC and IFA compliance statements.',
    `contact_email` STRING COMMENT 'Primary email address used for prospect communications.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the prospect.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the prospects address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prospect record was first created.',
    `discovery_day_attended` BOOLEAN COMMENT 'Indicates whether the prospect attended a Discovery Day session.',
    `discovery_day_date` DATE COMMENT 'Date of the Discovery Day attended by the prospect.',
    `estimated_initial_investment` DECIMAL(18,2) COMMENT 'Prospects estimated total investment required to launch the franchise.',
    `estimated_initial_investment_currency` STRING COMMENT 'Currency code for the estimated initial investment.',
    `expected_open_date` DATE COMMENT 'Projected date for the new restaurant to open if the prospect is approved.',
    `fdd_disclosure_date` DATE COMMENT 'Date the Franchise Disclosure Document was provided to the prospect.',
    `fdd_sent_flag` BOOLEAN COMMENT 'Indicates whether the FDD has been sent to the prospect.',
    `franchise_type_preference` STRING COMMENT 'Preferred restaurant format (e.g., Quick‑Service, Casual, Fine‑Dining).. Valid values are `QSR|Casual|Fine_Dining`',
    `last_contact_date` DATE COMMENT 'Date of the most recent interaction with the prospect.',
    `last_contact_method` STRING COMMENT 'Channel used for the most recent contact with the prospect.. Valid values are `email|phone|in_person|online`',
    `legal_entity_type` STRING COMMENT 'Indicates whether the prospect is an individual or a corporate entity.. Valid values are `individual|company`',
    `liquid_capital_amount` DECIMAL(18,2) COMMENT 'Available liquid capital of the prospect.',
    `liquid_capital_currency` STRING COMMENT 'Currency code for the liquid capital amount.',
    `prospect_name` STRING COMMENT 'Full legal name of the individual or entity seeking a franchise.',
    `net_worth_amount` DECIMAL(18,2) COMMENT 'Prospects total net worth, used for financial qualification.',
    `net_worth_currency` STRING COMMENT 'Currency code for the net worth amount.',
    `notes` STRING COMMENT 'Free‑form notes captured by development staff about the prospect.',
    `pipeline_stage` STRING COMMENT 'Specific stage of the franchise development funnel.. Valid values are `lead|discovery|application|approval|contract|onboarding`',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the prospects mailing address.',
    `prospect_status` STRING COMMENT 'Current overall status of the prospect in the development pipeline.. Valid values are `new|qualified|disqualified|in_progress|won|lost`',
    `source_channel` STRING COMMENT 'Origin of the prospect lead.. Valid values are `referral|trade_show|digital_lead|broker`',
    `source_detail` STRING COMMENT 'Additional free‑text information about the lead source.',
    `state` STRING COMMENT 'State or province component of the prospects mailing address.',
    `territory_preference` STRING COMMENT 'Geographic territory or market the prospect prefers for a franchise location.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the prospect record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the prospect record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the prospect record.',
    CONSTRAINT pk_prospect PRIMARY KEY(`prospect_id`)
) COMMENT 'Master record for franchise development prospects — individuals or entities in the pipeline to become franchisees. Captures prospect source (referral, trade show, digital lead, broker, area representative), contact details, financial qualification status (net worth, liquid capital per FDD Item 7 requirements), background check status, discovery day attendance, FDD disclosure date, 14-day waiting period compliance, application status, assigned development consultant, pipeline stage, and conversion probability. Supports franchise development funnel management and FTC pre-sale compliance tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` (
    `area_representative_id` BIGINT COMMENT 'Unique surrogate key for the area representative.',
    `territory_id` BIGINT COMMENT 'Identifier of the geographic territory assigned.',
    `area_representative_status` STRING COMMENT 'Current lifecycle status.. Valid values are `active|inactive|suspended|terminated|pending`',
    `average_unit_volume_target` DECIMAL(18,2) COMMENT 'Target AUV for franchisees in the territory.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Fixed salary component (if applicable).',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Commission rate applied to sales or royalties.',
    `compensation_type` STRING COMMENT 'Type of compensation arrangement.. Valid values are `salary|commission|salary_plus_commission|bonus`',
    `compliance_status` STRING COMMENT 'Current compliance standing with franchise standards.. Valid values are `compliant|non_compliant|under_review`',
    `created_by_user` STRING COMMENT 'System user who created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'When the record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the agreement ends (nullable if ongoing).',
    `effective_start_date` DATE COMMENT 'Date when the representatives agreement becomes effective.',
    `email_address` STRING COMMENT 'Primary email for communication.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `external_reference_number` STRING COMMENT 'Identifier used in external systems (e.g., FranConnect).',
    `fee_structure_description` STRING COMMENT 'Narrative description of fees charged to the representative.',
    `full_name` STRING COMMENT 'Legal name of the area representative.',
    `last_compliance_review_date` DATE COMMENT 'Date of most recent compliance audit.',
    `market_segment` STRING COMMENT 'Segment classification of the territory market.. Valid values are `urban|suburban|rural|airport|high_traffic`',
    `notes` STRING COMMENT 'Free-text notes regarding the representative.',
    `number_of_franchisees_managed` STRING COMMENT 'Count of franchisees under the representatives oversight.',
    `performance_score` DECIMAL(18,2) COMMENT 'Composite score evaluating representative performance (e.g., based on sales, compliance).',
    `phone_number` STRING COMMENT 'Primary contact phone.',
    `primary_contact_method` STRING COMMENT 'Preferred method of contact.. Valid values are `email|phone|sms`',
    `region_code` STRING COMMENT 'Standard code for the broader region (e.g., NA, EU).',
    `role_type` STRING COMMENT 'Classification of the representatives role within franchise hierarchy.. Valid values are `area_representative|area_developer|sub_franchisor`',
    `royalty_fee_cap_amount` DECIMAL(18,2) COMMENT 'Maximum royalty fee payable to the representative.',
    `royalty_split_percent` DECIMAL(18,2) COMMENT 'Percentage of royalty revenue shared with the representative.',
    `training_completed_flag` BOOLEAN COMMENT 'Indicates if mandatory training has been completed.',
    `updated_by_user` STRING COMMENT 'System user who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last time the record was modified.',
    CONSTRAINT pk_area_representative PRIMARY KEY(`area_representative_id`)
) COMMENT 'Master record for Area Representatives (ARs) and Area Developers who hold sub-franchisor rights to recruit, support, and oversee franchisees within a defined geographic region. Captures AR entity name, territory covered, AR agreement effective and expiration dates, royalty split percentage, number of franchisees under management, performance obligations, and AR fee structure. Supports multi-tier franchise system management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` (
    `support_visit_id` BIGINT COMMENT 'System-generated unique identifier for the support visit record.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee restaurant unit that received the support visit.',
    `employee_id` BIGINT COMMENT 'Identifier of the field business consultant (FBC) who performed the visit.',
    `support_employee_id` BIGINT COMMENT 'Identifier of the field business consultant (FBC) who performed the visit.',
    `unit_id` BIGINT COMMENT 'Identifier of the specific restaurant location visited.',
    `support_unit_id` BIGINT COMMENT 'Identifier of the specific restaurant location visited.',
    `action_items` STRING COMMENT 'Detailed description of action items identified for the franchisee after the visit.',
    `city` STRING COMMENT 'City where the visited restaurant is located.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether any compliance issues were identified during the visit.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) summarizing overall compliance performance observed.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the restaurant location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the support visit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the expense amount.. Valid values are `^[A-Z]{3}$`',
    `equipment_inspected_flag` BOOLEAN COMMENT 'Indicates whether kitchen or back‑of‑house equipment was inspected.',
    `equipment_issue_count` STRING COMMENT 'Number of equipment issues identified during the inspection.',
    `expense_amount` DECIMAL(18,2) COMMENT 'Monetary cost incurred for the support visit (travel, lodging, etc.).',
    `expense_category` STRING COMMENT 'Category of the expense associated with the support visit.. Valid values are `travel|lodging|meals|supplies|other`',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow‑up visit or action is required after this support visit.',
    `is_training_visit` BOOLEAN COMMENT 'True if the visit included formal training for franchise staff.',
    `notes` STRING COMMENT 'Additional free‑form observations or comments recorded by the consultant.',
    `region` STRING COMMENT 'Broad geographic region (e.g., Midwest, West Coast) of the visited restaurant.',
    `sales_impact_estimate` DECIMAL(18,2) COMMENT 'Projected increase or decrease in sales attributable to the support visit actions.',
    `satisfaction_rating` STRING COMMENT 'Numeric rating (1‑5) provided by the franchisee to assess visit effectiveness.',
    `state_province` STRING COMMENT 'State or province of the visited restaurant location.',
    `support_visit_status` STRING COMMENT 'Current lifecycle status of the support visit.. Valid values are `scheduled|completed|cancelled|postponed|in_progress`',
    `topics_covered` STRING COMMENT 'Comma‑separated list of operational, marketing, financial, or training topics addressed during the visit.',
    `training_topic` STRING COMMENT 'Specific training subject covered during the visit (e.g., food safety, service standards).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the support visit record.',
    `visit_duration_minutes` STRING COMMENT 'Total time spent on the support visit, measured in minutes.',
    `visit_number` STRING COMMENT 'Human‑readable sequential number assigned to the support visit.',
    `visit_timestamp` TIMESTAMP COMMENT 'Date and time when the support visit actually occurred.',
    `visit_type` STRING COMMENT 'Classification of the visit purpose (e.g., scheduled, unannounced, follow‑up, opening support).. Valid values are `scheduled|unannounced|follow_up|opening_support`',
    `waste_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage of food waste observed during the visit.',
    CONSTRAINT pk_support_visit PRIMARY KEY(`support_visit_id`)
) COMMENT 'Records field support visits conducted by franchise business consultants (FBCs) or field operations teams to franchisee restaurant units. Captures visit date, visit type (scheduled, unannounced, follow-up, opening support), FBC identity, topics covered (operations, marketing, financial review, training), action items identified, franchisee satisfaction rating, and follow-up required flag. Supports franchisee relationship management and field support effectiveness tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` (
    `marketing_fund_contribution_id` BIGINT COMMENT 'Unique identifier for the franchise_marketing_fund_contribution data product (auto-inserted pre-linking).',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Marketing fund contributions are made by franchisees; adding franchisee_id creates the required relationship and resolves the siloed marketing_fund_contribution table.',
    `fund_id` BIGINT COMMENT 'add column fund_id (BIGINT) with FK to marketing.fund.fund_id - contributions must specify which marketing fund they flow into',
    CONSTRAINT pk_marketing_fund_contribution PRIMARY KEY(`marketing_fund_contribution_id`)
) COMMENT 'Tracks franchisee contributions to the national and regional marketing/advertising fund as required by the franchise agreement. Captures contribution period, contribution rate applied, gross sales basis, contribution amount, fund type (national advertising fund, regional co-op, local), payment status, and cumulative YTD contribution. Supports marketing fund governance, co-op advertising management, and FDD Item 11 advertising disclosure compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` (
    `lease_agreement_id` BIGINT COMMENT 'Primary key for the LeaseAgreement association',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to the franchisee tenant',
    `landlord_id` BIGINT COMMENT 'Foreign key linking to the landlord property owner',
    `site_id` BIGINT COMMENT 'add column site_id (BIGINT) with FK to realestate.site.site_id - franchise lease agreements must reference the physical site',
    `base_rent_amount` DECIMAL(18,2) COMMENT 'Monthly base rent amount agreed in the lease',
    `lease_end_date` DATE COMMENT 'Date the lease ends',
    `lease_start_date` DATE COMMENT 'Date the lease begins',
    `lease_term_months` STRING COMMENT 'Length of the lease in months',
    `lease_type` STRING COMMENT 'Classification of lease (e.g., gross, net, triple‑net)',
    `rent_escalation_rate` DECIMAL(18,2) COMMENT 'Annual rent escalation percentage',
    CONSTRAINT pk_lease_agreement PRIMARY KEY(`lease_agreement_id`)
) COMMENT 'Represents the contractual lease relationship between a franchisee and a landlord, capturing rent, term, escalation, and type details for each property lease.. Existence Justification: Franchisees (tenants) can lease properties from multiple landlords, and landlords can lease to multiple franchisees. The lease agreement is an operational contract that is created, updated, and terminated by business users and contains its own data such as rent amount, term, and escalation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_area_representative_id` FOREIGN KEY (`area_representative_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`area_representative`(`area_representative_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_compliance_franchisee_id` FOREIGN KEY (`compliance_franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ADD CONSTRAINT `fk_franchise_franchise_corrective_action_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ADD CONSTRAINT `fk_franchise_franchise_corrective_action_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ADD CONSTRAINT `fk_franchise_franchise_remodel_project_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ADD CONSTRAINT `fk_franchise_transfer_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ADD CONSTRAINT `fk_franchise_transfer_event_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ADD CONSTRAINT `fk_franchise_renewal_event_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ADD CONSTRAINT `fk_franchise_renewal_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ADD CONSTRAINT `fk_franchise_termination_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ADD CONSTRAINT `fk_franchise_performance_scorecard_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ADD CONSTRAINT `fk_franchise_fdd_disclosure_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`prospect`(`prospect_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ADD CONSTRAINT `fk_franchise_fdd_disclosure_fdd_recipient_prospect_id` FOREIGN KEY (`fdd_recipient_prospect_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`prospect`(`prospect_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ADD CONSTRAINT `fk_franchise_area_representative_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ADD CONSTRAINT `fk_franchise_support_visit_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ADD CONSTRAINT `fk_franchise_marketing_fund_contribution_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ADD CONSTRAINT `fk_franchise_lease_agreement_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `vibe_restaurants_v1`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`franchise` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`franchise` SET TAGS ('dbx_domain' = 'franchise');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `area_representative_id` SET TAGS ('dbx_business_glossary_term' = 'Area Representative Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Address Line 1)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Address Line 2)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue (Annual Revenue)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (City)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance Status)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (Country Code)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (Record Created Timestamp)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating (Credit Rating)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name (DBA Name)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number (Insurance Policy Number)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name (Legal Name)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Termination Date)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (Record Updated Timestamp)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisor ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisor ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
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
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `area_sq_miles` SET TAGS ('dbx_business_glossary_term' = 'Territory Area (Square Miles)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|unassigned|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV) for Territory');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Territory City Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `dma` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `franchise_fee` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Amount for Territory');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Territory Geographic Boundary (WKT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `median_income` SET TAGS ('dbx_business_glossary_term' = 'Territory Median Household Income');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
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
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `sales_report_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Report ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `sales_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
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
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` SET TAGS ('dbx_subdomain' = 'growth_execution');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `nro_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'New Restaurant Opening (NRO) Pipeline ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Development Consultant ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `nro_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Development Consultant ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `nro_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `nro_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `actual_capex_spent` SET TAGS ('dbx_business_glossary_term' = 'Actual CAPEX Spent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `actual_open_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Open Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `actual_opex_spent` SET TAGS ('dbx_business_glossary_term' = 'Actual OPEX Spent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `brand` SET TAGS ('dbx_business_glossary_term' = 'Brand');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `brand` SET TAGS ('dbx_value_regex' = 'QSR|Casual|Fine_Dining');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `budget_capex` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Budget');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `budget_opex` SET TAGS ('dbx_business_glossary_term' = 'OPEX Budget');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `capital_investment_estimate` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment Estimate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `construction_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Construction Complete Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `construction_start_flag` SET TAGS ('dbx_business_glossary_term' = 'Construction Started Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `development_type` SET TAGS ('dbx_business_glossary_term' = 'Development Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `development_type` SET TAGS ('dbx_value_regex' = 'new_build|conversion|remodel');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_acuv` SET TAGS ('dbx_business_glossary_term' = 'Expected Average Check Value (ACV)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_cogs_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected COGS Percentage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_labor_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Labor Cost Percentage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_roi` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment (ROI)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_traffic_volume` SET TAGS ('dbx_business_glossary_term' = 'Expected Traffic Volume');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `last_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `last_milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Project Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `opening_announced_flag` SET TAGS ('dbx_business_glossary_term' = 'Opening Announced Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `permits_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Permits Obtained Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^NRO-[A-Z0-9]{6}$');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|cancelled|completed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Project Stage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `stage_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Change Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `target_open_date` SET TAGS ('dbx_business_glossary_term' = 'Target Open Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `training_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Complete Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `development_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `cure_period_months` SET TAGS ('dbx_business_glossary_term' = 'Cure Period (Months)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `development_phase` SET TAGS ('dbx_business_glossary_term' = 'Development Phase');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `development_phase` SET TAGS ('dbx_value_regex' = 'planning|execution|monitoring|closed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `development_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `development_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed|default');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `last_compliance_check` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Check Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'MUDA|single_unit|renewal');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `target_units_year_1` SET TAGS ('dbx_business_glossary_term' = 'Target Units Year 1');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `target_units_year_2` SET TAGS ('dbx_business_glossary_term' = 'Target Units Year 2');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `target_units_year_3` SET TAGS ('dbx_business_glossary_term' = 'Target Units Year 3');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `total_units_committed` SET TAGS ('dbx_business_glossary_term' = 'Total Units Committed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `units_opened_to_date` SET TAGS ('dbx_business_glossary_term' = 'Units Opened To Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `units_remaining` SET TAGS ('dbx_business_glossary_term' = 'Units Remaining');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier (FRANCHISE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier (FRANCHISE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_disposition` SET TAGS ('dbx_business_glossary_term' = 'Audit Disposition (DISPOSITION)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_disposition` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_location_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Location Code (LOC_CODE)');
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
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `franchise_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for franchise_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'growth_execution');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_trainer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainer ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_trainer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_trainer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date (ACD)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date (CED)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued (CI)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (CF)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until (EU)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date (ED)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENR)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Hours Completed (HC)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `hours_required` SET TAGS ('dbx_business_glossary_term' = 'Hours Required (HR)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes (EN)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status (PFS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date (SCD)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Training Score (TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ES)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|completed|failed|cancelled|in-progress');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type (TT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'classroom|online|in-restaurant');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_subdomain' = 'growth_execution');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `franchise_remodel_project_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for franchise_remodel_project');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Event Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Transferor Franchisee Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `effective_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Transfer Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `fdd_redisclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Disclosure Document Redisclosure Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `franchisor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Franchisor Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `marketing_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fee Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `new_territory_code` SET TAGS ('dbx_business_glossary_term' = 'New Territory Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Event Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `previous_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Territory Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `right_of_first_refusal_exercised_flag` SET TAGS ('dbx_business_glossary_term' = 'Right of First Refusal Exercised Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `total_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_conditions` SET TAGS ('dbx_business_glossary_term' = 'Transfer Conditions');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_event_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_event_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_fee_due_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Due Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Paid Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_fee_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_value_regex' = 'retirement|sale|bankruptcy|strategic|other');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'sale|inheritance|estate|corporate_acquisition|internal_reassignment');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `units_transferred` SET TAGS ('dbx_business_glossary_term' = 'Number of Units Transferred');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Event ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Identifier (FRANCHISEE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Original Franchise Agreement ID (FA_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag (COMPLIANCE_REVIEWED)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `fdd_redisclosure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'FDD Redisclosure Timestamp (FDD_REDISCLOSE_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `franchisor_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Franchisor Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `ftc_compliance_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Attestation Flag (FTC_ATTEST)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Event Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Timestamp (APP_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_event_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Event Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_event_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Renewal Execution Timestamp (EXEC_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_fee_currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Paid Flag (FEE_PAID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Payment Date (FEE_PAYMENT_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Event Number (REN_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_number` SET TAGS ('dbx_value_regex' = 'RN-[0-9]{8}');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Length in Years (TERM_YRS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `updated_royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Updated Royalty Rate Percentage (ROYALTY_RATE_PCT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `updated_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Updated Territory Code (TERR_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `updated_territory_code` SET TAGS ('dbx_value_regex' = '[A-Z0-9]{3,10}');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_event_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Event ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date (COMPLIANCE_REVIEW_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `cure_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Period End Date (CURE_PERIOD_END_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `effective_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Termination Date (EFFECTIVE_TERMINATION_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `ftc_compliance_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Attestation Flag (FTC_COMPLIANCE_ATTESTATION_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `legal_dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Dispute Flag (LEGAL_DISPUTE_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date (NOTICE_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `outstanding_royalty_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Royalty Balance (OUTSTANDING_ROYALTY_BALANCE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `outstanding_royalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `outstanding_royalty_currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `post_termination_obligation` SET TAGS ('dbx_business_glossary_term' = 'Post-Termination Obligation (POST_TERMINATION_OBLIGATION)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `post_termination_obligation` SET TAGS ('dbx_value_regex' = 'de_identification|non_compete|none');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Cure Period Days (TERMINATION_CURE_PERIOD_DAYS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_event_status` SET TAGS ('dbx_business_glossary_term' = 'Termination Event Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_event_status` SET TAGS ('dbx_value_regex' = 'pending|approved|executed|closed|rejected');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Termination Fee Amount (TERMINATION_FEE_AMOUNT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_fee_currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_notice_method` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Method (TERMINATION_NOTICE_METHOD)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_notice_method` SET TAGS ('dbx_value_regex' = 'email|postal|fax|in_person');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERMINATION_REASON)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type (TERMINATION_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'voluntary|default|non_renewal|abandonment');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `units_affected` SET TAGS ('dbx_business_glossary_term' = 'Units Affected (UNITS_AFFECTED)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
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
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `food_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Score');
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
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Disclosure Document ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_recipient_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `acknowledgment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Document Title');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Document Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'initial|amendment|supplement');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_disclosure_status` SET TAGS ('dbx_value_regex' = 'draft|issued|archived|revoked');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_document_url` SET TAGS ('dbx_business_glossary_term' = 'FDD Document URL');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_version_number` SET TAGS ('dbx_business_glossary_term' = 'FDD Version Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `material_change_description` SET TAGS ('dbx_business_glossary_term' = 'Material Change Description');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `material_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Change Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'prospect|existing_franchisee|prospective_franchisee');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `state_registration_status` SET TAGS ('dbx_business_glossary_term' = 'State Registration Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `state_registration_status` SET TAGS ('dbx_value_regex' = 'registered|not_registered|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `version_year` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Version Year');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `waiting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `waiting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Development Consultant ID (CONSULTANT_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Development Consultant ID (CONSULTANT_ID)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status (APP_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|under_review|approved|rejected');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `application_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Date (APP_SUBMIT_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date (BG_CHECK_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status (BG_CHECK_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|failed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Attestation Flag (COMPLIANCE_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Prospect Email Address (EMAIL)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Prospect Phone Number (PHONE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `discovery_day_attended` SET TAGS ('dbx_business_glossary_term' = 'Discovery Day Attended Flag (DISCOVERY_ATTEND)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `discovery_day_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Day Date (DISCOVERY_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `estimated_initial_investment` SET TAGS ('dbx_business_glossary_term' = 'Estimated Initial Investment (EST_INVEST)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `estimated_initial_investment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `estimated_initial_investment` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `estimated_initial_investment_currency` SET TAGS ('dbx_business_glossary_term' = 'Initial Investment Currency (EST_INVEST_CURR)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `expected_open_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Opening Date (EXP_OPEN_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `fdd_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Disclosure Document Disclosure Date (FDD_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `fdd_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'FDD Sent Flag (FDD_SENT)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `franchise_type_preference` SET TAGS ('dbx_business_glossary_term' = 'Franchise Type Preference (TYPE_PREF)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `franchise_type_preference` SET TAGS ('dbx_value_regex' = 'QSR|Casual|Fine_Dining');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date (LAST_CONTACT_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Method (LAST_CONTACT_METHOD)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|in_person|online');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type (ENTITY_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `legal_entity_type` SET TAGS ('dbx_value_regex' = 'individual|company');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `liquid_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquid Capital Amount (LIQ_CAPITAL)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `liquid_capital_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `liquid_capital_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `liquid_capital_currency` SET TAGS ('dbx_business_glossary_term' = 'Liquid Capital Currency (LIQ_CAPITAL_CURR)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Full Legal Name (NAME)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `net_worth_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Worth Amount (NET_WORTH)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `net_worth_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `net_worth_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `net_worth_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Worth Currency (NET_WORTH_CURR)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prospect Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage (STAGE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_value_regex' = 'lead|discovery|application|approval|contract|onboarding');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_business_glossary_term' = 'Prospect Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_value_regex' = 'new|qualified|disqualified|in_progress|won|lost');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Prospect Source Channel (SRC_CHAN)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'referral|trade_show|digital_lead|broker');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `source_detail` SET TAGS ('dbx_business_glossary_term' = 'Source Detail (SRC_DETAIL)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `territory_preference` SET TAGS ('dbx_business_glossary_term' = 'Territory Preference (TERRITORY_PREF)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (UPDATED_BY)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (CREATED_BY)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `area_representative_id` SET TAGS ('dbx_business_glossary_term' = 'Area Representative ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `area_representative_status` SET TAGS ('dbx_business_glossary_term' = 'Area Representative Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `area_representative_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `average_unit_volume_target` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume Target');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'salary|commission|salary_plus_commission|bonus');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Area Representative Email Address');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `fee_structure_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Description');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Area Representative Full Name (First and Last)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|airport|high_traffic');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `number_of_franchisees_managed` SET TAGS ('dbx_business_glossary_term' = 'Number of Franchisees Managed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Area Representative Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Area Representative Role Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'area_representative|area_developer|sub_franchisor');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `royalty_fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Fee Cap Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `royalty_split_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Split Percentage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` SET TAGS ('dbx_subdomain' = 'growth_execution');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Support Visit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Field Business Consultant ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Field Business Consultant ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Store ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Store ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `action_items` SET TAGS ('dbx_business_glossary_term' = 'Visit Action Items');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `equipment_inspected_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Inspected Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `equipment_issue_count` SET TAGS ('dbx_business_glossary_term' = 'Equipment Issue Count');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Visit Expense Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `expense_category` SET TAGS ('dbx_value_regex' = 'travel|lodging|meals|supplies|other');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `is_training_visit` SET TAGS ('dbx_business_glossary_term' = 'Training Visit Indicator');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Visit Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `sales_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Sales Impact');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Satisfaction Rating');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_visit_status` SET TAGS ('dbx_business_glossary_term' = 'Support Visit Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|postponed|in_progress');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Visit Topics Covered');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `training_topic` SET TAGS ('dbx_business_glossary_term' = 'Training Topic');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `visit_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Visit Duration (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Support Visit Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Support Visit Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Support Visit Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_value_regex' = 'scheduled|unannounced|follow_up|opening_support');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Food Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `marketing_fund_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for franchise_marketing_fund_contribution');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` SET TAGS ('dbx_subdomain' = 'growth_execution');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` SET TAGS ('dbx_association_edges' = 'franchise.franchisee,realestate.landlord');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Leaseagreement - Lease Id');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Leaseagreement - Franchisee Id');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Leaseagreement - Landlord Id');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `base_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `base_rent_amount` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Lease Term');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_term_months` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_type` SET TAGS ('dbx_classification' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `rent_escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `rent_escalation_rate` SET TAGS ('dbx_financial' = 'true');
