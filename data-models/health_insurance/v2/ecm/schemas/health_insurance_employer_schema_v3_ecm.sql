-- Schema for Domain: employer | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 20:47:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`employer` COMMENT 'Manages employer group accounts — the B2B commercial customers who sponsor health coverage for their employees. Owns group demographics, SIC classification, group size, ASO/fully-insured funding arrangements, ERISA status, GFC controls, employer-subscriber relationships, contribution strategies, renewal dates, and participation requirements. Supports group billing aggregation, renewal management, and broker/TPA associations. Source system: Facets or QNXT group management module.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group` (
    `group_id` BIGINT COMMENT 'System-generated unique identifier for the employer group record.',
    `broker_id` BIGINT COMMENT 'Reference to the broker or agency that sourced the group.',
    `pool_id` BIGINT COMMENT 'Foreign key linking to risk.pool. Business justification: Group Risk Pool Assignment report requires each employer group to be linked to its risk pool for rating, reinsurance and regulatory compliance.',
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
    `group_status` STRING COMMENT 'Current lifecycle state of the employer group relationship.. Valid values are `prospect|active|suspended|terminated|reinstated`',
    `tax_id_ein` STRING COMMENT 'Federal tax identification number for the employer, used for reporting and compliance.. Valid values are `^d{2}-d{7}$`',
    `termination_date` DATE COMMENT 'Date the employer group contract is terminated or expires.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employer group record.',
    CONSTRAINT pk_group PRIMARY KEY(`group_id`)
) COMMENT 'Master record for employer group accounts — the B2B commercial customers who sponsor health coverage for their employees. Captures group demographics, legal entity name, tax ID (EIN), SIC/NAICS industry classification, group size tier, historical headcount and enrollment counts by coverage tier (EO/ES/EC/EF) tracked at monthly intervals for ACA small/large group market classification, line of business (LOB), funding arrangement (fully-insured vs ASO), ERISA status, domicile state, effective and termination dates, group financial control (GFC) identifiers, and complete lifecycle status transitions (prospect, active, suspended, terminated, reinstated) with status history. Single source of truth for employer group identity, size classification, headcount history, and status history.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_location` (
    `group_location_id` BIGINT COMMENT 'Unique surrogate key for each group location record.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Group locations belong to an employer group; linking enables address normalization and removes duplicate address fields from employer_group.',
    `service_area_id` BIGINT COMMENT 'Foreign key linking to network.service_area. Business justification: Needed for Network Adequacy Compliance audit: links employer location to the network service area covering that geography.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Links employer on‑site clinic locations to provider facilities, enabling employee access reporting and utilization analytics.',
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
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary address for the employer group.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the location in decimal degrees.',
    `location_code` STRING COMMENT 'Business identifier code for the location used in billing and regulatory filings.',
    `location_name` STRING COMMENT 'Descriptive name for the location (e.g., Headquarters, West Coast Office).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the location in decimal degrees.',
    `notes` STRING COMMENT 'Free-text field for additional remarks about the location.',
    `rating_area` STRING COMMENT 'Geographic rating area used for premium calculations.',
    `state` STRING COMMENT 'Two-letter state abbreviation.',
    `group_location_status` STRING COMMENT 'Current lifecycle status of the location record.. Valid values are `active|inactive|pending|closed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `zip_code` STRING COMMENT 'Five-digit postal code.',
    `zip_plus4` STRING COMMENT 'Extended ZIP+4 postal code.',
    CONSTRAINT pk_group_location PRIMARY KEY(`group_location_id`)
) COMMENT 'Physical and mailing addresses associated with an employer group, including headquarters, billing address, and satellite office locations. Tracks address type, street, city, state, ZIP+4, county FIPS code, and effective date range. Supports geographic rating, state regulatory filings, and premium billing address routing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` (
    `group_contact_id` BIGINT COMMENT 'System-generated unique identifier for the group contact record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group to which this contact belongs.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - group contacts may be assigned internal account managers',
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
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary point of contact for the group.',
    `last_name` STRING COMMENT 'Family name of the contact.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contact record.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the contact.',
    `phone_number` STRING COMMENT 'Primary telephone number for the contact.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the contacts mailing address.',
    `preferred_communication_channel` STRING COMMENT 'Contacts preferred method for receiving communications.. Valid values are `email|phone|mail|portal`',
    `source_system_contact_reference` STRING COMMENT 'Identifier for the contact as defined in the source system.',
    `state` STRING COMMENT 'State or province component of the contacts mailing address.',
    `group_contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|terminated|pending`',
    `title` STRING COMMENT 'Professional title or position of the contact within the employer organization.',
    CONSTRAINT pk_group_contact PRIMARY KEY(`group_contact_id`)
) COMMENT 'Authorized contacts associated with an employer group, including HR administrators, benefits coordinators, payroll contacts, and executive sponsors. Captures contact role type, name, title, phone, email, preferred communication channel, and authorization level for enrollment and billing transactions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_division` (
    `group_division_id` BIGINT COMMENT 'Unique surrogate key for the group division record.',
    `group_id` BIGINT COMMENT 'Identifier of the parent employer group to which this division belongs.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the Preferred Provider Organization (PPO) plan associated with this division, if applicable.',
    `tertiary_group_epo_plan_health_plan_id` BIGINT COMMENT 'Identifier of the Exclusive Provider Organization (EPO) plan associated with this division, if applicable.',
    `billing_entity_flag` BOOLEAN COMMENT 'Indicates whether the division is billed as a separate entity from the parent group.',
    `classification` STRING COMMENT 'Funding arrangement classification for the division.. Valid values are `ASO|Fully_Insured|Self_Funded|TPA|Broker_Managed`',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount contributed by employee per pay period for this division (if applicable).',
    `contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of premium contributed by employee for this division (if applicable).',
    `contribution_strategy` STRING COMMENT 'Method used to calculate employee contributions for this division.. Valid values are `fixed|percentage|tiered|none`',
    `covered_member_count` STRING COMMENT 'Number of members (including dependents) covered under this divisions benefits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the division record was first created in the system.',
    `division_code` STRING COMMENT 'Unique code assigned to the division for internal reference and billing.',
    `division_name` STRING COMMENT 'Human readable name of the division or subsidiary within the employer group.',
    `division_type` STRING COMMENT 'Category of the division indicating its organizational role.. Valid values are `department|subsidiary|cost_center|location|joint_venture`',
    `effective_end_date` DATE COMMENT 'Date when the divisions benefit configuration ends or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the divisions benefit configuration becomes effective.',
    `eligibility_rule_set` STRING COMMENT 'Reference to the eligibility rule set applied to members in this division.',
    `employee_count` STRING COMMENT 'Number of employees assigned to this division.',
    `flex_spending_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for the divisions Flexible Spending Account.',
    `fsa_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for the divisions Flexible Spending Account.',
    `hsa_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for the divisions Health Savings Account.',
    `is_eligible_for_flex_spending` BOOLEAN COMMENT 'Indicates if the division participates in a Flexible Spending Account (FSA) program.',
    `is_eligible_for_fsa` BOOLEAN COMMENT 'Indicates if the division offers a Flexible Spending Account (FSA) to its members.',
    `is_eligible_for_hsa` BOOLEAN COMMENT 'Indicates if the division offers a Health Savings Account (HSA) to its members.',
    `is_eligible_for_subsidy` BOOLEAN COMMENT 'Indicates if the division qualifies for employer-sponsored subsidy programs.',
    `is_eligible_for_waiver` BOOLEAN COMMENT 'Indicates if the division is eligible for premium waivers under certain conditions.',
    `renewal_date` DATE COMMENT 'Date when the divisions contract is up for renewal.',
    `group_division_status` STRING COMMENT 'Current lifecycle status of the division.. Valid values are `active|inactive|pending|closed|suspended`',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Fixed dollar subsidy amount applied to employee premiums for this division.',
    `subsidy_percent` DECIMAL(18,2) COMMENT 'Percentage subsidy applied to employee premiums for this division.',
    `termination_date` DATE COMMENT 'Date when the divisions agreement was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the division record.',
    CONSTRAINT pk_group_division PRIMARY KEY(`group_division_id`)
) COMMENT 'Organizational sub-units within an employer group — divisions, subsidiaries, cost centers, or departments — that have distinct benefit configurations, billing aggregation, or eligibility rules. Tracks division name, division code, parent group reference, effective dates, and whether the division is a separate billing entity. Supports multi-site and multi-subsidiary group structures in Facets.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` (
    `group_plan_offering_id` BIGINT COMMENT 'System‑generated unique identifier for the group plan offering record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group that sponsors this offering.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the underlying health plan catalog record.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.network_tier. Business justification: Supports Plan Tier Assignment process: defines which network tier (e.g., Tier 1, Tier 2) an employers plan offering uses for cost‑share calculations.',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employer contributes per employee when contribution_type = flat.',
    `contribution_effective_end_date` DATE COMMENT 'Date when the defined contribution strategy expires; null if ongoing.',
    `contribution_effective_start_date` DATE COMMENT 'Date when the defined contribution strategy becomes effective.',
    `contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of the premium the employer pays when contribution_type = percentage.',
    `contribution_strategy_description` STRING COMMENT 'Detailed explanation of how employer contributions are calculated.',
    `contribution_tier` STRING COMMENT 'Textual description of tiered contribution rules (e.g., "Tier 1: 70%", "Tier 2: 80%").',
    `contribution_type` STRING COMMENT 'Method the employer uses to calculate its contribution.. Valid values are `flat|percentage|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the offering record was first created in the system.',
    `effective_from` DATE COMMENT 'Date the offering becomes binding for the employer group.',
    `effective_until` DATE COMMENT 'Date the offering ends; null for open‑ended contracts.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for employee‑only coverage.',
    `family_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for family coverage.',
    `hra_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to employee HRA accounts.',
    `hsa_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to employee HSA accounts.',
    `is_affordable` BOOLEAN COMMENT 'True if the offering meets ACA affordability testing for the employer group.',
    `measurement_period_end` DATE COMMENT 'End of the period used to evaluate participation compliance.',
    `measurement_period_start` DATE COMMENT 'Start of the period used to evaluate participation compliance.',
    `minimum_enrolled_headcount` STRING COMMENT 'Absolute minimum number of participants required for the offering.',
    `minimum_participation_percent` DECIMAL(18,2) COMMENT 'Required percentage of eligible employees that must enroll for the offering to remain active.',
    `offering_code` STRING COMMENT 'External code used by the employer and carriers to reference this specific plan offering.',
    `offering_description` STRING COMMENT 'Narrative description of the plan offering, including benefits highlights.',
    `offering_name` STRING COMMENT 'Human‑readable name of the plan offering as displayed to employees.',
    `offering_type` STRING COMMENT 'Category of the health plan offering (e.g., QHP, HMO, PPO, EPO, HDHP, Dental, Vision). [ENUM-REF-CANDIDATE: qhp|hmo|ppo|epo|hdhp|dental|vision — promote to reference product]',
    `open_enrollment_end_date` DATE COMMENT 'Last day employees can enroll in the offering.',
    `open_enrollment_start_date` DATE COMMENT 'First day employees can enroll in the offering.',
    `participation_status` STRING COMMENT 'Current compliance result for the offerings participation thresholds.. Valid values are `compliant|non_compliant|pending_review`',
    `plan_catalog_version` STRING COMMENT 'Version identifier of the plan catalog used for this offering.',
    `plan_year` STRING COMMENT 'Calendar year to which the offering applies.',
    `group_plan_offering_status` STRING COMMENT 'Current lifecycle state of the offering.. Valid values are `active|pending|terminated|draft|suspended`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the offering record.',
    `waiver_criteria_description` STRING COMMENT 'Narrative description of the conditions under which a waiver may be granted.',
    `waiver_eligible` BOOLEAN COMMENT 'Indicates whether the employer allows waiver of spousal or other coverage.',
    CONSTRAINT pk_group_plan_offering PRIMARY KEY(`group_plan_offering_id`)
) COMMENT 'The set of health plan products offered by an employer group to its eligible employees during a plan year — the single source of truth for what plans are available, how the employer contributes, and what participation rules apply. Captures which QHP, HMO, PPO, EPO, HDHP, dental, and vision plans are available; employer contribution strategy per plan including contribution type (flat dollar, percentage of premium, tiered by coverage tier), employee-only vs family contribution amounts, HSA/HRA employer seed amounts, and contribution effective date ranges; minimum participation percentage, minimum enrolled headcount, waiver eligibility criteria (e.g., spousal coverage waivers), measurement period, and participation compliance status; and the open enrollment window linkage. Consolidates contribution strategies and participation requirements as attributes of the plan offering. Links employer groups to the plan catalog and drives the enrollment eligibility matrix, premium billing split calculations, and ACA affordability compliance testing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` (
    `contribution_strategy_id` BIGINT COMMENT 'System-generated unique identifier for the contribution strategy record.',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group to which this contribution strategy applies.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier of the health plan that the contribution rules are associated with.',
    `affordability_test_flag` BOOLEAN COMMENT 'Indicates whether the contribution satisfies the ACA affordability requirement.',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employer contributes per employee when contribution_type is flat.',
    `contribution_code` STRING COMMENT 'External business code used to reference the contribution strategy in contracts and communications.',
    `contribution_frequency` STRING COMMENT 'How often the employer contribution is applied to premium billing.. Valid values are `monthly|quarterly|annually`',
    `contribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of the premium the employer pays when contribution_type is percentage.',
    `contribution_rule_name` STRING COMMENT 'Descriptive name of the contribution rule for reporting and UI display.',
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
    `contribution_strategy_status` STRING COMMENT 'Current lifecycle state of the contribution strategy.. Valid values are `active|inactive|pending|retired`',
    `tax_credit_eligible` BOOLEAN COMMENT 'Indicates whether the contribution qualifies for a tax credit under applicable regulations.',
    `tier_code` STRING COMMENT 'Code indicating the employee coverage tier (e.g., employee‑only, family) that the contribution amount applies to.. Valid values are `employee|family|spouse|child`',
    `updated_by` STRING COMMENT 'User or system identifier that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the contribution strategy record.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_contribution_strategy PRIMARY KEY(`contribution_strategy_id`)
) COMMENT 'Employer contribution rules defining how much the employer pays toward employee and dependent premiums for each offered plan. Captures contribution type (flat dollar, percentage of premium, tiered by coverage tier), employee-only vs family contribution amounts, HSA/HRA employer seed amounts, and effective date ranges. Supports premium billing split calculations and ACA affordability compliance testing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` (
    `group_renewal_id` BIGINT COMMENT 'System-generated unique identifier for the group renewal record.',
    `broker_id` BIGINT COMMENT 'Identifier of the broker representing the group.',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group associated with this renewal.',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: A group renewal is conducted for specific plan offerings — the renewal lifecycle (rate changes, benefit configuration, participation requirements) is tied to the exact plan offerings the group is rene',
    `tpa_id` BIGINT COMMENT 'Identifier of the third‑party administrator handling the group.',
    `amendment_count` STRING COMMENT 'Total number of amendments applied to this renewal record.',
    `amendment_flag` BOOLEAN COMMENT 'True if any amendment has been applied to the renewal.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the renewal record was first created in the data warehouse.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the renewal record.',
    `benefit_plan_ids` STRING COMMENT 'Comma‑separated list of benefit plan identifiers attached to the renewal.',
    `compliance_check_date` DATE COMMENT 'Date on which the regulatory compliance check was performed.',
    `compliance_status` STRING COMMENT 'Result of the compliance validation for the renewal.. Valid values are `compliant|non_compliant|pending`',
    `contribution_strategy` STRING COMMENT 'How employer contributions are calculated for the renewal period.. Valid values are `fixed|percentage|tiered`',
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
    `renewal_cycle_year` STRING COMMENT 'Calendar year in which the renewal takes effect.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` (
    `participation_requirement_id` BIGINT COMMENT 'Unique identifier for the participation requirement record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group to which this participation requirement applies.',
    `health_plan_id` BIGINT COMMENT 'add column plan_health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - participation requirements vary by plan offering',
    `compliance_review_due_date` DATE COMMENT 'Date by which the next compliance review of the participation requirement must be completed.',
    `compliance_status` STRING COMMENT 'Current compliance outcome of the participation requirement.. Valid values are `compliant|non_compliant|under_review`',
    `contribution_strategy` STRING COMMENT 'How premium contributions are allocated for the group (employer, employee, or shared).. Valid values are `employer_paid|employee_paid|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the participation requirement record was first created.',
    `participation_requirement_description` STRING COMMENT 'Free‑form description providing context and details about the participation requirement.',
    `effective_from` DATE COMMENT 'Date when the participation requirement becomes effective.',
    `effective_until` DATE COMMENT 'Date when the participation requirement expires or is superseded (null if open‑ended).',
    `enrolled_headcount` STRING COMMENT 'Current number of members enrolled under the group.',
    `erisa_status` STRING COMMENT 'Indicates whether the employer group is subject to ERISA regulations.. Valid values are `applicable|not_applicable`',
    `funding_arrangement` STRING COMMENT 'Funding model for the group (Administrative Services Only, Fully Insured, or Self‑Funded).. Valid values are `ASO|fully_insured|self_funded`',
    `group_size` STRING COMMENT 'Total number of eligible members in the employer group.',
    `last_evaluated_date` DATE COMMENT 'Date when the participation requirement was last evaluated for compliance.',
    `measurement_period` STRING COMMENT 'Frequency at which participation is measured for compliance.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `minimum_enrolled_headcount` STRING COMMENT 'Minimum number of enrolled individuals required for the group to remain eligible.',
    `notes` STRING COMMENT 'Additional notes or comments entered by administrators.',
    `participation_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of eligible members that must enroll to satisfy the requirement.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this participation requirement must be reported to regulatory bodies (e.g., CMS, NAIC).',
    `renewal_date` DATE COMMENT 'Scheduled date for the next renewal evaluation of the participation requirement.',
    `requirement_code` STRING COMMENT 'Business identifier code for the participation requirement.',
    `requirement_name` STRING COMMENT 'Human‑readable name of the participation requirement.',
    `requirement_type` STRING COMMENT 'Classification of the requirement (e.g., minimum participation, waiver eligibility, headcount threshold).. Valid values are `minimum_participation|waiver_eligibility|headcount_threshold`',
    `participation_requirement_status` STRING COMMENT 'Current lifecycle status of the participation requirement.. Valid values are `active|inactive|pending|suspended|terminated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the participation requirement record.',
    `waiver_allowed` BOOLEAN COMMENT 'Indicates whether the group permits waivers (e.g., spousal coverage waivers).',
    `waiver_percentage_allowed` DECIMAL(18,2) COMMENT 'Maximum percentage of eligible members that may be waived while maintaining compliance.',
    CONSTRAINT pk_participation_requirement PRIMARY KEY(`participation_requirement_id`)
) COMMENT 'Minimum participation rules that an employer group must satisfy to maintain group coverage eligibility. Captures minimum participation percentage, minimum enrolled headcount, waiver eligibility criteria (e.g., spousal coverage waivers), measurement period, and compliance status. Used during underwriting, renewal, and open enrollment to validate group eligibility for continued coverage.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` (
    `broker_assignment_id` BIGINT COMMENT 'Unique surrogate key for the broker assignment record.',
    `broker_agreement_id` BIGINT COMMENT 'Foreign key linking to employer.broker_agreement. Business justification: A broker assignment (linking a broker to an employer group) should reference the formal broker agreement that governs the terms of that assignment — commission rates, effective dates, exclusivity, and',
    `broker_id` BIGINT COMMENT 'FK to employer.broker',
    `group_id` BIGINT COMMENT 'Unique identifier for the employer group (client) in the core administration system.',
    `agency_name` STRING COMMENT 'Legal name of the brokers agency or firm.',
    `commission_basis` STRING COMMENT 'Business metric on which the commission is calculated.. Valid values are `premium|claim|revenue|service_fee`',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate applicable to the broker for this employer group, expressed as a percentage.',
    `commission_type` STRING COMMENT 'Method used to calculate broker commission.. Valid values are `percentage|flat|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker assignment record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the broker assignment terminates or expires. Null if ongoing.',
    `effective_start_date` DATE COMMENT 'Date when the broker assignment becomes effective.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating whether this broker is the primary broker for the employer group.',
    `notes` STRING COMMENT 'Free-text field for additional comments or remarks about the broker assignment.',
    `broker_assignment_status` STRING COMMENT 'Current lifecycle status of the broker assignment.. Valid values are `active|inactive|pending|terminated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the broker assignment record.',
    CONSTRAINT pk_broker_assignment PRIMARY KEY(`broker_assignment_id`)
) COMMENT 'Association between an employer group and its licensed broker(s) or general agent(s), capturing the broker NPN, agency name, commission arrangement type, commission rate, effective and termination dates, and primary vs secondary broker designation. Supports broker compensation processing, group servicing accountability, and regulatory disclosure requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` (
    `tpa_arrangement_id` BIGINT COMMENT 'System-generated unique identifier for the TPA arrangement record.',
    `aso_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to employer.aso_fee_schedule. Business justification: tpa_arrangement embeds fee schedule attributes inline (fee_schedule_rate_pmpm, fee_schedule_cap_amount, fee_schedule_type) that are already formally defined in the aso_fee_schedule table. Adding aso_f',
    `broker_id` BIGINT COMMENT 'FK to employer.broker',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: TPA arrangement is specific to an employer group; linking provides association.',
    `stop_loss_policy_id` BIGINT COMMENT 'Foreign key linking to employer.stop_loss_policy. Business justification: tpa_arrangement embeds 10 stop-loss policy attributes inline (stop_loss_aggregate_corridor, stop_loss_aggregate_deductible, stop_loss_carrier_name, stop_loss_coverage_scope, stop_loss_effective_date, ',
    `tpa_id` BIGINT COMMENT 'FK to employer.tpa',
    `arrangement_name` STRING COMMENT 'Human‑readable name for the TPA arrangement.',
    `arrangement_number` STRING COMMENT 'External contract number or code assigned to the TPA arrangement.',
    `arrangement_type` STRING COMMENT 'Category of the arrangement indicating funding model.. Valid values are `ASO|Self-Funded|Fully-Insured`',
    `contract_reference` STRING COMMENT 'External reference to the legal contract document.',
    `contribution_rate_pmpm` DECIMAL(18,2) COMMENT 'Per member per month contribution amount defined by the employer.',
    `contribution_strategy` STRING COMMENT 'Method used to calculate employer contributions to the self‑funded arrangement.. Valid values are `fixed|percentage|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the arrangement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date the arrangement terminates or expires; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date the arrangement becomes binding.',
    `erisa_status` STRING COMMENT 'Indicates whether the arrangement is subject to ERISA regulations.. Valid values are `covered|exempt`',
    `gfc_control_flag` BOOLEAN COMMENT 'True if the arrangement is subject to Group Financial Control oversight.',
    `group_size_max` STRING COMMENT 'Maximum number of covered lives allowed under the arrangement.',
    `group_size_min` STRING COMMENT 'Minimum number of covered lives required for the arrangement.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions.',
    `renewal_date` DATE COMMENT 'Date when the arrangement is scheduled for renewal.',
    `tpa_arrangement_status` STRING COMMENT 'Current operational status of the TPA arrangement.. Valid values are `active|inactive|suspended|terminated|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the arrangement record.',
    CONSTRAINT pk_tpa_arrangement PRIMARY KEY(`tpa_arrangement_id`)
) COMMENT 'Third Party Administrator (TPA) and Administrative Services Only (ASO) arrangement record for self-funded employer groups — the single source of truth for all ASO/self-funded configuration. Captures TPA entity name, TPA NPI/tax ID, ASO contract reference; administrative fee schedule components by service type (claims processing, network access, care management, PBM, utilization review) with PMPM rates, effective dates, and contractual fee caps; stop-loss (excess loss) insurance configuration including stop-loss carrier name, policy number, specific deductible (individual attachment point), aggregate deductible, aggregate corridor, lasering provisions with member-level laser amounts, stop-loss premium, covered benefits scope, and stop-loss policy effective/expiration dates; and overall arrangement effective dates. Consolidates ASO fee schedules and stop-loss policies as sub-configurations of the TPA arrangement, aligned with Facets/QNXT ASO module patterns. Drives ASO revenue recognition in the finance domain and self-funded group financial risk management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` (
    `open_enrollment_window_id` BIGINT COMMENT 'Primary key for open_enrollment_window',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group that sponsors the enrollment window.',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: An open enrollment window is defined for a specific plan offering — employees elect coverage for a particular plan during the window. open_enrollment_window already has group_id and plan_health_plan_i',
    `health_plan_id` BIGINT COMMENT 'add column plan_health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - enrollment windows are specific to plan offerings',
    `change_deadline` DATE COMMENT 'Last date an employee may modify an already‑submitted election within the window.',
    `coverage_type` STRING COMMENT 'Category of benefits offered in this enrollment window.. Valid values are `medical|dental|vision|wellness|all`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment window record was first created in the system.',
    `eligible_employee_count` STRING COMMENT 'Number of employees who meet eligibility criteria for this enrollment window.',
    `end_date` DATE COMMENT 'Date the enrollment window closes; no further changes are accepted after this date.',
    `enrollment_method` STRING COMMENT 'Channel through which employees may submit their elections (online portal, paper forms, or EDI 834).. Valid values are `online|paper|edi`',
    `enrollment_window_status` STRING COMMENT 'Current lifecycle status of the enrollment window.. Valid values are `open|closed|pending|cancelled`',
    `enrollment_window_type` STRING COMMENT 'Classification of the window (annual open enrollment, new‑hire election, COBRA election, or special election).. Valid values are `annual|new_hire|cobra|special`',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or special instructions related to the window.',
    `participation_rate` DECIMAL(18,2) COMMENT 'Percentage (to two decimal places) of eligible employees who completed an election.',
    `plan_selection_method` STRING COMMENT 'Whether employees may select a single plan or multiple plans during the window.. Valid values are `single|multiple`',
    `start_date` DATE COMMENT 'Date the enrollment window becomes effective for employee elections.',
    `submission_deadline` DATE COMMENT 'Final date by which an employee must submit an election to be processed.',
    `total_employee_count` STRING COMMENT 'Total number of employees in the employer group at the start of the window.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment window record.',
    `waiver_allowed` BOOLEAN COMMENT 'Indicates whether employees may waive coverage during this window.',
    `waiver_deadline` DATE COMMENT 'Date by which a waiver must be submitted if waivers are permitted.',
    `window_code` STRING COMMENT 'Business identifier code assigned to the enrollment window (e.g., OE2024Q1).',
    CONSTRAINT pk_open_enrollment_window PRIMARY KEY(`open_enrollment_window_id`)
) COMMENT 'Scheduled open enrollment windows defined by an employer group during which employees may elect, change, or waive coverage. Captures enrollment period type (annual open enrollment, new hire window, COBRA election), start and end dates, eligible plan offerings, enrollment method (online portal, paper, EDI 834), and enrollment completion status. Drives eligibility event processing in the enrollment domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` (
    `employer_underwriting_case_id` BIGINT COMMENT 'System-generated unique identifier for the underwriting case.',
    `broker_id` BIGINT COMMENT 'Identifier of the broker facilitating the employer’s enrollment.',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group that is the subject of the underwriting case.',
    `tpa_id` BIGINT COMMENT 'Identifier of the TPA associated with the underwriting case, if applicable.',
    `aca_adjustment_factor` DECIMAL(18,2) COMMENT 'Adjustment applied to ensure compliance with Affordable Care Act rating rules.',
    `actuarial_basis_document` STRING COMMENT 'Reference identifier for the actuarial documentation supporting the rating.',
    `age_gender_composite_factor` DECIMAL(18,2) COMMENT 'Composite factor derived from the group’s age and gender distribution.',
    `case_number` STRING COMMENT 'Business identifier assigned to the underwriting case, used for tracking and communication.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the underwriting case record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the premium estimate.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `effective_end_date` DATE COMMENT 'Last day the proposed premium rates are valid; after this date a new quote is required.',
    `effective_start_date` DATE COMMENT 'First day the proposed premium rates become effective if the quote is accepted.',
    `experience_rating_factor` DECIMAL(18,2) COMMENT 'Factor based on the employer’s prior loss experience and credibility weighting.',
    `geographic_factor` DECIMAL(18,2) COMMENT 'Factor reflecting cost differentials across geographic rating areas.',
    `group_average_age` DECIMAL(18,2) COMMENT 'Average age of covered members in the group.',
    `group_census_size` STRING COMMENT 'Number of covered lives in the employer group at the time of underwriting.',
    `group_female_percentage` DECIMAL(18,2) COMMENT 'Percentage of female members in the group census.',
    `industry_risk_factor` STRING COMMENT 'Code representing the industry classification risk factor applied to the group.',
    `manual_rate_basis` BOOLEAN COMMENT 'Indicates whether the rate was manually set rather than algorithmically derived.',
    `pmpm_estimate` DECIMAL(18,2) COMMENT 'Estimated premium cost per covered member per month.',
    `prior_carrier_loss_experience` STRING COMMENT 'Narrative summary of loss experience with the previous carrier.',
    `quote_expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the quote expires if not accepted.',
    `quote_generated_timestamp` TIMESTAMP COMMENT 'Date and time when the premium quote was generated.',
    `quote_status` STRING COMMENT 'Current status of the premium quote within the underwriting workflow.. Valid values are `draft|presented|accepted|expired|retracted`',
    `rating_area_code` STRING COMMENT 'Geographic rating area identifier used for regional premium adjustments.',
    `rating_methodology` STRING COMMENT 'Method used to calculate rates: community rated, experience rated, or blended.. Valid values are `community|experience|blended`',
    `risk_tier` STRING COMMENT 'Risk classification assigned to the employer group based on underwriting analysis.. Valid values are `low|medium|high|very_high`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the underwriting case was initially submitted.',
    `total_premium_estimate` DECIMAL(18,2) COMMENT 'Aggregate estimated premium for the entire employer group for the quoted period.',
    `underwriting_decision` STRING COMMENT 'Final decision outcome for the case after review.. Valid values are `approved|declined|modified|pending`',
    `underwriting_status` STRING COMMENT 'Current lifecycle status of the underwriting case.. Valid values are `draft|presented|accepted|expired|declined|modified`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the underwriting case record.',
    CONSTRAINT pk_employer_underwriting_case PRIMARY KEY(`employer_underwriting_case_id`)
) COMMENT 'Underwriting evaluation record and single source of truth for the complete risk assessment process from submission through rating through quote generation through decision for a new or renewing employer group. Tracks case submission date, group census data, prior carrier loss experience, medical underwriting status, risk tier assignment, manual rate basis; rating factors including age/gender composite factors, geographic area rating factors, industry risk factors, experience rating credibility weights, ACA-compliant rating adjustments, and actuarial basis documentation; underwriting decision (approved, declined, modified); and premium rate quotes with proposed rates by plan, coverage tier, and rating area, quote effective and expiration dates, rating methodology (community rated, experience rated, blended), proposed PMPM rates, total group premium estimate, and quote status (draft, presented, accepted, expired). Consolidates rating factors and rate quotes as stages within the underwriting case lifecycle. Links to the risk domain for RAF and HCC-based risk scoring at the group level. Supports the sales and renewal pipeline.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` (
    `rate_quote_id` BIGINT COMMENT 'System‑generated unique identifier for the premium rate quote.',
    `broker_id` BIGINT COMMENT 'Identifier of the broker or sales agent handling the quote.',
    `employer_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to employer.employer_underwriting_case. Business justification: Rate quotes are produced as outputs of the underwriting evaluation process. employer_underwriting_case is the parent record that drives the risk assessment, and rate_quote is the resulting premium quo',
    `group_id` BIGINT COMMENT 'Identifier of the employer group for which the quote is generated.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which the quote applies.',
    `tpa_id` BIGINT COMMENT 'Identifier of the Third‑Party Administrator associated with the quote, if any.',
    `contribution_strategy` STRING COMMENT 'Employer contribution approach (e.g., fixed amount, percentage of premium).',
    `coverage_tier` STRING COMMENT 'Tier of coverage being quoted (e.g., employee only, family).. Valid values are `employee|family|individual|spouse`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the quote (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of any discounts applied to the gross premium.',
    `effective_date` DATE COMMENT 'First date on which the quoted rates become effective if the quote is accepted.',
    `erisa_status` STRING COMMENT 'Indicates whether the employer group is subject to ERISA regulations.. Valid values are `ERISA|NonERISA`',
    `expiration_date` DATE COMMENT 'Date after which the quote is no longer valid.',
    `gross_premium_amount` DECIMAL(18,2) COMMENT 'Total premium before any discounts or adjustments, expressed in the quote currency.',
    `group_size` STRING COMMENT 'Total number of employees eligible for coverage under the employer group.',
    `group_type` STRING COMMENT 'Funding arrangement for the group: Administrative Services Only (ASO) or Fully Insured.. Valid values are `ASO|FullyInsured`',
    `issue_timestamp` TIMESTAMP COMMENT 'Date‑time when the quote was formally issued to the employer.',
    `member_count` STRING COMMENT 'Number of covered lives in the employer group for the quoted period.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Final premium after discounts, the amount the employer is expected to pay.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions.',
    `plan_year` STRING COMMENT 'Calendar year to which the quoted plan benefits apply.',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'Proposed premium rate expressed as a per‑member‑per‑month amount.',
    `quote_number` STRING COMMENT 'External reference number assigned to the quote for tracking and communication with the employer.',
    `quote_version` STRING COMMENT 'Version number of the quote, incremented on each revision.',
    `rating_area` STRING COMMENT 'Geographic rating area used to calculate the premium.',
    `renewal_date` DATE COMMENT 'Date when the current policy term ends and renewal is expected.',
    `rate_quote_status` STRING COMMENT 'Current lifecycle state of the quote (e.g., draft, presented, accepted, expired, rejected).. Valid values are `draft|presented|accepted|expired|rejected`',
    `total_group_premium_estimate` DECIMAL(18,2) COMMENT 'Projected total premium for the entire employer group based on the quoted rates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the quote record.',
    CONSTRAINT pk_rate_quote PRIMARY KEY(`rate_quote_id`)
) COMMENT 'Premium rate quote issued to a prospective or renewing employer group, capturing proposed rates by plan, coverage tier, and rating area. Includes quote effective date, expiration date, rating methodology (community rated, experience rated, blended), proposed PMPM rates, total group premium estimate, and quote status (draft, presented, accepted, expired). Supports the sales and renewal pipeline.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` (
    `group_amendment_id` BIGINT COMMENT 'System-generated unique identifier for each group amendment record.',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group to which the amendment applies.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - group amendments require tracking of who processed them',
    `after_value` DECIMAL(18,2) COMMENT 'JSON‑encoded snapshot of the group attributes after the amendment was applied.',
    `amendment_number` STRING COMMENT 'Business-visible sequential number assigned to the amendment.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `draft|pending|approved|rejected|implemented|cancelled`',
    `amendment_type` STRING COMMENT 'Category of the amendment indicating the nature of the change.. Valid values are `benefit_change|plan_add_drop|contribution_change|address_update|contact_change|coverage_change`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment received final approval.',
    `approval_user_role` STRING COMMENT 'Business role of the user who performed the approval.. Valid values are `broker|tpa|internal|compliance|executive`',
    `before_value` DECIMAL(18,2) COMMENT 'JSON‑encoded snapshot of the group attributes before the amendment was applied.',
    `contribution_change_amount` DECIMAL(18,2) COMMENT 'Net monetary change to the employer contribution resulting from the amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for monetary fields.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `effective_date` DATE COMMENT 'Date on which the amendment becomes effective for the group.',
    `is_critical_change` BOOLEAN COMMENT 'Flag indicating whether the amendment is considered critical for compliance or financial reporting.',
    `new_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount after the amendment (per member per month).',
    `original_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount before the amendment (per member per month).',
    `reason_code` STRING COMMENT 'Standardized code indicating why the amendment was initiated.. Valid values are `regulatory|member_request|broker_request|cost_control|plan_design|other`',
    `reason_description` STRING COMMENT 'Free‑text description providing additional context for the amendment reason.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment was submitted for review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the amendment record.',
    CONSTRAINT pk_group_amendment PRIMARY KEY(`group_amendment_id`)
) COMMENT 'Mid-year or off-cycle changes to an employer groups coverage terms, benefit configuration, or administrative parameters. Captures amendment type (benefit change, plan add/drop, contribution change, address update, contact change), effective date, reason code, approval status, and the before/after values of changed attributes. Provides a complete audit trail of group configuration changes between renewal cycles.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` (
    `cobra_administration_id` BIGINT COMMENT 'System-generated unique identifier for the COBRA administration record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group to which this COBRA administration applies.',
    `vendor_id` BIGINT COMMENT 'add column vendor_vendor_id (BIGINT) with FK to vendor.vendor.vendor_id - COBRA administration is often outsourced to vendors',
    `administrator_name` STRING COMMENT 'Name of the entity responsible for managing COBRA administration.',
    `administrator_type` STRING COMMENT 'Indicates whether COBRA administration is self‑administered or handled by a third‑party TPA.. Valid values are `self|third_party`',
    `agreement_type` STRING COMMENT 'Classification of the COBRA coverage type applicable to the group.. Valid values are `federal_cobra|state_mini_cobra|both`',
    `cobra_agreement_number` STRING COMMENT 'External reference number assigned to the COBRA agreement for the employer group.',
    `compliance_status` STRING COMMENT 'Current compliance status of the group with respect to COBRA obligations.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COBRA administration record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the COBRA coverage obligations become effective.',
    `effective_until` DATE COMMENT 'Date when the COBRA coverage obligations terminate or are superseded.',
    `election_end_date` DATE COMMENT 'End date of the COBRA election window for a qualifying event.',
    `election_period_days` STRING COMMENT 'Number of days participants have to elect COBRA coverage after a qualifying event.',
    `election_start_date` DATE COMMENT 'Start date of the COBRA election window for a qualifying event.',
    `group_cobra_eligibility` BOOLEAN COMMENT 'Indicates whether the employer group meets criteria to be subject to COBRA regulations.',
    `last_compliance_check_date` DATE COMMENT 'Date when the most recent compliance audit or review was performed.',
    `max_employee_count` STRING COMMENT 'Maximum number of employees for which the group remains subject to COBRA (used for state mini‑COBRA thresholds).',
    `min_employee_count` STRING COMMENT 'Minimum number of employees required for the group to be covered by federal COBRA.',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information or comments.',
    `notification_method` STRING COMMENT 'Preferred method for delivering COBRA notifications to participants.. Valid values are `email|mail|phone|portal`',
    `notification_required` BOOLEAN COMMENT 'Flag indicating whether participants must be notified of COBRA rights and election periods.',
    `premium_rate` DECIMAL(18,2) COMMENT 'Calculated COBRA premium amount per participant per period.',
    `premium_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the group premium rate to calculate the COBRA premium (typically 102%).',
    `qualifying_event_type` STRING COMMENT 'Type of qualifying event that triggers COBRA eligibility for a participant.. Valid values are `termination|reduction_of_hours|divorce|death|other`',
    `state_cobra_law` STRING COMMENT 'Two‑letter state code indicating which state’s mini‑COBRA law applies to the group.. Valid values are `AL|CA|NY|TX|FL|GA`',
    `cobra_administration_status` STRING COMMENT 'Current lifecycle status of the COBRA administration record.. Valid values are `active|inactive|terminated|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COBRA administration record.',
    CONSTRAINT pk_cobra_administration PRIMARY KEY(`cobra_administration_id`)
) COMMENT 'COBRA (Consolidated Omnibus Budget Reconciliation Act) administration configuration for an employer group, defining the groups COBRA obligations, qualifying event types, election period durations, premium rates (102% of group rate), and COBRA administrator designation (self-administered vs third-party COBRA TPA). Tracks group-level COBRA compliance status, election window configurations, and notification requirements. Required for all employer groups with 20+ employees under federal COBRA or state mini-COBRA equivalents.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` (
    `wellness_program_id` BIGINT COMMENT 'Unique system-generated identifier for each wellness program.',
    `group_id` BIGINT COMMENT 'add column employer_group_id (BIGINT) with FK to employer.group.group_id - wellness programs are offered to specific employer groups',
    `vendor_id` BIGINT COMMENT 'System identifier for the vendor partner.',
    `aca_compliance_classification` STRING COMMENT 'Classification of the program under ACA wellness rules.. Valid values are `participatory|health_contingent`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the program record was first created in the system.',
    `current_participant_count` STRING COMMENT 'Number of members currently enrolled in the program.',
    `wellness_program_description` STRING COMMENT 'Narrative description of the programs purpose and activities.',
    `effective_end_date` DATE COMMENT 'Date when the program ceases to be offered (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the program becomes active for eligible members.',
    `eligibility_criteria` STRING COMMENT 'Textual definition of the criteria members must meet to enroll.',
    `enrollment_cap` STRING COMMENT 'Maximum number of participants allowed for the program.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary value of the incentive offered to participants.',
    `incentive_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the incentive amount.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `incentive_type` STRING COMMENT 'Mechanism by which the incentive is delivered.. Valid values are `premium_discount|hsa_contribution|gift_card`',
    `is_eligible_for_tax_credit` BOOLEAN COMMENT 'True if the program qualifies for a tax credit under applicable regulations.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether participation is required for covered employees.',
    `participation_method` STRING COMMENT 'Method used to capture member participation data.. Valid values are `self_report|automated|third_party`',
    `program_actual_participation_pct` DECIMAL(18,2) COMMENT 'Observed percentage of eligible members who have participated.',
    `program_budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for the program during its effective period.',
    `program_budget_currency` STRING COMMENT 'ISO currency code for the program budget.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `program_category` STRING COMMENT 'High‑level category grouping similar wellness programs.. Valid values are `wellness|prevention|mental_health|nutrition|physical_activity`',
    `program_code` STRING COMMENT 'Business‑assigned alphanumeric code that uniquely identifies the program across systems.',
    `program_compliance_notes` STRING COMMENT 'Free‑text field for regulatory or audit comments related to the program.',
    `program_effective_year` STRING COMMENT 'Calendar year in which the program becomes effective.',
    `program_end_reason` STRING COMMENT 'Reason why the program was terminated or discontinued.',
    `program_last_review_date` DATE COMMENT 'Date of the most recent governance or compliance review.',
    `program_name` STRING COMMENT 'Human‑readable name of the wellness program.',
    `program_review_status` STRING COMMENT 'Current status of the programs compliance or policy review.. Valid values are `not_reviewed|under_review|approved|rejected`',
    `program_risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used in actuarial models to adjust risk based on program participation.',
    `program_source_system` STRING COMMENT 'Name of the operational system that originated the program record.',
    `program_subtype` STRING COMMENT 'More specific classification within the program category.',
    `program_target_participation_pct` DECIMAL(18,2) COMMENT 'Desired percentage of eligible members to participate.',
    `program_type` STRING COMMENT 'Category of the wellness program indicating its primary focus.. Valid values are `biometric_screening|smoking_cessation|weight_management|eap|chronic_disease_prevention|other`',
    `program_version` STRING COMMENT 'Version identifier for the program definition (e.g., v1.0).',
    `wellness_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|pending|retired|draft`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the program record.',
    CONSTRAINT pk_wellness_program PRIMARY KEY(`wellness_program_id`)
) COMMENT 'Employer-sponsored wellness and health promotion programs offered to enrolled members, including biometric screening, smoking cessation, weight management, EAP (Employee Assistance Program), and chronic disease prevention initiatives. Captures program name, type, vendor partner, incentive structure (premium discount, HSA contribution, gift cards), participation tracking method, program effective dates, and ACA wellness program compliance classification (participatory vs health-contingent). Supports employer value-add differentiation and group retention strategy.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_document` (
    `group_document_id` BIGINT COMMENT 'Surrogate primary key for the group document record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group to which the document belongs.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - document uploads require audit trail of uploader',
    `amendment_date` DATE COMMENT 'Date the amendment became effective.',
    `amendment_number` STRING COMMENT 'Identifier of the amendment version for amendment documents.',
    `audit_trail` STRING COMMENT 'Serialized audit log of changes to the document metadata.',
    `checksum` STRING COMMENT 'Checksum (e.g., SHA‑256) for integrity verification of the document.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the document meets current regulatory compliance requirements.',
    `confidential` BOOLEAN COMMENT 'True if the document contains confidential or restricted information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was created in the system.',
    `document_category` STRING COMMENT 'Higher‑level category grouping for the document.. Valid values are `legal|benefit|regulatory|administrative|financial|operational`',
    `document_language` STRING COMMENT 'Language code of the document content.. Valid values are `en|es|fr|de|zh|other`',
    `document_title` STRING COMMENT 'Human‑readable title of the document.',
    `document_type` STRING COMMENT 'Classification of the document (e.g., contract, summary of benefits, ERISA plan document). [ENUM-REF-CANDIDATE: contract|plan|spd|sbc|erisa|trust|fiduciary|filing|renewal|broker_letter — 10 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date on which the document becomes effective.',
    `erisa_plan_administrator` STRING COMMENT 'Name of the plan administrator designated under ERISA for the document.',
    `expiration_date` DATE COMMENT 'Date on which the document expires or is no longer in force.',
    `expiration_policy` STRING COMMENT 'Policy governing what happens when the document expires.. Valid values are `auto_delete|archive|retain|review`',
    `fiduciary_designation` STRING COMMENT 'Designation of fiduciary(s) associated with the document.',
    `file_format` STRING COMMENT 'File format of the stored document.. Valid values are `pdf|docx|xlsx|txt|html`',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `is_electronic` BOOLEAN COMMENT 'True if the document is stored electronically rather than paper.',
    `is_mandatory` BOOLEAN COMMENT 'True if the document is required by regulation or policy for the group.',
    `is_primary` BOOLEAN COMMENT 'True if this document is the primary version for its type within the group.',
    `last_reviewed_date` DATE COMMENT 'Date the document was last reviewed for accuracy/compliance.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the document.',
    `physical_location` STRING COMMENT 'Physical storage location reference for paper documents.',
    `plan_year` STRING COMMENT 'Plan year to which the document applies.',
    `retention_period_months` STRING COMMENT 'Number of months the document must be retained per policy.',
    `reviewed_by` STRING COMMENT 'Identifier of the person or role that performed the last review.',
    `source_system_document_reference` STRING COMMENT 'Identifier of the document in the source system.',
    `group_document_status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `active|inactive|archived|pending|superseded`',
    `storage_uri` STRING COMMENT 'URI pointing to the document location in the enterprise content repository.',
    `trust_agreement_details` STRING COMMENT 'Key details of the trust agreement referenced by the document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `version_number` STRING COMMENT 'Version identifier of the document, following the organization’s versioning scheme.',
    CONSTRAINT pk_group_document PRIMARY KEY(`group_document_id`)
) COMMENT 'Repository and single source of truth for all documents associated with an employer group, including executed group contracts, plan documents, SPDs (Summary Plan Descriptions), SBCs (Summary of Benefits and Coverage), ERISA wrap documents, trust agreements, named fiduciary designations, plan administrator information, DOL Form 5500 filings, ERISA plan amendment history, fiduciary liability insurance records, DOI filings, renewal agreements, broker appointment letters, and all ERISA compliance artifacts. Captures document type, document title, version, effective date, expiration date, storage reference URI, document status, plan year, and ERISA-specific metadata (plan administrator, fiduciary designations, amendment history, trust agreement details, plan year). Consolidates all group documentation including ERISA plan documents — ERISA documents are distinguished by document type classification, not by separate entity. Supports regulatory audit readiness, ERISA fiduciary obligations, DOL reporting, and group servicing.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` (
    `aso_fee_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the ASO fee schedule record.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: ASO fee schedule applies to a particular employer group; linking removes need for separate group reference.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - fee schedules require tracking of who created/approved them',
    `billing_frequency` STRING COMMENT 'How often the fee is invoiced to the employer group.. Valid values are `monthly|quarterly|annually`',
    `cap_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount that can be charged for this component within a billing period.',
    `cap_type` STRING COMMENT 'Defines how the cap amount is applied (per member, per claim, or overall).. Valid values are `per_member|per_claim|overall`',
    `component_type` STRING COMMENT 'Category of administrative service for which the fee is charged (e.g., claims processing, network access).. Valid values are `claims_processing|network_access|care_management|pharmacy_benefit|administrative|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in this schedule.. Valid values are `^[A-Z]{3}$`',
    `aso_fee_schedule_description` STRING COMMENT 'Free‑text description of the fee schedule purpose and any special conditions.',
    `effective_end_date` DATE COMMENT 'Date when the fee schedule expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the fee schedule becomes effective and billable.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which employer groups or members qualify for this fee schedule.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the fee is subject to tax.',
    `minimum_participation_percent` DECIMAL(18,2) COMMENT 'Minimum percentage of eligible members that must enroll for the schedule to apply.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the fee schedule.',
    `pm_per_member_rate` DECIMAL(18,2) COMMENT 'Base administrative fee charged per covered member per month for the specified component.',
    `schedule_code` STRING COMMENT 'External business code used to reference the fee schedule in contracts and communications.',
    `aso_fee_schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule.. Valid values are `active|inactive|pending|terminated`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage when is_taxable is true.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fee schedule record.',
    CONSTRAINT pk_aso_fee_schedule PRIMARY KEY(`aso_fee_schedule_id`)
) COMMENT 'Administrative fee schedule for ASO (Administrative Services Only) self-funded employer groups, defining the per-member-per-month (PMPM) administrative fees charged for claims processing, network access, care management, pharmacy benefit management, and other administrative services. Captures fee component type, PMPM rate, effective date, and contractual cap amounts. Drives ASO revenue recognition in the finance domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` (
    `stop_loss_policy_id` BIGINT COMMENT 'System‑generated unique identifier for the stop‑loss policy record.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Stop‑loss policy is tied to an employer group; linking creates proper relationship.',
    `vendor_id` BIGINT COMMENT 'add column vendor_vendor_id (BIGINT) with FK to vendor.vendor.vendor_id - stop loss policies are purchased from reinsurance vendors',
    `aggregate_attachment_point` DECIMAL(18,2) COMMENT 'Total deductible amount the employer group must incur before the carrier pays for excess claims.',
    `aggregate_deductible_reset_period` STRING COMMENT 'Period after which the aggregate attachment point resets (e.g., annually).. Valid values are `annual|calendar_year|policy_year`',
    `attachment_point_type` STRING COMMENT 'Specifies whether attachment points are calculated per individual claim or on an annual basis.. Valid values are `per_claim|per_year`',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier that provides the stop‑loss coverage.',
    `claim_payment_limit` DECIMAL(18,2) COMMENT 'Maximum amount the carrier will pay for a single claim under the stop‑loss policy.',
    `claim_payment_limit_currency` STRING COMMENT 'Currency of the claim payment limit.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `contribution_strategy` STRING COMMENT 'Method the employer uses to contribute toward the stop‑loss premium (fixed amount, percentage of premium, or tiered).. Valid values are `fixed|percentage|tiered`',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` (
    `group_rating_factor_id` BIGINT COMMENT 'System-generated unique identifier for the rating factor record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group to which this rating factor applies.',
    `actuarial_basis` STRING COMMENT 'Underlying actuarial methodology used to derive the factor.. Valid values are `experience|community|state|custom`',
    `adjustment_reason` STRING COMMENT 'Explanation for any manual adjustment to the factor value.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the factor record was first created in the data lake.',
    `effective_end_date` DATE COMMENT 'Date when the rating factor ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the rating factor becomes effective for premium calculations.',
    `factor_code` STRING COMMENT 'Business code that uniquely identifies the rating factor within the group.',
    `factor_description` STRING COMMENT 'Human‑readable description of the factor purpose and calculation methodology.',
    `factor_type` STRING COMMENT 'Category of the rating factor (e.g., age/gender composite, geographic area, industry risk, experience rating, ACA adjustment).. Valid values are `age_gender|geographic|industry|experience|aca_adjustment|other`',
    `factor_value` DECIMAL(18,2) COMMENT 'Numeric value of the factor (e.g., 1.025 for a 2.5% increase).',
    `is_adjusted` BOOLEAN COMMENT 'True if the factor value has been manually overridden from the actuarial default.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this factor is the default for its type when no group‑specific factor exists.',
    `notes` STRING COMMENT 'Free‑form comments or business notes about the factor.',
    `rating_period_end` DATE COMMENT 'End date of the rating period to which the factor applies.',
    `rating_period_start` DATE COMMENT 'Start date of the rating period to which the factor applies.',
    `regulatory_reference` STRING COMMENT 'Regulatory framework or guideline that mandates or influences the factor.. Valid values are `ACA|CMS|NAIC|state`',
    `source_system_factor_reference` STRING COMMENT 'Identifier of the factor in the source system.',
    `group_rating_factor_status` STRING COMMENT 'Current lifecycle status of the factor record.. Valid values are `active|inactive|pending|retired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the factor record.',
    `value_unit` STRING COMMENT 'Unit of measure for the factor value: percentage, multiplier, or dollar amount.. Valid values are `percentage|multiplier|dollar`',
    CONSTRAINT pk_group_rating_factor PRIMARY KEY(`group_rating_factor_id`)
) COMMENT 'Rating factors applied to an employer group for premium calculation, including age/gender composite factors, geographic area rating factors, industry risk factors, experience rating credibility weights, and ACA-compliant rating adjustments. Captures factor type, factor value, rating period, and the actuarial basis for each factor. Used by the billing domain for premium calculation and by the risk domain for group-level risk adjustment.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` (
    `erisa_plan_document_id` BIGINT COMMENT 'Unique surrogate key for the ERISA plan document record.',
    `group_id` BIGINT COMMENT 'add column employer_group_id (BIGINT) with FK to employer.group.group_id - ERISA documents are filed for specific employer groups',
    `health_plan_id` BIGINT COMMENT 'Identifier of the employer group plan associated with this document.',
    `amendment_date` DATE COMMENT 'Date the amendment became effective.',
    `amendment_description` STRING COMMENT 'Narrative description of the amendment changes.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment to the original plan document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `document_name` STRING COMMENT 'Descriptive title of the ERISA plan document.',
    `document_number` STRING COMMENT 'External reference number assigned to the plan document by the employer or regulator.',
    `document_type` STRING COMMENT 'Classification of the document (e.g., plan, trust, amendment).. Valid values are `plan|trust|amendment`',
    `effective_from` DATE COMMENT 'Date the document becomes effective.',
    `effective_until` DATE COMMENT 'Date the document ceases to be effective (null for open‑ended).',
    `fiduciary_name` STRING COMMENT 'Full legal name of the fiduciary responsible for the plan.',
    `fiduciary_role` STRING COMMENT 'Role of the fiduciary (e.g., trustee, administrator).',
    `filing_deadline_date` DATE COMMENT 'Date by which the plan document must be filed with the Department of Labor.',
    `filing_status` STRING COMMENT 'Current filing status of the document.. Valid values are `filed|pending|late`',
    `liability_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum coverage amount provided by the liability insurance.',
    `liability_insurance_policy_number` STRING COMMENT 'Policy number for the fiduciary liability insurance.',
    `liability_insurance_provider` STRING COMMENT 'Name of the insurer providing fiduciary liability coverage.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the document.',
    `plan_administrator_email` STRING COMMENT 'Email address for the plan administrator.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `plan_administrator_name` STRING COMMENT 'Name of the individual or entity administering the plan.',
    `plan_name` STRING COMMENT 'Name of the health insurance plan governed by the document.',
    `plan_year` STRING COMMENT 'Fiscal year to which the plan document applies.',
    `erisa_plan_document_status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `draft|active|inactive|archived`',
    `trust_address` STRING COMMENT 'Street address of the trust.',
    `trust_city` STRING COMMENT 'City component of the trust address.',
    `trust_ein` STRING COMMENT 'Employer Identification Number of the trust.',
    `trust_name` STRING COMMENT 'Legal name of the trust holding plan assets.',
    `trust_state` STRING COMMENT 'State component of the trust address (US state code).',
    `trust_zip` STRING COMMENT 'ZIP/Postal code for the trust address.. Valid values are `^d{5}(-d{4})?$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    CONSTRAINT pk_erisa_plan_document PRIMARY KEY(`erisa_plan_document_id`)
) COMMENT 'ERISA-governed plan document record for self-funded employer groups, capturing the formal plan document, trust agreement, named fiduciary designations, plan administrator information, plan year, and ERISA wrap document details. Tracks DOL Form 5500 filing obligations, plan amendment history, and fiduciary liability insurance. Distinct from group_document in that it specifically governs ERISA compliance obligations and fiduciary responsibilities.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` (
    `regulatory_compliance_record_id` BIGINT COMMENT 'Primary key for the RegulatoryComplianceRecord association',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory_obligation',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer_group',
    `compliance_status` STRING COMMENT 'Current compliance state of the employer group for this obligation',
    `last_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment for this group‑obligation pair',
    CONSTRAINT pk_regulatory_compliance_record PRIMARY KEY(`regulatory_compliance_record_id`)
) COMMENT 'This association product captures the compliance relationship between an employer group and a regulatory obligation. It records the compliance status and the date of the most recent assessment for each group‑obligation pair.. Existence Justification: Each employer group must satisfy many regulatory obligations, and each regulatory obligation (e.g., HIPAA, ACA) applies to many employer groups. The insurer tracks compliance status and assessment dates for every group‑obligation pair, creating, updating, and deleting these records as part of ongoing compliance management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` (
    `employer_contract_id` BIGINT COMMENT 'Primary key for the Contract association',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer_group',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor',
    `annual_review_date` DATE COMMENT 'Scheduled date for the annual contract review',
    `contract_number` STRING COMMENT 'Unique identifier for the contract',
    `effective_date` DATE COMMENT 'Date the contract becomes effective',
    `employer_contract_status` STRING COMMENT 'Current lifecycle status of the contract (e.g., active, pending, terminated)',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract',
    CONSTRAINT pk_employer_contract PRIMARY KEY(`employer_contract_id`)
) COMMENT 'This association product represents the contractual relationship between an employer group and a vendor. It captures contract-specific details that exist only in the context of this relationship, linking one employer_group to one vendor per record.. Existence Justification: Employer groups negotiate separate contracts with multiple vendors, and each vendor can serve many employer groups. The contract itself carries attributes such as contract number, effective dates, status, total value, and review schedule, which are not owned by either the employer group or the vendor.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker` (
    `broker_id` BIGINT COMMENT 'Primary key for broker',
    `parent_broker_id` BIGINT COMMENT 'Self-referencing FK on broker (parent_broker_id)',
    `vendor_id` BIGINT COMMENT 'add column vendor_vendor_id (BIGINT) with FK to vendor.vendor.vendor_id - brokers are external business partners tracked in vendor master',
    `address_line1` STRING COMMENT 'First line of brokers physical address.',
    `address_line2` STRING COMMENT 'Second line of brokers physical address.',
    `agreement_end_date` DATE COMMENT 'End date of the broker agreement.',
    `agreement_start_date` DATE COMMENT 'Start date of the broker agreement.',
    `agreement_status` STRING COMMENT 'Current status of the broker agreement.',
    `agreement_terms` STRING COMMENT 'Detailed terms and conditions of the broker agreement.',
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
    `broker_status` STRING COMMENT 'Current operational status of the broker.',
    `tax_number` STRING COMMENT 'Tax ID used for regulatory reporting.',
    `termination_reason` STRING COMMENT 'Reason for terminating the broker relationship.',
    `broker_type` STRING COMMENT 'Classification of broker (e.g., independent, captive).',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Master reference table for broker. Referenced by broker_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`tpa` (
    `tpa_id` BIGINT COMMENT 'Primary key for tpa',
    `parent_tpa_id` BIGINT COMMENT 'Self-referencing FK on tpa (parent_tpa_id)',
    `vendor_id` BIGINT COMMENT 'add column vendor_vendor_id (BIGINT) with FK to vendor.vendor.vendor_id - TPAs are third-party vendors requiring vendor master linkage',
    `address_line1` STRING COMMENT 'Street address line 1 of the TPAs primary location.',
    `city` STRING COMMENT 'City of the TPAs primary location.',
    `contact_email` STRING COMMENT 'Primary email address for contacting the TPA.',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the TPA.',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting the TPA.',
    `contract_currency` STRING COMMENT 'ISO 4217 currency code for the contract value.',
    `contract_end_date` DATE COMMENT 'Date when the contract with the TPA is set to expire or was terminated.',
    `contract_notes` STRING COMMENT 'Additional notes or remarks about the contract.',
    `contract_number` STRING COMMENT 'Unique identifier for the contract between the insurer and the TPA.',
    `contract_start_date` DATE COMMENT 'Date when the contract with the TPA became effective.',
    `contract_status` STRING COMMENT 'Current status of the TPA contract.',
    `contract_type` STRING COMMENT 'Nature of the contract (e.g., service agreement, fee schedule, etc.).',
    `contract_value` DECIMAL(18,2) COMMENT 'Monetary value of the contract in the contract currency.',
    `country` STRING COMMENT 'ISO 3166-1 Alpha-3 country code of the TPAs primary location.',
    `coverage_end_date` DATE COMMENT 'End date of the coverage provided by the TPA.',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Monetary limit of the coverage in the coverage currency.',
    `coverage_limit_currency` STRING COMMENT 'ISO 4217 currency code for the coverage limit.',
    `coverage_start_date` DATE COMMENT 'Start date of the coverage provided by the TPA.',
    `coverage_status` STRING COMMENT 'Current status of the coverage.',
    `coverage_type` STRING COMMENT 'Type of coverage provided by the TPA.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the TPA record was first captured in the system.',
    `tpa_name` STRING COMMENT 'Human-readable name of the third-party administrator.',
    `renewal_date` DATE COMMENT 'Scheduled date for the next renewal of the TPA relationship.',
    `renewal_status` STRING COMMENT 'Current status of the renewal process.',
    `sla_end` DATE COMMENT 'End date of the current SLA with the TPA.',
    `sla_notes` STRING COMMENT 'Notes or remarks about the SLA.',
    `sla_start` DATE COMMENT 'Start date of the current SLA with the TPA.',
    `sla_status` STRING COMMENT 'Current status of the SLA.',
    `state` STRING COMMENT 'State or province of the TPAs primary location.',
    `tpa_status` STRING COMMENT 'Current lifecycle status of the third-party administrator.',
    `tax_number` STRING COMMENT 'Tax identification number assigned to the TPA.',
    `termination_date` DATE COMMENT 'Date when the TPA relationship was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason for termination of the TPA relationship.',
    `tpa_contact_name` STRING COMMENT 'Contact name for the TPA',
    `tpa_type` STRING COMMENT 'Classification of the third-party administrators role within the health insurance ecosystem.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the TPA record.',
    `zip` STRING COMMENT 'Postal ZIP code of the TPAs primary location.',
    CONSTRAINT pk_tpa PRIMARY KEY(`tpa_id`)
) COMMENT 'Master reference table for tpa. Referenced by tpa_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` (
    `broker_agreement_id` BIGINT COMMENT 'Primary key for broker_agreement',
    `group_id` BIGINT COMMENT 'Identifier of the specific employer group account this broker agreement is associated with, if the agreement is group-specific rather than a general agency agreement.',
    `general_agent_id` BIGINT COMMENT 'Identifier of the general agent or managing general agent under whose hierarchy this broker agreement falls, if applicable.',
    `parent_broker_agreement_id` BIGINT COMMENT 'Self-referencing FK on broker_agreement (parent_broker_agreement_id)',
    `vendor_id` BIGINT COMMENT 'add column vendor_vendor_id (BIGINT) with FK to vendor.vendor.vendor_id - broker agreements are contracts with external vendor entities',
    `broker_id` BIGINT COMMENT 'Identifier of the broker or producer entity that is party to this agreement.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the broker agreement, used in correspondence, commission statements, and regulatory filings.',
    `agreement_type` STRING COMMENT 'Classification of the broker agreement indicating the nature of the intermediary relationship (e.g., general agent, broker, sub-broker, managing general agent, consultant, or third-party administrator).',
    `amendment_count` STRING COMMENT 'Total number of formal amendments or addenda that have been executed against this broker agreement since its original effective date.',
    `appointment_date` DATE COMMENT 'Date on which the broker was formally appointed by the carrier to represent and sell its health insurance products.',
    `appointment_status` STRING COMMENT 'Status of the brokers formal appointment with the carrier, indicating whether the broker is currently appointed, pending appointment, lapsed, or revoked.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the broker agreement automatically renews at the end of each term period without requiring explicit re-execution.',
    `base_commission_rate` DECIMAL(18,2) COMMENT 'Standard base commission rate (expressed as a decimal percentage, e.g., 0.0500 = 5%) applicable under this agreement for new business production.',
    `broker_npn` STRING COMMENT 'National Producer Number assigned by the National Insurance Producer Registry (NIPR), uniquely identifying the licensed producer across all states.',
    `broker_tin` STRING COMMENT 'Federal Taxpayer Identification Number (EIN or SSN) of the broker, used for IRS 1099 reporting of commission payments.',
    `commission_schedule_type` STRING COMMENT 'Type of commission schedule governing broker compensation under this agreement, such as flat rate, tiered, percentage of premium, per-member-per-month, bonus-eligible, or override commission.',
    `compensation_method` STRING COMMENT 'Method by which the broker is compensated under this agreement, such as commission-based, fee-for-service, salary, or a hybrid arrangement.',
    `compliance_certification_date` DATE COMMENT 'Date of the most recent compliance certification or attestation completed by the broker, confirming adherence to carrier policies, ACA requirements, and anti-fraud provisions.',
    `contract_version` STRING COMMENT 'Version number of the broker agreement contract template used, supporting tracking of contract amendments and revisions over time.',
    `effective_date` DATE COMMENT 'Date on which the broker agreement becomes legally binding and the broker is authorized to solicit and sell health insurance products on behalf of the carrier.',
    `errors_omissions_expiry` DATE COMMENT 'Expiration date of the brokers current Errors and Omissions (E&O) insurance policy on file with the carrier.',
    `errors_omissions_required` BOOLEAN COMMENT 'Indicates whether the broker is required to maintain Errors and Omissions (E&O) professional liability insurance as a condition of this agreement.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this is an exclusive agreement where the broker is restricted from selling competing carriers products in the same market segment and territory.',
    `execution_date` DATE COMMENT 'Date on which the broker agreement was formally signed and executed by both parties.',
    `expiration_date` DATE COMMENT 'Date on which the broker agreement is scheduled to expire. Nullable for open-ended or evergreen agreements that auto-renew.',
    `market_segment` STRING COMMENT 'Health insurance market segment that the broker is authorized to sell under this agreement, such as small group, large group, individual, Medicare, Medicaid, or exchange marketplace.',
    `minimum_production_requirement` DECIMAL(18,2) COMMENT 'Minimum annual premium production volume or number of enrolled lives the broker must achieve to maintain active status under this agreement.',
    `non_compete_period_months` STRING COMMENT 'Duration in months of the non-compete or non-solicitation clause that applies after termination of this agreement.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the broker agreement, capturing special terms, negotiated exceptions, or administrative remarks.',
    `override_commission_rate` DECIMAL(18,2) COMMENT 'Override or bonus commission rate paid to general agents or managing brokers on production generated by sub-brokers under their hierarchy.',
    `payment_frequency` STRING COMMENT 'Frequency at which commission payments are disbursed to the broker under this agreement.',
    `product_line` STRING COMMENT 'Line of health insurance products the broker is authorized to sell under this agreement, such as medical, dental, vision, life, disability, or supplemental coverage.',
    `renewal_commission_rate` DECIMAL(18,2) COMMENT 'Commission rate applicable to renewal business under this agreement, often different from the new business rate.',
    `renewal_date` DATE COMMENT 'Next scheduled renewal date for the broker agreement, used for renewal management workflows and commission schedule reviews.',
    `state_of_licensure` STRING COMMENT 'Two-letter state code where the broker holds an active insurance producer license, as required for this agreement to be valid.',
    `broker_agreement_status` STRING COMMENT 'Current lifecycle status of the broker agreement indicating whether it is draft, active, suspended, terminated, expired, or pending renewal.',
    `termination_date` DATE COMMENT 'Actual date the broker agreement was terminated, if terminated prior to the scheduled expiration date. Null if the agreement has not been terminated.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the broker agreement, such as voluntary withdrawal, for-cause termination, non-renewal, regulatory action, mutual agreement, or carrier-initiated cancellation.',
    `territory_code` STRING COMMENT 'Code identifying the geographic sales territory or service area in which the broker is authorized to operate under this agreement.',
    CONSTRAINT pk_broker_agreement PRIMARY KEY(`broker_agreement_id`)
) COMMENT 'Master reference table for broker_agreement. Referenced by agreement_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` (
    `general_agent_id` BIGINT COMMENT 'Primary key for general_agent',
    `parent_ga_general_agent_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent general agent in a hierarchical GA structure (e.g., a Managing General Agent overseeing sub-GAs). Null for top-level GAs.',
    `supervising_general_agent_id` BIGINT COMMENT 'Self-referencing FK on general_agent (supervising_general_agent_id)',
    `address_line1` STRING COMMENT 'Primary street address line of the general agents principal place of business as registered with the state insurance department.',
    `address_line2` STRING COMMENT 'Secondary address line (suite, floor, unit number) for the general agents principal place of business.',
    `agent_status` STRING COMMENT 'Current lifecycle status of the general agent relationship with the health insurer. Drives eligibility to sell and receive commissions.',
    `ahip_certification_year` STRING COMMENT 'Plan year (e.g., 2024) for which the general agents AHIP Medicare certification is valid. AHIP certification must be renewed annually.',
    `ahip_certified` BOOLEAN COMMENT 'Indicates whether the general agent holds a current AHIP (Americas Health Insurance Plans) Medicare certification, required for selling Medicare Advantage and Part D products.',
    `appointed_lines_of_authority` STRING COMMENT 'Comma-delimited list of insurance lines of authority (e.g., Life, Accident & Health, Property) for which the general agent is appointed. Determines which product types the GA may distribute.',
    `appointment_date` DATE COMMENT 'Date on which the general agent was formally appointed by the health insurer to sell and distribute health insurance products. Marks the start of the contractual distribution relationship.',
    `background_check_date` DATE COMMENT 'Date on which the most recent background check was completed for the general agent. Used to determine if a refresh is required.',
    `background_check_status` STRING COMMENT 'Status of the most recent background check conducted on the general agent organization or its principals. Required for appointment and ongoing compliance.',
    `base_commission_pct` DECIMAL(18,2) COMMENT 'Base commission rate paid to the general agent for direct sales of health insurance products. Expressed as a decimal (e.g., 0.0500 = 5.00%).',
    `business_email` STRING COMMENT 'Official business email address for the general agent organization. Used for formal correspondence, appointment letters, and commission remittances.',
    `business_phone` STRING COMMENT 'Main business telephone number for the general agent organizations office. Used for general correspondence and partner communications.',
    `city` STRING COMMENT 'City of the general agents principal place of business.',
    `cms_approval_date` DATE COMMENT 'Date on which CMS approval was granted to the general agent for Medicare product distribution. Required for Medicare Advantage and Part D marketing activities.',
    `cms_approved` BOOLEAN COMMENT 'Indicates whether the general agent has been approved by the Centers for Medicare & Medicaid Services (CMS) to market Medicare Advantage and Part D products.',
    `commission_schedule_code` STRING COMMENT 'Code referencing the commission schedule or compensation tier applicable to this general agent. Determines base commission rates, override percentages, and bonus eligibility for sold products.',
    `compensation_method` STRING COMMENT 'Method by which the general agent is compensated for distribution services. Determines how commission calculations are structured.',
    `contract_effective_date` DATE COMMENT 'Date on which the general agent agreement (GA contract) became legally effective. May differ from the appointment date.',
    `contract_expiration_date` DATE COMMENT 'Date on which the general agent contract is scheduled to expire or renew. Null for evergreen contracts.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the general agents principal place of business. Typically USA for domestic general agents.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the general agent record was first created in the system. Used for audit trail and data lineage tracking.',
    `dba_name` STRING COMMENT 'Trade name or doing-business-as name used by the general agent in market-facing communications, if different from the legal name.',
    `distribution_channel` STRING COMMENT 'Primary distribution channel through which the general agent markets and sells health insurance products to employer groups and individuals.',
    `e_o_coverage_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the general agents E&O professional liability insurance coverage. Minimum coverage thresholds may be required by the insurer or state.',
    `e_o_expiration_date` DATE COMMENT 'Expiration date of the general agents E&O professional liability insurance policy. Triggers renewal reminders and may suspend appointment if lapsed.',
    `e_o_insurance_carrier` STRING COMMENT 'Name of the insurance carrier providing the general agents Errors and Omissions (E&O) professional liability coverage. Required for appointment and ongoing compliance.',
    `e_o_policy_number` STRING COMMENT 'Policy number of the general agents Errors and Omissions (E&O) professional liability insurance policy. Tracked for compliance and appointment renewal.',
    `fein` STRING COMMENT 'Federal Employer Identification Number in formatted XX-XXXXXXX form. Used for IRS 1099-MISC commission reporting and W-9 compliance.',
    `ga_code` STRING COMMENT 'Externally-known alphanumeric code assigned to the general agent by the health insurer or industry registry. Used for cross-system identification and partner communications.',
    `ga_name` STRING COMMENT 'Full legal business name of the general agent organization as registered with the state insurance department.',
    `ga_type` STRING COMMENT 'Classification of the general agent entity indicating its distribution tier and operational scope. [ENUM-REF-CANDIDATE: general_agent|managing_general_agent|field_marketing_organization|independent_marketing_organization — promote to reference product]',
    `license_expiration_date` DATE COMMENT 'Expiration date of the general agents primary state insurance producer license. Triggers renewal reminders and compliance alerts.',
    `license_number` STRING COMMENT 'Primary state insurance producer license number for the general agent in their home state. Additional state licenses are tracked in a separate license product.',
    `license_state` STRING COMMENT 'Two-letter USPS state code for the state in which the general agent holds their primary insurance producer license (home state).',
    `market_segment` STRING COMMENT 'Health insurance market segment(s) in which the general agent is authorized to operate. Drives product eligibility and commission structures.',
    `npi` STRING COMMENT 'National Producer Number assigned by the NIPR (National Insurance Producer Registry) uniquely identifying the general agent across all states. Used for appointment verification and regulatory reporting.',
    `npn` STRING COMMENT 'National Producer Number (NPN) as assigned by the National Insurance Producer Registry (NIPR). Primary regulatory identifier for the general agent used in state filings and CMS submissions.',
    `override_commission_pct` DECIMAL(18,2) COMMENT 'Override commission percentage paid to the general agent on top of base commissions earned by sub-agents or downline brokers. Expressed as a decimal (e.g., 0.0200 = 2.00%).',
    `postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the general agents principal place of business. Used for geographic territory assignment and state regulatory filings.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact at the general agent. Used for commission statements, appointment notices, and regulatory communications.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the general agent organization responsible for day-to-day relationship management.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the general agents main business contact. Used for appointment and commission inquiries.',
    `state_code` STRING COMMENT 'Two-letter USPS state abbreviation for the general agents principal place of business. Drives state-specific licensing and regulatory requirements.',
    `sub_agent_count` STRING COMMENT 'Number of licensed sub-agents or downline brokers currently operating under this general agents hierarchy. Used for override commission calculations and capacity planning.',
    `tax_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number (TIN) assigned to the general agent by the IRS. Required for commission payments and 1099 reporting.',
    `termination_date` DATE COMMENT 'Date on which the general agents appointment with the health insurer was terminated. Null if the appointment is currently active.',
    `territory_states` STRING COMMENT 'Comma-delimited list of two-letter state codes representing the geographic territory assigned to the general agent for distribution activities.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the general agent record was most recently modified. Used for change tracking and incremental data processing.',
    `w9_on_file` BOOLEAN COMMENT 'Indicates whether a valid IRS Form W-9 has been received and is on file for this general agent. Required before commission payments can be issued.',
    CONSTRAINT pk_general_agent PRIMARY KEY(`general_agent_id`)
) COMMENT 'Master reference table for general_agent. Referenced by general_agent_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ADD CONSTRAINT `fk_employer_group_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ADD CONSTRAINT `fk_employer_group_contact_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ADD CONSTRAINT `fk_employer_group_division_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ADD CONSTRAINT `fk_employer_participation_requirement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_broker_agreement_id` FOREIGN KEY (`broker_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker_agreement`(`broker_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_aso_fee_schedule_id` FOREIGN KEY (`aso_fee_schedule_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule`(`aso_fee_schedule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_stop_loss_policy_id` FOREIGN KEY (`stop_loss_policy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`stop_loss_policy`(`stop_loss_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ADD CONSTRAINT `fk_employer_open_enrollment_window_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ADD CONSTRAINT `fk_employer_open_enrollment_window_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ADD CONSTRAINT `fk_employer_employer_underwriting_case_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ADD CONSTRAINT `fk_employer_employer_underwriting_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ADD CONSTRAINT `fk_employer_employer_underwriting_case_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_employer_underwriting_case_id` FOREIGN KEY (`employer_underwriting_case_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case`(`employer_underwriting_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ADD CONSTRAINT `fk_employer_group_amendment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ADD CONSTRAINT `fk_employer_cobra_administration_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ADD CONSTRAINT `fk_employer_wellness_program_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ADD CONSTRAINT `fk_employer_group_document_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ADD CONSTRAINT `fk_employer_aso_fee_schedule_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ADD CONSTRAINT `fk_employer_group_rating_factor_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ADD CONSTRAINT `fk_employer_erisa_plan_document_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` ADD CONSTRAINT `fk_employer_regulatory_compliance_record_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ADD CONSTRAINT `fk_employer_employer_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_parent_broker_id` FOREIGN KEY (`parent_broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ADD CONSTRAINT `fk_employer_tpa_parent_tpa_id` FOREIGN KEY (`parent_tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_general_agent_id` FOREIGN KEY (`general_agent_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`general_agent`(`general_agent_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_parent_broker_agreement_id` FOREIGN KEY (`parent_broker_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker_agreement`(`broker_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ADD CONSTRAINT `fk_employer_general_agent_parent_ga_general_agent_id` FOREIGN KEY (`parent_ga_general_agent_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`general_agent`(`general_agent_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ADD CONSTRAINT `fk_employer_general_agent_supervising_general_agent_id` FOREIGN KEY (`supervising_general_agent_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`general_agent`(`general_agent_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`employer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`employer` SET TAGS ('dbx_domain' = 'employer');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (Broker Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool Id (Foreign Key)');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('dbx_business_glossary_term' = 'Domicile State (Domicile State)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('dbx_pii_person_data' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `headcount_current` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount (Current Headcount)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `headcount_last_month` SET TAGS ('dbx_business_glossary_term' = 'Headcount Last Month (Headcount Last Month)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `headcount_last_year` SET TAGS ('dbx_business_glossary_term' = 'Headcount Last Year (Headcount Last Year)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp (Last Status Change Timestamp)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name (Legal Name)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_flag' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_status` SET TAGS ('dbx_business_glossary_term' = 'Group Lifecycle Status (Group Lifecycle Status)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `group_status` SET TAGS ('dbx_value_regex' = 'prospect|active|suspended|terminated|reinstated');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'On Site Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Group Location Address Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'headquarters|billing|satellite|mailing');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_flag' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Location Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Group Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Group Location Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `rating_area` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `group_location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `group_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `group_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `group_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title (TITLE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'PPO Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `tertiary_group_epo_plan_health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'EPO Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `tertiary_group_epo_plan_health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `tertiary_group_epo_plan_health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `billing_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Billing Entity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Funding Classification');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'ASO|Fully_Insured|Self_Funded|TPA|Broker_Managed');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `contribution_percent` SET TAGS ('dbx_business_glossary_term' = 'Contribution Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered|none');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `covered_member_count` SET TAGS ('dbx_business_glossary_term' = 'Covered Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_name` SET TAGS ('dbx_business_glossary_term' = 'Division Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_type` SET TAGS ('dbx_business_glossary_term' = 'Division Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_type` SET TAGS ('dbx_value_regex' = 'department|subsidiary|cost_center|location|joint_venture');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `eligibility_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Set');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `flex_spending_amount` SET TAGS ('dbx_business_glossary_term' = 'Flex Spending Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `fsa_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'FSA Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `hsa_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'HSA Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_flex_spending` SET TAGS ('dbx_business_glossary_term' = 'Flex Spending Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_fsa` SET TAGS ('dbx_business_glossary_term' = 'FSA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_hsa` SET TAGS ('dbx_business_glossary_term' = 'HSA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_subsidy` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_waiver` SET TAGS ('dbx_business_glossary_term' = 'Waiver Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `group_division_status` SET TAGS ('dbx_business_glossary_term' = 'Division Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `group_division_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `subsidy_percent` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier (EMP_GRP_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier (PLAN_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Contribution Amount (CONTRIB_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Effective End Date (CONTRIB_EFF_END)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Effective Start Date (CONTRIB_EFF_START)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_percent` SET TAGS ('dbx_business_glossary_term' = 'Contribution Percentage (CONTRIB_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_strategy_description` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Description (CONTRIB_STRAT_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_tier` SET TAGS ('dbx_business_glossary_term' = 'Contribution Tier (CONTRIB_TIER)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type (CONTRIB_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_type` SET TAGS ('dbx_value_regex' = 'flat|percentage|tiered');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_FROM)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_UNTIL)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee‑Only Contribution Amount (EMP_CONTRIB_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `family_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Family Contribution Amount (FAM_CONTRIB_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `hra_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Reimbursement Arrangement Seed Amount (HRA_SEED)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `hsa_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account Seed Amount (HSA_SEED)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `is_affordable` SET TAGS ('dbx_business_glossary_term' = 'ACA Affordability Indicator (ACA_AFFORD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date (MEAS_END)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date (MEAS_START)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `minimum_enrolled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Enrolled Headcount (MIN_ENR_HEADCOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `minimum_participation_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participation Percentage (MIN_PART_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_business_glossary_term' = 'Offering Code (OFC)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_description` SET TAGS ('dbx_business_glossary_term' = 'Offering Description (OFC_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_business_glossary_term' = 'Offering Name (OFC_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_type` SET TAGS ('dbx_business_glossary_term' = 'Offering Type (OFC_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date (OE_END)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date (OE_START)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status (PARTICIP_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `plan_catalog_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Catalog Version (CATALOG_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year (PLAN_YEAR)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_status` SET TAGS ('dbx_business_glossary_term' = 'Offering Status (OFC_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|draft|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `waiver_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Waiver Criteria Description (WAIVER_CRIT_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `waiver_eligible` SET TAGS ('dbx_business_glossary_term' = 'Waiver Eligibility (WAIVER_ELIG)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `affordability_test_flag` SET TAGS ('dbx_business_glossary_term' = 'ACA Affordability Test Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Contribution Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_code` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Code (CS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contribution Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Contribution Rule Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('dbx_pii_flag' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = 'employee|family|spouse|child');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `tpa_id` SET TAGS ('dbx_business_glossary_term' = 'TPA ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `benefit_plan_ids` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan IDs');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ALTER COLUMN `renewal_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Year');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Participation Requirement ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `compliance_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'employer_paid|employee_paid|shared');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `enrolled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Enrolled Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'applicable|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Funding Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_value_regex' = 'ASO|fully_insured|self_funded');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Total Group Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `last_evaluated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluated Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `measurement_period` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `minimum_enrolled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Enrolled Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Evaluation Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Requirement Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'minimum_participation|waiver_eligibility|headcount_threshold');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `waiver_allowed` SET TAGS ('dbx_business_glossary_term' = 'Waiver Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `waiver_percentage_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Waiver Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Assignment ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Agency Name (AGENCY_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('dbx_pii_flag' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Broker Assignment Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('dbx_subdomain' = 'vendor_contracting');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'TPA Arrangement ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `aso_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Aso Fee Schedule Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `broker_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_id` SET TAGS ('dbx_business_glossary_term' = 'Tpa Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_value_regex' = 'ASO|Self-Funded|Fully-Insured');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `contribution_rate_pmpm` SET TAGS ('dbx_business_glossary_term' = 'Contribution Rate (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'covered|exempt');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `gfc_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Group Financial Control Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `group_size_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Group Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `group_size_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Group Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_arrangement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `open_enrollment_window_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `change_deadline` SET TAGS ('dbx_business_glossary_term' = 'Election Change Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `change_deadline` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|wellness|all');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `eligible_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Eligible Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online|paper|edi');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_type` SET TAGS ('dbx_value_regex' = 'annual|new_hire|cobra|special');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `participation_rate` SET TAGS ('dbx_business_glossary_term' = 'Participation Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `plan_selection_method` SET TAGS ('dbx_business_glossary_term' = 'Plan Selection Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `plan_selection_method` SET TAGS ('dbx_value_regex' = 'single|multiple');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Election Submission Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `total_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Total Employee Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `waiver_allowed` SET TAGS ('dbx_business_glossary_term' = 'Waiver Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `waiver_deadline` SET TAGS ('dbx_business_glossary_term' = 'Waiver Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `waiver_deadline` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ALTER COLUMN `window_code` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` SET TAGS ('dbx_subdomain' = 'risk_rating');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `employer_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Underwriting Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `employer_underwriting_case_id` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `tpa_id` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Administrator (TPA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `aca_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'ACA Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `actuarial_basis_document` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Basis Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_business_glossary_term' = 'Age/Gender Composite Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Case Number (UCN)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Effective End Date (Expiration Date)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Effective Start Date (Effective Date)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `experience_rating_factor` SET TAGS ('dbx_business_glossary_term' = 'Experience Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `experience_rating_factor` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `geographic_factor` SET TAGS ('dbx_business_glossary_term' = 'Geographic Rating Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_average_age` SET TAGS ('dbx_business_glossary_term' = 'Group Average Age');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_census_size` SET TAGS ('dbx_business_glossary_term' = 'Group Census Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_female_percentage` SET TAGS ('dbx_business_glossary_term' = 'Group Female Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `industry_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Industry Risk Factor Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `manual_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Manual Rate Basis Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `pmpm_estimate` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month (PMPM) Estimate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `prior_carrier_loss_experience` SET TAGS ('dbx_business_glossary_term' = 'Prior Carrier Loss Experience Summary');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `quote_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Expiration Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `quote_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Generation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `quote_status` SET TAGS ('dbx_value_regex' = 'draft|presented|accepted|expired|retracted');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `rating_area_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `rating_area_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_value_regex' = 'community|experience|blended');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `total_premium_estimate` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Estimate (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_value_regex' = 'approved|declined|modified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_status` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_status` SET TAGS ('dbx_value_regex' = 'draft|presented|accepted|expired|declined|modified');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('dbx_subdomain' = 'risk_rating');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Quote ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `employer_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Underwriting Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `tpa_id` SET TAGS ('dbx_business_glossary_term' = 'TPA ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Group Size');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Funding Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_type` SET TAGS ('dbx_value_regex' = 'ASO|FullyInsured');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Issue Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `net_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `pmpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `quote_version` SET TAGS ('dbx_business_glossary_term' = 'Quote Version');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rating_area` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_status` SET TAGS ('dbx_value_regex' = 'draft|presented|accepted|expired|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `total_group_premium_estimate` SET TAGS ('dbx_business_glossary_term' = 'Total Group Premium Estimate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `group_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Group Amendment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `after_value` SET TAGS ('dbx_business_glossary_term' = 'Post‑Amendment Value Snapshot');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Group Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Group Amendment Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|implemented|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Group Amendment Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'benefit_change|plan_add_drop|contribution_change|address_update|contact_change|coverage_change');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `approval_user_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `approval_user_role` SET TAGS ('dbx_value_regex' = 'broker|tpa|internal|compliance|executive');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `before_value` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Amendment Value Snapshot');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `contribution_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Contribution Change Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `is_critical_change` SET TAGS ('dbx_business_glossary_term' = 'Critical Change Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `new_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'New Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `original_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Contribution Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'regulatory|member_request|broker_request|cost_control|plan_design|other');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `cobra_administration_id` SET TAGS ('dbx_business_glossary_term' = 'COBRA Administration ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `administrator_name` SET TAGS ('dbx_business_glossary_term' = 'COBRA Administrator Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `administrator_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `administrator_type` SET TAGS ('dbx_business_glossary_term' = 'COBRA Administrator Type (ADMIN_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `administrator_type` SET TAGS ('dbx_value_regex' = 'self|third_party');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'COBRA Agreement Type (COBRA_AGMT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'federal_cobra|state_mini_cobra|both');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `cobra_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'COBRA Agreement Number (COBRA_AGMT_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'COBRA Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `election_end_date` SET TAGS ('dbx_business_glossary_term' = 'Election Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `election_period_days` SET TAGS ('dbx_business_glossary_term' = 'Election Period Duration (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `election_start_date` SET TAGS ('dbx_business_glossary_term' = 'Election Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `group_cobra_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Group COBRA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `last_compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last COBRA Compliance Check Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `max_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Employee Count for COBRA Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `min_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Employee Count for COBRA Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|mail|phone|portal');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `premium_rate` SET TAGS ('dbx_business_glossary_term' = 'COBRA Premium Rate (Currency Amount)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `premium_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Multiplier (Percent of Group Rate)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Type (QUAL_EVENT_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_value_regex' = 'termination|reduction_of_hours|divorce|death|other');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `state_cobra_law` SET TAGS ('dbx_business_glossary_term' = 'State COBRA Law Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `state_cobra_law` SET TAGS ('dbx_value_regex' = 'AL|CA|NY|TX|FL|GA');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `state_cobra_law` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `cobra_administration_status` SET TAGS ('dbx_business_glossary_term' = 'COBRA Administration Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `cobra_administration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `wellness_program_id` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Partner Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `aca_compliance_classification` SET TAGS ('dbx_business_glossary_term' = 'ACA Compliance Classification');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `aca_compliance_classification` SET TAGS ('dbx_value_regex' = 'participatory|health_contingent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `current_participant_count` SET TAGS ('dbx_business_glossary_term' = 'Current Participant Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `wellness_program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `enrollment_cap` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cap');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `incentive_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Incentive Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `incentive_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'premium_discount|hsa_contribution|gift_card');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `is_eligible_for_tax_credit` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Program Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `participation_method` SET TAGS ('dbx_business_glossary_term' = 'Participation Tracking Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `participation_method` SET TAGS ('dbx_value_regex' = 'self_report|automated|third_party');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_actual_participation_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Participation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Amount (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_budget_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'wellness|prevention|mental_health|nutrition|physical_activity');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_effective_year` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_end_reason` SET TAGS ('dbx_business_glossary_term' = 'Program End Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_review_status` SET TAGS ('dbx_business_glossary_term' = 'Program Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|under_review|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_subtype` SET TAGS ('dbx_business_glossary_term' = 'Program Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_target_participation_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Participation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'biometric_screening|smoking_cessation|weight_management|eap|chronic_disease_prevention|other');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'Program Version');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `wellness_program_status` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `wellness_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|draft');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `group_document_id` SET TAGS ('dbx_business_glossary_term' = 'Group Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'legal|benefit|regulatory|administrative|financial|operational');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|other');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `erisa_plan_administrator` SET TAGS ('dbx_business_glossary_term' = 'ERISA Plan Administrator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `expiration_policy` SET TAGS ('dbx_business_glossary_term' = 'Expiration Policy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `expiration_policy` SET TAGS ('dbx_value_regex' = 'auto_delete|archive|retain|review');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `fiduciary_designation` SET TAGS ('dbx_business_glossary_term' = 'Fiduciary Designation');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|xlsx|txt|html');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `is_electronic` SET TAGS ('dbx_business_glossary_term' = 'Electronic Document Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Document Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Document Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `physical_location` SET TAGS ('dbx_business_glossary_term' = 'Physical Location');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `retention_period_months` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `source_system_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `group_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `group_document_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending|superseded');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage URI');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `storage_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `trust_agreement_details` SET TAGS ('dbx_business_glossary_term' = 'Trust Agreement Details');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('dbx_subdomain' = 'risk_rating');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `aso_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'ASO Fee Schedule Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `cap_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `cap_type` SET TAGS ('dbx_value_regex' = 'per_member|per_claim|overall');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Component Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'claims_processing|network_access|care_management|pharmacy_benefit|administrative|other');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `aso_fee_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `minimum_participation_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participation Percent');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `pm_per_member_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `aso_fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `aso_fee_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('dbx_subdomain' = 'risk_rating');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `stop_loss_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Stop-Loss Policy Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_attachment_point` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Attachment Point');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_attachment_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_attachment_point` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_deductible_reset_period` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Deductible Reset Period');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `aggregate_deductible_reset_period` SET TAGS ('dbx_value_regex' = 'annual|calendar_year|policy_year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `attachment_point_type` SET TAGS ('dbx_business_glossary_term' = 'Attachment Point Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `attachment_point_type` SET TAGS ('dbx_value_regex' = 'per_claim|per_year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Carrier Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `carrier_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Limit');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `claim_payment_limit_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Strategy');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('dbx_subdomain' = 'risk_rating');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `group_rating_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Rating Factor ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `actuarial_basis` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Basis');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `actuarial_basis` SET TAGS ('dbx_value_regex' = 'experience|community|state|custom');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Factor Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Factor Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `factor_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Factor Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `factor_description` SET TAGS ('dbx_business_glossary_term' = 'Rating Factor Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `factor_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Factor Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `factor_type` SET TAGS ('dbx_value_regex' = 'age_gender|geographic|industry|experience|aca_adjustment|other');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `factor_value` SET TAGS ('dbx_business_glossary_term' = 'Rating Factor Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `is_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Factor Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `rating_period_end` SET TAGS ('dbx_business_glossary_term' = 'Rating Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `rating_period_end` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `rating_period_start` SET TAGS ('dbx_business_glossary_term' = 'Rating Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `rating_period_start` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_value_regex' = 'ACA|CMS|NAIC|state');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `source_system_factor_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Factor ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `group_rating_factor_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Factor Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `group_rating_factor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `group_rating_factor_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `value_unit` SET TAGS ('dbx_business_glossary_term' = 'Rating Factor Unit');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `value_unit` SET TAGS ('dbx_value_regex' = 'percentage|multiplier|dollar');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `erisa_plan_document_id` SET TAGS ('dbx_business_glossary_term' = 'ERISA Plan Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_name` SET TAGS ('dbx_business_glossary_term' = 'Document Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'plan|trust|amendment');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('dbx_business_glossary_term' = 'Fiduciary Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_role` SET TAGS ('dbx_business_glossary_term' = 'Fiduciary Role');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'filed|pending|late');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Coverage Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_coverage_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `liability_insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Liability Insurance Provider');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `erisa_plan_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `erisa_plan_document_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_address` SET TAGS ('dbx_business_glossary_term' = 'Trust Address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_city` SET TAGS ('dbx_business_glossary_term' = 'Trust City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_city` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('dbx_business_glossary_term' = 'Trust EIN');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_name` SET TAGS ('dbx_business_glossary_term' = 'Trust Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_state` SET TAGS ('dbx_business_glossary_term' = 'Trust State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_state` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('dbx_business_glossary_term' = 'Trust ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('dbx_subdomain' = 'vendor_contracting');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('dbx_association_edges' = 'employer.employer_group,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` ALTER COLUMN `regulatory_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatorycompliancerecord - Compliance Record Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatorycompliancerecord - Regulatory Obligation Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatorycompliancerecord - Employer Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` SET TAGS ('dbx_subdomain' = 'vendor_contracting');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` SET TAGS ('dbx_association_edges' = 'employer.employer_group,vendor.vendor');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `employer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract - Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `employer_contract_id` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `employer_contract_id` SET TAGS ('dbx_ssot_entity' = 'contract');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Contract - Employer Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contract - Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `annual_review_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `employer_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `rating` SET TAGS ('dbx_pii_personal' = 'true');
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
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('dbx_subdomain' = 'vendor_contracting');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_id` SET TAGS ('dbx_business_glossary_term' = 'Tpa Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `parent_tpa_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tpa Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `parent_tpa_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Tpa Address Line1');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Tpa City');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_currency` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contract Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contract End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_notes` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contract Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contract Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Tpa Contract Value');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Tpa Country');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tpa Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Tpa Coverage Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Tpa Coverage Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tpa Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Tpa Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Tpa Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Tpa Created At');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_name` SET TAGS ('dbx_business_glossary_term' = 'Tpa Name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Tpa Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Tpa Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `sla_end` SET TAGS ('dbx_business_glossary_term' = 'Tpa Sla End');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `sla_notes` SET TAGS ('dbx_business_glossary_term' = 'Tpa Sla Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `sla_start` SET TAGS ('dbx_business_glossary_term' = 'Tpa Sla Start');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Tpa Sla Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Tpa State');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_status` SET TAGS ('dbx_business_glossary_term' = 'Tpa Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tpa Tax Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Tpa Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Tpa Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_type` SET TAGS ('dbx_business_glossary_term' = 'Tpa Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Tpa Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('dbx_business_glossary_term' = 'Tpa Zip');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Agreement Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `general_agent_id` SET TAGS ('dbx_business_glossary_term' = 'General Agent Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `parent_broker_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Broker Agreement Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `parent_broker_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `base_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `base_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_npn` SET TAGS ('dbx_business_glossary_term' = 'Broker Npn');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_tin` SET TAGS ('dbx_business_glossary_term' = 'Broker Tin');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `commission_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Type');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('dbx_business_glossary_term' = 'Compensation Method');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `errors_omissions_expiry` SET TAGS ('dbx_business_glossary_term' = 'Errors Omissions Expiry');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `errors_omissions_required` SET TAGS ('dbx_business_glossary_term' = 'Errors Omissions Required');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `minimum_production_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Production Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `non_compete_period_months` SET TAGS ('dbx_business_glossary_term' = 'Non Compete Period Months');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `override_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Override Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `override_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `renewal_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Renewal Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `renewal_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `state_of_licensure` SET TAGS ('dbx_business_glossary_term' = 'State Of Licensure');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `state_of_licensure` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `broker_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `general_agent_id` SET TAGS ('dbx_business_glossary_term' = 'General Agent Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `supervising_general_agent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `base_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `compensation_method` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `e_o_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `e_o_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `fein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `fein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `ga_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `ga_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `npi` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `override_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
