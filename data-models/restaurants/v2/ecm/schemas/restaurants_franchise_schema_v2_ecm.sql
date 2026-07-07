-- Schema for Domain: franchise | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`franchise` COMMENT 'SSOT for franchise partner identity, FDD agreements, territory management, royalty rate calculations, franchise fees, compliance tracking, NRO (New Restaurant Opening) pipeline, franchisee performance metrics, and development lifecycle via FranConnect. Ensures adherence to brand standards, IFA best practices, and FTC Franchise Rule.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` (
    `franchisee_id` BIGINT COMMENT 'Unique identifier for the franchisee',
    `area_representative_id` BIGINT COMMENT 'FK to the area representative managing this franchisee',
    `bank_account_id` BIGINT COMMENT 'FK to the franchisee bank account for royalty payments',
    `distribution_center_id` BIGINT COMMENT 'FK to the primary distribution center serving this franchisee',
    `program_id` BIGINT COMMENT 'FK to the loyalty program this franchisee participates in',
    `territory_id` BIGINT COMMENT 'FK to the territory assigned to this franchisee',
    `address_line1` STRING COMMENT 'Primary street address of the franchisee',
    `address_line2` STRING COMMENT 'Secondary address line',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Total annual revenue across all units',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Average unit volume across all locations',
    `city` STRING COMMENT 'City of the franchisee headquarters',
    `compliance_status` STRING COMMENT 'Current compliance status of the franchisee',
    `country_code` STRING COMMENT 'ISO country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credit_rating` STRING COMMENT 'Credit rating of the franchisee entity',
    `dba_name` STRING COMMENT 'Doing-business-as name',
    `established_date` DATE COMMENT 'Date the franchisee entity was established',
    `fdd_disclosure_status` STRING COMMENT 'Status of FDD disclosure for this franchisee',
    `food_safety_certified` BOOLEAN COMMENT 'Whether the franchisee holds food safety certification',
    `franchise_fee_amount` DECIMAL(18,2) COMMENT 'Initial franchise fee paid',
    `franchisee_number` STRING COMMENT 'Business identifier number for the franchisee',
    `franchisee_status` STRING COMMENT 'Current operational status (active, inactive, suspended)',
    `franchisee_type` STRING COMMENT 'Type of franchisee (single-unit, multi-unit, area developer)',
    `ifa_membership_status` STRING COMMENT 'International Franchise Association membership status',
    `industry_segment` STRING COMMENT 'Industry segment classification',
    `insurance_expiry_date` DATE COMMENT 'Date when insurance coverage expires',
    `insurance_policy_number` STRING COMMENT 'Insurance policy reference number',
    `legal_name` STRING COMMENT 'Legal registered name of the franchisee entity',
    `next_renewal_date` DATE COMMENT 'Date of next franchise agreement renewal',
    `number_of_units` STRING COMMENT 'Total number of restaurant units operated',
    `postal_code` STRING COMMENT 'Postal/ZIP code',
    `royalty_fee_amount` DECIMAL(18,2) COMMENT 'Current royalty fee amount',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Royalty rate percentage',
    `state_province` STRING COMMENT 'State or province',
    `state_tax_number` STRING COMMENT 'State tax identification number',
    `tax_id_ein` STRING COMMENT 'Federal employer identification number',
    `termination_date` DATE COMMENT 'Date franchise was terminated if applicable',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_franchisee PRIMARY KEY(`franchisee_id`)
) COMMENT 'A franchisee entity representing an individual or organization that operates one or more franchise restaurant units under a franchise agreement.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the franchise agreement',
    `legal_entity_id` BIGINT COMMENT 'FK to the franchisor legal entity',
    `agreement_legal_entity_id` BIGINT COMMENT 'FK to the franchisee legal entity',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee party',
    `territory_id` BIGINT COMMENT 'FK to the territory covered by this agreement',
    `agreement_number` STRING COMMENT 'Business reference number for the agreement',
    `agreement_status` STRING COMMENT 'Current status (active, expired, terminated)',
    `agreement_type` STRING COMMENT 'Type of agreement (single-unit, multi-unit, area development)',
    `amendment_effective_date` DATE COMMENT 'Effective date of the latest amendment',
    `amendment_number` STRING COMMENT 'Sequential amendment number',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Expected average unit volume under this agreement',
    `compliance_review_date` DATE COMMENT 'Date of last compliance review',
    `compliance_status` STRING COMMENT 'Compliance status of the agreement',
    `contract_version` STRING COMMENT 'Version of the contract template used',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Agreement end date',
    `effective_start_date` DATE COMMENT 'Agreement start date',
    `ftc_compliance_attestation_flag` BOOLEAN COMMENT 'Whether FTC compliance has been attested',
    `initial_fee_amount` DECIMAL(18,2) COMMENT 'Initial franchise fee amount',
    `marketing_fee_percent` DECIMAL(18,2) COMMENT 'Marketing fund contribution percentage',
    `notes` STRING COMMENT 'Free-text notes about the agreement',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged upon renewal',
    `renewal_term_years` STRING COMMENT 'Length of renewal term in years',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Royalty rate as a percentage of gross sales',
    `sales_target_amount` DECIMAL(18,2) COMMENT 'Minimum sales target amount',
    `signed_date` DATE COMMENT 'Date the agreement was signed',
    `termination_date` DATE COMMENT 'Date the agreement was terminated',
    `transfer_rights_flag` BOOLEAN COMMENT 'Whether the agreement includes transfer rights',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'A franchise agreement governing the relationship between franchisor and franchisee including terms, fees, and obligations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory',
    `distribution_center_id` BIGINT COMMENT 'FK to the distribution center serving this territory',
    `area_sq_miles` DECIMAL(18,2) COMMENT 'Total area of the territory in square miles',
    `assignment_status` STRING COMMENT 'Whether the territory is assigned or available',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Average unit volume for locations in this territory',
    `city` STRING COMMENT 'Primary city within the territory',
    `territory_code` STRING COMMENT 'Short code for the territory',
    `compliance_status` STRING COMMENT 'Compliance status of the territory',
    `country_code` STRING COMMENT 'ISO country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `territory_description` STRING COMMENT 'Description of the territory',
    `dma` STRING COMMENT 'Designated Market Area',
    `effective_end_date` DATE COMMENT 'End date of territory assignment',
    `effective_start_date` DATE COMMENT 'Start date of territory assignment',
    `franchise_fee` DECIMAL(18,2) COMMENT 'Franchise fee applicable in this territory',
    `geometry_wkt` STRING COMMENT 'Well-Known Text representation of territory boundary',
    `last_inspection_date` DATE COMMENT 'Date of last territory inspection',
    `median_income` DECIMAL(18,2) COMMENT 'Median household income in the territory',
    `territory_name` STRING COMMENT 'Name of the territory',
    `notes` STRING COMMENT 'Free-text notes',
    `number_of_locations` STRING COMMENT 'Number of restaurant locations in the territory',
    `population` STRING COMMENT 'Population within the territory',
    `radius_miles` DECIMAL(18,2) COMMENT 'Radius of the territory in miles',
    `region` STRING COMMENT 'Region classification',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Royalty rate applicable in this territory',
    `territory_status` STRING COMMENT 'Current status of the territory',
    `territory_type` STRING COMMENT 'Type of territory (exclusive, non-exclusive)',
    `trade_area_classification` STRING COMMENT 'Classification of the trade area',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `zip_codes` STRING COMMENT 'Comma-separated list of ZIP codes in the territory',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'A geographic territory assigned to a franchisee defining the exclusive or protected area for franchise operations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`billing` (
    `billing_id` BIGINT COMMENT 'Unique identifier for the billing record',
    `agreement_id` BIGINT COMMENT 'FK to the governing franchise agreement',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee being billed',
    `amount_due` DECIMAL(18,2) COMMENT 'The amount due attribute value for this billing record in the franchise domain',
    `amount_paid` DECIMAL(18,2) COMMENT 'Amount already paid',
    `balance_outstanding` DECIMAL(18,2) COMMENT 'Remaining balance outstanding',
    `billing_date` DATE COMMENT 'The date and time when the billing event occurred for this billing',
    `billing_number` STRING COMMENT 'Business reference number for the billing',
    `billing_status` STRING COMMENT 'Status of the billing (draft, sent, paid, overdue)',
    `billing_type` STRING COMMENT 'Type of billing (recurring, one-time, adjustment)',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'ISO currency code',
    `due_date` DATE COMMENT 'Payment due date',
    `invoice_date` DATE COMMENT 'Date the invoice was issued',
    `invoice_number` STRING COMMENT 'Invoice reference number',
    `is_paid` BOOLEAN COMMENT 'Whether the billing has been fully paid',
    `marketing_fee_amount` DECIMAL(18,2) COMMENT 'Marketing fund contribution amount',
    `paid_date` DATE COMMENT 'Date payment was received',
    `payment_status` STRING COMMENT 'The current status of the payment for this billing',
    `period` STRING COMMENT 'The period attribute value for this billing record in the franchise domain',
    `period_end` DATE COMMENT 'End date of the billing period',
    `period_start` DATE COMMENT 'Start date of the billing period',
    `royalty_amount` DECIMAL(18,2) COMMENT 'Royalty fee amount billed',
    `technology_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for technology fee in this billing',
    `total_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for total in this billing',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Total amount due on this billing',
    `total_due` DECIMAL(18,2) COMMENT 'The total due attribute value for this billing record in the franchise domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_billing PRIMARY KEY(`billing_id`)
) COMMENT 'Franchise billing records representing invoices sent to franchisees for royalties, marketing fees, and technology fees.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` (
    `sales_report_id` BIGINT COMMENT 'Unique identifier for the sales report',
    `franchisee_id` BIGINT COMMENT 'FK to the reporting franchisee',
    `unit_id` BIGINT COMMENT 'FK to the restaurant unit',
    `sales_unit_id` BIGINT COMMENT 'FK to the restaurant unit',
    `employee_id` BIGINT COMMENT 'FK to the employee who submitted the report',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Total adjustments to gross sales',
    `audit_trail` STRING COMMENT 'The audit trail attribute value for this sales report record in the franchise domain',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average transaction value',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'ISO currency code',
    `daypart_sales_breakdown` DECIMAL(18,2) COMMENT 'The daypart sales breakdown attribute value for this sales report record in the franchise domain',
    `franchise_fee` DECIMAL(18,2) COMMENT 'The franchise fee attribute value for this sales report record in the franchise domain',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total gross sales for the period',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Net sales after adjustments',
    `notes` STRING COMMENT 'Free-text notes',
    `report_number` STRING COMMENT 'Business reference number',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period',
    `reporting_period_type` STRING COMMENT 'Type of period (weekly, monthly, quarterly)',
    `royalty_amount` DECIMAL(18,2) COMMENT 'Calculated royalty amount',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Royalty rate applied',
    `sales_report_status` STRING COMMENT 'Status of the report (draft, submitted, validated)',
    `same_store_sales` DECIMAL(18,2) COMMENT 'Same-store sales comparison amount',
    `submission_method` STRING COMMENT 'How the report was submitted',
    `submission_timestamp` TIMESTAMP COMMENT 'When the report was submitted',
    `transaction_count` BIGINT COMMENT 'Number of transactions in the period',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `validation_status` STRING COMMENT 'Validation status of the report',
    `variance_amount` DECIMAL(18,2) COMMENT 'Variance from expected sales',
    `variance_flag` BOOLEAN COMMENT 'Whether a significant variance was detected',
    CONSTRAINT pk_sales_report PRIMARY KEY(`sales_report_id`)
) COMMENT 'Periodic sales reports submitted by franchisees to the franchisor for royalty calculation and performance tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` (
    `nro_pipeline_id` BIGINT COMMENT 'Unique identifier for the NRO pipeline record',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee developing the new unit',
    `employee_id` BIGINT COMMENT 'FK to the consulting employee',
    `nro_employee_id` BIGINT COMMENT 'FK to the responsible employee',
    `actual_capex_spent` DECIMAL(18,2) COMMENT 'Actual capital expenditure spent to date',
    `actual_open_date` DATE COMMENT 'Actual opening date',
    `actual_opex_spent` DECIMAL(18,2) COMMENT 'The actual opex spent attribute value for this nro pipeline record in the franchise domain',
    `brand` STRING COMMENT 'The brand attribute value for this nro pipeline record in the franchise domain',
    `budget_capex` DECIMAL(18,2) COMMENT 'Budgeted capital expenditure',
    `budget_opex` DECIMAL(18,2) COMMENT 'The budget opex attribute value for this nro pipeline record in the franchise domain',
    `capital_investment_estimate` DECIMAL(18,2) COMMENT 'Estimated total capital investment',
    `compliance_status` STRING COMMENT 'Compliance status of the NRO project',
    `construction_complete_flag` BOOLEAN COMMENT 'Whether construction is complete',
    `construction_start_flag` BOOLEAN COMMENT 'Boolean indicator flag for construction start flag status in this nro pipeline',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `development_type` STRING COMMENT 'Type of development (new build, conversion, relocation)',
    `effective_from` DATE COMMENT 'The effective from attribute value for this nro pipeline record in the franchise domain',
    `effective_until` DATE COMMENT 'The effective until attribute value for this nro pipeline record in the franchise domain',
    `expected_acuv` DECIMAL(18,2) COMMENT 'The expected acuv attribute value for this nro pipeline record in the franchise domain',
    `expected_cogs_percent` DECIMAL(18,2) COMMENT 'The expected cogs percent attribute value for this nro pipeline record in the franchise domain',
    `expected_labor_percent` DECIMAL(18,2) COMMENT 'The expected labor percent attribute value for this nro pipeline record in the franchise domain',
    `expected_roi` DECIMAL(18,2) COMMENT 'Expected return on investment percentage',
    `expected_traffic_volume` STRING COMMENT 'The expected traffic volume attribute value for this nro pipeline record in the franchise domain',
    `health_inspection_score` DECIMAL(18,2) COMMENT 'The health inspection score attribute value for this nro pipeline record in the franchise domain',
    `last_milestone_date` DATE COMMENT 'Date of the last milestone achieved',
    `last_milestone_name` STRING COMMENT 'Name of the last milestone achieved',
    `notes` STRING COMMENT 'Free-text notes',
    `opening_announced_flag` BOOLEAN COMMENT 'Boolean indicator flag for opening announced flag status in this nro pipeline',
    `permits_obtained_flag` BOOLEAN COMMENT 'Whether all permits have been obtained',
    `project_code` STRING COMMENT 'Project reference code',
    `project_name` STRING COMMENT 'Name of the NRO project',
    `project_status` STRING COMMENT 'Current status of the project',
    `risk_level` STRING COMMENT 'Risk level assessment',
    `stage` STRING COMMENT 'Current pipeline stage',
    `stage_change_timestamp` TIMESTAMP COMMENT 'The stage change timestamp attribute value for this nro pipeline record in the franchise domain',
    `target_open_date` DATE COMMENT 'Target opening date',
    `territory_code` STRING COMMENT 'Territory code for the new location',
    `training_complete_flag` BOOLEAN COMMENT 'Whether pre-opening training is complete',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_nro_pipeline PRIMARY KEY(`nro_pipeline_id`)
) COMMENT 'New Restaurant Opening pipeline tracking projects from site selection through grand opening.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` (
    `development_schedule_id` BIGINT COMMENT 'Unique identifier for the development schedule',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee',
    `territory_id` BIGINT COMMENT 'FK to the territory',
    `compliance_status` STRING COMMENT 'Whether the franchisee is on track',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cure_period_months` STRING COMMENT 'Months allowed to cure non-compliance',
    `development_phase` STRING COMMENT 'Current development phase',
    `development_schedule_status` STRING COMMENT 'Status of the schedule',
    `end_date` DATE COMMENT 'Schedule end date',
    `last_compliance_check` DATE COMMENT 'The last compliance check attribute value for this development schedule record in the franchise domain',
    `notes` STRING COMMENT 'Free-text notes',
    `schedule_number` STRING COMMENT 'Business reference number',
    `schedule_type` STRING COMMENT 'Type of schedule',
    `schedule_version` STRING COMMENT 'The schedule version attribute value for this development schedule record in the franchise domain',
    `start_date` DATE COMMENT 'Schedule start date',
    `target_units_year_1` STRING COMMENT 'Units to open in year 1',
    `target_units_year_2` STRING COMMENT 'Units to open in year 2',
    `target_units_year_3` STRING COMMENT 'Units to open in year 3',
    `total_units_committed` STRING COMMENT 'Total number of units committed',
    `units_opened_to_date` STRING COMMENT 'Number of units opened so far',
    `units_remaining` STRING COMMENT 'Units remaining to be opened',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_development_schedule PRIMARY KEY(`development_schedule_id`)
) COMMENT 'Development schedule defining the committed timeline for opening new franchise units within a territory.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` (
    `compliance_audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit',
    `employee_id` BIGINT COMMENT 'FK to the auditor employee',
    `compliance_employee_id` BIGINT COMMENT 'Unique identifier referencing the compliance employee associated with this compliance audit record',
    `franchisee_id` BIGINT COMMENT 'Unique identifier for the compliance franchise franchisee associated with this compliance audit',
    `compliance_franchisee_id` BIGINT COMMENT 'FK to the franchisee being audited',
    `audit_disposition` STRING COMMENT 'The audit disposition attribute value for this compliance audit record in the franchise domain',
    `audit_location_code` STRING COMMENT 'A standardized code representing the audit location classification for this compliance audit',
    `audit_notes` STRING COMMENT 'Notes from the audit',
    `audit_number` STRING COMMENT 'Business reference number',
    `audit_source_system` STRING COMMENT 'The audit source system attribute value for this compliance audit record in the franchise domain',
    `audit_timestamp` TIMESTAMP COMMENT 'When the audit was conducted',
    `audit_type` STRING COMMENT 'Type of audit (scheduled, surprise, follow-up)',
    `brand_standards_score` DECIMAL(18,2) COMMENT 'Score for brand standards compliance',
    `cleanliness_score` DECIMAL(18,2) COMMENT 'Score for cleanliness',
    `compliance_audit_status` STRING COMMENT 'Status of the audit',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is needed',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `critical_violations_count` STRING COMMENT 'Number of critical violations found',
    `equipment_score` DECIMAL(18,2) COMMENT 'The equipment score attribute value for this compliance audit record in the franchise domain',
    `food_safety_score` DECIMAL(18,2) COMMENT 'Score for food safety compliance',
    `non_critical_violations_count` STRING COMMENT 'Number of non-critical violations',
    `overall_score` DECIMAL(18,2) COMMENT 'Overall audit score',
    `service_score` DECIMAL(18,2) COMMENT 'Score for service standards',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_compliance_audit PRIMARY KEY(`compliance_audit_id`)
) COMMENT 'Compliance audits conducted on franchise locations to assess adherence to brand standards, food safety, and operational requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` (
    `franchise_corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action',
    `compliance_audit_id` BIGINT COMMENT 'FK to the triggering compliance audit',
    `foodsafety_corrective_action_id` BIGINT COMMENT 'FK to related food safety corrective action if applicable',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee',
    `action_description` STRING COMMENT 'Description of the corrective action required',
    `action_number` STRING COMMENT 'Business reference number',
    `action_plan` STRING COMMENT 'The action plan attribute value for this franchise corrective action record in the franchise domain',
    `action_status` STRING COMMENT 'Current status of the corrective action',
    `assigned_to` STRING COMMENT 'Person responsible for resolution',
    `closed_date` DATE COMMENT 'The date and time when the closed event occurred for this franchise corrective action',
    `completed_date` DATE COMMENT 'The date and time when the completed event occurred for this franchise corrective action',
    `completion_date` DATE COMMENT 'Date the action was completed',
    `corrective_action_description` STRING COMMENT 'The corrective action description attribute value for this franchise corrective action record in the franchise domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `due_date` DATE COMMENT 'Deadline for corrective action completion',
    `is_closed` BOOLEAN COMMENT 'Whether the action is closed',
    `is_resolved` BOOLEAN COMMENT 'Boolean indicator flag for is resolved status in this franchise corrective action',
    `issue_category` STRING COMMENT 'Category of the issue',
    `issue_description` STRING COMMENT 'The issue description attribute value for this franchise corrective action record in the franchise domain',
    `issued_date` DATE COMMENT 'The date and time when the issued event occurred for this franchise corrective action',
    `resolution_date` DATE COMMENT 'The date and time when the resolution event occurred for this franchise corrective action',
    `resolution_notes` STRING COMMENT 'Notes on how the issue was resolved',
    `resolved_date` DATE COMMENT 'The date and time when the resolved event occurred for this franchise corrective action',
    `responsible_party` STRING COMMENT 'The responsible party attribute value for this franchise corrective action record in the franchise domain',
    `root_cause` STRING COMMENT 'Identified root cause of the issue',
    `severity` STRING COMMENT 'Severity level (critical, major, minor)',
    `severity_level` STRING COMMENT 'The severity level attribute value for this franchise corrective action record in the franchise domain',
    `franchise_corrective_action_status` STRING COMMENT 'The current status of the franchise corrective action for this franchise corrective action',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_franchise_corrective_action PRIMARY KEY(`franchise_corrective_action_id`)
) COMMENT 'Corrective actions issued to franchisees as a result of compliance audits, requiring remediation of identified issues.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` (
    `fee_schedule_id` BIGINT COMMENT 'Unique identifier for the fee schedule',
    `agreement_id` BIGINT COMMENT 'FK to the franchise agreement',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee',
    `territory_id` BIGINT COMMENT 'FK to the territory',
    `active_flag` BOOLEAN COMMENT 'Boolean indicator flag for active flag status in this fee schedule',
    `calculation_basis` STRING COMMENT 'Basis for calculation (gross sales, net sales)',
    `calculation_method` STRING COMMENT 'How the fee is calculated (percentage, flat, tiered)',
    `fee_schedule_code` STRING COMMENT 'Business reference code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'ISO currency code',
    `effective_date` DATE COMMENT 'The date and time when the effective event occurred for this fee schedule',
    `effective_end_date` DATE COMMENT 'End date of the fee schedule',
    `effective_start_date` DATE COMMENT 'Start date of the fee schedule',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this fee schedule',
    `expiry_date` DATE COMMENT 'The date and time when the expiry event occurred for this fee schedule',
    `fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for fee in this fee schedule',
    `fee_basis` STRING COMMENT 'The fee basis attribute value for this fee schedule record in the franchise domain',
    `fee_name` STRING COMMENT 'Name of the fee',
    `fee_percent` DECIMAL(18,2) COMMENT 'The fee percent attribute value for this fee schedule record in the franchise domain',
    `fee_percentage` DECIMAL(18,2) COMMENT 'The fee percentage attribute value for this fee schedule record in the franchise domain',
    `fee_rate` DECIMAL(18,2) COMMENT 'The fee rate attribute value for this fee schedule record in the franchise domain',
    `fee_rate_pct` DECIMAL(18,2) COMMENT 'Fee rate as a percentage',
    `fee_type` STRING COMMENT 'Type of fee (royalty, marketing, technology, other)',
    `flat_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for flat in this fee schedule',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Flat fee amount if applicable',
    `frequency` STRING COMMENT 'Billing frequency (weekly, monthly, quarterly)',
    `is_active` BOOLEAN COMMENT 'Whether the fee schedule is currently active',
    `marketing_fee_rate_pct` DECIMAL(18,2) COMMENT 'The marketing fee rate pct attribute value for this fee schedule record in the franchise domain',
    `minimum_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for minimum in this fee schedule',
    `minimum_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for minimum fee in this fee schedule',
    `rate_percent` DECIMAL(18,2) COMMENT 'The rate percent attribute value for this fee schedule record in the franchise domain',
    `royalty_rate_pct` DECIMAL(18,2) COMMENT 'The royalty rate pct attribute value for this fee schedule record in the franchise domain',
    `technology_fee_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for technology fee in this fee schedule',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Fee schedules defining the various fees (royalty, marketing, technology) applicable to franchise agreements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'Unique identifier for the training enrollment',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the primary training employee associated with this training enrollment record',
    `training_employee_id` BIGINT COMMENT 'FK to the employee being trained',
    `training_trainer_employee_id` BIGINT COMMENT 'FK to the trainer',
    `unit_id` BIGINT COMMENT 'FK to the restaurant unit where training occurs',
    `actual_completion_date` DATE COMMENT 'The date and time when the actual completion event occurred for this training enrollment',
    `certification_expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the certification expiration event occurred for this training enrollment',
    `certification_issued` BOOLEAN COMMENT 'Whether a certification was issued',
    `compliance_flag` BOOLEAN COMMENT 'Whether training meets compliance requirements',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_until` DATE COMMENT 'The effective until attribute value for this training enrollment record in the franchise domain',
    `enrollment_date` TIMESTAMP COMMENT 'Date of enrollment',
    `enrollment_number` STRING COMMENT 'Business reference number',
    `hours_completed` DECIMAL(18,2) COMMENT 'Training hours completed',
    `hours_required` DECIMAL(18,2) COMMENT 'Total training hours required',
    `notes` STRING COMMENT 'Free-text notes',
    `pass_fail_status` STRING COMMENT 'Whether the trainee passed or failed',
    `scheduled_completion_date` DATE COMMENT 'Expected completion date',
    `score` DECIMAL(18,2) COMMENT 'Assessment score',
    `training_enrollment_status` STRING COMMENT 'Status of the enrollment',
    `training_type` STRING COMMENT 'Type of training program',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Training enrollments for franchise employees tracking required training programs, completion, and certification.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` (
    `franchise_remodel_project_id` BIGINT COMMENT 'Unique identifier for the remodel project',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee',
    `unit_id` BIGINT COMMENT 'FK to the restaurant unit being remodeled',
    `remodel_project_id` BIGINT COMMENT 'FK to the corresponding real estate remodel project',
    `actual_completion_date` DATE COMMENT 'The date and time when the actual completion event occurred for this franchise remodel project',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cost attribute value for this franchise remodel project record in the franchise domain',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual cost incurred',
    `actual_start_date` DATE COMMENT 'The date and time when the actual start event occurred for this franchise remodel project',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount',
    `completion_date` DATE COMMENT 'The date and time when the completion event occurred for this franchise remodel project',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'ISO currency code',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The estimated cost attribute value for this franchise remodel project record in the franchise domain',
    `is_complete` BOOLEAN COMMENT 'Whether the project is complete',
    `percent_complete` DECIMAL(18,2) COMMENT 'Percentage of project completed',
    `planned_completion_date` DATE COMMENT 'The date and time when the planned completion event occurred for this franchise remodel project',
    `planned_end_date` DATE COMMENT 'The date and time when the planned end event occurred for this franchise remodel project',
    `planned_start_date` DATE COMMENT 'The date and time when the planned start event occurred for this franchise remodel project',
    `project_code` STRING COMMENT 'Project reference code',
    `project_name` STRING COMMENT 'Name of the remodel project',
    `project_status` STRING COMMENT 'Current status of the project',
    `remodel_type` STRING COMMENT 'Type of remodel (full, partial, refresh)',
    `scope_description` STRING COMMENT 'Description of the remodel scope',
    `start_date` DATE COMMENT 'The date and time when the start event occurred for this franchise remodel project',
    `franchise_remodel_project_status` STRING COMMENT 'The current status of the franchise remodel project for this franchise remodel project',
    `target_completion_date` DATE COMMENT 'The date and time when the target completion event occurred for this franchise remodel project',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_franchise_remodel_project PRIMARY KEY(`franchise_remodel_project_id`)
) COMMENT 'Remodel projects for franchise restaurant units tracking scope, budget, timeline, and completion status.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` (
    `transfer_event_id` BIGINT COMMENT 'Unique identifier for the transfer event',
    `agreement_id` BIGINT COMMENT 'FK to the franchise agreement being transferred',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee transferring ownership',
    `employee_id` BIGINT COMMENT 'FK to the employee who approved the transfer',
    `transfer_employee_id` BIGINT COMMENT 'Unique identifier referencing the transfer employee associated with this transfer event record',
    `compliance_review_date` DATE COMMENT 'The date and time when the compliance review event occurred for this transfer event',
    `compliance_status` STRING COMMENT 'Compliance status of the transfer',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'ISO currency code',
    `effective_transfer_date` DATE COMMENT 'Date the transfer becomes effective',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp attribute value for this transfer event record in the franchise domain',
    `fdd_redisclosure_date` DATE COMMENT 'The date and time when the fdd redisclosure event occurred for this transfer event',
    `franchisor_approval_date` DATE COMMENT 'Date franchisor approved the transfer',
    `marketing_fee_percent` DECIMAL(18,2) COMMENT 'The marketing fee percent attribute value for this transfer event record in the franchise domain',
    `new_territory_code` STRING COMMENT 'A standardized code representing the new territory classification for this transfer event',
    `notes` STRING COMMENT 'Free-text notes',
    `previous_territory_code` STRING COMMENT 'A standardized code representing the previous territory classification for this transfer event',
    `right_of_first_refusal_exercised_flag` BOOLEAN COMMENT 'Boolean indicator flag for right of first refusal exercised flag status in this transfer event',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The royalty rate percent attribute value for this transfer event record in the franchise domain',
    `total_transfer_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the transfer',
    `transfer_conditions` STRING COMMENT 'The transfer conditions attribute value for this transfer event record in the franchise domain',
    `transfer_event_status` STRING COMMENT 'Status of the transfer event',
    `transfer_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for the transfer',
    `transfer_fee_due_date` DATE COMMENT 'The date and time when the transfer fee due event occurred for this transfer event',
    `transfer_fee_paid_flag` BOOLEAN COMMENT 'Whether the transfer fee has been paid',
    `transfer_fee_tax_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for transfer fee tax in this transfer event',
    `transfer_number` STRING COMMENT 'Business reference number',
    `transfer_reason` STRING COMMENT 'Reason for the transfer',
    `transfer_type` STRING COMMENT 'Type of transfer (sale, inheritance, corporate restructure)',
    `units_transferred` STRING COMMENT 'Number of units being transferred',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_transfer_event PRIMARY KEY(`transfer_event_id`)
) COMMENT 'Transfer events recording the transfer of franchise ownership from one franchisee to another.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` (
    `renewal_event_id` BIGINT COMMENT 'Unique identifier for the renewal event',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee',
    `agreement_id` BIGINT COMMENT 'FK to the original agreement being renewed',
    `compliance_review_flag` BOOLEAN COMMENT 'Whether compliance review was conducted',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_from` DATE COMMENT 'Start date of the renewed term',
    `effective_until` DATE COMMENT 'End date of the renewed term',
    `fdd_redisclosure_timestamp` TIMESTAMP COMMENT 'The fdd redisclosure timestamp attribute value for this renewal event record in the franchise domain',
    `franchisor_approval_timestamp` TIMESTAMP COMMENT 'The franchisor approval timestamp attribute value for this renewal event record in the franchise domain',
    `ftc_compliance_attestation_flag` BOOLEAN COMMENT 'Whether FTC compliance was attested',
    `notes` STRING COMMENT 'Free-text notes',
    `renewal_application_timestamp` TIMESTAMP COMMENT 'The renewal application timestamp attribute value for this renewal event record in the franchise domain',
    `renewal_event_status` STRING COMMENT 'Status of the renewal event',
    `renewal_execution_timestamp` TIMESTAMP COMMENT 'The renewal execution timestamp attribute value for this renewal event record in the franchise domain',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for renewal',
    `renewal_fee_currency` STRING COMMENT 'The renewal fee currency attribute value for this renewal event record in the franchise domain',
    `renewal_fee_paid_flag` BOOLEAN COMMENT 'Whether the renewal fee has been paid',
    `renewal_fee_payment_date` DATE COMMENT 'Date the renewal fee was paid',
    `renewal_number` STRING COMMENT 'Business reference number',
    `renewal_term_years` STRING COMMENT 'Length of the renewal term in years',
    `updated_royalty_rate_percent` DECIMAL(18,2) COMMENT 'New royalty rate if changed',
    `updated_territory_code` STRING COMMENT 'A standardized code representing the updated territory classification for this renewal event',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_renewal_event PRIMARY KEY(`renewal_event_id`)
) COMMENT 'Renewal events tracking the renewal of franchise agreements including terms, fees, and compliance review.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` (
    `termination_event_id` BIGINT COMMENT 'Unique identifier for the termination event',
    `agreement_id` BIGINT COMMENT 'FK to the agreement being terminated',
    `compliance_review_date` DATE COMMENT 'The date and time when the compliance review event occurred for this termination event',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this termination event',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cure_period_end_date` DATE COMMENT 'End date of the cure period',
    `effective_termination_date` DATE COMMENT 'Date termination becomes effective',
    `ftc_compliance_attestation_flag` BOOLEAN COMMENT 'Whether FTC compliance was attested',
    `legal_dispute_flag` BOOLEAN COMMENT 'Whether there is a legal dispute',
    `notes` STRING COMMENT 'Free-text notes',
    `notice_date` DATE COMMENT 'Date termination notice was given',
    `outstanding_royalty_balance` DECIMAL(18,2) COMMENT 'Outstanding royalty balance at termination',
    `outstanding_royalty_currency_code` STRING COMMENT 'A standardized code representing the outstanding royalty currency classification for this termination event',
    `post_termination_obligation` STRING COMMENT 'Post-termination obligations',
    `termination_cure_period_days` STRING COMMENT 'Number of days in the cure period',
    `termination_event_status` STRING COMMENT 'Status of the termination event',
    `termination_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for termination',
    `termination_fee_currency_code` STRING COMMENT 'A standardized code representing the termination fee currency classification for this termination event',
    `termination_notice_method` STRING COMMENT 'The termination notice method attribute value for this termination event record in the franchise domain',
    `termination_reason` STRING COMMENT 'Reason for termination',
    `termination_type` STRING COMMENT 'Type of termination (voluntary, involuntary, mutual)',
    `units_affected` STRING COMMENT 'Number of units affected by termination',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_termination_event PRIMARY KEY(`termination_event_id`)
) COMMENT 'Termination events recording the termination of franchise agreements including reason, notice, and financial obligations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` (
    `performance_scorecard_id` DECIMAL(18,2) COMMENT 'Unique identifier for the scorecard',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'The average unit volume attribute value for this performance scorecard record in the franchise domain',
    `compliance_audit_average_score` DECIMAL(18,2) COMMENT 'Average compliance audit score',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `customer_satisfaction_score` DECIMAL(18,2) COMMENT 'The customer satisfaction score attribute value for this performance scorecard record in the franchise domain',
    `evaluation_month` STRING COMMENT 'The evaluation month attribute value for this performance scorecard record in the franchise domain',
    `evaluation_period_end` DATE COMMENT 'End of evaluation period',
    `evaluation_period_start` DATE COMMENT 'Start of evaluation period',
    `evaluation_status` STRING COMMENT 'Status of the evaluation',
    `evaluation_type` STRING COMMENT 'Type of evaluation',
    `evaluation_year` STRING COMMENT 'The evaluation year attribute value for this performance scorecard record in the franchise domain',
    `food_safety_score` DECIMAL(18,2) COMMENT 'Food safety audit score',
    `net_promoter_score` DECIMAL(18,2) COMMENT 'The net promoter score attribute value for this performance scorecard record in the franchise domain',
    `notes` STRING COMMENT 'Free-text notes',
    `number_of_restaurants` STRING COMMENT 'Number of restaurants operated',
    `overall_performance_tier` STRING COMMENT 'Overall performance tier (A, B, C, D)',
    `region_code` STRING COMMENT 'A standardized code representing the region classification for this performance scorecard',
    `royalty_payment_timeliness_pct` DECIMAL(18,2) COMMENT 'Percentage of royalty payments made on time',
    `same_store_sales_growth_pct` DECIMAL(18,2) COMMENT 'Same-store sales growth percentage',
    `total_royalty_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for total royalty in this performance scorecard',
    `total_sales_amount` DECIMAL(18,2) COMMENT 'Total sales in the period',
    `training_completion_rate_pct` DECIMAL(18,2) COMMENT 'Training completion rate',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_performance_scorecard PRIMARY KEY(`performance_scorecard_id`)
) COMMENT 'Performance scorecards evaluating franchisee performance across multiple dimensions including sales, compliance, and customer satisfaction.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` (
    `fdd_disclosure_id` BIGINT COMMENT 'Unique identifier for the FDD disclosure',
    `prospect_id` BIGINT COMMENT 'FK to the prospect receiving the FDD',
    `fdd_recipient_prospect_id` BIGINT COMMENT 'Unique identifier for the fdd recipient prospect associated with this fdd disclosure',
    `acknowledgment_received_date` DATE COMMENT 'Date acknowledgment was received',
    `compliance_review_date` DATE COMMENT 'The date and time when the compliance review event occurred for this fdd disclosure',
    `compliance_review_status` STRING COMMENT 'The current status of the compliance review for this fdd disclosure',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_date` DATE COMMENT 'Date the FDD was delivered',
    `document_title` STRING COMMENT 'The document title attribute value for this fdd disclosure record in the franchise domain',
    `document_type` STRING COMMENT 'The classification type for document in this fdd disclosure',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this fdd disclosure',
    `fdd_disclosure_status` STRING COMMENT 'Status of the disclosure',
    `fdd_document_url` STRING COMMENT 'URL to the FDD document',
    `fdd_version_number` STRING COMMENT 'Version number of the FDD',
    `material_change_description` STRING COMMENT 'Description of material changes',
    `material_change_flag` BOOLEAN COMMENT 'Whether there were material changes',
    `notes` STRING COMMENT 'Free-text notes',
    `recipient_type` STRING COMMENT 'The classification type for recipient in this fdd disclosure',
    `state_code` STRING COMMENT 'State where disclosure was made',
    `state_registration_status` DECIMAL(18,2) COMMENT 'The current status of the state registration for this fdd disclosure',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `version_year` STRING COMMENT 'Year of the FDD version',
    `waiting_period_end_date` DATE COMMENT 'End of the mandatory waiting period',
    `waiting_period_start_date` DATE COMMENT 'Start of the mandatory waiting period',
    CONSTRAINT pk_fdd_disclosure PRIMARY KEY(`fdd_disclosure_id`)
) COMMENT 'Franchise Disclosure Document (FDD) records tracking the delivery and acknowledgment of disclosure documents to prospects.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`prospect` (
    `prospect_id` BIGINT COMMENT 'Unique identifier for the prospect',
    `employee_id` BIGINT COMMENT 'FK to the assigned franchise consultant',
    `address_line1` STRING COMMENT 'Primary address',
    `address_line2` STRING COMMENT 'The address line2 attribute value for this prospect record in the franchise domain',
    `application_status` STRING COMMENT 'Status of the franchise application',
    `application_submitted_date` DATE COMMENT 'The date and time when the application submitted event occurred for this prospect',
    `background_check_date` DATE COMMENT 'The date and time when the background check event occurred for this prospect',
    `background_check_status` STRING COMMENT 'Status of background check',
    `city` STRING COMMENT 'The city attribute value for this prospect record in the franchise domain',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator flag for compliance flag status in this prospect',
    `contact_email` STRING COMMENT 'Email address of the prospect',
    `contact_phone` STRING COMMENT 'Phone number of the prospect',
    `country_code` STRING COMMENT 'ISO country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `discovery_day_attended` BOOLEAN COMMENT 'Whether prospect attended discovery day',
    `discovery_day_date` DATE COMMENT 'The date and time when the discovery day event occurred for this prospect',
    `estimated_initial_investment` DECIMAL(18,2) COMMENT 'The estimated initial investment attribute value for this prospect record in the franchise domain',
    `estimated_initial_investment_currency` STRING COMMENT 'The estimated initial investment currency attribute value for this prospect record in the franchise domain',
    `expected_open_date` DATE COMMENT 'The date and time when the expected open event occurred for this prospect',
    `fdd_disclosure_date` DATE COMMENT 'The date and time when the fdd disclosure event occurred for this prospect',
    `fdd_sent_flag` BOOLEAN COMMENT 'Whether FDD has been sent',
    `franchise_type_preference` STRING COMMENT 'Preferred franchise type',
    `last_contact_date` DATE COMMENT 'Date of last contact',
    `last_contact_method` STRING COMMENT 'The last contact method attribute value for this prospect record in the franchise domain',
    `legal_entity_type` STRING COMMENT 'The classification type for legal entity in this prospect',
    `liquid_capital_amount` DECIMAL(18,2) COMMENT 'Available liquid capital',
    `liquid_capital_currency` STRING COMMENT 'The liquid capital currency attribute value for this prospect record in the franchise domain',
    `prospect_name` STRING COMMENT 'Name of the prospect',
    `net_worth_amount` DECIMAL(18,2) COMMENT 'Declared net worth',
    `net_worth_currency` STRING COMMENT 'The net worth currency attribute value for this prospect record in the franchise domain',
    `notes` STRING COMMENT 'Free-text notes',
    `pipeline_stage` STRING COMMENT 'Current stage in the franchise sales pipeline',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification for this prospect',
    `prospect_status` STRING COMMENT 'Status of the prospect',
    `source_channel` STRING COMMENT 'How the prospect was sourced',
    `source_detail` STRING COMMENT 'The source detail attribute value for this prospect record in the franchise domain',
    `state` STRING COMMENT 'The state attribute value for this prospect record in the franchise domain',
    `territory_preference` STRING COMMENT 'Preferred territory',
    `updated_by` STRING COMMENT 'The updated by attribute value for this prospect record in the franchise domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `created_by` STRING COMMENT 'The created by attribute value for this prospect record in the franchise domain',
    CONSTRAINT pk_prospect PRIMARY KEY(`prospect_id`)
) COMMENT 'Franchise prospects representing potential franchisees in the sales pipeline from initial inquiry through approval.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` (
    `area_representative_id` BIGINT COMMENT 'Unique identifier for the area representative',
    `territory_id` BIGINT COMMENT 'FK to the assigned territory',
    `area_representative_status` STRING COMMENT 'Current status',
    `average_unit_volume_target` DECIMAL(18,2) COMMENT 'The average unit volume target attribute value for this area representative record in the franchise domain',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for base salary in this area representative',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Commission rate percentage',
    `compensation_type` STRING COMMENT 'The classification type for compensation in this area representative',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this area representative',
    `created_by_user` STRING COMMENT 'The created by user attribute value for this area representative record in the franchise domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'End date of assignment',
    `effective_start_date` DATE COMMENT 'Start date of assignment',
    `email_address` STRING COMMENT 'The email address attribute value for this area representative record in the franchise domain',
    `external_reference_number` STRING COMMENT 'The external reference number attribute value for this area representative record in the franchise domain',
    `fee_structure_description` STRING COMMENT 'The fee structure description attribute value for this area representative record in the franchise domain',
    `full_name` STRING COMMENT 'Full name of the area representative',
    `last_compliance_review_date` DATE COMMENT 'The date and time when the last compliance review event occurred for this area representative',
    `market_segment` STRING COMMENT 'The market segment attribute value for this area representative record in the franchise domain',
    `notes` STRING COMMENT 'Free-text notes',
    `number_of_franchisees_managed` STRING COMMENT 'The number of franchisees managed attribute value for this area representative record in the franchise domain',
    `performance_score` DECIMAL(18,2) COMMENT 'The performance score attribute value for this area representative record in the franchise domain',
    `phone_number` STRING COMMENT 'The phone number attribute value for this area representative record in the franchise domain',
    `primary_contact_method` STRING COMMENT 'The primary contact method attribute value for this area representative record in the franchise domain',
    `region_code` STRING COMMENT 'A standardized code representing the region classification for this area representative',
    `role_type` STRING COMMENT 'Type of role',
    `royalty_fee_cap_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for royalty fee cap in this area representative',
    `royalty_split_percent` DECIMAL(18,2) COMMENT 'Percentage of royalty split',
    `training_completed_flag` BOOLEAN COMMENT 'Whether required training is complete',
    `updated_by_user` STRING COMMENT 'The updated by user attribute value for this area representative record in the franchise domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_area_representative PRIMARY KEY(`area_representative_id`)
) COMMENT 'Area representatives who manage and support franchisees within assigned territories on behalf of the franchisor.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` (
    `support_visit_id` BIGINT COMMENT 'Unique identifier for the support visit',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee',
    `employee_id` BIGINT COMMENT 'FK to the consulting employee',
    `support_employee_id` BIGINT COMMENT 'Unique identifier referencing the support employee associated with this support visit record',
    `unit_id` BIGINT COMMENT 'Unique identifier for the support store unit associated with this support visit',
    `support_unit_id` BIGINT COMMENT 'FK to the restaurant unit visited',
    `action_items` STRING COMMENT 'Action items identified',
    `city` STRING COMMENT 'The city attribute value for this support visit record in the franchise domain',
    `compliance_flag` BOOLEAN COMMENT 'Whether compliance issues were found',
    `compliance_score` DECIMAL(18,2) COMMENT 'Compliance score from the visit',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this support visit',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this support visit',
    `equipment_inspected_flag` BOOLEAN COMMENT 'Boolean indicator flag for equipment inspected flag status in this support visit',
    `equipment_issue_count` STRING COMMENT 'The count or quantity of equipment issue items in this support visit',
    `expense_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for expense in this support visit',
    `expense_category` STRING COMMENT 'The expense category attribute value for this support visit record in the franchise domain',
    `follow_up_required` BOOLEAN COMMENT 'Whether follow-up is needed',
    `is_training_visit` BOOLEAN COMMENT 'Whether this was a training visit',
    `notes` STRING COMMENT 'Free-text notes',
    `region` STRING COMMENT 'The region attribute value for this support visit record in the franchise domain',
    `sales_impact_estimate` DECIMAL(18,2) COMMENT 'The sales impact estimate attribute value for this support visit record in the franchise domain',
    `satisfaction_rating` STRING COMMENT 'The satisfaction rating attribute value for this support visit record in the franchise domain',
    `state_province` STRING COMMENT 'The state province attribute value for this support visit record in the franchise domain',
    `support_visit_status` STRING COMMENT 'Status of the visit',
    `topics_covered` STRING COMMENT 'Topics covered during the visit',
    `training_topic` STRING COMMENT 'The training topic attribute value for this support visit record in the franchise domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `visit_duration_minutes` DECIMAL(18,2) COMMENT 'Duration of the visit in minutes',
    `visit_number` STRING COMMENT 'Business reference number',
    `visit_timestamp` TIMESTAMP COMMENT 'When the visit occurred',
    `visit_type` STRING COMMENT 'Type of visit (routine, follow-up, training)',
    `waste_percentage` DECIMAL(18,2) COMMENT 'The waste percentage attribute value for this support visit record in the franchise domain',
    CONSTRAINT pk_support_visit PRIMARY KEY(`support_visit_id`)
) COMMENT 'Support visits conducted by franchise consultants to franchisee locations for operational support, training, and compliance review.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` (
    `marketing_fund_contribution_id` BIGINT COMMENT 'Unique identifier for the contribution',
    `franchisee_id` BIGINT COMMENT 'FK to the contributing franchisee',
    `calculation_basis` STRING COMMENT 'Basis for calculation (gross sales, net sales)',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Calculated contribution amount',
    `contribution_date` DATE COMMENT 'The date and time when the contribution event occurred for this marketing fund contribution',
    `contribution_number` STRING COMMENT 'Business reference number',
    `contribution_percent` DECIMAL(18,2) COMMENT 'The contribution percent attribute value for this marketing fund contribution record in the franchise domain',
    `contribution_period` STRING COMMENT 'The contribution period attribute value for this marketing fund contribution record in the franchise domain',
    `contribution_period_end` DATE COMMENT 'End of the contribution period',
    `contribution_period_start` DATE COMMENT 'Start of the contribution period',
    `contribution_rate` DECIMAL(18,2) COMMENT 'The contribution rate attribute value for this marketing fund contribution record in the franchise domain',
    `contribution_rate_pct` DECIMAL(18,2) COMMENT 'Contribution rate as a percentage',
    `contribution_rate_percent` DECIMAL(18,2) COMMENT 'The contribution rate percent attribute value for this marketing fund contribution record in the franchise domain',
    `contribution_status` STRING COMMENT 'Status of the contribution',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency` STRING COMMENT 'The currency attribute value for this marketing fund contribution record in the franchise domain',
    `currency_code` STRING COMMENT 'ISO currency code',
    `due_date` DATE COMMENT 'Payment due date',
    `gross_sales` DECIMAL(18,2) COMMENT 'The gross sales attribute value for this marketing fund contribution record in the franchise domain',
    `gross_sales_base` DECIMAL(18,2) COMMENT 'The gross sales base attribute value for this marketing fund contribution record in the franchise domain',
    `gross_sales_basis` DECIMAL(18,2) COMMENT 'The gross sales basis attribute value for this marketing fund contribution record in the franchise domain',
    `gross_sales_basis_amount` DECIMAL(18,2) COMMENT 'Gross sales amount used as calculation basis',
    `is_paid` BOOLEAN COMMENT 'Whether the contribution has been paid',
    `paid_date` DATE COMMENT 'The date and time when the paid event occurred for this marketing fund contribution',
    `payment_date` DATE COMMENT 'Date payment was made',
    `payment_status` STRING COMMENT 'The current status of the payment for this marketing fund contribution',
    `sales_basis_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for sales basis in this marketing fund contribution',
    `marketing_fund_contribution_status` STRING COMMENT 'The current status of the marketing fund contribution for this marketing fund contribution',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_marketing_fund_contribution PRIMARY KEY(`marketing_fund_contribution_id`)
) COMMENT 'Marketing fund contributions collected from franchisees based on gross sales for cooperative advertising and brand marketing.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` (
    `lease_agreement_id` BIGINT COMMENT 'Unique identifier for the lease agreement',
    `franchisee_id` BIGINT COMMENT 'FK to the franchisee',
    `landlord_id` BIGINT COMMENT 'FK to the landlord',
    `unit_id` BIGINT COMMENT 'FK to the restaurant unit',
    `site_id` BIGINT COMMENT 'FK to the real estate site',
    `base_rent_amount` DECIMAL(18,2) COMMENT 'Base monthly rent amount',
    `cam_charge_amount` DECIMAL(18,2) COMMENT 'Common area maintenance charges',
    `lease_agreement_code` STRING COMMENT 'Business reference code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency` STRING COMMENT 'The currency attribute value for this lease agreement record in the franchise domain',
    `currency_code` STRING COMMENT 'ISO currency code',
    `end_date` DATE COMMENT 'The date and time when the end event occurred for this lease agreement',
    `is_active` BOOLEAN COMMENT 'Whether the lease is currently active',
    `lease_end_date` DATE COMMENT 'Lease expiration date',
    `lease_number` STRING COMMENT 'The lease number attribute value for this lease agreement record in the franchise domain',
    `lease_start_date` DATE COMMENT 'Lease commencement date',
    `lease_status` STRING COMMENT 'Current status of the lease',
    `lease_term_months` STRING COMMENT 'Total lease term in months',
    `lease_type` STRING COMMENT 'Type of lease (gross, net, triple-net, percentage)',
    `monthly_rent` DECIMAL(18,2) COMMENT 'The monthly rent attribute value for this lease agreement record in the franchise domain',
    `monthly_rent_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for monthly rent in this lease agreement',
    `percentage_rent_rate` DECIMAL(18,2) COMMENT 'Percentage rent rate if applicable',
    `renewal_option` STRING COMMENT 'The renewal option attribute value for this lease agreement record in the franchise domain',
    `renewal_option_count` STRING COMMENT 'Number of renewal options',
    `renewal_option_term_months` STRING COMMENT 'Term of each renewal option in months',
    `rent_escalation_rate` DECIMAL(18,2) COMMENT 'Annual rent escalation rate',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for security deposit in this lease agreement',
    `start_date` DATE COMMENT 'The date and time when the start event occurred for this lease agreement',
    `lease_agreement_status` STRING COMMENT 'The current status of the lease agreement for this lease agreement',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_lease_agreement PRIMARY KEY(`lease_agreement_id`)
) COMMENT 'Lease agreements for franchise restaurant locations linking franchisees to their real estate leases.';

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
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `area_representative_id` SET TAGS ('dbx_business_glossary_term' = 'Area Representative ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'DBA Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `fdd_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'FDD Disclosure Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `food_safety_certified` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certified');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchise_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_number` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_status` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `franchisee_type` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `ifa_membership_status` SET TAGS ('dbx_business_glossary_term' = 'IFA Membership Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Units');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `royalty_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_tax_number` SET TAGS ('dbx_business_glossary_term' = 'State Tax Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_tax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `state_tax_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_business_glossary_term' = 'Tax ID EIN');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchisee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisor Legal Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `ftc_compliance_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Attestation Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `initial_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `marketing_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fee Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Years');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `sales_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `transfer_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Rights Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `area_sq_miles` SET TAGS ('dbx_business_glossary_term' = 'Area Square Miles');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `dma` SET TAGS ('dbx_business_glossary_term' = 'DMA');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `franchise_fee` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry WKT');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `median_income` SET TAGS ('dbx_business_glossary_term' = 'Median Income');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `median_income` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `number_of_locations` SET TAGS ('dbx_business_glossary_term' = 'Number of Locations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `population` SET TAGS ('dbx_business_glossary_term' = 'Population');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Radius Miles');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `trade_area_classification` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Classification');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `zip_codes` SET TAGS ('dbx_business_glossary_term' = 'Zip Codes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`territory` ALTER COLUMN `zip_codes` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Billing ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `balance_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Balance Outstanding');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `billing_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Is Paid');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `marketing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Paid Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `technology_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Technology Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`billing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `sales_report_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Report ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `sales_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `sales_report_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Report Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `same_store_sales` SET TAGS ('dbx_business_glossary_term' = 'Same Store Sales');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`sales_report` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` SET TAGS ('dbx_subdomain' = 'development_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `nro_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'NRO Pipeline ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Consultant Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `nro_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `nro_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `nro_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `actual_capex_spent` SET TAGS ('dbx_business_glossary_term' = 'Actual Capex Spent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `actual_open_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Open Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `budget_capex` SET TAGS ('dbx_business_glossary_term' = 'Budget Capex');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `capital_investment_estimate` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment Estimate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `construction_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Construction Complete Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `development_type` SET TAGS ('dbx_business_glossary_term' = 'Development Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_roi` SET TAGS ('dbx_business_glossary_term' = 'Expected ROI');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `last_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `last_milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `last_milestone_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `last_milestone_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `permits_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Permits Obtained Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `project_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Stage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `target_open_date` SET TAGS ('dbx_business_glossary_term' = 'Target Open Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `training_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Complete Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`nro_pipeline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` SET TAGS ('dbx_subdomain' = 'development_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `development_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `cure_period_months` SET TAGS ('dbx_business_glossary_term' = 'Cure Period Months');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `development_phase` SET TAGS ('dbx_business_glossary_term' = 'Development Phase');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `development_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `target_units_year_1` SET TAGS ('dbx_business_glossary_term' = 'Target Units Year 1');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `target_units_year_2` SET TAGS ('dbx_business_glossary_term' = 'Target Units Year 2');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `target_units_year_3` SET TAGS ('dbx_business_glossary_term' = 'Target Units Year 3');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `total_units_committed` SET TAGS ('dbx_business_glossary_term' = 'Total Units Committed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `units_opened_to_date` SET TAGS ('dbx_business_glossary_term' = 'Units Opened to Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `units_remaining` SET TAGS ('dbx_business_glossary_term' = 'Units Remaining');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`development_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` SET TAGS ('dbx_subdomain' = 'compliance_support');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_location_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `brand_standards_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Standards Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `cleanliness_score` SET TAGS ('dbx_business_glossary_term' = 'Cleanliness Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Violations Count');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `food_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `non_critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Critical Violations Count');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `service_score` SET TAGS ('dbx_business_glossary_term' = 'Service Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`compliance_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_subdomain' = 'compliance_support');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_canonical' = 'foodsafety.foodsafety_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot' = 'deprecated_duplicate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_canonical_of' = 'foodsafety.foodsafety_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_of' = 'foodsafety.foodsafety_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_source' = 'foodsafety.foodsafety_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_ref' = 'foodsafety.foodsafety_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_context' = 'franchise_compliance_audit_findings');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_duplicate' = 'foodsafety.foodsafety_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_master' = 'foodsafety.foodsafety_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` SET TAGS ('dbx_ssot_deprecated_duplicate' = 'foodsafety.foodsafety_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `franchise_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Corrective Action ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `foodsafety_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Corrective Action ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Action Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `issue_category` SET TAGS ('dbx_business_glossary_term' = 'Issue Category');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_corrective_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` SET TAGS ('dbx_subdomain' = 'agreement_lifecycle');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `fee_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `fee_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `fee_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `minimum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'compliance_support');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_trainer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainer Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_trainer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_trainer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Hours Completed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `hours_required` SET TAGS ('dbx_business_glossary_term' = 'Hours Required');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`training_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_subdomain' = 'development_operations');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_ssot_canonical' = 'realestate.realestate_remodel_project');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_ssot_role' = 'source_of_truth');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_ssot_pair' = 'realestate.realestate_remodel_project');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_ssot_ref' = 'realestate.realestate_remodel_project');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_ssot_context' = 'franchisee_funded_remodel_projects');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_ssot_duplicate' = 'realestate.realestate_remodel_project');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` SET TAGS ('dbx_ssot_canonical' = 'realestate.realestate_remodel_project');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `franchise_remodel_project_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Remodel Project ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `remodel_project_id` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Remodel Project ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `is_complete` SET TAGS ('dbx_business_glossary_term' = 'Is Complete');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `project_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `remodel_type` SET TAGS ('dbx_business_glossary_term' = 'Remodel Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`franchise_remodel_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` SET TAGS ('dbx_subdomain' = 'agreement_lifecycle');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Event ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Transferor Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `effective_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Transfer Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `franchisor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Franchisor Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `total_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_event_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Event Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Paid Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `units_transferred` SET TAGS ('dbx_business_glossary_term' = 'Units Transferred');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`transfer_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` SET TAGS ('dbx_subdomain' = 'agreement_lifecycle');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Event ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Original Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `ftc_compliance_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Attestation Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_event_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Event Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Paid Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Years');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `updated_royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Updated Royalty Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`renewal_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` SET TAGS ('dbx_subdomain' = 'agreement_lifecycle');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_event_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Event ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `cure_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `effective_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Termination Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `ftc_compliance_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Attestation Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `legal_dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Dispute Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `outstanding_royalty_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Royalty Balance');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `post_termination_obligation` SET TAGS ('dbx_business_glossary_term' = 'Post Termination Obligation');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Cure Period Days');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_event_status` SET TAGS ('dbx_business_glossary_term' = 'Termination Event Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Termination Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `units_affected` SET TAGS ('dbx_business_glossary_term' = 'Units Affected');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`termination_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `compliance_audit_average_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Average Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `food_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `number_of_restaurants` SET TAGS ('dbx_business_glossary_term' = 'Number of Restaurants');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `overall_performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Tier');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `royalty_payment_timeliness_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Timeliness Pct');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `same_store_sales_growth_pct` SET TAGS ('dbx_business_glossary_term' = 'Same Store Sales Growth Pct');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `total_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `training_completion_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Rate Pct');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`performance_scorecard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'FDD Disclosure ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `acknowledgment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `document_title` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'FDD Disclosure Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_document_url` SET TAGS ('dbx_business_glossary_term' = 'FDD Document URL');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `fdd_version_number` SET TAGS ('dbx_business_glossary_term' = 'FDD Version Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `material_change_description` SET TAGS ('dbx_business_glossary_term' = 'Material Change Description');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `material_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Change Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `state_registration_status` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `version_year` SET TAGS ('dbx_business_glossary_term' = 'Version Year');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `waiting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`fdd_disclosure` ALTER COLUMN `waiting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Consultant Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `discovery_day_attended` SET TAGS ('dbx_business_glossary_term' = 'Discovery Day Attended');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `fdd_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'FDD Sent Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `franchise_type_preference` SET TAGS ('dbx_business_glossary_term' = 'Franchise Type Preference');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `liquid_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquid Capital Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `net_worth_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Worth Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_business_glossary_term' = 'Prospect Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `territory_preference` SET TAGS ('dbx_business_glossary_term' = 'Territory Preference');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`prospect` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `area_representative_id` SET TAGS ('dbx_business_glossary_term' = 'Area Representative ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `area_representative_status` SET TAGS ('dbx_business_glossary_term' = 'Area Representative Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `number_of_franchisees_managed` SET TAGS ('dbx_business_glossary_term' = 'Number of Franchisees Managed');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `royalty_split_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Split Percent');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`area_representative` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` SET TAGS ('dbx_subdomain' = 'compliance_support');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Support Visit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Consultant Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `action_items` SET TAGS ('dbx_business_glossary_term' = 'Action Items');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Required');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `is_training_visit` SET TAGS ('dbx_business_glossary_term' = 'Is Training Visit');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `support_visit_status` SET TAGS ('dbx_business_glossary_term' = 'Support Visit Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Topics Covered');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `visit_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Visit Duration Minutes');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`support_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` SET TAGS ('dbx_subdomain' = 'financial_reporting');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `marketing_fund_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Contribution ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Contribution Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `contribution_number` SET TAGS ('dbx_business_glossary_term' = 'Contribution Number');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `contribution_period_end` SET TAGS ('dbx_business_glossary_term' = 'Contribution Period End');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `contribution_period_start` SET TAGS ('dbx_business_glossary_term' = 'Contribution Period Start');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `contribution_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Contribution Rate Pct');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `contribution_status` SET TAGS ('dbx_business_glossary_term' = 'Contribution Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `gross_sales_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Basis Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Is Paid');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` SET TAGS ('dbx_subdomain' = 'agreement_lifecycle');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` SET TAGS ('dbx_association_edges' = 'franchise.franchisee,realestate.landlord');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Landlord ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `base_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `cam_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'CAM Charge Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Lease Term Months');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `percentage_rent_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Rate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `renewal_option_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Count');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `renewal_option_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Term Months');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `rent_escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `vibe_restaurants_v1`.`franchise`.`lease_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
