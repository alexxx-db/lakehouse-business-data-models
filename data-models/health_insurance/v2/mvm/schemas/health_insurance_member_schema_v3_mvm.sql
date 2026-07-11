-- Schema for Domain: member | Business: Health_Insurance | Version: v3_mvm
-- Generated on: 2026-07-10 22:45:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`member` COMMENT 'Single source of truth for all insured individuals — members, subscribers, dependents, and beneficiaries across commercial, Medicare, Medicaid, and CHIP lines of business. Owns member demographics, PII/PHI identity, eligibility status, LOB assignment, COBRA continuants, household relationships, and member lifecycle events. All other domains reference member identity via FK. Supports HIPAA privacy obligations and CMS enrollment reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`subscriber` (
    `subscriber_id` BIGINT COMMENT 'Primary key for subscriber',
    `group_location_id` BIGINT COMMENT 'Foreign key linking to employer.group_location. Business justification: Multi-site employers assign subscribers to specific group locations for rating area determination, on-site clinic access, and location-based benefit administration. This link enables location-level en',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan product.',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.care_coordinator. Business justification: Primary Care Coordinator Assignment: case‑management reports need each subscriber linked to their assigned care coordinator.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: Primary Care Provider assignment for each subscriber is needed for care coordination, network adequacy reporting, and member portal display.',
    `annual_income` DECIMAL(18,2) COMMENT 'Subscribers reported annual income (for subsidy eligibility).',
    `chip_number` STRING COMMENT 'Childrens Health Insurance Program identifier.',
    `citizenship_status` STRING COMMENT 'Legal citizenship or residency status.. Valid values are `citizen|permanent_resident|non_resident|unknown`',
    `cob_indicator` STRING COMMENT 'Indicates subscribers position in coordination of benefits.. Valid values are `primary|secondary|tertiary`',
    `consent_to_electronic_communication` BOOLEAN COMMENT 'Subscribers consent to receive electronic communications.',
    `coverage_type` STRING COMMENT 'Type of health plan coverage.. Valid values are `hmo|ppo|epo|pos|hdhp|hsa`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscriber record was created.',
    `date_of_birth` DATE COMMENT 'Subscribers birth date.',
    `disability_status` STRING COMMENT 'Indicates if subscriber has a disability.. Valid values are `yes|no|unknown`',
    `effective_date` DATE COMMENT 'Date when subscriber coverage becomes effective.',
    `enrollment_source` STRING COMMENT 'Channel through which subscriber enrolled.. Valid values are `online|call_center|agent|mail|broker`',
    `first_name` STRING COMMENT 'Subscribers given name.',
    `gender` STRING COMMENT 'Subscribers gender as reported.. Valid values are `male|female|other|unknown`',
    `hcc_score` DECIMAL(18,2) COMMENT 'Aggregated HCC score for the subscriber.',
    `is_deceased` BOOLEAN COMMENT 'Flag indicating if subscriber is deceased.',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|fr|zh|other`',
    `last_name` STRING COMMENT 'Subscribers family name.',
    `line_of_business` STRING COMMENT 'Business line the subscriber belongs to.. Valid values are `commercial|medicare|medicaid|chip|group|individual`',
    `marital_status` STRING COMMENT 'Subscribers marital status.. Valid values are `single|married|divorced|widowed|separated|unknown`',
    `medicaid_number` STRING COMMENT 'State Medicaid identifier.',
    `medicare_beneficiary_number` STRING COMMENT 'Unique identifier for Medicare beneficiaries.',
    `middle_name` STRING COMMENT 'Subscribers middle name (if any).',
    `number` STRING COMMENT 'External contract number assigned to the subscriber.',
    `primary_contact_method` STRING COMMENT 'Preferred method for contacting subscriber.. Valid values are `phone|email|mail|portal`',
    `race_ethnicity` STRING COMMENT 'Self-reported race/ethnicity for reporting.. Valid values are `white|black|asian|hispanic|native_american|other`',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk adjustment calculations.',
    `ssn` STRING COMMENT 'Subscribers Social Security Number.. Valid values are `^(d{3}-d{2}-d{4})$`',
    `subscriber_status` STRING COMMENT 'Current lifecycle status of the subscriber.. Valid values are `active|inactive|terminated|suspended|pending`',
    `termination_date` DATE COMMENT 'Date when subscriber coverage ends (if applicable).',
    `tobacco_use_status` STRING COMMENT 'Subscribers tobacco use status.. Valid values are `current|former|never|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subscriber record.',
    `veteran_status` BOOLEAN COMMENT 'Indicates if subscriber is a veteran.',
    CONSTRAINT pk_subscriber PRIMARY KEY(`subscriber_id`)
) COMMENT 'Core master entity representing the primary insured individual (subscriber/policyholder) who holds the health insurance contract. Captures full demographic identity including SSN, date of birth, gender, marital status, language preference, race/ethnicity (for HEDIS/CMS reporting), tobacco use status, disability status, and Medicare/Medicaid beneficiary identifiers. Serves as the SSOT for subscriber identity across commercial, Medicare Advantage, Medicaid, and CHIP lines of business. All dependent, eligibility, and benefit records reference this entity. Supports HIPAA PHI/PII obligations, CMS enrollment reporting, and X12 834 subscriber loop requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`dependent` (
    `dependent_id` BIGINT COMMENT 'Primary key for dependent',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Dependents may be enrolled in different benefit packages than the subscriber (e.g., pediatric-only dental/vision packages, CHIP benefit packages). Benefit determination and cost-sharing calculations f',
    `contact_id` BIGINT COMMENT 'Foreign key linking to member.member_contact. Business justification: member_contact is the single source of truth for all member contact information and addresses. The dependent table currently stores inline contact and address fields (address_line1, address_line2, cit',
    `identity_id` BIGINT COMMENT 'Foreign key linking to member.identity. Business justification: The identity table is the authoritative identity resolution record for each unique insured individual — explicitly covering both subscribers AND dependents (identity.member_type and identity.relations',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary member (subscriber) to whom this dependent is attached.',
    `age_out_eligibility_flag` BOOLEAN COMMENT 'True if the dependent is eligible for age-out coverage under plan rules.',
    `chip_eligibility_flag` BOOLEAN COMMENT 'Indicates eligibility for the Childrens Health Insurance Program.',
    `country` STRING COMMENT 'Three-letter ISO country code of residence.. Valid values are `^[A-Z]{3}$`',
    `coverage_end_date` DATE COMMENT 'Date when dependents coverage terminated or is scheduled to end.',
    `coverage_start_date` DATE COMMENT 'Date when dependents coverage became effective.',
    `coverage_status` STRING COMMENT 'Current status of the dependents coverage.. Valid values are `active|inactive|terminated|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dependent record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Birth date of the dependent.',
    `disability_status` BOOLEAN COMMENT 'Indicates if the dependent has a documented disability.',
    `first_name` STRING COMMENT 'Given name of the dependent.',
    `gender` STRING COMMENT 'Gender of the dependent as reported.. Valid values are `male|female|other|unknown`',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates if this dependent is the primary contact for the subscribers household.',
    `language_preference` STRING COMMENT 'Preferred language for communications with the dependent.',
    `last_name` STRING COMMENT 'Family name of the dependent.',
    `medicaid_eligibility_flag` BOOLEAN COMMENT 'Indicates eligibility for Medicaid program.',
    `middle_name` STRING COMMENT 'Middle name or initial of the dependent.',
    `record_status` STRING COMMENT 'Lifecycle status of the record itself.. Valid values are `active|inactive|deleted|archived`',
    `relationship_end_date` DATE COMMENT 'Date when the dependent relationship ended, if applicable.',
    `relationship_start_date` DATE COMMENT 'Date when the dependent relationship became effective.',
    `relationship_type` STRING COMMENT 'Legal relationship of the dependent to the subscriber.. Valid values are `spouse|domestic_partner|child|other`',
    `sequence_number` STRING COMMENT 'Ordinal number to differentiate multiple dependents of same relationship type.',
    `ssn` STRING COMMENT 'Government-issued identifier for the dependent.. Valid values are `^d{3}-d{2}-d{4}$`',
    `student_status` BOOLEAN COMMENT 'Indicates if the dependent is currently a student (True) or not (False).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dependent record.',
    CONSTRAINT pk_dependent PRIMARY KEY(`dependent_id`)
) COMMENT 'Master entity representing individuals covered under a subscribers health plan — spouses, domestic partners, children, and other qualifying dependents. Tracks relationship type to subscriber, dependent sequence number, student status, disability status, age-out eligibility rules, and CHIP/Medicaid eligibility indicators. Maintains its own demographic profile including DOB, gender, SSN, and language preference. Supports dependent verification workflows, age-out processing, and CMS CHIP enrollment reporting. Each dependent record is linked to a subscriber and an enrollment span.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`identity` (
    `identity_id` BIGINT COMMENT 'Primary key for identity',
    `subscriber_id` BIGINT COMMENT 'Identifier assigned by the health plan to the member (e.g., commercial member ID, MBI for Medicare).',
    `address_line1` STRING COMMENT 'First line of the members mailing address.',
    `address_line2` STRING COMMENT 'Second line of the members mailing address (if applicable).',
    `citizenship_status` STRING COMMENT 'Citizenship or residency status relevant for eligibility and reporting.. Valid values are `citizen|non_citizen|permanent_resident|temporary_resident|unknown`',
    `city` STRING COMMENT 'City component of the members mailing address.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the members residence.',
    `coverage_end_date` DATE COMMENT 'Date when the members coverage terminated or is scheduled to end.',
    `coverage_start_date` DATE COMMENT 'Date when the members coverage became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the identity record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Members birth date, used for age‑based eligibility and risk calculations.',
    `eligibility_status` STRING COMMENT 'Current eligibility determination for benefits coverage.. Valid values are `eligible|ineligible|pending`',
    `email` STRING COMMENT 'Primary email address used for member communications and portal login.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `enrollment_effective_date` DATE COMMENT 'Date the members enrollment into the plan became effective.',
    `ethnicity` STRING COMMENT 'Members ethnicity as reported for demographic reporting.',
    `external_subscriber_number` STRING COMMENT 'Identifier from an external source such as employer payroll or third‑party administrator.',
    `first_name` STRING COMMENT 'Members given (first) name.',
    `full_name` STRING COMMENT 'Complete legal name of the member as it appears on official documents.',
    `gender` STRING COMMENT 'Self‑identified gender of the member.. Valid values are `male|female|other|unknown`',
    `language_preference` STRING COMMENT 'Primary language the member prefers for communications.',
    `last_name` STRING COMMENT 'Members family (last) name.',
    `lob` STRING COMMENT 'Business line (e.g., commercial, Medicare) to which the member belongs.. Valid values are `commercial|medicare|medicaid|chip|group`',
    `marital_status` STRING COMMENT 'Members marital status for demographic and eligibility purposes.. Valid values are `single|married|divorced|widowed|separated|unknown`',
    `member_status` STRING COMMENT 'Overall lifecycle status of the member within the health plan.. Valid values are `active|inactive|terminated|suspended|pending`',
    `member_type` STRING COMMENT 'Indicates whether the record represents a primary subscriber or a dependent.. Valid values are `subscriber|dependent|spouse|child|other`',
    `middle_name` STRING COMMENT 'Members middle name(s), if any.',
    `phone_number` STRING COMMENT 'Primary telephone number for member contact.',
    `postal_code` STRING COMMENT 'ZIP or postal code of the members mailing address.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for member communications.. Valid values are `email|phone|mail|portal`',
    `race` STRING COMMENT 'Members race classification for HEDIS and regulatory reporting.',
    `relationship_to_subscriber` STRING COMMENT 'Describes the members relationship to the primary subscriber.. Valid values are `self|spouse|child|parent|other`',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score used for underwriting and care management.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of the source record in the originating system.',
    `ssn_hash` STRING COMMENT 'Hashed Social Security Number used for identity matching while protecting PII.',
    `state` STRING COMMENT 'State or province component of the members mailing address (2‑letter code).',
    `termination_date` DATE COMMENT 'Date the members relationship with the plan was terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the identity record.',
    `verification_date` DATE COMMENT 'Date on which the members identity was successfully verified.',
    `verification_status` STRING COMMENT 'Current status of the members identity verification process.. Valid values are `unverified|pending|verified|failed`',
    CONSTRAINT pk_identity PRIMARY KEY(`identity_id`)
) COMMENT 'Authoritative identity resolution record for each unique insured individual (subscriber or dependent) assigned a unique member ID by the health plan. Stores the plan-assigned member ID (MBI for Medicare, Medicaid ID, commercial member ID), cross-reference IDs from source systems (Facets member ID, QNXT ID), alternate IDs (SSN hash, external subscriber ID from employer), and identity verification status. Manages member ID history and superseded IDs. This is the enterprise golden record for member identity used by all downstream domains (claims, pharmacy, care management) to resolve member identity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`contact` (
    `contact_id` BIGINT COMMENT 'System-generated unique identifier for each contact record associated with a member.',
    `subscriber_id` BIGINT COMMENT 'add column member_subscriber_id (BIGINT) with FK to member.subscriber.subscriber_id - member contacts must link to the subscriber they represent',
    `address_cass_certified` BOOLEAN COMMENT 'True if the address has passed USPS CASS certification.',
    `address_effective_date` DATE COMMENT 'Date when the address became effective for the member.',
    `address_geocode_accuracy` STRING COMMENT 'Indicates the confidence level of the geocoding result.. Valid values are `high|medium|low`',
    `address_geocode_source` STRING COMMENT 'System used to generate latitude/longitude for the address.. Valid values are `USPS|Google|HERE|Other`',
    `address_line1` STRING COMMENT 'Primary street address line.',
    `address_line2` STRING COMMENT 'Secondary street address line (apartment, suite, etc.).',
    `address_priority_rank` STRING COMMENT 'Numeric rank indicating the order of address preference for the member.',
    `address_source_system` STRING COMMENT 'Source system that originally supplied the address record.. Valid values are `Facets|QNXT|CRM|Other`',
    `address_termination_date` DATE COMMENT 'Date when the address was terminated or superseded.',
    `address_type` STRING COMMENT 'Purpose of the address (e.g., home, mailing, temporary).. Valid values are `home|mailing|temporary|employer|other`',
    `address_verification_status` STRING COMMENT 'USPS CASS certification status of the address.. Valid values are `verified|unverified|pending`',
    `census_tract` STRING COMMENT 'Eleven‑digit census tract identifier for geographic analysis.',
    `city` STRING COMMENT 'City of the address.',
    `contact_type` STRING COMMENT 'Classification of the contact relationship to the member.. Valid values are `member|dependent|beneficiary|employer|provider|other`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the address.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `county_fips` STRING COMMENT 'Five‑digit Federal Information Processing Standard code for the county.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contact record was first created.',
    `email_address` STRING COMMENT 'Primary electronic mail address for the contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the contact.',
    `id_type` STRING COMMENT 'Type of identifier used for the contact (e.g., NPI, SSN).. Valid values are `NPI|SSN|MemberID|Other`',
    `id_value` DECIMAL(18,2) COMMENT 'The actual identifier value corresponding to contact_id_type.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this record is the members primary contact.',
    `language_preference` STRING COMMENT 'Members preferred language for communications.. Valid values are `en|es|fr|zh|other`',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent address verification event.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the address in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the address in decimal degrees.',
    `member_contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|terminated|pending`',
    `contact_name` STRING COMMENT 'Legal full name of the contact person (member, dependent, or other party).',
    `notes` STRING COMMENT 'Free‑form notes related to the contact (e.g., preferred call times).',
    `opt_in_email` BOOLEAN COMMENT 'Indicates whether the member has consented to receive email communications.',
    `opt_in_robocall` BOOLEAN COMMENT 'Indicates whether the member permits automated voice calls.',
    `opt_in_sms` BOOLEAN COMMENT 'Indicates whether the member has consented to receive SMS messages.',
    `phone_home` STRING COMMENT 'Primary residential telephone number.',
    `phone_mobile` STRING COMMENT 'Cellular telephone number for mobile contact.',
    `phone_work` STRING COMMENT 'Telephone number associated with the contacts place of work.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.',
    `preferred_contact_method` STRING COMMENT 'Contact channel the member prefers for communications.. Valid values are `phone|email|mail|sms`',
    `relationship` STRING COMMENT 'Relationship of the contact to the member.. Valid values are `self|spouse|child|parent|guardian|other`',
    `state_province` STRING COMMENT 'State or province component of the address.',
    `tcp_a_consent_flag` BOOLEAN COMMENT 'True if the contact has provided consent under the Telephone Consumer Protection Act.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the contact record.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Single source of truth for all member contact information and addresses. Manages physical and mailing addresses (home, mailing, temporary, employer), phone numbers (home, mobile, work), email addresses, and fax numbers. Tracks contact type, address type, effective and termination dates, address verification status (USPS CASS-certified), county FIPS code, census tract, geographic coordinates for network adequacy analysis, opt-in/opt-out status per channel (SMS, email, robocall), TCPA consent flags, and preferred contact method and language. Supports multiple concurrent addresses with priority ranking. Used for premium billing, EOB mailing, provider directory access, CMS geographic reporting, member services outreach, care management communications, and CAHPS survey administration. Maintains full address and contact history for audit and compliance purposes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` (
    `pcp_assignment_id` BIGINT COMMENT 'Primary key for pcp_assignment',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Benefit packages define PCP assignment requirements (e.g., mandatory PCP for HMO benefit packages). Linking pcp_assignment to benefit_package enables benefit-package-level PCP compliance reporting and',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: PCPs under capitation contracts have their panel members attributed through PCP assignments. Linking pcp_assignment to capitation_arrangement enables accurate PMPM payment calculation per PCP panel, s',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required for compliance check that a PCP assignment respects an active provider contract; ensures network participation rules are enforced during PCP selection.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: PCP assignments are plan-specific — HMO plans require PCP assignment while PPO plans do not. Plan-level PCP panel management, network adequacy reporting, and auto-assignment logic all require knowing ',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom the PCP is assigned.',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: PCP assignment workflows must verify the specific PAR agreement under which the PCP participates in the network, supporting continuity of care, credentialing status checks, and contract compliance. Th',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: PCP assignment records must reference the provider entity to support network participation audits and accurate provider‑member linkage.',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: PCP assignments must specify WHICH office location the member is assigned to, since a provider can have multiple practice locations. Network adequacy reporting, member directory display, and care coor',
    `provider_assignment_id` BIGINT COMMENT 'Foreign key linking to network.provider_assignment. Business justification: Panel management requires linking a members PCP assignment to the providers network.provider_assignment record to verify panel capacity, accepting_new_patients_flag, and panel_status before assignme',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which the PCP belongs.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: pcp_assignment.pcp_specialty_code is a denormalized representation of provider.specialty. Linking to specialty normalizes this, enabling credentialing validation, HEDIS specialty reporting, and networ',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: PCP assignments in tiered networks must record the PCPs tier to calculate member cost-sharing and steerage incentives. The existing network_tier plain-text column is a denormalization of network.tier',
    `assignment_reason` STRING COMMENT 'Free‑text explanation for why the PCP was assigned (e.g., member request, network requirement).',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the PCP assignment.. Valid values are `active|inactive|pending|terminated`',
    `assignment_type` STRING COMMENT 'Method by which the PCP was assigned: member‑selected, auto‑assigned by system, or plan‑assigned.. Valid values are `member_selected|auto_assigned|plan_assigned`',
    `change_reason` STRING COMMENT 'Reason for a change to the PCP assignment (e.g., member relocation, provider departure).',
    `change_timestamp` TIMESTAMP COMMENT 'Exact time when the most recent change to the assignment was recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PCP assignment record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the PCP assignment becomes effective for the member.',
    `is_current` BOOLEAN COMMENT 'True if the assignment is the active PCP for the member at query time.',
    `is_primary` BOOLEAN COMMENT 'Indicates if this PCP is the members primary provider when multiple assignments exist.',
    `notes` STRING COMMENT 'Additional free‑form comments or audit notes about the assignment.',
    `panel_status` STRING COMMENT 'Indicates whether the PCP is currently in the members provider panel.. Valid values are `in_panel|out_of_panel|pending`',
    `termination_date` DATE COMMENT 'Date when the PCP assignment ends or is scheduled to end; null if still active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the PCP assignment record.',
    CONSTRAINT pk_pcp_assignment PRIMARY KEY(`pcp_assignment_id`)
) COMMENT 'Tracks Primary Care Provider (PCP) assignments for members enrolled in HMO, POS, and other gatekeeper plan types. Records assigned PCP NPI, PCP effective and termination dates, assignment type (member-selected, auto-assigned, plan-assigned), PCP change reason, PCP panel status at time of assignment, and PCP network tier. Manages PCP change request history and auto-assignment rules for newborns and new enrollees. Used for care coordination, referral authorization, capitation payment calculation, and HEDIS PCP attribution. Integrates with provider and network domains.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`cob_record` (
    `cob_record_id` BIGINT COMMENT 'Primary key for cob_record',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Coordination of benefits processing must record the employee handling the COB record for compliance and audit.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: COB adjudication requires knowing which health_plan is primary/secondary to apply correct cost-sharing rules. Insurers must reference the specific plan whose benefits are being coordinated. Every COB ',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom this COB record belongs.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Medicare Secondary Payer (MSP) rules and state COB regulations are specific regulatory obligations governing COB records. The existing is_msp_compliant column signals MSP regulatory dependency. Comp',
    `birthday_rule_applicable` BOOLEAN COMMENT 'Indicates whether the birthday rule is used to determine primary payer.',
    `cob_order` STRING COMMENT 'Sequencing of the carrier in the coordination of benefits hierarchy.. Valid values are `primary|secondary|tertiary`',
    `cob_status` STRING COMMENT 'Current lifecycle status of the COB record.. Valid values are `active|inactive|pending|terminated`',
    `cob_verification_date` DATE COMMENT 'Date when the COB information was verified.',
    `coordination_of_benefits_rule` STRING COMMENT 'Rule applied to determine payer order (e.g., birthday rule).. Valid values are `birthday|plan|state|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COB record was first created in the data lake.',
    `effective_date` DATE COMMENT 'Date the COB coverage becomes effective.',
    `is_msp_compliant` BOOLEAN COMMENT 'Indicates compliance with Medicare Secondary Payer rules.',
    `is_subrogation_flag` BOOLEAN COMMENT 'True if the claim may be subject to subrogation based on this COB arrangement.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the COB arrangement.',
    `number` STRING COMMENT 'Business identifier assigned to the COB record for external reference.',
    `policy_type` STRING COMMENT 'Classification of the other carrier policy.. Valid values are `commercial|medicare|medicaid|auto|workers_comp|other`',
    `termination_date` DATE COMMENT 'Date the COB coverage ends or is terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COB record.',
    `verification_method` STRING COMMENT 'Method used to verify the COB information.. Valid values are `manual|electronic|auto`',
    CONSTRAINT pk_cob_record PRIMARY KEY(`cob_record_id`)
) COMMENT 'Coordination of Benefits (COB) record tracking a members other insurance coverage to prevent duplicate payment and ensure correct primary/secondary/tertiary payer sequencing. Captures other carrier name, other carrier member ID, other carrier group number, policy type (commercial, Medicare, Medicaid, auto, workers comp), COB order (primary/secondary/tertiary), effective and termination dates, birthday rule applicability, and COB verification date. Supports COB inquiry workflows, subrogation identification, and Medicare Secondary Payer (MSP) compliance. Used by claims adjudication for COB calculation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`id_card` (
    `id_card_id` BIGINT COMMENT 'Surrogate primary key for the ID card record.',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.eligibility_span. Business justification: An ID card is issued to represent a members active coverage for a specific eligibility period. Linking id_card to eligibility_span establishes the authoritative coverage period the card represents, e',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Member ID cards display formulary-specific pharmacy benefit information (tier copays, BIN/PCN). Linking id_card to formulary enables member portal drug coverage lookups, formulary change notifications',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Member ID cards display the employer group number; group_number on id_card is a denormalized plain attribute. A proper FK to employer.group enforces referential integrity, enables group-level card iss',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: ID cards are issued per health plan; linking enables tracking issuance per plan for regulatory reporting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the card is issued.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: id_card.pcp_name is a denormalized copy of provider data used for card printing. A direct FK to provider.provider normalizes this, enabling real-time PCP name/contact retrieval for card generation and',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: ID card generation for tiered network plans requires the members assigned tier to print correct copay amounts and tier labels. ID card printing systems must reference network.tier directly to populat',
    `barcode` STRING COMMENT 'Machine-readable barcode value encoded on the card.',
    `card_format` STRING COMMENT 'Delivery format of the card: physical plastic, digital image, or mobile app representation.. Valid values are `physical|digital|mobile`',
    `card_number` STRING COMMENT 'The alphanumeric identifier printed on the ID card, used for member identification.',
    `card_type` STRING COMMENT 'Category of coverage the card provides (e.g., medical, dental).. Valid values are `medical|dental|vision|pharmacy|combined`',
    `card_version` STRING COMMENT 'Version identifier for the card design/layout.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Standard copayment amount shown on the card for office visits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the card record was created in the system.',
    `customer_service_phone` STRING COMMENT 'Phone number printed on the card for member support.',
    `delivery_confirmation_date` DATE COMMENT 'Date when delivery of the card was confirmed.',
    `delivery_method` STRING COMMENT 'Method used to deliver the card to the member.. Valid values are `mail|courier|in_person|digital_download|mobile_push`',
    `expiration_date` DATE COMMENT 'Date after which the card is no longer valid.',
    `external_system_code` STRING COMMENT 'Identifier of the card record in the source operational system (e.g., Facets).',
    `id_card_status` STRING COMMENT 'Current lifecycle status of the card.. Valid values are `active|replaced|lost|stolen|expired|pending`',
    `is_primary` BOOLEAN COMMENT 'Indicates if this card is the members primary ID card.',
    `issue_date` DATE COMMENT 'Date the card was originally issued to the member.',
    `language_preference` STRING COMMENT 'Members preferred language for card language.. Valid values are `en|es|fr|zh|vi|ar`',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the card status last changed.',
    `magnetic_stripe_data` STRING COMMENT 'Data encoded on the magnetic stripe of the physical card.',
    `pharmacy_bin` STRING COMMENT 'Bank Identification Number for pharmacy benefits.',
    `pharmacy_group_number` STRING COMMENT 'Group number used for pharmacy benefit routing.',
    `pharmacy_pcn` STRING COMMENT 'Processor Control Number for pharmacy claims.',
    `replacement_date` DATE COMMENT 'Date a replacement card was issued, if applicable.',
    `replacement_reason` STRING COMMENT 'Reason why the card was replaced.. Valid values are `damage|loss|theft|upgrade|member_request|expiration`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the card record.',
    CONSTRAINT pk_id_card PRIMARY KEY(`id_card_id`)
) COMMENT 'Manages the issuance and tracking of member health insurance ID cards (physical and digital). Records card issue date, card type (medical, dental, vision, pharmacy, combined), card format (physical, digital/mobile), card status (active, replaced, lost/stolen, expired), plan name on card, group number, member ID displayed, PCP name (for HMO cards), copay amounts displayed, pharmacy BIN/PCN/Group numbers, and customer service phone numbers. Tracks card replacement requests, reason for replacement, and delivery confirmation. Supports member services ID card fulfillment workflows and digital ID card provisioning via member portal.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`policy` (
    `policy_id` BIGINT COMMENT 'Primary key for policy',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: A policys coverage terms are defined by a specific benefit package. Claims adjudication, prior authorization, and EOB generation all require knowing which benefit package governs the policy. Domain e',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: A member policy governs which formulary applies to pharmacy benefits. Pharmacy benefit administrators and member portals require direct policy-to-formulary resolution for benefit verification, member ',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: A member policy is created from a specific employer group plan offering — the exact product selected during open enrollment. This link drives renewal processing, ACA affordability determination, emplo',
    `identity_id` BIGINT COMMENT 'Reference to the insured member associated with the policy.',
    `parent_policy_id` BIGINT COMMENT 'Self-referencing FK on policy (parent_policy_id)',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: A policys premium is calculated from a specific rate record. Linking policy to rate enables premium reconciliation, rate change impact analysis, and actuarial audits. The denormalized premium_amount/',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to member.subscriber. Business justification: Policy is a child of subscriber; adding subscriber_id FK establishes the 1:N relationship and removes the silo.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Policies align to plan years for accumulator resets, ACA MLR reporting, and renewal processing. The plan year governs deductible reset dates and open enrollment eligibility. A domain expert would expe',
    `coverage_end_date` DATE COMMENT 'Date when coverage under the policy ends.',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary limit for covered services under the policy.',
    `coverage_limit_currency` STRING COMMENT 'Currency code for the coverage limit amount.',
    `coverage_limit_type` STRING COMMENT 'Scope of the coverage limit (e.g., lifetime, annual).',
    `coverage_start_date` DATE COMMENT 'Date when coverage under the policy begins.',
    `coverage_status` STRING COMMENT 'Current status of the coverage portion of the policy.',
    `coverage_type` STRING COMMENT 'Type of coverage plan (e.g., HMO, PPO).',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the insured must pay before coverage applies.',
    `deductible_currency` STRING COMMENT 'Currency code for the deductible amount.',
    `effective_date` DATE COMMENT 'Date when the policy becomes effective.',
    `expiration_date` DATE COMMENT 'Date when the policy expires if not renewed.',
    `number` STRING COMMENT 'Human-readable policy number assigned by the insurer.',
    `out_of_pocket_max_amount` DECIMAL(18,2) COMMENT 'Maximum amount the insured pays in a benefit year.',
    `out_of_pocket_max_currency` STRING COMMENT 'Currency code for the out-of-pocket maximum amount.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the policy.',
    `policy_type` STRING COMMENT 'Classification of the policy based on the insured entity type.',
    `renewal_amount` DECIMAL(18,2) COMMENT 'Total amount paid for the policy renewal.',
    `renewal_currency` STRING COMMENT 'Currency code for the renewal amount.',
    `renewal_date` DATE COMMENT 'Date when the policy renewal was processed.',
    `renewal_deductible_amount` DECIMAL(18,2) COMMENT 'Deductible portion of the renewal payment.',
    `renewal_deductible_currency` STRING COMMENT 'Currency code for the renewal deductible amount.',
    `renewal_out_of_pocket_max_amount` DECIMAL(18,2) COMMENT 'Out-of-pocket maximum for the renewal period.',
    `renewal_out_of_pocket_max_currency` STRING COMMENT 'Currency code for the renewal out-of-pocket maximum amount.',
    `renewal_premium_amount` DECIMAL(18,2) COMMENT 'Premium portion of the renewal payment.',
    `renewal_premium_currency` STRING COMMENT 'Currency code for the renewal premium amount.',
    `renewal_status` STRING COMMENT 'Current status of the policy renewal process.',
    `termination_date` DATE COMMENT 'Date when the policy was terminated.',
    `termination_reason` STRING COMMENT 'Reason for policy termination.',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master reference table for policy. Referenced by policy_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` (
    `eligibility_span_id` BIGINT COMMENT 'System-generated unique identifier for the eligibility span record.',
    `benefit_package_id` BIGINT COMMENT 'Identifier of the specific benefit package within the plan.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom this eligibility span applies.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.service_area. Business justification: An eligibility span is fundamentally tied to a service area — regulatory filings, network adequacy reporting, and enrollment processing all require knowing which service area covers the members eligi',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: An eligibility span represents a continuous period of health plan eligibility under a specific policy. policy is the master reference for coverage terms (deductible, out-of-pocket max, premium, covera',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: Enrollment transaction processing: enrollment transactions (add, change, terminate) directly create or modify eligibility spans. This link supports retroactive adjustment processing, enrollment audit ',
    `cobro_end_date` DATE COMMENT 'End date of COBRA continuation coverage, if applicable.',
    `cobro_start_date` DATE COMMENT 'Start date of COBRA continuation coverage, if applicable.',
    `coverage_type` STRING COMMENT 'Type of coverage provided during the eligibility span.. Valid values are `medical|dental|vision|rx|wellness`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility span record was created in the system.',
    `effective_date` DATE COMMENT 'Date when the eligibility period becomes effective.',
    `eligibility_source` STRING COMMENT 'Origin of the eligibility information (e.g., EDI 834 file, manual entry).. Valid values are `834|manual|cms|portal`',
    `eligibility_status` STRING COMMENT 'Current status of the eligibility span.. Valid values are `active|terminated|suspended|cobra|pending`',
    `enrollment_type` STRING COMMENT 'Nature of the enrollment event that created this eligibility span.. Valid values are `new|renewal|change|reinstatement`',
    `gap_in_coverage_flag` BOOLEAN COMMENT 'True if there is a gap in coverage between this span and the previous span.',
    `is_primary_coverage` BOOLEAN COMMENT 'Indicates whether this span represents the primary coverage for the member (vs. supplemental).',
    `line_of_business` STRING COMMENT 'Business line under which the coverage is offered.. Valid values are `commercial|medicare|medicaid|chip`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount associated with this eligibility span.',
    `premium_currency` STRING COMMENT 'Three-letter ISO currency code for the premium amount.. Valid values are `[A-Z]{3}`',
    `retroactive_eligibility_flag` BOOLEAN COMMENT 'Indicates if the eligibility was applied retroactively.',
    `subscriber_relationship_code` STRING COMMENT 'Code indicating the relationship of the member to the primary subscriber.. Valid values are `self|spouse|child|parent|other`',
    `termination_date` DATE COMMENT 'Date when the eligibility period ends or is scheduled to end.',
    `termination_reason_code` STRING COMMENT 'Code describing why the eligibility span terminated.. Valid values are `member_request|non_payment|plan_change|death|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the eligibility span record.',
    CONSTRAINT pk_eligibility_span PRIMARY KEY(`eligibility_span_id`)
) COMMENT 'Core transactional entity representing a continuous period of health plan eligibility for a member. Captures effective date, termination date, termination reason code, plan ID, benefit package, group/employer ID, subscriber relationship code, premium amount, and eligibility source (834 EDI, manual entry, CMS enrollment file). Tracks eligibility status (active, terminated, suspended, COBRA), retroactive eligibility adjustments, and gap-in-coverage periods. The SSOT for answering Is this member eligible on date X? — used by claims adjudication, pharmacy, and provider eligibility verification (270/271 transactions).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` (
    `member_enrollment_id` BIGINT COMMENT 'Primary key for the enrollment association',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Enrollment events specify the exact benefit package selected by the member. This drives benefit determination, cost-sharing application, and formulary assignment at enrollment. Required for accurate b',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Member enrollment in care programs drives capitation payment calculations. The capitation_arrangement governs PMPM rates and attributed member counts. Finance and provider relations teams require this',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber',
    `program_id` BIGINT COMMENT 'Foreign key linking to care program',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Enrollment events are tied to specific plan years for open enrollment period validation, ACA compliance reporting, and accumulator reset processing. CMS requires plan-year-level enrollment counts; thi',
    `effective_end_date` DATE COMMENT 'Date when the enrollment ends or is terminated',
    `effective_start_date` DATE COMMENT 'Date when the enrollment becomes effective',
    `member_enrollment_status` STRING COMMENT 'Current status of the enrollment (e.g., active, terminated)',
    `member_enrollment_type` STRING COMMENT 'Classification of enrollment (e.g., mandatory, optional)',
    `number` STRING COMMENT 'Unique identifier for the enrollment record',
    `reason` STRING COMMENT 'Reason for enrollment, often derived from eligibility criteria',
    CONSTRAINT pk_member_enrollment PRIMARY KEY(`member_enrollment_id`)
) COMMENT 'This association product represents the enrollment contract between a subscriber and a care program. It captures enrollment-specific data such as enrollment number, status, effective dates, type, and reason. Each record links one subscriber to one care program.. Existence Justification: Subscribers can enroll in multiple care programs and each care program can have many subscribers. The enrollment is an operational record that is created, updated, and deleted by staff and includes attributes such as enrollment dates, status, type, and reason. The business treats enrollment as a distinct entity (Enrollment) that is queried and reported on.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`grievance` (
    `grievance_id` BIGINT COMMENT 'Primary key for grievance',
    `benefit_package_id` BIGINT COMMENT 'Identifier of the specific benefit package linked to the members coverage.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Member grievances filed for drug coverage denials, formulary tier placement disputes, or PA denials must reference the specific drug. CMS Part D and state regulators require grievance reporting by dru',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Grievances are frequently filed against facilities (hospitals, urgent care centers) rather than individual providers. CMS grievance reporting and state regulatory submissions require identifying the f',
    `formulary_exception_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary_exception. Business justification: Grievances are frequently filed after a formulary exception denial. CMS Part D requires tracking the full coverage determination appeals chain: exception request → denial → grievance. This FK creates ',
    `group_id` BIGINT COMMENT 'Identifier of the staff member or investigator assigned to handle the grievance.',
    `header_id` BIGINT COMMENT 'SSOT reference to appeal.grievance (single source of truth)',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is enrolled at the time of the grievance.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who filed the grievance.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Grievances are frequently filed when a PA request is denied. This link supports the denial-to-grievance workflow, CMS regulatory reporting of adverse determination appeals, and grievance resolution tr',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: CMS and state regulators require grievances to identify the specific practice location where the access or service issue occurred. A provider may operate at multiple sites; location-level grievance tr',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: Grievances are filed when prior authorizations are denied. CMS Part D coverage determination regulations require tracking the PA denial → grievance → appeal chain. Health plan compliance teams and reg',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Member grievances arising from network adequacy, claim denials, or reimbursement disputes must be linked to the governing provider contract for contract performance monitoring, dispute resolution trac',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: Grievances are often filed against a specific provider; linking enables tracking, reporting, and regulatory compliance.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Grievance Management Report requires linking each grievance to the provider network involved, enabling compliance tracking and root‑cause analysis.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: CMS and state regulations mandate specific grievance/appeals timelines and reporting (ACA §2719, CMS managed care rules). Linking grievance to the governing regulatory_obligation enables compliance tr',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Grievances frequently dispute specific reimbursement policy decisions — denials, bundling reductions, or modifier edits. Linking grievance to the triggering reimbursement_policy enables root-cause ana',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: Grievances arise from adverse UM case determinations (e.g., concurrent review denials, LOS disputes). Linking grievance to um_case enables UM-driven grievance reporting, NCQA/URAC compliance audits, a',
    `cms_reportable_indicator` BOOLEAN COMMENT 'True if the grievance is reportable under CMS grievance reporting requirements (e.g., Medicare Advantage).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grievance record was first created in the data warehouse.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for the disputed amount.. Valid values are `^[A-Z]{3}$`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary amount that the member is contesting, if applicable (e.g., billing dispute).',
    `investigation_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the investigation concluded.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the investigation of the grievance began.',
    `issue_category_code` STRING COMMENT 'More granular classification of the grievance issue within the selected grievance type.',
    `lob_code` STRING COMMENT 'Code identifying the line of business (e.g., commercial, Medicare, Medicaid, CHIP) associated with the member.',
    `member_grievance_status` STRING COMMENT 'Current lifecycle state of the grievance.. Valid values are `open|in_review|resolved|closed|withdrawn`',
    `member_satisfaction_score` STRING COMMENT 'Member‑reported satisfaction rating of the grievance resolution on a 1‑5 scale.',
    `number` STRING COMMENT 'Business‑visible identifier assigned to the grievance, often used in member communications and regulatory reporting.',
    `received_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the grievance was first recorded in the system.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the grievance must be reported to regulatory bodies (true) or not (false).',
    `resolution_date` DATE COMMENT 'Calendar date on which the grievance was formally resolved.',
    `resolution_description` STRING COMMENT 'Narrative details of the actions taken or explanation provided to resolve the grievance.',
    `resolution_type_code` STRING COMMENT 'Indicates how the grievance was addressed, e.g., corrective action, explanation, refund, no action, or other.. Valid values are `corrective_action|explanation|refund|no_action|other`',
    `source` STRING COMMENT 'Channel through which the grievance was received.. Valid values are `call_center|online_portal|mail|in_person`',
    `state_code` STRING COMMENT 'Two‑letter US state abbreviation where the grievance originated or is applicable.. Valid values are `^[A-Z]{2}$`',
    `type_code` STRING COMMENT 'Categorizes the grievance by primary concern area such as quality of care, access, provider attitude, billing/financial, or benefit/coverage.. Valid values are `quality_of_care|access|attitude|billing|benefit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grievance record.',
    CONSTRAINT pk_grievance PRIMARY KEY(`grievance_id`)
) COMMENT 'Operational record of formal member grievances (non-appeal complaints) filed against the health plan regarding service quality, access to care, provider behavior, billing disputes, or administrative issues. Tracks grievance receipt date, grievance type code (quality of care, access, attitude/service, billing/financial, benefit/coverage), issue category, member-reported description, assigned investigator, investigation timeline, resolution date, resolution type, resolution description, member satisfaction with resolution, regulatory reporting flag, and CMS/state DOI reportable indicator. Distinct from the appeal domain which handles coverage determination and claim denial disputes — grievances are expressions of dissatisfaction, not requests for coverage reversal. Supports CMS grievance reporting requirements for Medicare Advantage (42 CFR §422.564) and Medicaid managed care (42 CFR §438.402), state DOI complaint reporting, and NCQA accreditation standards (CR standards).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`address` (
    `address_id` BIGINT COMMENT 'Surrogate primary key for the address record.',
    `plan_service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: Member addresses must be validated against plan service areas to confirm enrollment eligibility and regulatory compliance. State insurance regulators require insurers to verify members reside within t',
    `subscriber_id` BIGINT COMMENT 'Identifier of the member to whom this address belongs.',
    `address_type` STRING COMMENT 'Classification of address purpose.. Valid values are `home|mailing|temporary|employer|other`',
    `census_tract` STRING COMMENT 'Census tract identifier for demographic analysis.. Valid values are `^d{11}$`',
    `change_reason` STRING COMMENT 'Reason for address change (e.g., member request, system update).',
    `city` STRING COMMENT 'City name of the address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code.. Valid values are `^[A-Z]{3}$`',
    `county_fips` STRING COMMENT 'Federal Information Processing Standard code for the county.. Valid values are `^d{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created in the data lake.',
    `effective_date` DATE COMMENT 'Date when the address became effective for the member.',
    `external_code` STRING COMMENT 'External identifier for the address from source system.',
    `geocode_accuracy_meters` STRING COMMENT 'Accuracy of the geocoding result in meters.',
    `is_primary` BOOLEAN COMMENT 'Indicates if this address is the primary address for the member.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude in decimal degrees.',
    `line1` STRING COMMENT 'Primary street address line.',
    `line2` STRING COMMENT 'Secondary address line (apartment, suite, etc.).',
    `line3` STRING COMMENT 'Additional address line if needed.',
    `line4` STRING COMMENT 'Additional address line if needed.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude in decimal degrees.',
    `member_address_status` STRING COMMENT 'Current lifecycle status of the address.. Valid values are `active|inactive|pending|terminated`',
    `postal_code` STRING COMMENT 'Five-digit ZIP code, optionally with ZIP+4.. Valid values are `^d{5}(-d{4})?$`',
    `priority_rank` STRING COMMENT 'Rank indicating priority among multiple concurrent addresses for the member (1 = highest).',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date when the address was terminated or superseded.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the address record.',
    `verification_date` DATE COMMENT 'Date when address verification was performed.',
    `verification_status` STRING COMMENT 'USPS CASS certification status of the address.. Valid values are `verified|unverified|pending`',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Manages all physical and mailing addresses associated with a member, including home address, mailing address, temporary address, and employer address. Tracks address type, effective and termination dates, address verification status (USPS CASS-certified), county FIPS code, census tract, and geographic coordinates for network adequacy analysis. Supports multiple concurrent addresses with priority ranking. Used for premium billing, EOB mailing, provider directory access, and CMS geographic reporting. Maintains address history for audit and compliance purposes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`contact`(`contact_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ADD CONSTRAINT `fk_member_contact_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_eligibility_span_id` FOREIGN KEY (`eligibility_span_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_parent_policy_id` FOREIGN KEY (`parent_policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ADD CONSTRAINT `fk_member_eligibility_span_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ADD CONSTRAINT `fk_member_eligibility_span_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ADD CONSTRAINT `fk_member_grievance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ADD CONSTRAINT `fk_member_address_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`member` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`member` SET TAGS ('dbx_domain' = 'member');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('dbx_subdomain' = 'coverage_administration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `group_location_id` SET TAGS ('dbx_business_glossary_term' = 'Group Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Coordinator Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_business_glossary_term' = 'Annual Income');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_business_glossary_term' = 'CHIP Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|non_resident|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `consent_to_electronic_communication` SET TAGS ('dbx_business_glossary_term' = 'Electronic Communication Consent');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp|hsa');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'yes|no|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'online|call_center|agent|mail|broker');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_business_glossary_term' = 'Deceased Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (Family Name)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|chip|group|individual');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Number (Policy Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|portal');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Race/Ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_value_regex' = 'white|black|asian|hispanic|native_american|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^(d{3}-d{2}-d{4})$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Use Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_value_regex' = 'current|former|never|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('dbx_subdomain' = 'coverage_administration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Member Contact Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `age_out_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Age-Out Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `chip_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'CHIP Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Dependent Date of Birth (DOB)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent First Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Dependent Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `medicaid_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|archived');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Dependent Relationship Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'spouse|domestic_partner|child|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Dependent Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^d{3}-d{2}-d{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `student_status` SET TAGS ('dbx_business_glossary_term' = 'Student Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('dbx_subdomain' = 'coverage_administration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Assigned Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Member Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Member Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Member Citizenship Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'citizen|non_citizen|permanent_resident|temporary_resident|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Member City');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Member Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Member Date of Birth');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Member Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Member Ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('dbx_business_glossary_term' = 'External Subscriber Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Member First Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Member Full Legal Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Member Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Member Preferred Language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Member Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|chip|group');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Member Marital Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('dbx_business_glossary_term' = 'Member Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_type` SET TAGS ('dbx_business_glossary_term' = 'Member Type (Subscriber or Dependent)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_type` SET TAGS ('dbx_value_regex' = 'subscriber|dependent|spouse|child|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Member Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Member Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Member Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|portal');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('dbx_business_glossary_term' = 'Member Race');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Subscriber');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number Hash');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Member State');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|pending|verified|failed');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` SET TAGS ('dbx_subdomain' = 'coverage_administration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Member Contact Identifier (MCID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_business_glossary_term' = 'CASS Certified Flag (CASS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Date (AED)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy (GEO_ACC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_business_glossary_term' = 'Geocode Source (GEO_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_value_regex' = 'USPS|Google|HERE|Other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Address Priority Rank (APR)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_business_glossary_term' = 'Address Source System (ASS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_value_regex' = 'Facets|QNXT|CRM|Other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Address Termination Date (ATD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type (AT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|mailing|temporary|employer|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status (AVS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract (CT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type (CT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'member|dependent|beneficiary|employer|provider|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (CC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `county_fips` SET TAGS ('dbx_business_glossary_term' = 'County FIPS Code (FIPS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `county_fips` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number (FAX)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier Type (CID_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_type` SET TAGS ('dbx_value_regex' = 'NPI|SSN|MemberID|Other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_value` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier Value (CID_VAL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag (PRIMARY)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp (LVT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `member_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (CSTAT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `member_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name (CFN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes (CNOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Opt‑In Flag (EMAIL_OPT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_robocall` SET TAGS ('dbx_business_glossary_term' = 'Robocall Opt‑In Flag (RC_OPT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Opt‑In Flag (SMS_OPT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_business_glossary_term' = 'Home Phone Number (HPN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number (MPN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number (WPN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method (PCM)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|sms');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `relationship` SET TAGS ('dbx_business_glossary_term' = 'Contact Relationship (CREL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `relationship` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|guardian|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province (ST)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `tcp_a_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'TCPA Consent Flag (TCPA)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('dbx_subdomain' = 'provider_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `pcp_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Assignment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID (Member Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Assignment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Assignment Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'member_selected|auto_assigned|plan_assigned');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'PCP Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PCP Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Assignment Start Date)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Current Assignment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary PCP Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'in_panel|out_of_panel|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Assignment End Date)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('dbx_subdomain' = 'provider_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_record_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Record Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `group_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `group_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('dbx_business_glossary_term' = 'Birthday Rule Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_order` SET TAGS ('dbx_business_glossary_term' = 'COB Order');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_order` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_status` SET TAGS ('dbx_business_glossary_term' = 'COB Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_verification_date` SET TAGS ('dbx_business_glossary_term' = 'COB Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `coordination_of_benefits_rule` SET TAGS ('dbx_business_glossary_term' = 'COB Rule Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `coordination_of_benefits_rule` SET TAGS ('dbx_value_regex' = 'birthday|plan|state|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `is_msp_compliant` SET TAGS ('dbx_business_glossary_term' = 'MSP Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `is_subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'COB Notes');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'COB Record Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type (COB)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|auto|workers_comp|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual|electronic|auto');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('dbx_subdomain' = 'provider_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `id_card_id` SET TAGS ('dbx_business_glossary_term' = 'ID Card ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Card Barcode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_format` SET TAGS ('dbx_business_glossary_term' = 'Card Format');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_format` SET TAGS ('dbx_value_regex' = 'physical|digital|mobile');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('dbx_business_glossary_term' = 'Card Number (ID Card Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|combined');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_version` SET TAGS ('dbx_business_glossary_term' = 'Card Version Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount Displayed');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Card Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|courier|in_person|digital_download|mobile_push');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Card Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `id_card_status` SET TAGS ('dbx_business_glossary_term' = 'Card Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `id_card_status` SET TAGS ('dbx_value_regex' = 'active|replaced|lost|stolen|expired|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Card Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Card Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|vi|ar');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `magnetic_stripe_data` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Stripe Data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_bin` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy BIN (Bank Identification Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_group_number` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Group Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_pcn` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy PCN (Processor Control Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Card Replacement Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `replacement_reason` SET TAGS ('dbx_business_glossary_term' = 'Card Replacement Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `replacement_reason` SET TAGS ('dbx_value_regex' = 'damage|loss|theft|upgrade|member_request|expiration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('dbx_subdomain' = 'enrollment_management');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `parent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Policy Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `parent_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `deductible_currency` SET TAGS ('dbx_business_glossary_term' = 'Deductible Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `out_of_pocket_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Out Of Pocket Max Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `out_of_pocket_max_currency` SET TAGS ('dbx_business_glossary_term' = 'Out Of Pocket Max Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_currency` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_deductible_currency` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Deductible Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_out_of_pocket_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Out Of Pocket Max Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_out_of_pocket_max_currency` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Out Of Pocket Max Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Premium Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Policy Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` SET TAGS ('dbx_subdomain' = 'enrollment_management');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `cobro_end_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `cobro_start_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|rx|wellness');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `eligibility_source` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Source');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `eligibility_source` SET TAGS ('dbx_value_regex' = '834|manual|cms|portal');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'active|terminated|suspended|cobra|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'new|renewal|change|reinstatement');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `gap_in_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap In Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `is_primary_coverage` SET TAGS ('dbx_business_glossary_term' = 'Primary Coverage Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|chip');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `retroactive_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `subscriber_relationship_code` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Relationship Code (SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `subscriber_relationship_code` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code (TRC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'member_request|non_payment|plan_change|death|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` SET TAGS ('dbx_subdomain' = 'enrollment_management');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Enrollment Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Member Subscriber Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Care Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `member_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `member_enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` SET TAGS ('dbx_subdomain' = 'provider_coordination');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Grievance Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Identifier (BP_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `formulary_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Exception Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Identifier (INV_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `group_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `group_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier (PLAN_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (MEM_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Grievance Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `cms_reportable_indicator` SET TAGS ('dbx_business_glossary_term' = 'CMS Reportable Indicator (CMS_IND)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount (DIS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `investigation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Timestamp (INV_END_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp (INV_START_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `issue_category_code` SET TAGS ('dbx_business_glossary_term' = 'Issue Category Code (ISS_CAT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business Code (LOB_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `member_grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Status (GRV_STS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `member_grievance_status` SET TAGS ('dbx_value_regex' = 'open|in_review|resolved|closed|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `member_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Member Satisfaction Score (SAT_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Number (GRV_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grievance Received Timestamp (GRV_RCV_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date (RES_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description (RES_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `resolution_type_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type Code (RES_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `resolution_type_code` SET TAGS ('dbx_value_regex' = 'corrective_action|explanation|refund|no_action|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Grievance Source (GRV_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'call_center|online_portal|mail|in_person');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code (ST_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Grievance Type Code (GRV_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = 'quality_of_care|access|attitude|billing|benefit');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`grievance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` SET TAGS ('dbx_subdomain' = 'coverage_administration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Member Address ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `plan_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|mailing|temporary|employer|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_value_regex' = '^d{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Address Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_business_glossary_term' = 'County FIPS Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_value_regex' = '^d{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External Address ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `geocode_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy (Meters)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `geocode_accuracy_meters` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Street Address)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Apartment/Suite)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line4` SET TAGS ('dbx_business_glossary_term' = 'Address Line 4');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line4` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code (Postal Code)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code (US Postal)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
