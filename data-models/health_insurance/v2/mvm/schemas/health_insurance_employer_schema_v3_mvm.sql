-- Schema for Domain: employer | Business: Health_Insurance | Version: v3_mvm
-- Generated on: 2026-07-10 22:45:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`employer` COMMENT 'Manages employer group accounts — the B2B commercial customers who sponsor health coverage for their employees. Owns group demographics, SIC classification, group size, ASO/fully-insured funding arrangements, ERISA status, GFC controls, employer-subscriber relationships, contribution strategies, renewal dates, and participation requirements. Supports group billing aggregation, renewal management, and broker/TPA associations. Source system: Facets or QNXT group management module.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group` (
    `group_id` BIGINT COMMENT 'System-generated unique identifier for the employer group record.',
    `broker_id` BIGINT COMMENT 'Reference to the broker or agency that sourced the group.',
    `address_line1` STRING COMMENT 'Primary street address of the employers headquarters.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `average_claim_cost` DECIMAL(18,2) COMMENT 'Average cost per claim historically incurred by the group.',
    `city` STRING COMMENT 'City component of the employers address.',
    `contribution_strategy` STRING COMMENT 'Method used to calculate employer contributions to premiums.. Valid values are `fixed|percentage|tiered`',
    `country` STRING COMMENT 'Country of the employers headquarters (ISO‑3 code).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employer group record was first created in the system.',
    `dba_name` STRING COMMENT 'Trade name or DBA under which the employer operates, if different from legal name.',
    `domicile_state` STRING COMMENT 'Two‑letter state code where the employer is legally domiciled.. Valid values are `^[A-Z]{2}$`',
    `effective_date` DATE COMMENT 'Date the employer group contract becomes binding.',
    `email_address` STRING COMMENT 'Primary email address for employer communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `enrollment_count_ec` STRING COMMENT 'Number of employees plus dependent children enrolled.',
    `enrollment_count_ef` STRING COMMENT 'Number of employees enrolled with full family coverage (employee, spouse, and children).',
    `enrollment_count_eo` STRING COMMENT 'Number of employees enrolled in employee‑only coverage.',
    `enrollment_count_es` STRING COMMENT 'Number of employees plus spouses enrolled.',
    `erisa_status` STRING COMMENT 'Indicates whether the group is subject to ERISA regulations.. Valid values are `covered|exempt`',
    `funding_arrangement` STRING COMMENT 'How the group pays for coverage: fully insured, ASO, or self‑funded.. Valid values are `fully_insured|aso|self_funded`',
    `gfc_code` BIGINT COMMENT 'Link to the financial control entity responsible for the groups accounting.',
    `group_status` STRING COMMENT 'Current lifecycle state of the employer group relationship.. Valid values are `prospect|active|suspended|terminated|reinstated`',
    `headcount_current` STRING COMMENT 'Current total number of employees covered under the group plan.',
    `headcount_last_month` STRING COMMENT 'Employee headcount as of the end of the previous month.',
    `headcount_last_year` STRING COMMENT 'Employee headcount as of the same month in the prior calendar year.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the status field last changed value.',
    `legal_name` STRING COMMENT 'Full legal name of the employer organization as registered.',
    `line_of_business` STRING COMMENT 'Primary product line(s) offered to the employer group.. Valid values are `health|dental|vision|wellness|pharmacy`',
    `market_segment` STRING COMMENT 'Regulatory market segment classification for the group.. Valid values are `small_group|large_group|individual`',
    `naics_code` STRING COMMENT 'Six‑digit code representing the employers industry sector.. Valid values are `^d{6}$`',
    `number` STRING COMMENT 'Internal identifier assigned to the employer group by the insurer.',
    `participation_requirement` STRING COMMENT 'Minimum employee participation level required for the group plan.',
    `phone_number` STRING COMMENT 'Primary business telephone number for the employer.. Valid values are `^d{10}$`',
    `postal_code` STRING COMMENT 'ZIP code for the employers address.. Valid values are `^d{5}(-d{4})?$`',
    `renewal_date` DATE COMMENT 'Scheduled date for contract renewal negotiations.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used in risk‑adjusted pricing for the group.',
    `sic_code` STRING COMMENT 'Four‑digit code classifying the employers primary industry.. Valid values are `^d{4}$`',
    `size_tier` STRING COMMENT 'Categorization of the employer based on employee headcount.. Valid values are `small|medium|large|enterprise`',
    `state` STRING COMMENT 'State component of the employers address.',
    `tax_id_ein` STRING COMMENT 'Federal tax identification number for the employer, used for reporting and compliance.. Valid values are `^d{2}-d{7}$`',
    `termination_date` DATE COMMENT 'Date the employer group contract is terminated or expires.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employer group record.',
    CONSTRAINT pk_group PRIMARY KEY(`group_id`)
) COMMENT 'Master record for employer group accounts — the B2B commercial customers who sponsor health coverage for their employees. Captures group demographics, legal entity name, tax ID (EIN), SIC/NAICS industry classification, group size tier, historical headcount and enrollment counts by coverage tier (EO/ES/EC/EF) tracked at monthly intervals for ACA small/large group market classification, line of business (LOB), funding arrangement (fully-insured vs ASO), ERISA status, domicile state, effective and termination dates, group financial control (GFC) identifiers, and complete lifecycle status transitions (prospect, active, suspended, terminated, reinstated) with status history. Single source of truth for employer group identity, size classification, headcount history, and status history.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_location` (
    `group_location_id` BIGINT COMMENT 'Unique surrogate key for each group location record.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Group locations belong to an employer group; linking enables address normalization and removes duplicate address fields from employer_group.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.service_area. Business justification: Needed for Network Adequacy Compliance audit: links employer location to the network service area covering that geography.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Links employer on‑site clinic locations to provider facilities, enabling employee access reporting and utilization analytics.',
    `plan_service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: Each group location must be validated against the plans service area to confirm plan eligibility before enrollment. This is a core eligibility check distinct from network service area coverage (alrea',
    `address_line1` STRING COMMENT 'First line of the street address.',
    `address_line2` STRING COMMENT 'Second line of the street address, if applicable.',
    `address_type` STRING COMMENT 'Classifies the purpose of the address (headquarters, billing, satellite, mailing).. Valid values are `headquarters|billing|satellite|mailing`',
    `city` STRING COMMENT 'City of the location.',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA).',
    `county_fips` STRING COMMENT 'Federal Information Processing Standard code for the county.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the location ceases to be effective; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the location becomes effective for billing and regulatory purposes.',
    `geocode_accuracy` STRING COMMENT 'Indicates the precision of the latitude/longitude coordinates.. Valid values are `high|medium|low`',
    `group_location_status` STRING COMMENT 'Current lifecycle status of the location record.. Valid values are `active|inactive|pending|closed`',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary address for the employer group.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the location in decimal degrees.',
    `location_code` STRING COMMENT 'Business identifier code for the location used in billing and regulatory filings.',
    `location_name` STRING COMMENT 'Descriptive name for the location (e.g., Headquarters, West Coast Office).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the location in decimal degrees.',
    `notes` STRING COMMENT 'Free-text field for additional remarks about the location.',
    `rating_area` STRING COMMENT 'Geographic rating area used for premium calculations.',
    `state` STRING COMMENT 'Two-letter state abbreviation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `zip_code` STRING COMMENT 'Five-digit postal code.',
    `zip_plus4` STRING COMMENT 'Extended ZIP+4 postal code.',
    CONSTRAINT pk_group_location PRIMARY KEY(`group_location_id`)
) COMMENT 'Physical and mailing addresses associated with an employer group, including headquarters, billing address, and satellite office locations. Tracks address type, street, city, state, ZIP+4, county FIPS code, and effective date range. Supports geographic rating, state regulatory filings, and premium billing address routing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` (
    `group_contact_id` BIGINT COMMENT 'System-generated unique identifier for the group contact record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group to which this contact belongs.',
    `address_line1` STRING COMMENT 'First line of the contacts mailing address.',
    `address_line2` STRING COMMENT 'Second line of the contacts mailing address, if applicable.',
    `authorization_level` STRING COMMENT 'Level of authority the contact has for enrollment and billing actions.. Valid values are `full|limited|view_only`',
    `can_bill` BOOLEAN COMMENT 'Indicates whether the contact is authorized to initiate billing or premium payment actions.',
    `can_enroll` BOOLEAN COMMENT 'Indicates whether the contact is authorized to submit enrollment transactions.',
    `city` STRING COMMENT 'City component of the contacts mailing address.',
    `contact_type` STRING COMMENT 'Classification of the contacts functional role for the employer group.. Valid values are `hr_admin|benefits_coordinator|payroll|executive_sponsor|other`',
    `country` STRING COMMENT 'Three‑letter ISO country code for the contacts address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was first created in the system.',
    `department` STRING COMMENT 'Department or business unit where the contact works.',
    `effective_end_date` DATE COMMENT 'Date when the contacts authorization expires or is terminated; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the contacts authorization becomes effective.',
    `email` STRING COMMENT 'Primary email address used for electronic communications with the contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the contact.',
    `full_name` STRING COMMENT 'Legal full name of the contact person.',
    `group_contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|terminated|pending`',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary point of contact for the group.',
    `last_name` STRING COMMENT 'Family name of the contact.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contact record.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the contact.',
    `phone_number` STRING COMMENT 'Primary telephone number for the contact.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the contacts mailing address.',
    `preferred_communication_channel` STRING COMMENT 'Contacts preferred method for receiving communications.. Valid values are `email|phone|mail|portal`',
    `source_system_contact_reference` STRING COMMENT 'Identifier for the contact as defined in the source system.',
    `state` STRING COMMENT 'State or province component of the contacts mailing address.',
    `title` STRING COMMENT 'Professional title or position of the contact within the employer organization.',
    CONSTRAINT pk_group_contact PRIMARY KEY(`group_contact_id`)
) COMMENT 'Authorized contacts associated with an employer group, including HR administrators, benefits coordinators, payroll contacts, and executive sponsors. Captures contact role type, name, title, phone, email, preferred communication channel, and authorization level for enrollment and billing transactions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` (
    `group_plan_offering_id` BIGINT COMMENT 'System‑generated unique identifier for the group plan offering record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Group plan offerings must reference a specific benefit_package (metal tier, cost-sharing design) for enrollment, SBC disclosure, and ACA compliance reporting. Benefits administrators and underwriters ',
    `contribution_strategy_id` BIGINT COMMENT 'Foreign key linking to employer.contribution_strategy. Business justification: A group plan offering is governed by a specific contribution strategy that defines employer/employee cost-sharing. contribution_strategy is the SSOT for contribution rules and already has group_id and',
    `group_id` BIGINT COMMENT 'Identifier of the employer group that sponsors this offering.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.open_enrollment_window. Business justification: A group plan offering is available for election during a specific open enrollment window. open_enrollment_window is the SSOT for enrollment period dates and already has group_id and plan_health_plan_i',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: A group plan offering is bound to a specific plan year governing open enrollment windows, accumulator resets, and ACA reporting periods. plan_year is a denormalized text value on group_plan_offering; ',
    `contribution_effective_end_date` DATE COMMENT 'Date when the defined contribution strategy expires; null if ongoing.',
    `contribution_effective_start_date` DATE COMMENT 'Date when the defined contribution strategy becomes effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the offering record was first created in the system.',
    `effective_from` DATE COMMENT 'Date the offering becomes binding for the employer group.',
    `effective_until` DATE COMMENT 'Date the offering ends; null for open‑ended contracts.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for employee‑only coverage.',
    `family_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for family coverage.',
    `group_plan_offering_status` STRING COMMENT 'Current lifecycle state of the offering.. Valid values are `active|pending|terminated|draft|suspended`',
    `hra_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to employee HRA accounts.',
    `hsa_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to employee HSA accounts.',
    `is_affordable` BOOLEAN COMMENT 'True if the offering meets ACA affordability testing for the employer group.',
    `measurement_period_end` DATE COMMENT 'End of the period used to evaluate participation compliance.',
    `measurement_period_start` DATE COMMENT 'Start of the period used to evaluate participation compliance.',
    `offering_code` STRING COMMENT 'External code used by the employer and carriers to reference this specific plan offering.',
    `offering_description` STRING COMMENT 'Narrative description of the plan offering, including benefits highlights.',
    `offering_name` STRING COMMENT 'Human‑readable name of the plan offering as displayed to employees.',
    `offering_type` STRING COMMENT 'Category of the health plan offering (e.g., QHP, HMO, PPO, EPO, HDHP, Dental, Vision). [ENUM-REF-CANDIDATE: qhp|hmo|ppo|epo|hdhp|dental|vision — promote to reference product]',
    `participation_status` STRING COMMENT 'Current compliance result for the offerings participation thresholds.. Valid values are `compliant|non_compliant|pending_review`',
    `plan_catalog_version` STRING COMMENT 'Version identifier of the plan catalog used for this offering.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the offering record.',
    `waiver_criteria_description` STRING COMMENT 'Narrative description of the conditions under which a waiver may be granted.',
    `waiver_eligible` BOOLEAN COMMENT 'Indicates whether the employer allows waiver of spousal or other coverage.',
    CONSTRAINT pk_group_plan_offering PRIMARY KEY(`group_plan_offering_id`)
) COMMENT 'The set of health plan products offered by an employer group to its eligible employees during a plan year — the single source of truth for what plans are available, how the employer contributes, and what participation rules apply. Captures which QHP, HMO, PPO, EPO, HDHP, dental, and vision plans are available; employer contribution strategy per plan including contribution type (flat dollar, percentage of premium, tiered by coverage tier), employee-only vs family contribution amounts, HSA/HRA employer seed amounts, and contribution effective date ranges; minimum participation percentage, minimum enrolled headcount, waiver eligibility criteria (e.g., spousal coverage waivers), measurement period, and participation compliance status; and the open enrollment window linkage. Consolidates contribution strategies and participation requirements as attributes of the plan offering. Links employer groups to the plan catalog and drives the enrollment eligibility matrix, premium billing split calculations, and ACA affordability compliance testing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` (
    `contribution_strategy_id` BIGINT COMMENT 'System-generated unique identifier for the contribution strategy record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Contribution strategies are often defined at the benefit_package level (e.g., employer contributes more toward gold than silver plans). ACA affordability testing and multi-tier employer contribution m',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group to which this contribution strategy applies.',
    `affordability_test_flag` BOOLEAN COMMENT 'Indicates whether the contribution satisfies the ACA affordability requirement.',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employer contributes per employee when contribution_type is flat.',
    `contribution_code` STRING COMMENT 'External business code used to reference the contribution strategy in contracts and communications.',
    `contribution_frequency` STRING COMMENT 'How often the employer contribution is applied to premium billing.. Valid values are `monthly|quarterly|annually`',
    `contribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of the premium the employer pays when contribution_type is percentage.',
    `contribution_rule_name` STRING COMMENT 'Descriptive name of the contribution rule for reporting and UI display.',
    `contribution_strategy_status` STRING COMMENT 'Current lifecycle state of the contribution strategy.. Valid values are `active|inactive|pending|retired`',
    `contribution_type` STRING COMMENT 'Method used to calculate the employer contribution: flat dollar amount, percentage of premium, or tiered based on coverage tier.. Valid values are `flat|percentage|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contribution strategy record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the contribution strategy expires or is superseded; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the contribution strategy becomes active.',
    `eligibility_criteria` STRING COMMENT 'Free‑text description of employee eligibility rules (e.g., full‑time status, tenure) for this contribution.',
    `employer_contribution_cap` DECIMAL(18,2) COMMENT 'Maximum total amount the employer will contribute per employee per billing period.',
    `hra_employer_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to a Health Reimbursement Arrangement for eligible employees.',
    `hsa_employer_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to a Health Savings Account for eligible employees.',
    `is_post_tax` BOOLEAN COMMENT 'True if the employer contribution is made on a post‑tax basis.',
    `is_pre_tax` BOOLEAN COMMENT 'True if the employer contribution is made on a pre‑tax basis.',
    `last_review_date` DATE COMMENT 'Date when the contribution strategy was last reviewed for compliance or policy updates.',
    `maximum_employee_contribution` DECIMAL(18,2) COMMENT 'Highest amount an employee may be required to pay after employer contribution is applied.',
    `minimum_employee_contribution` DECIMAL(18,2) COMMENT 'Lowest amount an employee must pay after employer contribution is applied.',
    `notes` STRING COMMENT 'Additional comments or special instructions related to the contribution strategy.',
    `review_status` STRING COMMENT 'Result of the most recent compliance review.. Valid values are `compliant|non_compliant|under_review`',
    `tax_credit_eligible` BOOLEAN COMMENT 'Indicates whether the contribution qualifies for a tax credit under applicable regulations.',
    `tier_code` STRING COMMENT 'Code indicating the employee coverage tier (e.g., employee‑only, family) that the contribution amount applies to.. Valid values are `employee|family|spouse|child`',
    `updated_by` STRING COMMENT 'User or system identifier that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the contribution strategy record.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_contribution_strategy PRIMARY KEY(`contribution_strategy_id`)
) COMMENT 'Employer contribution rules defining how much the employer pays toward employee and dependent premiums for each offered plan. Captures contribution type (flat dollar, percentage of premium, tiered by coverage tier), employee-only vs family contribution amounts, HSA/HRA employer seed amounts, and effective date ranges. Supports premium billing split calculations and ACA affordability compliance testing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` (
    `group_renewal_id` BIGINT COMMENT 'System-generated unique identifier for the group renewal record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Renewal processing requires knowing the specific benefit_package being renewed or replaced. ACA and ERISA compliance checks, rate change calculations, and retention analysis all depend on the benefit ',
    `broker_id` BIGINT COMMENT 'Identifier of the broker representing the group.',
    `contribution_strategy_id` BIGINT COMMENT 'Foreign key linking to employer.contribution_strategy. Business justification: group_renewal currently stores contribution_strategy as a denormalized STRING column. The renewal lifecycle record is the single source of truth for all group configuration changes, and the contributi',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group associated with this renewal.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Group renewals are executed for a specific plan year; open enrollment windows, premium effective dates, and ACA compliance filings are all governed by the plan.year record. renewal_cycle_year is a den',
    `amendment_count` STRING COMMENT 'Total number of amendments applied to this renewal record.',
    `amendment_flag` BOOLEAN COMMENT 'True if any amendment has been applied to the renewal.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the renewal record was first created in the data warehouse.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the renewal record.',
    `compliance_check_date` DATE COMMENT 'Date on which the regulatory compliance check was performed.',
    `compliance_status` STRING COMMENT 'Result of the compliance validation for the renewal.. Valid values are `compliant|non_compliant|pending`',
    `erisa_status` STRING COMMENT 'Indicates whether the Employee Retirement Income Security Act applies to the group.. Valid values are `applicable|not_applicable`',
    `funding_arrangement` STRING COMMENT 'Method by which the group finances coverage.. Valid values are `fully_insured|aso|self_funded|tpa`',
    `group_size` STRING COMMENT 'Total number of covered individuals in the group for the renewal year.',
    `latest_amendment_after_value` DECIMAL(18,2) COMMENT 'Value of the changed attribute after the amendment (stored as text).',
    `latest_amendment_approval_status` STRING COMMENT 'Approval status of the most recent amendment.. Valid values are `approved|rejected|pending`',
    `latest_amendment_before_value` DECIMAL(18,2) COMMENT 'Value of the changed attribute before the amendment (stored as text).',
    `latest_amendment_effective_date` DATE COMMENT 'Effective date of the most recent amendment.',
    `latest_amendment_reason_code` STRING COMMENT 'Standardized reason code for the most recent amendment.',
    `latest_amendment_type` STRING COMMENT 'Type of the most recent amendment applied to the renewal.. Valid values are `benefit_change|plan_add_drop|contribution_change|address_update|contact_change`',
    `participation_requirement_met` BOOLEAN COMMENT 'Indicates whether the group met the minimum participation threshold for the renewal.',
    `participation_requirement_outcome` STRING COMMENT 'Result of the participation requirement evaluation.. Valid values are `met|not_met|partial`',
    `premium_rate_prior_year` DECIMAL(18,2) COMMENT 'Base premium rate applied in the prior renewal year.',
    `premium_rate_renewal_year` DECIMAL(18,2) COMMENT 'Base premium rate applied for the renewal year.',
    `prior_renewal_effective_date` DATE COMMENT 'Effective date of the immediately preceding renewal.',
    `rate_change_percentage` DECIMAL(18,2) COMMENT 'Percent change between prior year and renewal year premium rates.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the renewal passed all required regulatory validations.',
    `renewal_effective_date` DATE COMMENT 'First day of coverage under the renewed contract.',
    `renewal_end_date` DATE COMMENT 'Last day of coverage for the renewal term.',
    `renewal_notes` STRING COMMENT 'Free‑form notes entered by users during the renewal process.',
    `renewal_status` STRING COMMENT 'Current workflow status of the renewal.. Valid values are `pending|proposed|accepted|declined|expired`',
    `renewal_status_date` DATE COMMENT 'Date when the current renewal status was set.',
    `retention_outcome` STRING COMMENT 'Result of the renewal in terms of group retention.. Valid values are `retained|lost|pending`',
    `retention_reason_code` STRING COMMENT 'Code describing why a group was retained or lost.',
    `sic_code` STRING COMMENT 'Four‑digit industry classification code for the employer.',
    CONSTRAINT pk_group_renewal PRIMARY KEY(`group_renewal_id`)
) COMMENT 'Annual renewal lifecycle record and single source of truth for all group configuration changes — both at renewal and between renewal cycles. Captures renewal effective date, prior year vs renewal year premium rates, rate change percentage, benefit modifications, participation requirement outcomes, renewal status (pending, proposed, accepted, declined), and retention outcome. Also captures mid-year and off-cycle amendments including amendment type (benefit change, plan add/drop, contribution change, address update, contact change), amendment effective date, reason code, approval status, and before/after values of changed attributes. Consolidates group amendments as lifecycle events within the renewal record — amendments are tracked against the current plan years renewal. Provides complete audit trail for group retention management, regulatory compliance, and configuration change history.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` (
    `broker_assignment_id` BIGINT COMMENT 'Unique surrogate key for the broker assignment record.',
    `broker_id` BIGINT COMMENT 'FK to employer.broker',
    `group_id` BIGINT COMMENT 'Unique identifier for the employer group (client) in the core administration system.',
    `agency_name` STRING COMMENT 'Legal name of the brokers agency or firm.',
    `broker_assignment_status` STRING COMMENT 'Current lifecycle status of the broker assignment.. Valid values are `active|inactive|pending|terminated`',
    `commission_basis` STRING COMMENT 'Business metric on which the commission is calculated.. Valid values are `premium|claim|revenue|service_fee`',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate applicable to the broker for this employer group, expressed as a percentage.',
    `commission_type` STRING COMMENT 'Method used to calculate broker commission.. Valid values are `percentage|flat|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker assignment record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the broker assignment terminates or expires. Null if ongoing.',
    `effective_start_date` DATE COMMENT 'Date when the broker assignment becomes effective.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating whether this broker is the primary broker for the employer group.',
    `notes` STRING COMMENT 'Free-text field for additional comments or remarks about the broker assignment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the broker assignment record.',
    CONSTRAINT pk_broker_assignment PRIMARY KEY(`broker_assignment_id`)
) COMMENT 'Association between an employer group and its licensed broker(s) or general agent(s), capturing the broker NPN, agency name, commission arrangement type, commission rate, effective and termination dates, and primary vs secondary broker designation. Supports broker compensation processing, group servicing accountability, and regulatory disclosure requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` (
    `rate_quote_id` BIGINT COMMENT 'System‑generated unique identifier for the premium rate quote.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Rate quotes are generated for a specific benefit_package; the deductible, OOP max, and copay structure in the package directly drive actuarial pricing. Underwriting and quoting systems require this li',
    `broker_id` BIGINT COMMENT 'Identifier of the broker or sales agent handling the quote.',
    `contribution_strategy_id` BIGINT COMMENT 'Foreign key linking to employer.contribution_strategy. Business justification: rate_quote currently stores contribution_strategy as a denormalized STRING column. contribution_strategy is a first-class product in the employer domain with its own PK. Normalizing this relationship ',
    `group_id` BIGINT COMMENT 'Identifier of the employer group for which the quote is generated.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.employer_underwriting_case. Business justification: A rate quote is generated as the output of an underwriting evaluation. The employer_underwriting_case is the source of the risk assessment that drives the rate quote. Linking rate_quote to employer_un',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: A rate quote is derived from a specific base rate record. Underwriting audit trails, regulatory filings, and repricing workflows require tracing each quote back to the plan.rate record used as its bas',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Rate quotes are issued for a specific plan year; the plan year determines rating parameters, regulatory filing deadlines, and premium effective dates. plan_year is a denormalized text field on rate_qu',
    `coverage_tier` STRING COMMENT 'Tier of coverage being quoted (e.g., employee only, family).. Valid values are `employee|family|individual|spouse`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the quote (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of any discounts applied to the gross premium.',
    `effective_date` DATE COMMENT 'First date on which the quoted rates become effective if the quote is accepted.',
    `erisa_status` STRING COMMENT 'Indicates whether the employer group is subject to ERISA regulations.. Valid values are `ERISA|NonERISA`',
    `expiration_date` DATE COMMENT 'Date after which the quote is no longer valid.',
    `gross_premium_amount` DECIMAL(18,2) COMMENT 'Total premium before any discounts or adjustments, expressed in the quote currency.',
    `group_sic_code` STRING COMMENT 'Standard Industrial Classification code describing the employers industry.',
    `group_size` STRING COMMENT 'Total number of employees eligible for coverage under the employer group.',
    `group_type` STRING COMMENT 'Funding arrangement for the group: Administrative Services Only (ASO) or Fully Insured.. Valid values are `ASO|FullyInsured`',
    `issue_timestamp` TIMESTAMP COMMENT 'Date‑time when the quote was formally issued to the employer.',
    `member_count` STRING COMMENT 'Number of covered lives in the employer group for the quoted period.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Final premium after discounts, the amount the employer is expected to pay.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions.',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'Proposed premium rate expressed as a per‑member‑per‑month amount.',
    `quote_number` STRING COMMENT 'External reference number assigned to the quote for tracking and communication with the employer.',
    `quote_version` STRING COMMENT 'Version number of the quote, incremented on each revision.',
    `rate_quote_status` STRING COMMENT 'Current lifecycle state of the quote (e.g., draft, presented, accepted, expired, rejected).. Valid values are `draft|presented|accepted|expired|rejected`',
    `rating_area` STRING COMMENT 'Geographic rating area used to calculate the premium.',
    `rating_methodology` STRING COMMENT 'Method used to calculate rates: community, experience, or blended.. Valid values are `community|experience|blended`',
    `renewal_date` DATE COMMENT 'Date when the current policy term ends and renewal is expected.',
    `total_group_premium_estimate` DECIMAL(18,2) COMMENT 'Projected total premium for the entire employer group based on the quoted rates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the quote record.',
    CONSTRAINT pk_rate_quote PRIMARY KEY(`rate_quote_id`)
) COMMENT 'Premium rate quote issued to a prospective or renewing employer group, capturing proposed rates by plan, coverage tier, and rating area. Includes quote effective date, expiration date, rating methodology (community rated, experience rated, blended), proposed PMPM rates, total group premium estimate, and quote status (draft, presented, accepted, expired). Supports the sales and renewal pipeline.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` (
    `stop_loss_policy_id` BIGINT COMMENT 'System‑generated unique identifier for the stop‑loss policy record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Stop-loss policies for self-funded groups are underwritten against a specific benefit design. Attachment points, covered benefit codes, and aggregate deductibles are calibrated to the benefit_package ',
    `contribution_strategy_id` BIGINT COMMENT 'Foreign key linking to employer.contribution_strategy. Business justification: stop_loss_policy currently stores contribution_strategy as a denormalized STRING column. For self-funded ASO groups, the stop-loss policy is directly tied to the employers contribution strategy — the',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Stop‑loss policy is tied to an employer group; linking creates proper relationship.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Stop-loss policies are negotiated and renewed as part of the annual group renewal process. Linking stop_loss_policy to group_renewal establishes which renewal cycle the policy was issued for, enabling',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Stop-loss policies are underwritten and priced per plan year; the plan year governs the policy period, aggregate deductible reset dates, and claims run-out periods. Stop-loss reinsurance settlements a',
    `aggregate_attachment_point` DECIMAL(18,2) COMMENT 'Total deductible amount the employer group must incur before the carrier pays for excess claims.',
    `aggregate_deductible_reset_period` STRING COMMENT 'Period after which the aggregate attachment point resets (e.g., annually).. Valid values are `annual|calendar_year|policy_year`',
    `attachment_point_type` STRING COMMENT 'Specifies whether attachment points are calculated per individual claim or on an annual basis.. Valid values are `per_claim|per_year`',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier that provides the stop‑loss coverage.',
    `claim_payment_limit` DECIMAL(18,2) COMMENT 'Maximum amount the carrier will pay for a single claim under the stop‑loss policy.',
    `claim_payment_limit_currency` STRING COMMENT 'Currency of the claim payment limit.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `covered_benefit_codes` STRING COMMENT 'Comma‑separated list of benefit codes (e.g., CPT, DRG) that are covered under the stop‑loss policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the stop‑loss policy record was first created in the system.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'General deductible amount defined in the stop‑loss contract (may differ from attachment points).',
    `effective_from` DATE COMMENT 'Date on which the stop‑loss coverage becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the stop‑loss coverage expires (if not renewed).',
    `individual_attachment_point` DECIMAL(18,2) COMMENT 'Deductible amount an individual member must incur before the stop‑loss carrier pays.',
    `lasering_provision_flag` BOOLEAN COMMENT 'Indicates whether the policy includes a lasering provision (reinstatement after a loss).',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions related to the policy.',
    `policy_number` STRING COMMENT 'External policy number assigned by the carrier; used for billing and claims.',
    `policy_type` STRING COMMENT 'Indicates whether the policy provides individual attachment point coverage, aggregate coverage, or both.. Valid values are `individual|aggregate|both`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Periodic premium charged by the carrier for the stop‑loss coverage.',
    `premium_currency` STRING COMMENT 'Three‑letter ISO currency code for the premium amount.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `renewal_date` DATE COMMENT 'Scheduled date for policy renewal negotiations.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor applied to the premium based on the employer groups risk profile.',
    `stop_loss_policy_status` STRING COMMENT 'Current lifecycle status of the stop‑loss policy.. Valid values are `active|inactive|terminated|pending`',
    `termination_date` DATE COMMENT 'Date the policy was terminated prior to its scheduled expiration, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the stop‑loss policy record.',
    CONSTRAINT pk_stop_loss_policy PRIMARY KEY(`stop_loss_policy_id`)
) COMMENT 'Stop-loss (excess loss) insurance policy associated with a self-funded ASO employer group, providing financial protection against catastrophic claims. Captures stop-loss carrier name, policy number, specific deductible (individual attachment point), aggregate deductible, lasering provisions, covered benefits, policy effective and expiration dates, and premium amounts. Critical for ASO group financial risk management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker` (
    `broker_id` BIGINT COMMENT 'Primary key for broker',
    `parent_broker_id` BIGINT COMMENT 'Self-referencing FK on broker (parent_broker_id)',
    `address_line1` STRING COMMENT 'First line of brokers physical address.',
    `address_line2` STRING COMMENT 'Second line of brokers physical address.',
    `agreement_end_date` DATE COMMENT 'End date of the broker agreement.',
    `agreement_start_date` DATE COMMENT 'Start date of the broker agreement.',
    `agreement_status` STRING COMMENT 'Current status of the broker agreement.',
    `agreement_terms` STRING COMMENT 'Detailed terms and conditions of the broker agreement.',
    `broker_status` STRING COMMENT 'Current operational status of the broker.',
    `broker_type` STRING COMMENT 'Classification of broker (e.g., independent, captive).',
    `city` STRING COMMENT 'City of brokers address.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount paid to the broker.',
    `commission_currency` STRING COMMENT 'Currency in which the commission is paid.',
    `commission_end_date` DATE COMMENT 'End date of the commission period.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate agreed with the broker.',
    `commission_start_date` DATE COMMENT 'Start date of the commission period.',
    `country` STRING COMMENT 'Country of brokers address.',
    `email` STRING COMMENT 'Primary email address for broker communication.',
    `end_date` DATE COMMENT 'Date when the broker relationship ended or is scheduled to end.',
    `fax` STRING COMMENT 'Fax number for broker contact.',
    `license_number` STRING COMMENT 'License number issued by regulatory authority.',
    `broker_name` STRING COMMENT 'Full legal name of the broker.',
    `phone` STRING COMMENT 'Primary phone number for broker contact.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of brokers address.',
    `rating` DECIMAL(18,2) COMMENT 'Credit rating or performance score assigned to the broker.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the broker record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp when the broker record was last updated.',
    `region` STRING COMMENT 'Geographic region where the broker operates.',
    `registration_number` STRING COMMENT 'Official registration number assigned to the broker.',
    `renewal_date` DATE COMMENT 'Scheduled date for renewing the broker agreement.',
    `renewal_status` STRING COMMENT 'Current status of the renewal process.',
    `start_date` DATE COMMENT 'Date when the broker relationship began.',
    `state` STRING COMMENT 'State or province of brokers address.',
    `tax_number` STRING COMMENT 'Tax ID used for regulatory reporting.',
    `termination_reason` STRING COMMENT 'Reason for terminating the broker relationship.',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Master reference table for broker. Referenced by broker_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ADD CONSTRAINT `fk_employer_group_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ADD CONSTRAINT `fk_employer_group_contact_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_contribution_strategy_id` FOREIGN KEY (`contribution_strategy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`contribution_strategy`(`contribution_strategy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_contribution_strategy_id` FOREIGN KEY (`contribution_strategy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`contribution_strategy`(`contribution_strategy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_contribution_strategy_id` FOREIGN KEY (`contribution_strategy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`contribution_strategy`(`contribution_strategy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_contribution_strategy_id` FOREIGN KEY (`contribution_strategy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`contribution_strategy`(`contribution_strategy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_parent_broker_id` FOREIGN KEY (`parent_broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`employer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`employer` SET TAGS ('dbx_domain' = 'employer');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (Broker Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Address Line 1)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Address Line 2)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `average_claim_cost` SET TAGS ('dbx_business_glossary_term' = 'Average Claim Cost (Average Claim Cost)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (City)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy (Contribution Strategy)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country (Country)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Record Creation Timestamp)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name (DBA Name)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('dbx_business_glossary_term' = 'Domicile State (Domicile State)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Effective Date)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (Email Address)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `enrollment_count_ec` SET TAGS ('dbx_business_glossary_term' = 'Employee + Child Enrollment Count (Employee + Child Enrollment Count)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `enrollment_count_ef` SET TAGS ('dbx_business_glossary_term' = 'Family Enrollment Count (Family Enrollment Count)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `enrollment_count_eo` SET TAGS ('dbx_business_glossary_term' = 'Employee‑Only Enrollment Count (Employee‑Only Enrollment Count)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `enrollment_count_es` SET TAGS ('dbx_business_glossary_term' = 'Employee + Spouse Enrollment Count (Employee + Spouse Enrollment Count)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Status (ERISA Status)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'covered|exempt');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Funding Arrangement (Funding Arrangement)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_value_regex' = 'fully_insured|aso|self_funded');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `gfc_code` SET TAGS ('dbx_business_glossary_term' = 'Group Financial Control Identifier (GFC Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_status` SET TAGS ('dbx_business_glossary_term' = 'Group Lifecycle Status (Group Lifecycle Status)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_status` SET TAGS ('dbx_value_regex' = 'prospect|active|suspended|terminated|reinstated');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `headcount_current` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount (Current Headcount)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `headcount_last_month` SET TAGS ('dbx_business_glossary_term' = 'Headcount Last Month (Headcount Last Month)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `headcount_last_year` SET TAGS ('dbx_business_glossary_term' = 'Headcount Last Year (Headcount Last Year)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp (Last Status Change Timestamp)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name (Legal Name)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (Line of Business)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'health|dental|vision|wellness|pharmacy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (Market Segment)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'small_group|large_group|individual');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System Code (NAICS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Group Number (Group Number)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `participation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Participation Requirement (Participation Requirement)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (Phone Number)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^d{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (Postal Code)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date (Renewal Date)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (Risk Adjustment Factor)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification Code (SIC)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `size_tier` SET TAGS ('dbx_business_glossary_term' = 'Group Size Tier (Group Size Tier)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `size_tier` SET TAGS ('dbx_value_regex' = 'small|medium|large|enterprise');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State (State)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Termination Date)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Record Update Timestamp)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `group_location_id` SET TAGS ('dbx_business_glossary_term' = 'Group Location ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'On Site Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `plan_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Group Location Address Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'headquarters|billing|satellite|mailing');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('dbx_business_glossary_term' = 'County FIPS Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `group_location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `group_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Location Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Group Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Group Location Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `rating_area` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_business_glossary_term' = 'ZIP+4 Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `group_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Group Contact ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Contact Authorization Level (AUTHORIZATION_LEVEL)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'full|limited|view_only');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `can_bill` SET TAGS ('dbx_business_glossary_term' = 'Can Bill Flag (CAN_BILL)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `can_enroll` SET TAGS ('dbx_business_glossary_term' = 'Can Enroll Flag (CAN_ENROLL)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Contact City (CITY)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type (CONTACT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'hr_admin|benefits_coordinator|payroll|executive_sponsor|other');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Contact Country Code (COUNTRY)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department (DEPARTMENT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address (EMAIL)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name (FIRST_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name (FULL_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `group_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `group_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag (IS_PRIMARY_CONTACT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name (LAST_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (LAST_UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number (PHONE_NUMBER)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Postal Code (POSTAL_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel (PREFERRED_COMM_CHANNEL)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mail|portal');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `source_system_contact_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Contact Identifier (SOURCE_SYSTEM_CONTACT_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Contact State/Province (STATE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title (TITLE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier (EMP_GRP_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Effective End Date (CONTRIB_EFF_END)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Effective Start Date (CONTRIB_EFF_START)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_FROM)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_UNTIL)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee‑Only Contribution Amount (EMP_CONTRIB_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `family_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Family Contribution Amount (FAM_CONTRIB_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_status` SET TAGS ('dbx_business_glossary_term' = 'Offering Status (OFC_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|draft|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `hra_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Reimbursement Arrangement Seed Amount (HRA_SEED)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `hsa_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account Seed Amount (HSA_SEED)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `is_affordable` SET TAGS ('dbx_business_glossary_term' = 'ACA Affordability Indicator (ACA_AFFORD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date (MEAS_END)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date (MEAS_START)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_business_glossary_term' = 'Offering Code (OFC)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_description` SET TAGS ('dbx_business_glossary_term' = 'Offering Description (OFC_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_business_glossary_term' = 'Offering Name (OFC_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_type` SET TAGS ('dbx_business_glossary_term' = 'Offering Type (OFC_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status (PARTICIP_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `plan_catalog_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Catalog Version (CATALOG_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `waiver_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Waiver Criteria Description (WAIVER_CRIT_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `waiver_eligible` SET TAGS ('dbx_business_glossary_term' = 'Waiver Eligibility (WAIVER_ELIG)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `affordability_test_flag` SET TAGS ('dbx_business_glossary_term' = 'ACA Affordability Test Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Contribution Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_code` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Code (CS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contribution Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Contribution Rule Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_type` SET TAGS ('dbx_value_regex' = 'flat|percentage|tiered');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `employer_contribution_cap` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Cap (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `hra_employer_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer HRA Seed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `hsa_employer_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer HSA Seed Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `is_post_tax` SET TAGS ('dbx_business_glossary_term' = 'Post‑Tax Contribution Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `is_pre_tax` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Tax Contribution Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `maximum_employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Employee Contribution (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `minimum_employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Minimum Employee Contribution (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = 'employee|family|spouse|child');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'applicable|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Funding Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_value_regex' = 'fully_insured|aso|self_funded|tpa');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Group Size (Number of Covered Lives)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_after_value` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment After Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_before_value` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Before Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_type` SET TAGS ('dbx_value_regex' = 'benefit_change|plan_add_drop|contribution_change|address_update|contact_change');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `participation_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Participation Requirement Met');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `participation_requirement_outcome` SET TAGS ('dbx_business_glossary_term' = 'Participation Requirement Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `participation_requirement_outcome` SET TAGS ('dbx_value_regex' = 'met|not_met|partial');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `premium_rate_prior_year` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Premium Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `premium_rate_renewal_year` SET TAGS ('dbx_business_glossary_term' = 'Renewal Year Premium Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `prior_renewal_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Renewal Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `rate_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|proposed|accepted|declined|expired');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_status_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `retention_outcome` SET TAGS ('dbx_business_glossary_term' = 'Retention Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `retention_outcome` SET TAGS ('dbx_value_regex' = 'retained|lost|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `retention_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Assignment ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Agency Name (AGENCY_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Broker Assignment Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `commission_basis` SET TAGS ('dbx_business_glossary_term' = 'Commission Basis (COMMISSION_BASIS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `commission_basis` SET TAGS ('dbx_value_regex' = 'premium|claim|revenue|service_fee');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate (COMMISSION_RATE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `commission_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Type (COMMISSION_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `commission_type` SET TAGS ('dbx_value_regex' = 'percentage|flat|tiered');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Broker Indicator (IS_PRIMARY)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Quote ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Underwriting Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee|family|individual|spouse');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'ERISA|NonERISA');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `gross_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_sic_code` SET TAGS ('dbx_business_glossary_term' = 'Group SIC Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Group Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Funding Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_type` SET TAGS ('dbx_value_regex' = 'ASO|FullyInsured');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Issue Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `net_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `pmpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `quote_version` SET TAGS ('dbx_business_glossary_term' = 'Quote Version');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_status` SET TAGS ('dbx_value_regex' = 'draft|presented|accepted|expired|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rating_area` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_value_regex' = 'community|experience|blended');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `total_group_premium_estimate` SET TAGS ('dbx_business_glossary_term' = 'Total Group Premium Estimate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `stop_loss_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Stop-Loss Policy Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_attachment_point` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Attachment Point');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_attachment_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_attachment_point` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_deductible_reset_period` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Deductible Reset Period');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_deductible_reset_period` SET TAGS ('dbx_value_regex' = 'annual|calendar_year|policy_year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `attachment_point_type` SET TAGS ('dbx_business_glossary_term' = 'Attachment Point Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `attachment_point_type` SET TAGS ('dbx_value_regex' = 'per_claim|per_year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Carrier Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Limit');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `covered_benefit_codes` SET TAGS ('dbx_business_glossary_term' = 'Covered Benefit Codes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `individual_attachment_point` SET TAGS ('dbx_business_glossary_term' = 'Individual Attachment Point');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `individual_attachment_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `individual_attachment_point` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `lasering_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Lasering Provision Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Policy Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'individual|aggregate|both');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Policy Premium Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `stop_loss_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Policy Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `stop_loss_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `parent_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `parent_broker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `agreement_terms` SET TAGS ('dbx_business_glossary_term' = 'Agreement Terms');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_currency` SET TAGS ('dbx_business_glossary_term' = 'Commission Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_end_date` SET TAGS ('dbx_business_glossary_term' = 'Commission End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `commission_start_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('dbx_business_glossary_term' = 'Fax');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Rating');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `rating` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
