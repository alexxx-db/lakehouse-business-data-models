-- Schema for Domain: employer | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`employer` COMMENT 'Manages employer group accounts — the B2B commercial customers who sponsor health coverage for their employees. Owns group demographics, SIC classification, group size, ASO/fully-insured funding arrangements, ERISA status, GFC controls, employer-subscriber relationships, contribution strategies, renewal dates, and participation requirements. Supports group billing aggregation, renewal management, and broker/TPA associations. Source system: Facets or QNXT group management module.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group` (
    `group_id` BIGINT COMMENT 'Primary key for employer group',
    `employee_id` BIGINT COMMENT 'Employee ID of the assigned account executive',
    `group_underwriter_employee_id` BIGINT COMMENT 'Employee ID of the assigned underwriter',
    `parent_group_id` BIGINT COMMENT 'Reference to parent group for hierarchical group structures',
    `pool_id` BIGINT COMMENT 'FK to risk pool',
    `address_line1` STRING COMMENT 'Primary address line 1',
    `address_line2` STRING COMMENT 'Primary address line 2',
    `anniversary_date` DATE COMMENT 'Annual anniversary date for the group contract',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates if the group contract auto-renews',
    `average_claim_cost` DECIMAL(18,2) COMMENT 'Average claim cost for the group',
    `billing_frequency` STRING COMMENT 'Frequency of premium billing (monthly, quarterly, annual)',
    `blended_rating_flag` BOOLEAN COMMENT 'Indicates if group uses blended rating methodology',
    `city` STRING COMMENT 'City',
    `cobra_administrator` STRING COMMENT 'Entity responsible for COBRA administration',
    `contribution_strategy` STRING COMMENT 'Employer contribution strategy code',
    `country` STRING COMMENT 'Country',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data quality score for this record',
    `dba_name` STRING COMMENT 'Doing-business-as name',
    `domicile_state` STRING COMMENT 'State of domicile',
    `effective_date` DATE COMMENT 'Group effective date',
    `effective_end_date` DATE COMMENT 'Date when this record version ceased to be effective',
    `effective_start_date` DATE COMMENT 'Date when this record version became effective',
    `email_address` STRING COMMENT 'Primary email',
    `enrollment_count_ec` STRING COMMENT 'Employee+children enrollment count',
    `enrollment_count_ef` STRING COMMENT 'Employee+family enrollment count',
    `enrollment_count_eo` STRING COMMENT 'Employee-only enrollment count',
    `enrollment_count_es` STRING COMMENT 'Employee+spouse enrollment count',
    `erisa_status` STRING COMMENT 'ERISA plan status',
    `experience_rating_flag` BOOLEAN COMMENT 'Indicates if group is experience-rated',
    `fhir_last_updated` TIMESTAMP COMMENT 'Timestamp of last FHIR resource update',
    `fhir_profile_url` STRING COMMENT 'URL of the FHIR profile this resource conforms to',
    `fhir_resource_identifier` STRING COMMENT 'FHIR resource identifier for cross-system interoperability',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type for interoperability mapping (e.g., Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR resource version identifier',
    `fsa_eligible_flag` BOOLEAN COMMENT 'Indicates if group offers FSA-eligible plans',
    `funding_arrangement` STRING COMMENT 'Funding arrangement type',
    `gfc_code` BIGINT COMMENT 'Group financial code',
    `group_number` STRING COMMENT 'External group number',
    `group_status` STRING COMMENT 'Current group status',
    `headcount_current` STRING COMMENT 'Current headcount',
    `headcount_last_month` STRING COMMENT 'Headcount last month',
    `headcount_last_year` STRING COMMENT 'Headcount last year',
    `hra_eligible_flag` BOOLEAN COMMENT 'Indicates if group offers HRA-eligible plans',
    `hsa_eligible_flag` BOOLEAN COMMENT 'Indicates if group offers HSA-eligible plans',
    `industry_code` STRING COMMENT 'Industry classification code for the employer',
    `is_active` BOOLEAN COMMENT 'Indicates if the group record is currently active',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of last status change',
    `legal_name` STRING COMMENT 'Legal entity name',
    `line_of_business` STRING COMMENT 'Line of business',
    `manual_rating_flag` BOOLEAN COMMENT 'Indicates if group uses manual rating',
    `market_segment` STRING COMMENT 'Market segment classification',
    `master_entity_code` STRING COMMENT 'Master data management entity identifier for deduplication',
    `multi_site_flag` BOOLEAN COMMENT 'Indicates if employer has multiple locations',
    `naics_code` STRING COMMENT 'NAICS industry code',
    `original_effective_date` DATE COMMENT 'Original date when the group first became effective',
    `participation_requirement` STRING COMMENT 'Participation requirement description',
    `payment_terms` STRING COMMENT 'Payment terms for premium invoices (e.g., Net 30)',
    `phone_number` STRING COMMENT 'Primary phone',
    `postal_code` STRING COMMENT 'Postal code',
    `primary_contact_name` STRING COMMENT 'Name of primary contact at the employer',
    `primary_contact_title` STRING COMMENT 'Job title of primary contact at the employer',
    `probation_period_days` STRING COMMENT 'Probationary period in days before eligibility',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp when record was created in source system',
    `record_source_system` STRING COMMENT 'Source system that originated this record',
    `record_status` STRING COMMENT 'Status of the record (e.g., draft, validated, archived)',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp when record was last updated in source system',
    `record_version` STRING COMMENT 'Version number for optimistic concurrency control',
    `renewal_date` DATE COMMENT 'Next renewal date',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Risk adjustment factor',
    `section_125_plan_flag` BOOLEAN COMMENT 'Indicates if group has a Section 125 cafeteria plan',
    `sic_code` STRING COMMENT 'SIC industry code',
    `size_tier` STRING COMMENT 'Group size tier',
    `state` STRING COMMENT 'State',
    `tax_id_ein` STRING COMMENT 'Tax ID / EIN',
    `termination_date` DATE COMMENT 'Group termination date',
    `termination_reason` STRING COMMENT 'Reason for group termination if applicable',
    `union_flag` BOOLEAN COMMENT 'Indicates if group has union employees',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `waiting_period_days` STRING COMMENT 'Number of days new employees must wait before coverage begins',
    `website_url` STRING COMMENT 'Employer website URL',
    `wellness_program_flag` BOOLEAN COMMENT 'Indicates if group participates in wellness programs',
    CONSTRAINT pk_group PRIMARY KEY(`group_id`)
) COMMENT 'Master record for employer group accounts — the B2B commercial customers who sponsor health coverage for their employees. Captures group demographics, legal entity name, tax ID (EIN), SIC/NAICS industry classification, group size tier, historical headcount and enrollment counts by coverage tier (EO/ES/EC/EF) tracked at monthly intervals for ACA small/large group market classification, line of business (LOB), funding arrangement (fully-insured vs ASO), ERISA status, domicile state, effective and termination dates, group financial control (GFC) identifiers, and complete lifecycle status transitions (prospect, active, suspended, terminated, reinstated) with status history. Single source of truth for employer group identity, size classification, headcount history, and status history.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_location` (
    `group_location_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `network_service_area_id` BIGINT COMMENT 'FK to network service area',
    `facility_id` BIGINT COMMENT 'FK to on-site facility',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `address_type` STRING COMMENT 'Address type',
    `city` STRING COMMENT 'City',
    `country_code` STRING COMMENT 'Country code',
    `county_fips` STRING COMMENT 'County FIPS code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `geocode_accuracy` STRING COMMENT 'Geocode accuracy level',
    `group_location_status` STRING COMMENT 'Location status',
    `is_primary` BOOLEAN COMMENT 'Is primary location flag',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude',
    `location_code` STRING COMMENT 'Location code',
    `location_name` STRING COMMENT 'Location name',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude',
    `notes` STRING COMMENT 'Notes',
    `rating_area` STRING COMMENT 'Rating area',
    `state` STRING COMMENT 'State',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `zip_code` STRING COMMENT 'ZIP code',
    `zip_plus4` STRING COMMENT 'ZIP+4 code',
    CONSTRAINT pk_group_location PRIMARY KEY(`group_location_id`)
) COMMENT 'Physical and mailing addresses associated with an employer group, including headquarters, billing address, and satellite office locations. Tracks address type, street, city, state, ZIP+4, county FIPS code, and effective date range. Supports geographic rating, state regulatory filings, and premium billing address routing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` (
    `group_contact_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `authorization_level` STRING COMMENT 'Authorization level',
    `can_bill` BOOLEAN COMMENT 'Can perform billing actions',
    `can_enroll` BOOLEAN COMMENT 'Can perform enrollment actions',
    `city` STRING COMMENT 'City',
    `contact_type` STRING COMMENT 'Contact type',
    `country` STRING COMMENT 'Country',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `department` STRING COMMENT 'Department',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `email` STRING COMMENT 'Email address',
    `first_name` STRING COMMENT 'First name',
    `full_name` STRING COMMENT 'Full name',
    `group_contact_status` STRING COMMENT 'Contact status',
    `is_primary_contact` BOOLEAN COMMENT 'Is primary contact',
    `last_name` STRING COMMENT 'Last name',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `notes` STRING COMMENT 'Notes',
    `phone_number` STRING COMMENT 'Phone number',
    `postal_code` STRING COMMENT 'Postal code',
    `preferred_communication_channel` STRING COMMENT 'Preferred communication channel',
    `source_system_contact_reference` STRING COMMENT 'Source system contact reference',
    `state` STRING COMMENT 'State',
    `title` STRING COMMENT 'Title',
    CONSTRAINT pk_group_contact PRIMARY KEY(`group_contact_id`)
) COMMENT 'Authorized contacts associated with an employer group, including HR administrators, benefits coordinators, payroll contacts, and executive sponsors. Captures contact role type, name, title, phone, email, preferred communication channel, and authorization level for enrollment and billing transactions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_division` (
    `group_division_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to parent group',
    `health_plan_id` BIGINT COMMENT 'FK to primary health plan',
    `tertiary_group_epo_plan_health_plan_id` BIGINT COMMENT 'FK to tertiary EPO plan',
    `billing_entity_flag` BOOLEAN COMMENT 'Is billing entity',
    `classification` STRING COMMENT 'Division classification',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Contribution amount',
    `contribution_percent` DECIMAL(18,2) COMMENT 'Contribution percentage',
    `contribution_strategy` STRING COMMENT 'Contribution strategy',
    `covered_member_count` STRING COMMENT 'Covered member count',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `division_code` STRING COMMENT 'Division code',
    `division_name` STRING COMMENT 'Division name',
    `division_type` STRING COMMENT 'Division type',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `eligibility_rule_set` STRING COMMENT 'Eligibility rule set',
    `employee_count` STRING COMMENT 'Employee count',
    `flex_spending_amount` DECIMAL(18,2) COMMENT 'Flex spending amount',
    `fsa_contribution_amount` DECIMAL(18,2) COMMENT 'FSA contribution amount',
    `group_division_status` STRING COMMENT 'Division status',
    `hsa_contribution_amount` DECIMAL(18,2) COMMENT 'HSA contribution amount',
    `is_eligible_for_flex_spending` BOOLEAN COMMENT 'Eligible for flex spending',
    `is_eligible_for_fsa` BOOLEAN COMMENT 'Eligible for FSA',
    `is_eligible_for_hsa` BOOLEAN COMMENT 'Eligible for HSA',
    `is_eligible_for_subsidy` BOOLEAN COMMENT 'Eligible for subsidy',
    `is_eligible_for_waiver` BOOLEAN COMMENT 'Eligible for waiver',
    `renewal_date` DATE COMMENT 'Renewal date',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Subsidy amount',
    `subsidy_percent` DECIMAL(18,2) COMMENT 'Subsidy percentage',
    `termination_date` DATE COMMENT 'Termination date',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_group_division PRIMARY KEY(`group_division_id`)
) COMMENT 'Organizational sub-units within an employer group — divisions, subsidiaries, cost centers, or departments — that have distinct benefit configurations, billing aggregation, or eligibility rules. Tracks division name, division code, parent group reference, effective dates, and whether the division is a separate billing entity. Supports multi-site and multi-subsidiary group structures in Facets.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` (
    `group_plan_offering_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `tier_id` BIGINT COMMENT 'FK to network tier',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Contribution amount',
    `contribution_effective_end_date` DATE COMMENT 'Contribution effective end',
    `contribution_effective_start_date` DATE COMMENT 'Contribution effective start',
    `contribution_percent` DECIMAL(18,2) COMMENT 'Contribution percent',
    `contribution_strategy_description` STRING COMMENT 'Contribution strategy description',
    `contribution_tier` STRING COMMENT 'Contribution tier',
    `contribution_type` STRING COMMENT 'Contribution type',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_from` DATE COMMENT 'Offering effective from',
    `effective_until` DATE COMMENT 'Offering effective until',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Employee contribution amount',
    `family_contribution_amount` DECIMAL(18,2) COMMENT 'Family contribution amount',
    `group_plan_offering_status` STRING COMMENT 'Offering status',
    `hra_seed_amount` DECIMAL(18,2) COMMENT 'HRA seed amount',
    `hsa_seed_amount` DECIMAL(18,2) COMMENT 'HSA seed amount',
    `is_affordable` BOOLEAN COMMENT 'ACA affordability flag',
    `measurement_period_end` DATE COMMENT 'Measurement period end',
    `measurement_period_start` DATE COMMENT 'Measurement period start',
    `minimum_enrolled_headcount` STRING COMMENT 'Minimum enrolled headcount',
    `minimum_participation_percent` DECIMAL(18,2) COMMENT 'Minimum participation percent',
    `offering_code` STRING COMMENT 'Offering code',
    `offering_description` STRING COMMENT 'Offering description',
    `offering_name` STRING COMMENT 'Offering name',
    `offering_type` STRING COMMENT 'Offering type',
    `open_enrollment_end_date` DATE COMMENT 'OE end date',
    `open_enrollment_start_date` DATE COMMENT 'OE start date',
    `participation_status` STRING COMMENT 'Participation status',
    `plan_catalog_version` STRING COMMENT 'Plan catalog version',
    `plan_year` STRING COMMENT 'Plan year',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `waiver_criteria_description` STRING COMMENT 'Waiver criteria description',
    `waiver_eligible` BOOLEAN COMMENT 'Waiver eligible flag',
    CONSTRAINT pk_group_plan_offering PRIMARY KEY(`group_plan_offering_id`)
) COMMENT 'The set of health plan products offered by an employer group to its eligible employees during a plan year — the single source of truth for what plans are available, how the employer contributes, and what participation rules apply. Captures which QHP, HMO, PPO, EPO, HDHP, dental, and vision plans are available; employer contribution strategy per plan including contribution type (flat dollar, percentage of premium, tiered by coverage tier), employee-only vs family contribution amounts, HSA/HRA employer seed amounts, and contribution effective date ranges; minimum participation percentage, minimum enrolled headcount, waiver eligibility criteria (e.g., spousal coverage waivers), measurement period, and participation compliance status; and the open enrollment window linkage. Consolidates contribution strategies and participation requirements as attributes of the plan offering. Links employer groups to the plan catalog and drives the enrollment eligibility matrix, premium billing split calculations, and ACA affordability compliance testing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` (
    `contribution_strategy_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `affordability_test_flag` BOOLEAN COMMENT 'ACA affordability test flag',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Contribution amount',
    `contribution_code` STRING COMMENT 'Contribution code',
    `contribution_frequency` STRING COMMENT 'Contribution frequency',
    `contribution_percentage` DECIMAL(18,2) COMMENT 'Contribution percentage',
    `contribution_rule_name` STRING COMMENT 'Contribution rule name',
    `contribution_strategy_status` STRING COMMENT 'Strategy status',
    `contribution_type` STRING COMMENT 'Contribution type',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `eligibility_criteria` STRING COMMENT 'Eligibility criteria',
    `employer_contribution_cap` DECIMAL(18,2) COMMENT 'Employer contribution cap',
    `hra_employer_seed_amount` DECIMAL(18,2) COMMENT 'HRA employer seed amount',
    `hsa_employer_seed_amount` DECIMAL(18,2) COMMENT 'HSA employer seed amount',
    `is_post_tax` BOOLEAN COMMENT 'Post-tax flag',
    `is_pre_tax` BOOLEAN COMMENT 'Pre-tax flag',
    `last_review_date` DATE COMMENT 'Last review date',
    `maximum_employee_contribution` DECIMAL(18,2) COMMENT 'Maximum employee contribution',
    `minimum_employee_contribution` DECIMAL(18,2) COMMENT 'Minimum employee contribution',
    `notes` STRING COMMENT 'Notes',
    `review_status` STRING COMMENT 'Review status',
    `tax_credit_eligible` BOOLEAN COMMENT 'Tax credit eligible',
    `tier_code` STRING COMMENT 'Tier code',
    `updated_by` STRING COMMENT 'Updated by user',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `created_by` STRING COMMENT 'Created by user',
    CONSTRAINT pk_contribution_strategy PRIMARY KEY(`contribution_strategy_id`)
) COMMENT 'Employer contribution rules defining how much the employer pays toward employee and dependent premiums for each offered plan. Captures contribution type (flat dollar, percentage of premium, tiered by coverage tier), employee-only vs family contribution amounts, HSA/HRA employer seed amounts, and effective date ranges. Supports premium billing split calculations and ACA affordability compliance testing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` (
    `group_renewal_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `tpa_id` BIGINT COMMENT 'FK to TPA',
    `amendment_count` STRING COMMENT 'Amendment count',
    `amendment_flag` BOOLEAN COMMENT 'Has amendments flag',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Audit creation timestamp',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Audit updated timestamp',
    `benefit_plan_ids` STRING COMMENT 'Benefit plan IDs',
    `compliance_check_date` DATE COMMENT 'Compliance check date',
    `compliance_status` STRING COMMENT 'Compliance status',
    `contribution_strategy` STRING COMMENT 'Contribution strategy',
    `erisa_status` STRING COMMENT 'ERISA status',
    `funding_arrangement` STRING COMMENT 'Funding arrangement',
    `group_size` STRING COMMENT 'Group size',
    `latest_amendment_after_value` DECIMAL(18,2) COMMENT 'Latest amendment after value',
    `latest_amendment_approval_status` STRING COMMENT 'Latest amendment approval status',
    `latest_amendment_before_value` DECIMAL(18,2) COMMENT 'Latest amendment before value',
    `latest_amendment_effective_date` DATE COMMENT 'Latest amendment effective date',
    `latest_amendment_reason_code` STRING COMMENT 'Latest amendment reason code',
    `latest_amendment_type` STRING COMMENT 'Latest amendment type',
    `participation_requirement_met` BOOLEAN COMMENT 'Participation requirement met',
    `participation_requirement_outcome` STRING COMMENT 'Participation requirement outcome',
    `premium_rate_prior_year` DECIMAL(18,2) COMMENT 'Premium rate prior year',
    `premium_rate_renewal_year` DECIMAL(18,2) COMMENT 'Premium rate renewal year',
    `prior_renewal_effective_date` DATE COMMENT 'Prior renewal effective date',
    `rate_change_percentage` DECIMAL(18,2) COMMENT 'Rate change percentage',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Regulatory compliance flag',
    `renewal_cycle_year` STRING COMMENT 'Renewal cycle year',
    `renewal_effective_date` DATE COMMENT 'Renewal effective date',
    `renewal_end_date` DATE COMMENT 'Renewal end date',
    `renewal_notes` STRING COMMENT 'Renewal notes',
    `renewal_status` STRING COMMENT 'Renewal status',
    `renewal_status_date` DATE COMMENT 'Renewal status date',
    `retention_outcome` STRING COMMENT 'Retention outcome',
    `retention_reason_code` STRING COMMENT 'Retention reason code',
    `sic_code` STRING COMMENT 'SIC code',
    CONSTRAINT pk_group_renewal PRIMARY KEY(`group_renewal_id`)
) COMMENT 'Annual renewal lifecycle record and single source of truth for all group configuration changes — both at renewal and between renewal cycles. Captures renewal effective date, prior year vs renewal year premium rates, rate change percentage, benefit modifications, participation requirement outcomes, renewal status (pending, proposed, accepted, declined), and retention outcome. Also captures mid-year and off-cycle amendments including amendment type (benefit change, plan add/drop, contribution change, address update, contact change), amendment effective date, reason code, approval status, and before/after values of changed attributes. Consolidates group amendments as lifecycle events within the renewal record — amendments are tracked against the current plan years renewal. Provides complete audit trail for group retention management, regulatory compliance, and configuration change history.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` (
    `participation_requirement_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `compliance_review_due_date` DATE COMMENT 'Compliance review due date',
    `compliance_status` STRING COMMENT 'Compliance status',
    `contribution_strategy` STRING COMMENT 'Contribution strategy',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `participation_requirement_description` STRING COMMENT 'Requirement description',
    `effective_from` DATE COMMENT 'Effective from',
    `effective_until` DATE COMMENT 'Effective until',
    `enrolled_headcount` STRING COMMENT 'Enrolled headcount',
    `erisa_status` STRING COMMENT 'ERISA status',
    `funding_arrangement` STRING COMMENT 'Funding arrangement',
    `group_size` STRING COMMENT 'Group size',
    `last_evaluated_date` DATE COMMENT 'Last evaluated date',
    `measurement_period` STRING COMMENT 'Measurement period',
    `minimum_enrolled_headcount` STRING COMMENT 'Minimum enrolled headcount',
    `notes` STRING COMMENT 'Notes',
    `participation_percentage` DECIMAL(18,2) COMMENT 'Participation percentage',
    `participation_requirement_status` STRING COMMENT 'Requirement status',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Regulatory reporting flag',
    `renewal_date` DATE COMMENT 'Renewal date',
    `requirement_code` STRING COMMENT 'Requirement code',
    `requirement_name` STRING COMMENT 'Requirement name',
    `requirement_type` STRING COMMENT 'Requirement type',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `waiver_allowed` BOOLEAN COMMENT 'Waiver allowed flag',
    `waiver_percentage_allowed` DECIMAL(18,2) COMMENT 'Waiver percentage allowed',
    CONSTRAINT pk_participation_requirement PRIMARY KEY(`participation_requirement_id`)
) COMMENT 'Minimum participation rules that an employer group must satisfy to maintain group coverage eligibility. Captures minimum participation percentage, minimum enrolled headcount, waiver eligibility criteria (e.g., spousal coverage waivers), measurement period, and compliance status. Used during underwriting, renewal, and open enrollment to validate group eligibility for continued coverage.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` (
    `broker_assignment_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `agency_name` STRING COMMENT 'Agency name',
    `broker_assignment_status` STRING COMMENT 'Assignment status',
    `commission_basis` STRING COMMENT 'Commission basis',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate',
    `commission_type` STRING COMMENT 'Commission type',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `is_primary` BOOLEAN COMMENT 'Is primary broker',
    `notes` STRING COMMENT 'Notes',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_broker_assignment PRIMARY KEY(`broker_assignment_id`)
) COMMENT 'Association between an employer group and its licensed broker(s) or general agent(s), capturing the broker NPN, agency name, commission arrangement type, commission rate, effective and termination dates, and primary vs secondary broker designation. Supports broker compensation processing, group servicing accountability, and regulatory disclosure requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` (
    `tpa_arrangement_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `stop_loss_policy_id` BIGINT COMMENT 'FK to employer.stop_loss_policy',
    `tpa_id` BIGINT COMMENT 'FK to TPA',
    `arrangement_name` STRING COMMENT 'Arrangement name',
    `arrangement_number` STRING COMMENT 'Arrangement number',
    `arrangement_type` STRING COMMENT 'Arrangement type',
    `contract_reference` STRING COMMENT 'Contract reference',
    `contribution_rate_pmpm` DECIMAL(18,2) COMMENT 'Contribution rate PMPM',
    `contribution_strategy` STRING COMMENT 'Contribution strategy',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `erisa_status` STRING COMMENT 'ERISA status',
    `fee_schedule_cap_amount` DECIMAL(18,2) COMMENT 'Fee schedule cap amount',
    `fee_schedule_rate_pmpm` DECIMAL(18,2) COMMENT 'Fee schedule rate PMPM',
    `fee_schedule_type` STRING COMMENT 'Fee schedule type',
    `gfc_control_flag` BOOLEAN COMMENT 'GFC control flag',
    `group_size_max` STRING COMMENT 'Group size max',
    `group_size_min` STRING COMMENT 'Group size min',
    `notes` STRING COMMENT 'Notes',
    `renewal_date` DATE COMMENT 'Renewal date',
    `stop_loss_aggregate_corridor` DECIMAL(18,2) COMMENT 'Stop loss aggregate corridor',
    `stop_loss_aggregate_deductible` DECIMAL(18,2) COMMENT 'Stop loss aggregate deductible',
    `stop_loss_coverage_scope` STRING COMMENT 'Stop loss coverage scope',
    `stop_loss_effective_date` DATE COMMENT 'Stop loss effective date',
    `stop_loss_expiration_date` DATE COMMENT 'Stop loss expiration date',
    `stop_loss_individual_attachment_point` DECIMAL(18,2) COMMENT 'Stop loss individual attachment point',
    `stop_loss_laser_amount` DECIMAL(18,2) COMMENT 'Stop loss laser amount',
    `stop_loss_premium` DECIMAL(18,2) COMMENT 'Stop loss premium',
    `tpa_arrangement_status` STRING COMMENT 'Arrangement status',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_tpa_arrangement PRIMARY KEY(`tpa_arrangement_id`)
) COMMENT 'Third Party Administrator (TPA) and Administrative Services Only (ASO) arrangement record for self-funded employer groups — the single source of truth for all ASO/self-funded configuration. Captures TPA entity name, TPA NPI/tax ID, ASO contract reference; administrative fee schedule components by service type (claims processing, network access, care management, PBM, utilization review) with PMPM rates, effective dates, and contractual fee caps; stop-loss (excess loss) insurance configuration including stop-loss carrier name, policy number, specific deductible (individual attachment point), aggregate deductible, aggregate corridor, lasering provisions with member-level laser amounts, stop-loss premium, covered benefits scope, and stop-loss policy effective/expiration dates; and overall arrangement effective dates. Consolidates ASO fee schedules and stop-loss policies as sub-configurations of the TPA arrangement, aligned with Facets/QNXT ASO module patterns. Drives ASO revenue recognition in the finance domain and self-funded group financial risk management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` (
    `open_enrollment_window_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `change_deadline` DATE COMMENT 'Change deadline',
    `coverage_type` STRING COMMENT 'Coverage type',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `eligible_employee_count` STRING COMMENT 'Eligible employee count',
    `end_date` DATE COMMENT 'Window end date',
    `enrollment_method` STRING COMMENT 'Enrollment method',
    `enrollment_window_status` STRING COMMENT 'Window status',
    `enrollment_window_type` STRING COMMENT 'Window type',
    `notes` STRING COMMENT 'Notes',
    `participation_rate` DECIMAL(18,2) COMMENT 'Participation rate',
    `plan_selection_method` STRING COMMENT 'Plan selection method',
    `start_date` DATE COMMENT 'Window start date',
    `submission_deadline` DATE COMMENT 'Submission deadline',
    `total_employee_count` STRING COMMENT 'Total employee count',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `waiver_allowed` BOOLEAN COMMENT 'Waiver allowed',
    `waiver_deadline` DATE COMMENT 'Waiver deadline',
    `window_code` STRING COMMENT 'Window code',
    CONSTRAINT pk_open_enrollment_window PRIMARY KEY(`open_enrollment_window_id`)
) COMMENT 'Scheduled open enrollment windows defined by an employer group during which employees may elect, change, or waive coverage. Captures enrollment period type (annual open enrollment, new hire window, COBRA election), start and end dates, eligible plan offerings, enrollment method (online portal, paper, EDI 834), and enrollment completion status. Drives eligibility event processing in the enrollment domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` (
    `rate_quote_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `tpa_id` BIGINT COMMENT 'FK to TPA',
    `contribution_strategy` STRING COMMENT 'Contribution strategy',
    `coverage_tier` STRING COMMENT 'Coverage tier',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount',
    `effective_date` DATE COMMENT 'Effective date',
    `erisa_status` STRING COMMENT 'ERISA status',
    `expiration_date` DATE COMMENT 'Expiration date',
    `gross_premium_amount` DECIMAL(18,2) COMMENT 'Gross premium amount',
    `group_sic_code` STRING COMMENT 'Group SIC code',
    `group_size` STRING COMMENT 'Group size',
    `group_type` STRING COMMENT 'Group type',
    `issue_timestamp` TIMESTAMP COMMENT 'Issue timestamp',
    `member_count` STRING COMMENT 'Member count',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Net premium amount',
    `notes` STRING COMMENT 'Notes',
    `plan_year` STRING COMMENT 'Plan year',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'PMPM rate',
    `quote_number` STRING COMMENT 'Quote number',
    `quote_version` STRING COMMENT 'Quote version',
    `rate_quote_status` STRING COMMENT 'Quote status',
    `rating_area` STRING COMMENT 'Rating area',
    `rating_methodology` STRING COMMENT 'Rating methodology',
    `renewal_date` DATE COMMENT 'Renewal date',
    `total_group_premium_estimate` DECIMAL(18,2) COMMENT 'Total group premium estimate',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_rate_quote PRIMARY KEY(`rate_quote_id`)
) COMMENT 'Premium rate quote issued to a prospective or renewing employer group, capturing proposed rates by plan, coverage tier, and rating area. Includes quote effective date, expiration date, rating methodology (community rated, experience rated, blended), proposed PMPM rates, total group premium estimate, and quote status (draft, presented, accepted, expired). Supports the sales and renewal pipeline.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` (
    `group_amendment_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `after_value` DECIMAL(18,2) COMMENT 'Value after amendment',
    `amendment_number` STRING COMMENT 'Amendment number',
    `amendment_status` STRING COMMENT 'Amendment status',
    `amendment_type` STRING COMMENT 'Amendment type',
    `approval_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `approval_user_role` STRING COMMENT 'Approval user role',
    `before_value` DECIMAL(18,2) COMMENT 'Value before amendment',
    `contribution_change_amount` DECIMAL(18,2) COMMENT 'Contribution change amount',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `effective_date` DATE COMMENT 'Effective date',
    `is_critical_change` BOOLEAN COMMENT 'Is critical change',
    `new_contribution_amount` DECIMAL(18,2) COMMENT 'New contribution amount',
    `original_contribution_amount` DECIMAL(18,2) COMMENT 'Original contribution amount',
    `reason_code` STRING COMMENT 'Reason code',
    `reason_description` STRING COMMENT 'Reason description',
    `submission_timestamp` TIMESTAMP COMMENT 'Submission timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_group_amendment PRIMARY KEY(`group_amendment_id`)
) COMMENT 'Mid-year or off-cycle changes to an employer groups coverage terms, benefit configuration, or administrative parameters. Captures amendment type (benefit change, plan add/drop, contribution change, address update, contact change), effective date, reason code, approval status, and the before/after values of changed attributes. Provides a complete audit trail of group configuration changes between renewal cycles.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` (
    `cobra_administration_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `tpa_id` BIGINT COMMENT 'Foreign key linking to employer.tpa. Business justification: COBRA administration is frequently outsourced to TPAs. The cobra_administration table has administrator_name (STRING) which should be replaced by a FK to the tpa table. This normalization allows joini',
    `administrator_type` STRING COMMENT 'Administrator type',
    `agreement_type` STRING COMMENT 'Agreement type',
    `cobra_administration_status` STRING COMMENT 'Administration status',
    `cobra_agreement_number` STRING COMMENT 'COBRA agreement number',
    `compliance_status` STRING COMMENT 'Compliance status',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_from` DATE COMMENT 'Effective from',
    `effective_until` DATE COMMENT 'Effective until',
    `election_end_date` DATE COMMENT 'Election end date',
    `election_period_days` STRING COMMENT 'Election period days',
    `election_start_date` DATE COMMENT 'Election start date',
    `group_cobra_eligibility` BOOLEAN COMMENT 'Group COBRA eligibility',
    `last_compliance_check_date` DATE COMMENT 'Last compliance check date',
    `max_employee_count` STRING COMMENT 'Max employee count',
    `min_employee_count` STRING COMMENT 'Min employee count',
    `notes` STRING COMMENT 'Notes',
    `notification_method` STRING COMMENT 'Notification method',
    `notification_required` BOOLEAN COMMENT 'Notification required',
    `premium_rate` DECIMAL(18,2) COMMENT 'Premium rate',
    `premium_rate_multiplier` DECIMAL(18,2) COMMENT 'Premium rate multiplier',
    `qualifying_event_type` STRING COMMENT 'Qualifying event type',
    `state_cobra_law` STRING COMMENT 'State COBRA law',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_cobra_administration PRIMARY KEY(`cobra_administration_id`)
) COMMENT 'COBRA (Consolidated Omnibus Budget Reconciliation Act) administration configuration for an employer group, defining the groups COBRA obligations, qualifying event types, election period durations, premium rates (102% of group rate), and COBRA administrator designation (self-administered vs third-party COBRA TPA). Tracks group-level COBRA compliance status, election window configurations, and notification requirements. Required for all employer groups with 20+ employees under federal COBRA or state mini-COBRA equivalents.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` (
    `wellness_program_id` BIGINT COMMENT 'Primary key',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `wellness_employer_group_id` BIGINT COMMENT 'Foreign key to employer.group.',
    `wellness_group_id` BIGINT COMMENT 'add column group_id (BIGINT) with FK to employer.group.group_id - wellness programs are offered to specific employer groups',
    `group_id` BIGINT COMMENT '',
    `aca_compliance_classification` STRING COMMENT 'ACA compliance classification',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `current_participant_count` STRING COMMENT 'Current participant count',
    `wellness_program_description` STRING COMMENT 'Program description',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `eligibility_criteria` STRING COMMENT 'Eligibility criteria',
    `enrollment_cap` STRING COMMENT 'Enrollment cap',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Incentive amount',
    `incentive_currency_code` STRING COMMENT 'Incentive currency code',
    `incentive_type` STRING COMMENT 'Incentive type',
    `is_eligible_for_tax_credit` BOOLEAN COMMENT 'Tax credit eligible',
    `is_mandatory` BOOLEAN COMMENT 'Is mandatory',
    `participation_method` STRING COMMENT 'Participation method',
    `program_actual_participation_pct` DECIMAL(18,2) COMMENT 'Actual participation pct',
    `program_budget_amount` DECIMAL(18,2) COMMENT 'Program budget amount',
    `program_budget_currency` STRING COMMENT 'Program budget currency',
    `program_category` STRING COMMENT 'Program category',
    `program_code` STRING COMMENT 'Program code',
    `program_compliance_notes` STRING COMMENT 'Compliance notes',
    `program_effective_year` STRING COMMENT 'Program effective year',
    `program_end_reason` STRING COMMENT 'Program end reason',
    `program_last_review_date` DATE COMMENT 'Last review date',
    `program_name` STRING COMMENT 'Program name',
    `program_review_status` STRING COMMENT 'Review status',
    `program_risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Risk adjustment factor',
    `program_source_system` STRING COMMENT 'Source system',
    `program_subtype` STRING COMMENT 'Program subtype',
    `program_target_participation_pct` DECIMAL(18,2) COMMENT 'Target participation pct',
    `program_type` STRING COMMENT 'Program type',
    `program_version` STRING COMMENT 'Program version',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `wellness_program_status` STRING COMMENT 'Program status',
    CONSTRAINT pk_wellness_program PRIMARY KEY(`wellness_program_id`)
) COMMENT 'Employer-sponsored wellness and health promotion programs offered to enrolled members, including biometric screening, smoking cessation, weight management, EAP (Employee Assistance Program), and chronic disease prevention initiatives. Captures program name, type, vendor partner, incentive structure (premium discount, HSA contribution, gift cards), participation tracking method, program effective dates, and ACA wellness program compliance classification (participatory vs health-contingent). Supports employer value-add differentiation and group retention strategy.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_document` (
    `group_document_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `amendment_date` DATE COMMENT 'Amendment date',
    `amendment_number` STRING COMMENT 'Amendment number',
    `audit_trail` STRING COMMENT 'Audit trail',
    `checksum` STRING COMMENT 'Document checksum',
    `compliance_flag` BOOLEAN COMMENT 'Compliance flag',
    `confidential` BOOLEAN COMMENT 'Confidential flag',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `document_category` STRING COMMENT 'Document category',
    `document_language` STRING COMMENT 'Document language',
    `document_title` STRING COMMENT 'Document title',
    `document_type` STRING COMMENT 'Document type',
    `effective_date` DATE COMMENT 'Effective date',
    `erisa_plan_administrator` STRING COMMENT 'ERISA plan administrator',
    `expiration_date` DATE COMMENT 'Expiration date',
    `expiration_policy` STRING COMMENT 'Expiration policy',
    `fiduciary_designation` STRING COMMENT 'Fiduciary designation',
    `file_format` STRING COMMENT 'File format',
    `file_size_bytes` BIGINT COMMENT 'File size in bytes',
    `group_document_status` STRING COMMENT 'Document status',
    `is_electronic` BOOLEAN COMMENT 'Is electronic',
    `is_mandatory` BOOLEAN COMMENT 'Is mandatory',
    `is_primary` BOOLEAN COMMENT 'Is primary document',
    `last_reviewed_date` DATE COMMENT 'Last reviewed date',
    `notes` STRING COMMENT 'Notes',
    `physical_location` STRING COMMENT 'Physical location',
    `plan_year` STRING COMMENT 'Plan year',
    `retention_period_months` STRING COMMENT 'Retention period months',
    `reviewed_by` STRING COMMENT 'Reviewed by',
    `source_system_document_reference` STRING COMMENT 'Source system document reference',
    `storage_uri` STRING COMMENT 'Storage URI',
    `trust_agreement_details` STRING COMMENT 'Trust agreement details',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `version_number` STRING COMMENT 'Version number',
    CONSTRAINT pk_group_document PRIMARY KEY(`group_document_id`)
) COMMENT 'Repository and single source of truth for all documents associated with an employer group, including executed group contracts, plan documents, SPDs (Summary Plan Descriptions), SBCs (Summary of Benefits and Coverage), ERISA wrap documents, trust agreements, named fiduciary designations, plan administrator information, DOL Form 5500 filings, ERISA plan amendment history, fiduciary liability insurance records, DOI filings, renewal agreements, broker appointment letters, and all ERISA compliance artifacts. Captures document type, document title, version, effective date, expiration date, storage reference URI, document status, plan year, and ERISA-specific metadata (plan administrator, fiduciary designations, amendment history, trust agreement details, plan year). Consolidates all group documentation including ERISA plan documents — ERISA documents are distinguished by document type classification, not by separate entity. Supports regulatory audit readiness, ERISA fiduciary obligations, DOL reporting, and group servicing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` (
    `aso_fee_schedule_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `tpa_id` BIGINT COMMENT 'Foreign key linking to employer.tpa. Business justification: ASO (Administrative Services Only) fee schedules define the fees charged by TPAs for administering self-funded employer groups. Each fee schedule is TPA-specific, as different TPAs have different fee ',
    `aso_fee_schedule_status` STRING COMMENT 'Fee schedule status',
    `billing_frequency` STRING COMMENT 'Billing frequency',
    `cap_amount` DECIMAL(18,2) COMMENT 'Cap amount',
    `cap_type` STRING COMMENT 'Cap type',
    `component_type` STRING COMMENT 'Component type',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `aso_fee_schedule_description` STRING COMMENT 'Fee schedule description',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `eligibility_criteria` STRING COMMENT 'Eligibility criteria',
    `is_taxable` BOOLEAN COMMENT 'Is taxable',
    `minimum_participation_percent` DECIMAL(18,2) COMMENT 'Minimum participation percent',
    `notes` STRING COMMENT 'Notes',
    `pm_per_member_rate` DECIMAL(18,2) COMMENT 'Per member rate',
    `schedule_code` STRING COMMENT 'Schedule code',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_aso_fee_schedule PRIMARY KEY(`aso_fee_schedule_id`)
) COMMENT 'Administrative fee schedule for ASO (Administrative Services Only) self-funded employer groups, defining the per-member-per-month (PMPM) administrative fees charged for claims processing, network access, care management, pharmacy benefit management, and other administrative services. Captures fee component type, PMPM rate, effective date, and contractual cap amounts. Drives ASO revenue recognition in the finance domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` (
    `stop_loss_policy_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `tpa_id` BIGINT COMMENT 'Foreign key linking to employer.tpa. Business justification: Stop-loss policies for self-funded groups are often administered by TPAs. While stop_loss_policy has carrier_name (the insurance carrier), the TPA that administers the policy should be explicitly link',
    `aggregate_attachment_point` DECIMAL(18,2) COMMENT 'Aggregate attachment point',
    `aggregate_deductible_reset_period` STRING COMMENT 'Aggregate deductible reset period',
    `attachment_point_type` STRING COMMENT 'Attachment point type',
    `carrier_name` STRING COMMENT 'Carrier name',
    `claim_payment_limit` DECIMAL(18,2) COMMENT 'Claim payment limit',
    `claim_payment_limit_currency` STRING COMMENT 'Claim payment limit currency',
    `contribution_strategy` STRING COMMENT 'Contribution strategy',
    `covered_benefit_codes` STRING COMMENT 'Covered benefit codes',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible amount',
    `effective_from` DATE COMMENT 'Effective from',
    `effective_until` DATE COMMENT 'Effective until',
    `individual_attachment_point` DECIMAL(18,2) COMMENT 'Individual attachment point',
    `lasering_provision_flag` BOOLEAN COMMENT 'Lasering provision flag',
    `notes` STRING COMMENT 'Notes',
    `policy_number` STRING COMMENT 'Policy number',
    `policy_type` STRING COMMENT 'Policy type',
    `premium_amount` DECIMAL(18,2) COMMENT 'Premium amount',
    `premium_currency` STRING COMMENT 'Premium currency',
    `renewal_date` DATE COMMENT 'Renewal date',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Risk adjustment factor',
    `stop_loss_policy_status` STRING COMMENT 'Policy status',
    `termination_date` DATE COMMENT 'Termination date',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_stop_loss_policy PRIMARY KEY(`stop_loss_policy_id`)
) COMMENT 'Stop-loss (excess loss) insurance policy associated with a self-funded ASO employer group, providing financial protection against catastrophic claims. Captures stop-loss carrier name, policy number, specific deductible (individual attachment point), aggregate deductible, lasering provisions, covered benefits, policy effective and expiration dates, and premium amounts. Critical for ASO group financial risk management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` (
    `group_rating_factor_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `actuarial_basis` STRING COMMENT 'Actuarial basis',
    `adjustment_reason` STRING COMMENT 'Adjustment reason',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `factor_code` STRING COMMENT 'Factor code',
    `factor_description` STRING COMMENT 'Factor description',
    `factor_type` STRING COMMENT 'Factor type',
    `factor_value` DECIMAL(18,2) COMMENT 'Factor value',
    `group_rating_factor_status` STRING COMMENT 'Factor status',
    `is_adjusted` BOOLEAN COMMENT 'Is adjusted',
    `is_default` BOOLEAN COMMENT 'Is default',
    `notes` STRING COMMENT 'Notes',
    `rating_period_end` DATE COMMENT 'Rating period end',
    `rating_period_start` DATE COMMENT 'Rating period start',
    `regulatory_reference` STRING COMMENT 'Regulatory reference',
    `source_system_factor_reference` STRING COMMENT 'Source system factor reference',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `value_unit` STRING COMMENT 'Value unit',
    CONSTRAINT pk_group_rating_factor PRIMARY KEY(`group_rating_factor_id`)
) COMMENT 'Rating factors applied to an employer group for premium calculation, including age/gender composite factors, geographic area rating factors, industry risk factors, experience rating credibility weights, and ACA-compliant rating adjustments. Captures factor type, factor value, rating period, and the actuarial basis for each factor. Used by the billing domain for premium calculation and by the risk domain for group-level risk adjustment.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` (
    `erisa_plan_document_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: ERISA plan documents are required for self-funded employer groups (ERISA-governed plans). Each document is group-specific, defining the plan terms, fiduciary responsibilities, and trust arrangements f',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `amendment_date` DATE COMMENT 'Amendment date',
    `amendment_description` STRING COMMENT 'Amendment description',
    `amendment_number` STRING COMMENT 'Amendment number',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `document_name` STRING COMMENT 'Document name',
    `document_number` STRING COMMENT 'Document number',
    `document_type` STRING COMMENT 'Document type',
    `effective_from` DATE COMMENT 'Effective from',
    `effective_until` DATE COMMENT 'Effective until',
    `erisa_plan_document_status` STRING COMMENT 'Document status',
    `fiduciary_name` STRING COMMENT 'Fiduciary name',
    `fiduciary_role` STRING COMMENT 'Fiduciary role',
    `filing_deadline_date` DATE COMMENT 'Filing deadline date',
    `filing_status` STRING COMMENT 'Filing status',
    `liability_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Liability insurance coverage amount',
    `liability_insurance_policy_number` STRING COMMENT 'Liability insurance policy number',
    `liability_insurance_provider` STRING COMMENT 'Liability insurance provider',
    `notes` STRING COMMENT 'Notes',
    `plan_administrator_email` STRING COMMENT 'Plan administrator email',
    `plan_administrator_name` STRING COMMENT 'Plan administrator name',
    `plan_name` STRING COMMENT 'Plan name',
    `plan_year` STRING COMMENT 'Plan year',
    `trust_address` STRING COMMENT 'Trust address',
    `trust_city` STRING COMMENT 'Trust city',
    `trust_ein` STRING COMMENT 'Trust EIN',
    `trust_name` STRING COMMENT 'Trust name',
    `trust_state` STRING COMMENT 'Trust state',
    `trust_zip` STRING COMMENT 'Trust ZIP',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_erisa_plan_document PRIMARY KEY(`erisa_plan_document_id`)
) COMMENT 'ERISA-governed plan document record for self-funded employer groups, capturing the formal plan document, trust agreement, named fiduciary designations, plan administrator information, plan year, and ERISA wrap document details. Tracks DOL Form 5500 filing obligations, plan amendment history, and fiduciary liability insurance. Distinct from group_document in that it specifically governs ERISA compliance obligations and fiduciary responsibilities.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` (
    `regulatory_compliance_record_id` BIGINT COMMENT '',
    `group_id` BIGINT COMMENT '',
    `obligation_id` BIGINT COMMENT '',
    `compliance_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    CONSTRAINT pk_regulatory_compliance_record PRIMARY KEY(`regulatory_compliance_record_id`)
) COMMENT 'This association product captures the compliance relationship between an employer group and a regulatory obligation. It records the compliance status and the date of the most recent assessment for each group‑obligation pair.. Existence Justification: Each employer group must satisfy many regulatory obligations, and each regulatory obligation (e.g., HIPAA, ACA) applies to many employer groups. The insurer tracks compliance status and assessment dates for every group‑obligation pair, creating, updating, and deleting these records as part of ongoing compliance management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker` (
    `broker_id` BIGINT COMMENT 'Primary key',
    `broker_agreement_id` BIGINT COMMENT 'FK to broker agreement',
    `vendor_id` BIGINT COMMENT 'add column vendor_id (BIGINT) with FK to vendor.vendor.vendor_id - brokers are external business partners tracked in vendor master',
    `broker_vendor_vendor_id` BIGINT COMMENT 'Foreign key to vendor.vendor.',
    `parent_broker_id` BIGINT COMMENT 'FK to parent broker',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `broker_status` STRING COMMENT 'Status',
    `broker_type` STRING COMMENT 'Broker type',
    `city` STRING COMMENT 'City',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount',
    `commission_currency` STRING COMMENT 'Commission currency',
    `commission_end_date` DATE COMMENT 'Commission end date',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate',
    `commission_start_date` DATE COMMENT 'Commission start date',
    `country` STRING COMMENT 'Country',
    `email` STRING COMMENT 'Email',
    `end_date` DATE COMMENT 'End date',
    `fax` STRING COMMENT 'Fax',
    `license_number` STRING COMMENT 'License number',
    `broker_name` STRING COMMENT 'Broker name',
    `phone` STRING COMMENT 'Phone',
    `postal_code` STRING COMMENT 'Postal code',
    `rating` DECIMAL(18,2) COMMENT 'Rating',
    `record_audit_created` TIMESTAMP COMMENT 'Record audit created',
    `record_audit_updated` TIMESTAMP COMMENT 'Record audit updated',
    `region` STRING COMMENT 'Region',
    `registration_number` STRING COMMENT 'Registration number',
    `renewal_date` DATE COMMENT 'Renewal date',
    `renewal_status` STRING COMMENT 'Renewal status',
    `start_date` DATE COMMENT 'Start date',
    `state` STRING COMMENT 'State',
    `tax_number` STRING COMMENT 'Tax number',
    `termination_reason` STRING COMMENT 'Termination reason',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Master reference table for broker. Referenced by broker_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`tpa` (
    `tpa_id` BIGINT COMMENT 'Primary key',
    `parent_tpa_id` BIGINT COMMENT 'FK to parent TPA',
    `vendor_id` BIGINT COMMENT 'add column vendor_id (BIGINT) with FK to vendor.vendor.vendor_id - TPAs are third-party vendors requiring vendor master linkage',
    `tpa_vendor_vendor_id` BIGINT COMMENT 'Foreign key to vendor.vendor.',
    `address_line1` STRING COMMENT 'TPA address line 1',
    `city` STRING COMMENT 'TPA city',
    `contact_email` STRING COMMENT 'TPA contact email',
    `contact_name` STRING COMMENT 'TPA contact name',
    `contact_phone` STRING COMMENT 'TPA contact phone',
    `contract_currency` STRING COMMENT 'TPA contract currency',
    `contract_end_date` DATE COMMENT 'TPA contract end date',
    `contract_notes` STRING COMMENT 'TPA contract notes',
    `contract_number` STRING COMMENT 'TPA contract number',
    `contract_start_date` DATE COMMENT 'TPA contract start date',
    `contract_status` STRING COMMENT 'TPA contract status',
    `contract_type` STRING COMMENT 'TPA contract type',
    `contract_value` DECIMAL(18,2) COMMENT 'TPA contract value',
    `country` STRING COMMENT 'TPA country',
    `coverage_end_date` DATE COMMENT 'TPA coverage end date',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'TPA coverage limit amount',
    `coverage_limit_currency` STRING COMMENT 'TPA coverage limit currency',
    `coverage_start_date` DATE COMMENT 'TPA coverage start date',
    `coverage_status` STRING COMMENT 'TPA coverage status',
    `coverage_type` STRING COMMENT 'TPA coverage type',
    `created_at` TIMESTAMP COMMENT 'TPA created at',
    `tpa_name` STRING COMMENT 'TPA name',
    `renewal_date` DATE COMMENT 'TPA renewal date',
    `renewal_status` STRING COMMENT 'TPA renewal status',
    `sla_end` DATE COMMENT 'TPA SLA end',
    `sla_notes` STRING COMMENT 'TPA SLA notes',
    `sla_start` DATE COMMENT 'TPA SLA start',
    `sla_status` STRING COMMENT 'TPA SLA status',
    `state` STRING COMMENT 'TPA state',
    `tax_number` STRING COMMENT 'TPA tax number',
    `termination_date` DATE COMMENT 'TPA termination date',
    `termination_reason` STRING COMMENT 'TPA termination reason',
    `tpa_status` STRING COMMENT 'TPA status',
    `tpa_type` STRING COMMENT 'TPA type',
    `updated_at` TIMESTAMP COMMENT 'TPA updated at',
    `zip` STRING COMMENT 'TPA ZIP',
    CONSTRAINT pk_tpa PRIMARY KEY(`tpa_id`)
) COMMENT 'Master reference table for tpa. Referenced by tpa_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` (
    `broker_agreement_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'Employer group ID reference',
    `general_agent_id` BIGINT COMMENT 'General agent ID',
    `parent_broker_agreement_id` BIGINT COMMENT 'FK to parent broker agreement',
    `broker_id` BIGINT COMMENT 'Broker ID reference',
    `broker` BIGINT COMMENT '',
    `agreement_number` STRING COMMENT 'Agreement number',
    `agreement_type` STRING COMMENT 'Agreement type',
    `amendment_count` STRING COMMENT 'Amendment count',
    `appointment_date` DATE COMMENT 'Appointment date',
    `appointment_status` STRING COMMENT 'Appointment status',
    `auto_renewal_flag` BOOLEAN COMMENT 'Auto renewal flag',
    `base_commission_rate` DECIMAL(18,2) COMMENT 'Base commission rate',
    `broker_agreement_status` STRING COMMENT 'Status',
    `commission_schedule_type` STRING COMMENT 'Commission schedule type',
    `compensation_method` STRING COMMENT 'Compensation method',
    `compliance_certification_date` DATE COMMENT 'Compliance certification date',
    `contract_version` STRING COMMENT 'Contract version',
    `effective_date` DATE COMMENT 'Effective date',
    `errors_omissions_expiry` DATE COMMENT 'E&O expiry',
    `errors_omissions_required` BOOLEAN COMMENT 'E&O required',
    `exclusivity_flag` BOOLEAN COMMENT 'Exclusivity flag',
    `execution_date` DATE COMMENT 'Execution date',
    `expiration_date` DATE COMMENT 'Expiration date',
    `market_segment` STRING COMMENT 'Market segment',
    `minimum_production_requirement` DECIMAL(18,2) COMMENT 'Minimum production requirement',
    `non_compete_period_months` STRING COMMENT 'Non-compete period months',
    `notes` STRING COMMENT 'Notes',
    `override_commission_rate` DECIMAL(18,2) COMMENT 'Override commission rate',
    `payment_frequency` STRING COMMENT 'Payment frequency',
    `product_line` STRING COMMENT 'Product line',
    `renewal_commission_rate` DECIMAL(18,2) COMMENT 'Renewal commission rate',
    `renewal_date` DATE COMMENT 'Renewal date',
    `state_of_licensure` STRING COMMENT 'State of licensure',
    `termination_date` DATE COMMENT 'Termination date',
    `termination_reason` STRING COMMENT 'Termination reason',
    `territory_code` STRING COMMENT 'Territory code',
    CONSTRAINT pk_broker_agreement PRIMARY KEY(`broker_agreement_id`)
) COMMENT 'Master reference table for broker_agreement. Referenced by agreement_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` (
    `general_agent_id` BIGINT COMMENT 'Primary key for general_agent',
    `supervising_general_agent_id` BIGINT COMMENT 'Self-referencing FK on general_agent (supervising_general_agent_id)',
    `agent_code` STRING COMMENT 'Externally-known unique business identifier code assigned to the general agent for reference in contracts, commissions, and reporting.',
    `agent_name` STRING COMMENT 'Legal business name of the general agent or agency.',
    `agent_status` STRING COMMENT 'Current lifecycle status of the general agent relationship with the carrier.',
    `agent_type` STRING COMMENT 'Classification of the general agent based on their business model and relationship with the carrier (e.g., general agent, managing general agent, wholesale broker, field marketing organization).',
    `annual_production_target_amount` DECIMAL(18,2) COMMENT 'Target annual premium production amount expected from the general agent, used for performance evaluation and bonus calculations.',
    `appointment_date` DATE COMMENT 'Date when the general agent was officially appointed to represent the carrier and sell its products.',
    `bank_account_number` STRING COMMENT 'Bank account number for electronic commission payments to the general agent.',
    `bank_account_type` STRING COMMENT 'Type of bank account used for commission payments (checking or savings).',
    `bank_routing_number` STRING COMMENT 'Nine-digit ABA routing number for the general agents bank account.',
    `business_address_line1` STRING COMMENT 'First line of the general agents primary business address (street number and name).',
    `business_address_line2` STRING COMMENT 'Second line of the general agents business address (suite, floor, building).',
    `business_city` STRING COMMENT 'City of the general agents primary business location.',
    `business_country_code` STRING COMMENT 'Three-letter ISO country code of the general agents primary business location.',
    `business_postal_code` STRING COMMENT 'ZIP or postal code of the general agents primary business location.',
    `business_state` STRING COMMENT 'Two-letter state code of the general agents primary business location.',
    `commission_payment_frequency` STRING COMMENT 'Frequency at which commissions are paid to the general agent.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Standard commission rate percentage paid to the general agent on new business sales. May be overridden at product or group level.',
    `contract_effective_date` DATE COMMENT 'Date when the general agent contract becomes effective and binding.',
    `contract_expiration_date` DATE COMMENT 'Date when the general agent contract expires. May be null for evergreen contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the general agent record was first created in the system.',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the general agent operates, if different from legal name.',
    `errors_omissions_coverage_amount` DECIMAL(18,2) COMMENT 'Dollar amount of errors and omissions insurance coverage maintained by the general agent.',
    `errors_omissions_expiration_date` DATE COMMENT 'Expiration date of the general agents current errors and omissions insurance policy.',
    `errors_omissions_insurance_carrier` STRING COMMENT 'Name of the insurance carrier providing errors and omissions coverage for the general agent.',
    `errors_omissions_policy_number` STRING COMMENT 'Policy number for the general agents errors and omissions insurance coverage.',
    `licensed_states` STRING COMMENT 'Comma-separated list of two-letter state codes where the general agent holds active insurance licenses.',
    `lines_of_authority` STRING COMMENT 'Comma-separated list of insurance product lines the general agent is authorized to sell (e.g., life, health, disability, dental, vision).',
    `national_producer_number` STRING COMMENT 'Unique 10-digit identifier assigned by the National Association of Insurance Commissioners (NAIC) for producer licensing and tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the general agent relationship.',
    `override_commission_rate_percent` DECIMAL(18,2) COMMENT 'Override commission rate percentage paid to the general agent on sales made by sub-agents in their hierarchy.',
    `payment_method` STRING COMMENT 'Method by which commission payments are made to the general agent.',
    `performance_tier` STRING COMMENT 'Performance tier classification assigned to the general agent based on production volume, persistency, and quality metrics.',
    `persistency_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of policies sold by the general agent that remain in force after 12 months, used as a quality metric.',
    `primary_contact_email` STRING COMMENT 'Primary email address for business communications with the general agent.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the general agent organization.',
    `primary_contact_phone` STRING COMMENT 'Primary business phone number for the general agent contact.',
    `prior_year_production_amount` DECIMAL(18,2) COMMENT 'Total premium production amount generated by the general agent in the prior calendar year.',
    `renewal_commission_rate_percent` DECIMAL(18,2) COMMENT 'Commission rate percentage paid to the general agent on renewal business.',
    `sub_agent_count` STRING COMMENT 'Number of sub-agents or downstream producers contracted under this general agent.',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (FEIN) or Tax ID for the general agent entity used for tax reporting and commission payments.',
    `termination_date` DATE COMMENT 'Date when the general agent relationship was terminated or contract ended. Null if currently active.',
    `territory_code` STRING COMMENT 'Geographic territory or region code assigned to the general agent for sales and servicing responsibilities.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the general agent record was last modified in the system.',
    `website_url` STRING COMMENT 'Public website URL for the general agents business.',
    `year_to_date_production_amount` DECIMAL(18,2) COMMENT 'Total premium production amount generated by the general agent in the current calendar year to date.',
    CONSTRAINT pk_general_agent PRIMARY KEY(`general_agent_id`)
) COMMENT 'Master reference table for general_agent. Referenced by general_agent_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` (
    `employer_contract2_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to the broker who sold or manages this contract',
    `employee_id` BIGINT COMMENT 'FK to employee who executed the contract',
    `group_id` BIGINT COMMENT 'FK to group',
    `tpa_id` BIGINT COMMENT 'Foreign key linking to employer.tpa. Business justification: Employer contracts may involve TPA services for self-funded arrangements. This FK allows linking contracts that engage a TPA for administrative services. The employer_contract already has group_id, ve',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `annual_review_date` DATE COMMENT 'Annual review date',
    `aso_fee` DECIMAL(18,2) COMMENT 'ASO fee amount',
    `auto_renew_flag` BOOLEAN COMMENT 'Whether the contract auto-renews.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Whether the contract auto-renews at the end of term',
    `billing_frequency` STRING COMMENT 'Billing frequency',
    `contract_effective_date` DATE COMMENT 'Effective date of the contract',
    `contract_number` STRING COMMENT 'Contract number',
    `contract_term_months` STRING COMMENT 'Duration of the contract in months',
    `contract_termination_date` DATE COMMENT 'Termination date of the contract',
    `contract_type` STRING COMMENT 'Type of employer contract (ASO, fully-insured).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code for contract monetary values.',
    `effective_date` DATE COMMENT 'Effective date',
    `eligible_employee_count` STRING COMMENT 'Total number of eligible employees under this contract',
    `employer_contract_status` STRING COMMENT 'Contract status',
    `enrolled_employee_count` STRING COMMENT 'Current number of enrolled employees under this contract',
    `erisa_plan_flag` BOOLEAN COMMENT 'Whether the contract is governed by ERISA',
    `expiration_date` DATE COMMENT 'Date the contract expires.',
    `funding_arrangement_code` STRING COMMENT 'Funding arrangement code',
    `governing_law_state` STRING COMMENT 'State whose laws govern the contract',
    `minimum_contribution_pct` DECIMAL(18,2) COMMENT 'Minimum employer contribution percentage required',
    `minimum_participation_pct` DECIMAL(18,2) COMMENT 'Minimum employee participation percentage required',
    `payment_terms` STRING COMMENT 'Payment terms for the contract (e.g., net-30, net-15)',
    `renewal_date` DATE COMMENT 'Date the contract is due for renewal',
    `renewal_terms` STRING COMMENT 'Renewal terms and conditions.',
    `signed_date` DATE COMMENT 'Date the contract was executed.',
    `situs_state` STRING COMMENT 'State where the contract is sitused for regulatory purposes',
    `stop_loss_flag` BOOLEAN COMMENT 'Stop loss flag',
    `termination_date` DATE COMMENT 'Date the employer contract was terminated',
    `termination_reason` STRING COMMENT 'Reason for contract termination',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total contract value',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_employer_contract2 PRIMARY KEY(`employer_contract2_id`)
) COMMENT 'This association product represents the contractual relationship between an employer group and a vendor. It captures contract-specific details that exist only in the context of this relationship, linking one employer_group to one vendor per record.. Existence Justification: Employer groups negotiate separate contracts with multiple vendors, and each vendor can serve many employer groups. The contract itself carries attributes such as contract number, effective dates, status, total value, and review schedule, which are not owned by either the employer group or the vendor.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` (
    `underwriting_case_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `tpa_id` BIGINT COMMENT 'FK to TPA',
    `aca_adjustment_factor` DECIMAL(18,2) COMMENT 'ACA adjustment factor',
    `actuarial_basis_document` STRING COMMENT 'Actuarial basis document',
    `age_gender_composite_factor` DECIMAL(18,2) COMMENT 'Age/gender composite factor',
    `case_number` STRING COMMENT 'Case number',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `experience_rating_factor` DECIMAL(18,2) COMMENT 'Experience rating factor',
    `geographic_factor` DECIMAL(18,2) COMMENT 'Geographic factor',
    `group_average_age` DECIMAL(18,2) COMMENT 'Group average age',
    `group_census_size` STRING COMMENT 'Group census size',
    `group_female_percentage` DECIMAL(18,2) COMMENT 'Group female percentage',
    `industry_risk_factor` STRING COMMENT 'Industry risk factor',
    `manual_rate_basis` BOOLEAN COMMENT 'Manual rate basis flag',
    `pmpm_estimate` DECIMAL(18,2) COMMENT 'PMPM estimate',
    `prior_carrier_loss_experience` STRING COMMENT 'Prior carrier loss experience',
    `quote_expiration_timestamp` TIMESTAMP COMMENT 'Quote expiration timestamp',
    `quote_generated_timestamp` TIMESTAMP COMMENT 'Quote generated timestamp',
    `quote_status` STRING COMMENT 'Quote status',
    `rating_area_code` STRING COMMENT 'Rating area code',
    `rating_methodology` STRING COMMENT 'Rating methodology',
    `risk_tier` STRING COMMENT 'Risk tier',
    `submission_timestamp` TIMESTAMP COMMENT 'Submission timestamp',
    `total_premium_estimate` DECIMAL(18,2) COMMENT 'Total premium estimate',
    `underwriting_decision` STRING COMMENT 'Underwriting decision',
    `underwriting_status` STRING COMMENT 'Underwriting status',
    `updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    CONSTRAINT pk_underwriting_case PRIMARY KEY(`underwriting_case_id`)
) COMMENT 'Underwriting evaluation record and single source of truth for the complete risk assessment process from submission through rating through quote generation through decision for a new or renewing employer group. Tracks case submission date, group census data, prior carrier loss experience, medical underwriting status, risk tier assignment, manual rate basis; rating factors including age/gender composite factors, geographic area rating factors, industry risk factors, experience rating credibility weights, ACA-compliant rating adjustments, and actuarial basis documentation; underwriting decision (approved, declined, modified); and premium rate quotes with proposed rates by plan, coverage tier, and rating area, quote effective and expiration dates, rating methodology (community rated, experience rated, blended), proposed PMPM rates, total group premium estimate, and quote status (draft, presented, accepted, expired). Consolidates rating factors and rate quotes as stages within the underwriting case lifecycle. Links to the risk domain for RAF and HCC-based risk scoring at the group level. Supports the sales and renewal pipeline.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` (
    `employer_contract_id` BIGINT COMMENT 'Primary key for employer_contract',
    `employee_id` BIGINT COMMENT '',
    `aso_fee` DECIMAL(18,2) COMMENT '',
    `billing_frequency` STRING COMMENT '',
    `contract_effective_date` DATE COMMENT '',
    `contract_termination_date` DATE COMMENT '',
    `funding_arrangement_code` STRING COMMENT '',
    `renewal_terms` STRING COMMENT '',
    `signed_date` DATE COMMENT '',
    `stop_loss_flag` BOOLEAN COMMENT '',
    `total_contract_value` DECIMAL(18,2) COMMENT '',
    `aso_fee_amount` DECIMAL(18,2) COMMENT '',
    `renewal_terms_text` STRING COMMENT '',
    `total_contract_value_amount` DECIMAL(18,2) COMMENT '',
    `billing_frequency_code` STRING COMMENT '',
    `contract_signed_date` DATE COMMENT '',
    CONSTRAINT pk_employer_contract PRIMARY KEY(`employer_contract_id`)
) COMMENT 'Employer contract details including terms, coverage, and agreement information';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ADD CONSTRAINT `fk_employer_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ADD CONSTRAINT `fk_employer_group_contact_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ADD CONSTRAINT `fk_employer_group_division_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ADD CONSTRAINT `fk_employer_participation_requirement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_stop_loss_policy_id` FOREIGN KEY (`stop_loss_policy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`stop_loss_policy`(`stop_loss_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ADD CONSTRAINT `fk_employer_open_enrollment_window_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ADD CONSTRAINT `fk_employer_group_amendment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ADD CONSTRAINT `fk_employer_cobra_administration_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ADD CONSTRAINT `fk_employer_cobra_administration_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ADD CONSTRAINT `fk_employer_wellness_program_wellness_employer_group_id` FOREIGN KEY (`wellness_employer_group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ADD CONSTRAINT `fk_employer_wellness_program_wellness_group_id` FOREIGN KEY (`wellness_group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ADD CONSTRAINT `fk_employer_wellness_program_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ADD CONSTRAINT `fk_employer_group_document_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ADD CONSTRAINT `fk_employer_aso_fee_schedule_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ADD CONSTRAINT `fk_employer_aso_fee_schedule_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ADD CONSTRAINT `fk_employer_group_rating_factor_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ADD CONSTRAINT `fk_employer_erisa_plan_document_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` ADD CONSTRAINT `fk_employer_regulatory_compliance_record_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_broker_agreement_id` FOREIGN KEY (`broker_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker_agreement`(`broker_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_parent_broker_id` FOREIGN KEY (`parent_broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ADD CONSTRAINT `fk_employer_tpa_parent_tpa_id` FOREIGN KEY (`parent_tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_general_agent_id` FOREIGN KEY (`general_agent_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`general_agent`(`general_agent_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_parent_broker_agreement_id` FOREIGN KEY (`parent_broker_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker_agreement`(`broker_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_broker` FOREIGN KEY (`broker`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ADD CONSTRAINT `fk_employer_general_agent_supervising_general_agent_id` FOREIGN KEY (`supervising_general_agent_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`general_agent`(`general_agent_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ADD CONSTRAINT `fk_employer_employer_contract2_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ADD CONSTRAINT `fk_employer_employer_contract2_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ADD CONSTRAINT `fk_employer_employer_contract2_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ADD CONSTRAINT `fk_employer_underwriting_case_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ADD CONSTRAINT `fk_employer_underwriting_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ADD CONSTRAINT `fk_employer_underwriting_case_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`employer` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`employer` SET TAGS ('pii_domain' = 'employer');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Account Executive Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_underwriter_employee_id` SET TAGS ('pii_business_glossary_term' = 'Underwriter Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_underwriter_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_underwriter_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `parent_group_id` SET TAGS ('pii_business_glossary_term' = 'Parent Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `pool_id` SET TAGS ('pii_business_glossary_term' = 'Risk Pool Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `anniversary_date` SET TAGS ('pii_business_glossary_term' = 'Anniversary Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `average_claim_cost` SET TAGS ('pii_business_glossary_term' = 'Average Claim Cost');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `billing_frequency` SET TAGS ('pii_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `blended_rating_flag` SET TAGS ('pii_business_glossary_term' = 'Blended Rating Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `cobra_administrator` SET TAGS ('pii_business_glossary_term' = 'COBRA Administrator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `contribution_strategy` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `dba_name` SET TAGS ('pii_business_glossary_term' = 'Dba Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `dba_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `dba_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `dba_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `dba_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('pii_business_glossary_term' = 'Domicile State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `enrollment_count_ec` SET TAGS ('pii_business_glossary_term' = 'Enrollment Count Ec');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `enrollment_count_ef` SET TAGS ('pii_business_glossary_term' = 'Enrollment Count Ef');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `enrollment_count_eo` SET TAGS ('pii_business_glossary_term' = 'Enrollment Count Eo');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `enrollment_count_es` SET TAGS ('pii_business_glossary_term' = 'Enrollment Count Es');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `erisa_status` SET TAGS ('pii_business_glossary_term' = 'Erisa Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `experience_rating_flag` SET TAGS ('pii_business_glossary_term' = 'Experience Rating Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Last Updated');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Profile URL');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Resource ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Resource Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Version ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `fsa_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'FSA Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `funding_arrangement` SET TAGS ('pii_business_glossary_term' = 'Funding Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `gfc_code` SET TAGS ('pii_business_glossary_term' = 'Gfc Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_number` SET TAGS ('pii_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_status` SET TAGS ('pii_business_glossary_term' = 'Group Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `headcount_current` SET TAGS ('pii_business_glossary_term' = 'Headcount Current');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `headcount_last_month` SET TAGS ('pii_business_glossary_term' = 'Headcount Last Month');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `headcount_last_year` SET TAGS ('pii_business_glossary_term' = 'Headcount Last Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `hra_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'HRA Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `hsa_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'HSA Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `industry_code` SET TAGS ('pii_business_glossary_term' = 'Industry Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('pii_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line Of Business');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `manual_rating_flag` SET TAGS ('pii_business_glossary_term' = 'Manual Rating Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `multi_site_flag` SET TAGS ('pii_business_glossary_term' = 'Multi-Site Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `naics_code` SET TAGS ('pii_business_glossary_term' = 'Naics Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `original_effective_date` SET TAGS ('pii_business_glossary_term' = 'Original Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `participation_requirement` SET TAGS ('pii_business_glossary_term' = 'Participation Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `primary_contact_title` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `probation_period_days` SET TAGS ('pii_business_glossary_term' = 'Probation Period Days');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `section_125_plan_flag` SET TAGS ('pii_business_glossary_term' = 'Section 125 Plan Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `sic_code` SET TAGS ('pii_business_glossary_term' = 'Sic Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `size_tier` SET TAGS ('pii_business_glossary_term' = 'Size Tier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('pii_business_glossary_term' = 'Tax Id Ein');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `union_flag` SET TAGS ('pii_business_glossary_term' = 'Union Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `waiting_period_days` SET TAGS ('pii_business_glossary_term' = 'Waiting Period Days');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `wellness_program_flag` SET TAGS ('pii_business_glossary_term' = 'Wellness Program Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('pii_fhir_resource' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `group_location_id` SET TAGS ('pii_business_glossary_term' = 'Group Location Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `network_service_area_id` SET TAGS ('pii_business_glossary_term' = 'Network Service Area Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `facility_id` SET TAGS ('pii_business_glossary_term' = 'On Site Facility Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('pii_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `country_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `country_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('pii_business_glossary_term' = 'County Fips');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `geocode_accuracy` SET TAGS ('pii_business_glossary_term' = 'Geocode Accuracy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `group_location_status` SET TAGS ('pii_business_glossary_term' = 'Group Location Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('pii_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `rating_area` SET TAGS ('pii_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('pii_business_glossary_term' = 'Zip Plus4');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `group_contact_id` SET TAGS ('pii_business_glossary_term' = 'Group Contact Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `authorization_level` SET TAGS ('pii_business_glossary_term' = 'Authorization Level');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `can_bill` SET TAGS ('pii_business_glossary_term' = 'Can Bill');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `can_enroll` SET TAGS ('pii_business_glossary_term' = 'Can Enroll');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `contact_type` SET TAGS ('pii_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `department` SET TAGS ('pii_business_glossary_term' = 'Department');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('pii_business_glossary_term' = 'Email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('pii_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `group_contact_status` SET TAGS ('pii_business_glossary_term' = 'Group Contact Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('pii_business_glossary_term' = 'Is Primary Contact');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('pii_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `source_system_contact_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Contact Reference');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `group_division_id` SET TAGS ('pii_business_glossary_term' = 'Group Division Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Parent Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Primary Group Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `tertiary_group_epo_plan_health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Tertiary Group Epo Plan Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `tertiary_group_epo_plan_health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `tertiary_group_epo_plan_health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `billing_entity_flag` SET TAGS ('pii_business_glossary_term' = 'Billing Entity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `classification` SET TAGS ('pii_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `contribution_percent` SET TAGS ('pii_business_glossary_term' = 'Contribution Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `contribution_strategy` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `covered_member_count` SET TAGS ('pii_business_glossary_term' = 'Covered Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_code` SET TAGS ('pii_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_name` SET TAGS ('pii_business_glossary_term' = 'Division Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_type` SET TAGS ('pii_business_glossary_term' = 'Division Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `eligibility_rule_set` SET TAGS ('pii_business_glossary_term' = 'Eligibility Rule Set');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `employee_count` SET TAGS ('pii_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `flex_spending_amount` SET TAGS ('pii_business_glossary_term' = 'Flex Spending Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `fsa_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Fsa Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `group_division_status` SET TAGS ('pii_business_glossary_term' = 'Group Division Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `hsa_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Hsa Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_flex_spending` SET TAGS ('pii_business_glossary_term' = 'Is Eligible For Flex Spending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_fsa` SET TAGS ('pii_business_glossary_term' = 'Is Eligible For Fsa');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_hsa` SET TAGS ('pii_business_glossary_term' = 'Is Eligible For Hsa');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_subsidy` SET TAGS ('pii_business_glossary_term' = 'Is Eligible For Subsidy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_waiver` SET TAGS ('pii_business_glossary_term' = 'Is Eligible For Waiver');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `subsidy_percent` SET TAGS ('pii_business_glossary_term' = 'Subsidy Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_id` SET TAGS ('pii_business_glossary_term' = 'Group Plan Offering Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `tier_id` SET TAGS ('pii_business_glossary_term' = 'Tier Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Contribution Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Contribution Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_percent` SET TAGS ('pii_business_glossary_term' = 'Contribution Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_strategy_description` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_tier` SET TAGS ('pii_business_glossary_term' = 'Contribution Tier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_type` SET TAGS ('pii_business_glossary_term' = 'Contribution Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `employee_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `family_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Family Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_status` SET TAGS ('pii_business_glossary_term' = 'Group Plan Offering Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `hra_seed_amount` SET TAGS ('pii_business_glossary_term' = 'Hra Seed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `hsa_seed_amount` SET TAGS ('pii_business_glossary_term' = 'Hsa Seed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `is_affordable` SET TAGS ('pii_business_glossary_term' = 'Is Affordable');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `measurement_period_end` SET TAGS ('pii_business_glossary_term' = 'Measurement Period End');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `measurement_period_start` SET TAGS ('pii_business_glossary_term' = 'Measurement Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `minimum_enrolled_headcount` SET TAGS ('pii_business_glossary_term' = 'Minimum Enrolled Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `minimum_participation_percent` SET TAGS ('pii_business_glossary_term' = 'Minimum Participation Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_code` SET TAGS ('pii_business_glossary_term' = 'Offering Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_description` SET TAGS ('pii_business_glossary_term' = 'Offering Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('pii_business_glossary_term' = 'Offering Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_type` SET TAGS ('pii_business_glossary_term' = 'Offering Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `plan_catalog_version` SET TAGS ('pii_business_glossary_term' = 'Plan Catalog Version');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `waiver_criteria_description` SET TAGS ('pii_business_glossary_term' = 'Waiver Criteria Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `waiver_eligible` SET TAGS ('pii_business_glossary_term' = 'Waiver Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.plan.specificCost');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_id` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `affordability_test_flag` SET TAGS ('pii_business_glossary_term' = 'Affordability Test Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_code` SET TAGS ('pii_business_glossary_term' = 'Contribution Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_frequency` SET TAGS ('pii_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_percentage` SET TAGS ('pii_business_glossary_term' = 'Contribution Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('pii_business_glossary_term' = 'Contribution Rule Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_status` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_type` SET TAGS ('pii_business_glossary_term' = 'Contribution Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `employer_contribution_cap` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Cap');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `hra_employer_seed_amount` SET TAGS ('pii_business_glossary_term' = 'Hra Employer Seed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `hsa_employer_seed_amount` SET TAGS ('pii_business_glossary_term' = 'Hsa Employer Seed Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `is_post_tax` SET TAGS ('pii_business_glossary_term' = 'Is Post Tax');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `is_pre_tax` SET TAGS ('pii_business_glossary_term' = 'Is Pre Tax');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `maximum_employee_contribution` SET TAGS ('pii_business_glossary_term' = 'Maximum Employee Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `minimum_employee_contribution` SET TAGS ('pii_business_glossary_term' = 'Minimum Employee Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `tax_credit_eligible` SET TAGS ('pii_business_glossary_term' = 'Tax Credit Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `tier_code` SET TAGS ('pii_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `group_renewal_id` SET TAGS ('pii_business_glossary_term' = 'Group Renewal Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `broker_id` SET TAGS ('pii_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `tpa_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `amendment_flag` SET TAGS ('pii_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `audit_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `benefit_plan_ids` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan Ids');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `compliance_check_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `contribution_strategy` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `erisa_status` SET TAGS ('pii_business_glossary_term' = 'Erisa Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `funding_arrangement` SET TAGS ('pii_business_glossary_term' = 'Funding Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `group_size` SET TAGS ('pii_business_glossary_term' = 'Group Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_after_value` SET TAGS ('pii_business_glossary_term' = 'Latest Amendment After Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_approval_status` SET TAGS ('pii_business_glossary_term' = 'Latest Amendment Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_before_value` SET TAGS ('pii_business_glossary_term' = 'Latest Amendment Before Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_effective_date` SET TAGS ('pii_business_glossary_term' = 'Latest Amendment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Latest Amendment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_type` SET TAGS ('pii_business_glossary_term' = 'Latest Amendment Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `participation_requirement_met` SET TAGS ('pii_business_glossary_term' = 'Participation Requirement Met');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `participation_requirement_outcome` SET TAGS ('pii_business_glossary_term' = 'Participation Requirement Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `premium_rate_prior_year` SET TAGS ('pii_business_glossary_term' = 'Premium Rate Prior Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `premium_rate_renewal_year` SET TAGS ('pii_business_glossary_term' = 'Premium Rate Renewal Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `prior_renewal_effective_date` SET TAGS ('pii_business_glossary_term' = 'Prior Renewal Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `rate_change_percentage` SET TAGS ('pii_business_glossary_term' = 'Rate Change Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_cycle_year` SET TAGS ('pii_business_glossary_term' = 'Renewal Cycle Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_effective_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_end_date` SET TAGS ('pii_business_glossary_term' = 'Renewal End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_notes` SET TAGS ('pii_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_status` SET TAGS ('pii_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_status_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Status Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `retention_outcome` SET TAGS ('pii_business_glossary_term' = 'Retention Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `retention_reason_code` SET TAGS ('pii_business_glossary_term' = 'Retention Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `sic_code` SET TAGS ('pii_business_glossary_term' = 'Sic Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Participation Requirement Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `compliance_review_due_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `contribution_strategy` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_description` SET TAGS ('pii_business_glossary_term' = 'Participation Requirement Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `enrolled_headcount` SET TAGS ('pii_business_glossary_term' = 'Enrolled Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `erisa_status` SET TAGS ('pii_business_glossary_term' = 'Erisa Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `funding_arrangement` SET TAGS ('pii_business_glossary_term' = 'Funding Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `group_size` SET TAGS ('pii_business_glossary_term' = 'Group Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `last_evaluated_date` SET TAGS ('pii_business_glossary_term' = 'Last Evaluated Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `measurement_period` SET TAGS ('pii_business_glossary_term' = 'Measurement Period');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `minimum_enrolled_headcount` SET TAGS ('pii_business_glossary_term' = 'Minimum Enrolled Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `participation_percentage` SET TAGS ('pii_business_glossary_term' = 'Participation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_status` SET TAGS ('pii_business_glossary_term' = 'Participation Requirement Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_code` SET TAGS ('pii_business_glossary_term' = 'Requirement Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_business_glossary_term' = 'Requirement Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_type` SET TAGS ('pii_business_glossary_term' = 'Requirement Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `waiver_allowed` SET TAGS ('pii_business_glossary_term' = 'Waiver Allowed');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `waiver_percentage_allowed` SET TAGS ('pii_business_glossary_term' = 'Waiver Percentage Allowed');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('pii_subdomain' = 'distribution_channels');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Broker Assignment Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_id` SET TAGS ('pii_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('pii_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_status` SET TAGS ('pii_business_glossary_term' = 'Broker Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `commission_basis` SET TAGS ('pii_business_glossary_term' = 'Commission Basis');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `commission_rate` SET TAGS ('pii_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `commission_type` SET TAGS ('pii_business_glossary_term' = 'Commission Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('pii_subdomain' = 'administrative_services');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Arrangement Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `broker_id` SET TAGS ('pii_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_policy_id` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Policy Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_policy_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('pii_business_glossary_term' = 'Arrangement Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('pii_business_glossary_term' = 'Arrangement Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('pii_business_glossary_term' = 'Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `contract_reference` SET TAGS ('pii_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `contribution_rate_pmpm` SET TAGS ('pii_business_glossary_term' = 'Contribution Rate Pmpm');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `contribution_strategy` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `erisa_status` SET TAGS ('pii_business_glossary_term' = 'Erisa Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `fee_schedule_cap_amount` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Cap Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `fee_schedule_rate_pmpm` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Rate Pmpm');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `fee_schedule_type` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `gfc_control_flag` SET TAGS ('pii_business_glossary_term' = 'Gfc Control Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `group_size_max` SET TAGS ('pii_business_glossary_term' = 'Group Size Max');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `group_size_min` SET TAGS ('pii_business_glossary_term' = 'Group Size Min');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_aggregate_corridor` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Aggregate Corridor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_aggregate_deductible` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Aggregate Deductible');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_coverage_scope` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Coverage Scope');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_effective_date` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_individual_attachment_point` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Individual Attachment Point');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_laser_amount` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Laser Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_premium` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Premium');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_arrangement_status` SET TAGS ('pii_business_glossary_term' = 'Tpa Arrangement Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('pii_fhir_resource' = 'EnrollmentRequest');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `open_enrollment_window_id` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment Window Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `change_deadline` SET TAGS ('pii_business_glossary_term' = 'Change Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `eligible_employee_count` SET TAGS ('pii_business_glossary_term' = 'Eligible Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_method` SET TAGS ('pii_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Window Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Window Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `participation_rate` SET TAGS ('pii_business_glossary_term' = 'Participation Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `plan_selection_method` SET TAGS ('pii_business_glossary_term' = 'Plan Selection Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `total_employee_count` SET TAGS ('pii_business_glossary_term' = 'Total Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `waiver_allowed` SET TAGS ('pii_business_glossary_term' = 'Waiver Allowed');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `waiver_deadline` SET TAGS ('pii_business_glossary_term' = 'Waiver Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `window_code` SET TAGS ('pii_business_glossary_term' = 'Window Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('pii_subdomain' = 'underwriting_risk');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.plan.specificCost');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_id` SET TAGS ('pii_business_glossary_term' = 'Rate Quote Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `broker_id` SET TAGS ('pii_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `tpa_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `contribution_strategy` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `coverage_tier` SET TAGS ('pii_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `erisa_status` SET TAGS ('pii_business_glossary_term' = 'Erisa Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `gross_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_sic_code` SET TAGS ('pii_business_glossary_term' = 'Group Sic Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_size` SET TAGS ('pii_business_glossary_term' = 'Group Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_type` SET TAGS ('pii_business_glossary_term' = 'Group Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `issue_timestamp` SET TAGS ('pii_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `member_count` SET TAGS ('pii_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `net_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `pmpm_rate` SET TAGS ('pii_business_glossary_term' = 'Pmpm Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `quote_number` SET TAGS ('pii_business_glossary_term' = 'Quote Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `quote_version` SET TAGS ('pii_business_glossary_term' = 'Quote Version');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_status` SET TAGS ('pii_business_glossary_term' = 'Rate Quote Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rating_area` SET TAGS ('pii_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rating_methodology` SET TAGS ('pii_business_glossary_term' = 'Rating Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `total_group_premium_estimate` SET TAGS ('pii_business_glossary_term' = 'Total Group Premium Estimate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `group_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Group Amendment Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `after_value` SET TAGS ('pii_business_glossary_term' = 'After Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `amendment_status` SET TAGS ('pii_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `approval_user_role` SET TAGS ('pii_business_glossary_term' = 'Approval User Role');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `before_value` SET TAGS ('pii_business_glossary_term' = 'Before Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `contribution_change_amount` SET TAGS ('pii_business_glossary_term' = 'Contribution Change Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `is_critical_change` SET TAGS ('pii_business_glossary_term' = 'Is Critical Change');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `new_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'New Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `original_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Original Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `cobra_administration_id` SET TAGS ('pii_business_glossary_term' = 'Cobra Administration Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `tpa_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `administrator_type` SET TAGS ('pii_business_glossary_term' = 'Administrator Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `cobra_administration_status` SET TAGS ('pii_business_glossary_term' = 'Cobra Administration Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `cobra_agreement_number` SET TAGS ('pii_business_glossary_term' = 'Cobra Agreement Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `election_end_date` SET TAGS ('pii_business_glossary_term' = 'Election End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `election_period_days` SET TAGS ('pii_business_glossary_term' = 'Election Period Days');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `election_start_date` SET TAGS ('pii_business_glossary_term' = 'Election Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `group_cobra_eligibility` SET TAGS ('pii_business_glossary_term' = 'Group Cobra Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `last_compliance_check_date` SET TAGS ('pii_business_glossary_term' = 'Last Compliance Check Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `max_employee_count` SET TAGS ('pii_business_glossary_term' = 'Max Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `min_employee_count` SET TAGS ('pii_business_glossary_term' = 'Min Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `notification_required` SET TAGS ('pii_business_glossary_term' = 'Notification Required');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `premium_rate` SET TAGS ('pii_business_glossary_term' = 'Premium Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `premium_rate_multiplier` SET TAGS ('pii_business_glossary_term' = 'Premium Rate Multiplier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `qualifying_event_type` SET TAGS ('pii_business_glossary_term' = 'Qualifying Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `state_cobra_law` SET TAGS ('pii_business_glossary_term' = 'State Cobra Law');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `state_cobra_law` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `state_cobra_law` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('pii_fhir_resource' = 'CareTeam');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `wellness_program_id` SET TAGS ('pii_business_glossary_term' = 'Wellness Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Primary Wellness Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `wellness_employer_group_id` SET TAGS ('pii_business_glossary_term' = 'employer group');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `aca_compliance_classification` SET TAGS ('pii_business_glossary_term' = 'Aca Compliance Classification');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `current_participant_count` SET TAGS ('pii_business_glossary_term' = 'Current Participant Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `wellness_program_description` SET TAGS ('pii_business_glossary_term' = 'Wellness Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `enrollment_cap` SET TAGS ('pii_business_glossary_term' = 'Enrollment Cap');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `incentive_amount` SET TAGS ('pii_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `incentive_currency_code` SET TAGS ('pii_business_glossary_term' = 'Incentive Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `incentive_type` SET TAGS ('pii_business_glossary_term' = 'Incentive Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `is_eligible_for_tax_credit` SET TAGS ('pii_business_glossary_term' = 'Is Eligible For Tax Credit');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `participation_method` SET TAGS ('pii_business_glossary_term' = 'Participation Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_actual_participation_pct` SET TAGS ('pii_business_glossary_term' = 'Program Actual Participation Pct');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Program Budget Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_budget_currency` SET TAGS ('pii_business_glossary_term' = 'Program Budget Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_category` SET TAGS ('pii_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Program Compliance Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_effective_year` SET TAGS ('pii_business_glossary_term' = 'Program Effective Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_end_reason` SET TAGS ('pii_business_glossary_term' = 'Program End Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_last_review_date` SET TAGS ('pii_business_glossary_term' = 'Program Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_review_status` SET TAGS ('pii_business_glossary_term' = 'Program Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Program Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_source_system` SET TAGS ('pii_business_glossary_term' = 'Program Source System');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_subtype` SET TAGS ('pii_business_glossary_term' = 'Program Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_target_participation_pct` SET TAGS ('pii_business_glossary_term' = 'Program Target Participation Pct');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_version` SET TAGS ('pii_business_glossary_term' = 'Program Version');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `wellness_program_status` SET TAGS ('pii_business_glossary_term' = 'Wellness Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('pii_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `group_document_id` SET TAGS ('pii_business_glossary_term' = 'Group Document Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `amendment_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `audit_trail` SET TAGS ('pii_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `checksum` SET TAGS ('pii_business_glossary_term' = 'Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `confidential` SET TAGS ('pii_business_glossary_term' = 'Confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_category` SET TAGS ('pii_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_language` SET TAGS ('pii_business_glossary_term' = 'Document Language');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_title` SET TAGS ('pii_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `erisa_plan_administrator` SET TAGS ('pii_business_glossary_term' = 'Erisa Plan Administrator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `expiration_policy` SET TAGS ('pii_business_glossary_term' = 'Expiration Policy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `fiduciary_designation` SET TAGS ('pii_business_glossary_term' = 'Fiduciary Designation');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `file_format` SET TAGS ('pii_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `group_document_status` SET TAGS ('pii_business_glossary_term' = 'Group Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `is_electronic` SET TAGS ('pii_business_glossary_term' = 'Is Electronic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `last_reviewed_date` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `physical_location` SET TAGS ('pii_business_glossary_term' = 'Physical Location');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `retention_period_months` SET TAGS ('pii_business_glossary_term' = 'Retention Period Months');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `source_system_document_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `storage_uri` SET TAGS ('pii_business_glossary_term' = 'Storage Uri');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `trust_agreement_details` SET TAGS ('pii_business_glossary_term' = 'Trust Agreement Details');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('pii_subdomain' = 'underwriting_risk');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `aso_fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Aso Fee Schedule Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `tpa_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `aso_fee_schedule_status` SET TAGS ('pii_business_glossary_term' = 'Aso Fee Schedule Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('pii_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `cap_amount` SET TAGS ('pii_business_glossary_term' = 'Cap Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `cap_type` SET TAGS ('pii_business_glossary_term' = 'Cap Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `component_type` SET TAGS ('pii_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `aso_fee_schedule_description` SET TAGS ('pii_business_glossary_term' = 'Aso Fee Schedule Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `is_taxable` SET TAGS ('pii_business_glossary_term' = 'Is Taxable');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `minimum_participation_percent` SET TAGS ('pii_business_glossary_term' = 'Minimum Participation Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `pm_per_member_rate` SET TAGS ('pii_business_glossary_term' = 'Pm Per Member Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('pii_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `tax_rate` SET TAGS ('pii_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('pii_subdomain' = 'underwriting_risk');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('pii_fhir_resource' = 'Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `stop_loss_policy_id` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Policy Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `tpa_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_attachment_point` SET TAGS ('pii_business_glossary_term' = 'Aggregate Attachment Point');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_deductible_reset_period` SET TAGS ('pii_business_glossary_term' = 'Aggregate Deductible Reset Period');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `attachment_point_type` SET TAGS ('pii_business_glossary_term' = 'Attachment Point Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `carrier_name` SET TAGS ('pii_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `carrier_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `carrier_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `carrier_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `carrier_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit` SET TAGS ('pii_business_glossary_term' = 'Claim Payment Limit');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit_currency` SET TAGS ('pii_business_glossary_term' = 'Claim Payment Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `contribution_strategy` SET TAGS ('pii_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `covered_benefit_codes` SET TAGS ('pii_business_glossary_term' = 'Covered Benefit Codes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `individual_attachment_point` SET TAGS ('pii_business_glossary_term' = 'Individual Attachment Point');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `lasering_provision_flag` SET TAGS ('pii_business_glossary_term' = 'Lasering Provision Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `policy_type` SET TAGS ('pii_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `premium_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `premium_amount` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `premium_currency` SET TAGS ('pii_business_glossary_term' = 'Premium Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `stop_loss_policy_status` SET TAGS ('pii_business_glossary_term' = 'Stop Loss Policy Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('pii_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `group_rating_factor_id` SET TAGS ('pii_business_glossary_term' = 'Group Rating Factor Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `actuarial_basis` SET TAGS ('pii_business_glossary_term' = 'Actuarial Basis');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `factor_code` SET TAGS ('pii_business_glossary_term' = 'Factor Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `factor_description` SET TAGS ('pii_business_glossary_term' = 'Factor Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `factor_type` SET TAGS ('pii_business_glossary_term' = 'Factor Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `factor_value` SET TAGS ('pii_business_glossary_term' = 'Factor Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `group_rating_factor_status` SET TAGS ('pii_business_glossary_term' = 'Group Rating Factor Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `is_adjusted` SET TAGS ('pii_business_glossary_term' = 'Is Adjusted');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `is_default` SET TAGS ('pii_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `rating_period_end` SET TAGS ('pii_business_glossary_term' = 'Rating Period End');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `rating_period_start` SET TAGS ('pii_business_glossary_term' = 'Rating Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `source_system_factor_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Factor Reference');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `value_unit` SET TAGS ('pii_business_glossary_term' = 'Value Unit');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `erisa_plan_document_id` SET TAGS ('pii_business_glossary_term' = 'Erisa Plan Document Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `amendment_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `amendment_description` SET TAGS ('pii_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_name` SET TAGS ('pii_business_glossary_term' = 'Document Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_number` SET TAGS ('pii_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_type` SET TAGS ('pii_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `erisa_plan_document_status` SET TAGS ('pii_business_glossary_term' = 'Erisa Plan Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('pii_business_glossary_term' = 'Fiduciary Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_role` SET TAGS ('pii_business_glossary_term' = 'Fiduciary Role');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `filing_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `filing_status` SET TAGS ('pii_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_coverage_amount` SET TAGS ('pii_business_glossary_term' = 'Liability Insurance Coverage Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Liability Insurance Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_policy_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_policy_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_provider` SET TAGS ('pii_business_glossary_term' = 'Liability Insurance Provider');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('pii_business_glossary_term' = 'Plan Administrator Email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('pii_business_glossary_term' = 'Plan Administrator Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_address` SET TAGS ('pii_business_glossary_term' = 'Trust Address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_city` SET TAGS ('pii_business_glossary_term' = 'Trust City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_city` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('pii_business_glossary_term' = 'Trust Ein');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_name` SET TAGS ('pii_business_glossary_term' = 'Trust Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_state` SET TAGS ('pii_business_glossary_term' = 'Trust State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_state` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('pii_business_glossary_term' = 'Trust Zip');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_association_edges' = 'employer.employer_group,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('pii_subdomain' = 'distribution_channels');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_id` SET TAGS ('pii_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_vendor_vendor_id` SET TAGS ('pii_business_glossary_term' = 'vendor master');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `parent_broker_id` SET TAGS ('pii_business_glossary_term' = 'Parent Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_status` SET TAGS ('pii_business_glossary_term' = 'Broker Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_type` SET TAGS ('pii_business_glossary_term' = 'Broker Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_amount` SET TAGS ('pii_business_glossary_term' = 'Commission Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_currency` SET TAGS ('pii_business_glossary_term' = 'Commission Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_end_date` SET TAGS ('pii_business_glossary_term' = 'Commission End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_rate` SET TAGS ('pii_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_start_date` SET TAGS ('pii_business_glossary_term' = 'Commission Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('pii_business_glossary_term' = 'Email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('pii_business_glossary_term' = 'Fax');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_business_glossary_term' = 'Broker Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('pii_business_glossary_term' = 'Phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `rating` SET TAGS ('pii_business_glossary_term' = 'Rating');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `registration_number` SET TAGS ('pii_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `renewal_status` SET TAGS ('pii_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('pii_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('pii_subdomain' = 'administrative_services');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `parent_tpa_id` SET TAGS ('pii_business_glossary_term' = 'Parent Tpa Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_vendor_vendor_id` SET TAGS ('pii_business_glossary_term' = 'vendor master');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('pii_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_currency` SET TAGS ('pii_business_glossary_term' = 'Contract Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_end_date` SET TAGS ('pii_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_notes` SET TAGS ('pii_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_start_date` SET TAGS ('pii_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_status` SET TAGS ('pii_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_value` SET TAGS ('pii_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `country` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `country` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `country` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_limit_amount` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_limit_currency` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_name` SET TAGS ('pii_business_glossary_term' = 'Tpa Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `renewal_status` SET TAGS ('pii_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `sla_end` SET TAGS ('pii_business_glossary_term' = 'Sla End');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `sla_notes` SET TAGS ('pii_business_glossary_term' = 'Sla Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `sla_start` SET TAGS ('pii_business_glossary_term' = 'Sla Start');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `sla_status` SET TAGS ('pii_business_glossary_term' = 'Sla Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tax_number` SET TAGS ('pii_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_status` SET TAGS ('pii_business_glossary_term' = 'Tpa Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_type` SET TAGS ('pii_business_glossary_term' = 'Tpa Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('pii_business_glossary_term' = 'Zip');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_subdomain' = 'distribution_channels');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('pii_broker_fk_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Broker Agreement Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `general_agent_id` SET TAGS ('pii_business_glossary_term' = 'General Agent Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `parent_broker_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Parent Broker Agreement Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_id` SET TAGS ('pii_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `agreement_number` SET TAGS ('pii_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `appointment_date` SET TAGS ('pii_business_glossary_term' = 'Appointment Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `appointment_status` SET TAGS ('pii_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `base_commission_rate` SET TAGS ('pii_business_glossary_term' = 'Base Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_agreement_status` SET TAGS ('pii_business_glossary_term' = 'Broker Agreement Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `commission_schedule_type` SET TAGS ('pii_business_glossary_term' = 'Commission Schedule Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('pii_business_glossary_term' = 'Compensation Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compliance_certification_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `contract_version` SET TAGS ('pii_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `errors_omissions_expiry` SET TAGS ('pii_business_glossary_term' = 'Errors Omissions Expiry');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `errors_omissions_required` SET TAGS ('pii_business_glossary_term' = 'Errors Omissions Required');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('pii_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `market_segment` SET TAGS ('pii_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `minimum_production_requirement` SET TAGS ('pii_business_glossary_term' = 'Minimum Production Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `non_compete_period_months` SET TAGS ('pii_business_glossary_term' = 'Non Compete Period Months');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `override_commission_rate` SET TAGS ('pii_business_glossary_term' = 'Override Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('pii_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `product_line` SET TAGS ('pii_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `renewal_commission_rate` SET TAGS ('pii_business_glossary_term' = 'Renewal Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `state_of_licensure` SET TAGS ('pii_business_glossary_term' = 'State Of Licensure');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `state_of_licensure` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `state_of_licensure` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `territory_code` SET TAGS ('pii_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` SET TAGS ('pii_subdomain' = 'distribution_channels');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `general_agent_id` SET TAGS ('pii_business_glossary_term' = 'General Agent Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `supervising_general_agent_id` SET TAGS ('pii_business_glossary_term' = 'Supervising General Agent Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `supervising_general_agent_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `agent_code` SET TAGS ('pii_business_glossary_term' = 'Agent Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `agent_name` SET TAGS ('pii_business_glossary_term' = 'Agent Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `agent_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `agent_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `agent_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `agent_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `agent_status` SET TAGS ('pii_business_glossary_term' = 'Agent Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `agent_type` SET TAGS ('pii_business_glossary_term' = 'Agent Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `annual_production_target_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Production Target Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `annual_production_target_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `appointment_date` SET TAGS ('pii_business_glossary_term' = 'Appointment Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_number` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_type` SET TAGS ('pii_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_type` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_bank_account' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line1` SET TAGS ('pii_business_glossary_term' = 'Business Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line2` SET TAGS ('pii_business_glossary_term' = 'Business Address Line2');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line2` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line2` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_city` SET TAGS ('pii_business_glossary_term' = 'Business City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_country_code` SET TAGS ('pii_business_glossary_term' = 'Business Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_country_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_postal_code` SET TAGS ('pii_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_postal_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_state` SET TAGS ('pii_business_glossary_term' = 'Business State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `commission_payment_frequency` SET TAGS ('pii_business_glossary_term' = 'Commission Payment Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `commission_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `commission_rate_percent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `contract_effective_date` SET TAGS ('pii_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `contract_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_business_glossary_term' = 'Doing Business As Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `errors_omissions_coverage_amount` SET TAGS ('pii_business_glossary_term' = 'Errors Omissions Coverage Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `errors_omissions_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Errors Omissions Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `errors_omissions_insurance_carrier` SET TAGS ('pii_business_glossary_term' = 'Errors Omissions Insurance Carrier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `errors_omissions_policy_number` SET TAGS ('pii_business_glossary_term' = 'Errors Omissions Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `errors_omissions_policy_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `errors_omissions_policy_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `licensed_states` SET TAGS ('pii_business_glossary_term' = 'Licensed States');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `licensed_states` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `licensed_states` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `lines_of_authority` SET TAGS ('pii_business_glossary_term' = 'Lines Of Authority');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `national_producer_number` SET TAGS ('pii_business_glossary_term' = 'National Producer Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `override_commission_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Override Commission Rate Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `override_commission_rate_percent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `performance_tier` SET TAGS ('pii_business_glossary_term' = 'Performance Tier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `persistency_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Persistency Rate Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `prior_year_production_amount` SET TAGS ('pii_business_glossary_term' = 'Prior Year Production Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `prior_year_production_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `renewal_commission_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Renewal Commission Rate Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `renewal_commission_rate_percent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `sub_agent_count` SET TAGS ('pii_business_glossary_term' = 'Sub Agent Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `territory_code` SET TAGS ('pii_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `year_to_date_production_amount` SET TAGS ('pii_business_glossary_term' = 'Year To Date Production Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `year_to_date_production_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_subdomain' = 'administrative_services');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_association_edges' = 'employer.employer_group,vendor.vendor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `employer_contract2_id` SET TAGS ('pii_business_glossary_term' = 'Employer Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `broker_id` SET TAGS ('pii_business_glossary_term' = 'Broker');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `tpa_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `annual_review_date` SET TAGS ('pii_business_glossary_term' = 'Annual Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `auto_renew_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Renew');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `contract_term_months` SET TAGS ('pii_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `eligible_employee_count` SET TAGS ('pii_business_glossary_term' = 'Eligible Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `employer_contract_status` SET TAGS ('pii_business_glossary_term' = 'Employer Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `enrolled_employee_count` SET TAGS ('pii_business_glossary_term' = 'Enrolled Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `erisa_plan_flag` SET TAGS ('pii_business_glossary_term' = 'ERISA Plan Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `governing_law_state` SET TAGS ('pii_business_glossary_term' = 'Governing Law State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `governing_law_state` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `governing_law_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `minimum_contribution_pct` SET TAGS ('pii_business_glossary_term' = 'Minimum Contribution Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `minimum_participation_pct` SET TAGS ('pii_business_glossary_term' = 'Minimum Participation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `renewal_terms` SET TAGS ('pii_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `signed_date` SET TAGS ('pii_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `situs_state` SET TAGS ('pii_business_glossary_term' = 'Situs State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `situs_state` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `situs_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `total_contract_value` SET TAGS ('pii_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` SET TAGS ('pii_subdomain' = 'underwriting_risk');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `underwriting_case_id` SET TAGS ('pii_business_glossary_term' = 'Employer Underwriting Case Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `broker_id` SET TAGS ('pii_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `tpa_id` SET TAGS ('pii_business_glossary_term' = 'Tpa Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `aca_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Aca Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `actuarial_basis_document` SET TAGS ('pii_business_glossary_term' = 'Actuarial Basis Document');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('pii_business_glossary_term' = 'Age Gender Composite Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `case_number` SET TAGS ('pii_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `experience_rating_factor` SET TAGS ('pii_business_glossary_term' = 'Experience Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `geographic_factor` SET TAGS ('pii_business_glossary_term' = 'Geographic Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `group_average_age` SET TAGS ('pii_business_glossary_term' = 'Group Average Age');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `group_census_size` SET TAGS ('pii_business_glossary_term' = 'Group Census Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `group_female_percentage` SET TAGS ('pii_business_glossary_term' = 'Group Female Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `industry_risk_factor` SET TAGS ('pii_business_glossary_term' = 'Industry Risk Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `manual_rate_basis` SET TAGS ('pii_business_glossary_term' = 'Manual Rate Basis');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `pmpm_estimate` SET TAGS ('pii_business_glossary_term' = 'Pmpm Estimate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `prior_carrier_loss_experience` SET TAGS ('pii_business_glossary_term' = 'Prior Carrier Loss Experience');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `quote_expiration_timestamp` SET TAGS ('pii_business_glossary_term' = 'Quote Expiration Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `quote_generated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Quote Generated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `quote_status` SET TAGS ('pii_business_glossary_term' = 'Quote Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `rating_area_code` SET TAGS ('pii_business_glossary_term' = 'Rating Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `rating_methodology` SET TAGS ('pii_business_glossary_term' = 'Rating Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `risk_tier` SET TAGS ('pii_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `risk_tier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `risk_tier` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `total_premium_estimate` SET TAGS ('pii_business_glossary_term' = 'Total Premium Estimate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `underwriting_decision` SET TAGS ('pii_business_glossary_term' = 'Underwriting Decision');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `underwriting_status` SET TAGS ('pii_business_glossary_term' = 'Underwriting Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`underwriting_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` SET TAGS ('pii_subdomain' = 'administrative_services');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `employer_contract_id` SET TAGS ('pii_business_glossary_term' = 'employer_contract Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
