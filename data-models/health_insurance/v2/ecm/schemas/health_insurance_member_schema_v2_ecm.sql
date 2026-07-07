-- Schema for Domain: member | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`member` COMMENT 'Single source of truth for all insured individuals — members, subscribers, dependents, and beneficiaries across commercial, Medicare, Medicaid, and CHIP lines of business. Owns member demographics, PII/PHI identity, eligibility status, LOB assignment, COBRA continuants, household relationships, and member lifecycle events. All other domains reference member identity via FK. Supports HIPAA privacy obligations and CMS enrollment reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`subscriber` (
    `subscriber_id` BIGINT COMMENT 'Primary key for subscriber',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for payroll‑deduction enrollment reports linking each employee subscriber to their employer group for contribution calculations and ERISA compliance.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan product.',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.care_coordinator. Business justification: Primary Care Coordinator Assignment: case‑management reports need each subscriber linked to their assigned care coordinator.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: Primary Care Provider assignment for each subscriber is needed for care coordination, network adequacy reporting, and member portal display.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for sales commission reporting and enrollment tracking; each subscriber is associated with the sales representative employee who sold the plan.',
    `member_address_id` BIGINT COMMENT 'FK to member.address',
    `member_contact_id` BIGINT COMMENT 'FK to member.contact',
    `annual_income` DECIMAL(18,2) COMMENT 'Subscribers reported annual income (for subsidy eligibility).',
    `chip_number` STRING COMMENT 'Childrens Health Insurance Program identifier.',
    `citizenship_status` STRING COMMENT 'Legal citizenship or residency status.. Valid values are `citizen|permanent_resident|non_resident|unknown`',
    `cob_indicator` STRING COMMENT 'Indicates subscribers position in coordination of benefits.. Valid values are `primary|secondary|tertiary`',
    `consent_to_electronic_communication` BOOLEAN COMMENT 'Subscribers consent to receive electronic communications.',
    `coverage_type` STRING COMMENT 'Type of health plan coverage.. Valid values are `hmo|ppo|epo|pos|hdhp|hsa`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscriber record was created.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `date_of_birth` DATE COMMENT 'Subscribers birth date.',
    `disability_status` STRING COMMENT 'Indicates if subscriber has a disability.. Valid values are `yes|no|unknown`',
    `effective_date` DATE COMMENT 'Date when subscriber coverage becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `enrollment_source` STRING COMMENT 'Channel through which subscriber enrolled.. Valid values are `online|call_center|agent|mail|broker`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Patient)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `first_name` STRING COMMENT 'Subscribers given name.',
    `gender` STRING COMMENT 'Subscribers gender as reported.. Valid values are `male|female|other|unknown`',
    `hcc_score` DECIMAL(18,2) COMMENT 'Aggregated HCC score for the subscriber.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_deceased` BOOLEAN COMMENT 'Flag indicating if subscriber is deceased.',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|fr|zh|other`',
    `last_name` STRING COMMENT 'Subscribers family name.',
    `line_of_business` STRING COMMENT 'Business line the subscriber belongs to.. Valid values are `commercial|medicare|medicaid|chip|group|individual`',
    `marital_status` STRING COMMENT 'Subscribers marital status.. Valid values are `single|married|divorced|widowed|separated|unknown`',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicaid_number` STRING COMMENT 'State Medicaid identifier.',
    `medicare_beneficiary_number` STRING COMMENT 'Unique identifier for Medicare beneficiaries.',
    `middle_name` STRING COMMENT 'Subscribers middle name (if any).',
    `primary_contact_method` STRING COMMENT 'Preferred method for contacting subscriber.. Valid values are `phone|email|mail|portal`',
    `race_ethnicity` STRING COMMENT 'Self-reported race/ethnicity for reporting.. Valid values are `white|black|asian|hispanic|native_american|other`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk adjustment calculations.',
    `ssn` STRING COMMENT 'Subscribers Social Security Number.. Valid values are `^(d{3}-d{2}-d{4})$`',
    `subscriber_number` STRING COMMENT 'External contract number assigned to the subscriber.',
    `subscriber_status` STRING COMMENT 'Current lifecycle status of the subscriber.. Valid values are `active|inactive|terminated|suspended|pending`',
    `termination_date` DATE COMMENT 'Date when subscriber coverage ends (if applicable).',
    `tobacco_use_status` STRING COMMENT 'Subscribers tobacco use status.. Valid values are `current|former|never|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subscriber record.',
    `veteran_status` BOOLEAN COMMENT 'Indicates if subscriber is a veteran.',
    CONSTRAINT pk_subscriber PRIMARY KEY(`subscriber_id`)
) COMMENT 'Core master entity representing the primary insured individual (subscriber/policyholder) who holds the health insurance contract. Captures full demographic identity including SSN, date of birth, gender, marital status, language preference, race/ethnicity (for HEDIS/CMS reporting), tobacco use status, disability status, and Medicare/Medicaid beneficiary identifiers. Serves as the SSOT for subscriber identity across commercial, Medicare Advantage, Medicaid, and CHIP lines of business. All dependent, eligibility, and benefit records reference this entity. Supports HIPAA PHI/PII obligations, CMS enrollment reporting, and X12 834 subscriber loop requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`dependent` (
    `dependent_id` BIGINT COMMENT 'Primary key for dependent',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary member (subscriber) to whom this dependent is attached.',
    `address_line1` STRING COMMENT 'Primary street address of the dependent.',
    `address_line2` STRING COMMENT 'Secondary address information (apartment, suite).',
    `age_out_eligibility_flag` BOOLEAN COMMENT 'True if the dependent is eligible for age-out coverage under plan rules.',
    `chip_eligibility_flag` BOOLEAN COMMENT 'Indicates eligibility for the Childrens Health Insurance Program.',
    `city` STRING COMMENT 'City of residence.',
    `country` STRING COMMENT 'Three-letter ISO country code of residence.. Valid values are `^[A-Z]{3}$`',
    `coverage_end_date` DATE COMMENT 'Date when dependents coverage terminated or is scheduled to end.',
    `coverage_start_date` DATE COMMENT 'Date when dependents coverage became effective.',
    `coverage_status` STRING COMMENT 'Current status of the dependents coverage.. Valid values are `active|inactive|terminated|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dependent record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `date_of_birth` DATE COMMENT 'Birth date of the dependent.',
    `disability_status` BOOLEAN COMMENT 'Indicates if the dependent has a documented disability.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `email_address` STRING COMMENT 'Primary email address for communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: RelatedPerson)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `first_name` STRING COMMENT 'Given name of the dependent.',
    `gender` STRING COMMENT 'Gender of the dependent as reported.. Valid values are `male|female|other|unknown`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates if this dependent is the primary contact for the subscribers household.',
    `language_preference` STRING COMMENT 'Preferred language for communications with the dependent.',
    `last_name` STRING COMMENT 'Family name of the dependent.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicaid_eligibility_flag` BOOLEAN COMMENT 'Indicates eligibility for Medicaid program.',
    `middle_name` STRING COMMENT 'Middle name or initial of the dependent.',
    `phone_number` STRING COMMENT 'Primary contact phone number.. Valid values are `^+?[1-9]d{1,14}$`',
    `postal_code` STRING COMMENT 'ZIP or postal code.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Lifecycle status of the record itself.. Valid values are `active|inactive|deleted|archived`',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `relationship_end_date` DATE COMMENT 'Date when the dependent relationship ended, if applicable.',
    `relationship_start_date` DATE COMMENT 'Date when the dependent relationship became effective.',
    `relationship_type` STRING COMMENT 'Legal relationship of the dependent to the subscriber.. Valid values are `spouse|domestic_partner|child|other`',
    `sequence_number` STRING COMMENT 'Ordinal number to differentiate multiple dependents of same relationship type.',
    `ssn` STRING COMMENT 'Government-issued identifier for the dependent.. Valid values are `^d{3}-d{2}-d{4}$`',
    `state` STRING COMMENT 'State or province of residence.',
    `student_status` BOOLEAN COMMENT 'Indicates if the dependent is currently a student (True) or not (False).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dependent record.',
    CONSTRAINT pk_dependent PRIMARY KEY(`dependent_id`)
) COMMENT 'Master entity representing individuals covered under a subscribers health plan — spouses, domestic partners, children, and other qualifying dependents. Tracks relationship type to subscriber, dependent sequence number, student status, disability status, age-out eligibility rules, and CHIP/Medicaid eligibility indicators. Maintains its own demographic profile including DOB, gender, SSN, and language preference. Supports dependent verification workflows, age-out processing, and CMS CHIP enrollment reporting. Each dependent record is linked to a subscriber and an enrollment span.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`identity` (
    `identity_id` BIGINT COMMENT 'Primary key for identity',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Business process: Billing Account Management – each member identity must be linked to a billing account for premium collection, payment processing, and regulatory reporting.',
    `group_id` BIGINT COMMENT 'Identifier of the benefit group (e.g., employer group) associated with the member.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links an employees own member identity to their workforce record for benefits enrollment and eligibility reporting.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which the member is assigned.',
    `subscriber_id` BIGINT COMMENT 'Identifier assigned by the health plan to the member (e.g., commercial member ID, MBI for Medicare).',
    `address_line1` STRING COMMENT 'First line of the members mailing address.',
    `address_line2` STRING COMMENT 'Second line of the members mailing address (if applicable).',
    `citizenship_status` STRING COMMENT 'Citizenship or residency status relevant for eligibility and reporting.. Valid values are `citizen|non_citizen|permanent_resident|temporary_resident|unknown`',
    `city` STRING COMMENT 'City component of the members mailing address.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the members residence.',
    `coverage_end_date` DATE COMMENT 'Date when the members coverage terminated or is scheduled to end.',
    `coverage_start_date` DATE COMMENT 'Date when the members coverage became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the identity record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `date_of_birth` DATE COMMENT 'Members birth date, used for age‑based eligibility and risk calculations.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eligibility_status` STRING COMMENT 'Current eligibility determination for benefits coverage.. Valid values are `eligible|ineligible|pending`',
    `email` STRING COMMENT 'Primary email address used for member communications and portal login.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `enrollment_effective_date` DATE COMMENT 'Date the members enrollment into the plan became effective.',
    `ethnicity` STRING COMMENT 'Members ethnicity as reported for demographic reporting.',
    `external_subscriber_number` STRING COMMENT 'External subscriber number identifier from source system',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_patient_resource_identifier` BIGINT COMMENT 'FHIR Patient resource identifier for interoperability with external health information systems',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Patient)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `first_name` STRING COMMENT 'Members given (first) name.',
    `full_name` STRING COMMENT 'Complete legal name of the member as it appears on official documents.',
    `gender` STRING COMMENT 'Self‑identified gender of the member.. Valid values are `male|female|other|unknown`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language_preference` STRING COMMENT 'Primary language the member prefers for communications.',
    `last_name` STRING COMMENT 'Members family (last) name.',
    `lob` STRING COMMENT 'Business line (e.g., commercial, Medicare) to which the member belongs.. Valid values are `commercial|medicare|medicaid|chip|group`',
    `marital_status` STRING COMMENT 'Members marital status for demographic and eligibility purposes.. Valid values are `single|married|divorced|widowed|separated|unknown`',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_status` STRING COMMENT 'Overall lifecycle status of the member within the health plan.. Valid values are `active|inactive|terminated|suspended|pending`',
    `member_type` STRING COMMENT 'Indicates whether the record represents a primary subscriber or a dependent.. Valid values are `subscriber|dependent|spouse|child|other`',
    `middle_name` STRING COMMENT 'Members middle name(s), if any.',
    `phone_number` STRING COMMENT 'Primary telephone number for member contact.',
    `postal_code` STRING COMMENT 'ZIP or postal code of the members mailing address.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for member communications.. Valid values are `email|phone|mail|portal`',
    `race` STRING COMMENT 'Members race classification for HEDIS and regulatory reporting.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `relationship_to_subscriber` STRING COMMENT 'Describes the members relationship to the primary subscriber.. Valid values are `self|spouse|child|parent|other`',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score used for underwriting and care management.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of the source record in the originating system.',
    `ssn_hash` STRING COMMENT 'Hashed Social Security Number used for identity matching while protecting PII.',
    `state` STRING COMMENT 'State or province component of the members mailing address (2‑letter code).',
    `termination_date` DATE COMMENT 'Date the members relationship with the plan was terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the identity record.',
    `verification_date` DATE COMMENT 'Date on which the members identity was successfully verified.',
    `verification_status` STRING COMMENT 'Current status of the members identity verification process.. Valid values are `unverified|pending|verified|failed`',
    `fhir_patient_resource_id` STRING COMMENT '',
    CONSTRAINT pk_identity PRIMARY KEY(`identity_id`)
) COMMENT 'Authoritative identity resolution record for each unique insured individual (subscriber or dependent) assigned a unique member ID by the health plan. Stores the plan-assigned member ID (MBI for Medicare, Medicaid ID, commercial member ID), cross-reference IDs from source systems (Facets member ID, QNXT ID), alternate IDs (SSN hash, external subscriber ID from employer), and identity verification status. Manages member ID history and superseded IDs. This is the enterprise golden record for member identity used by all downstream domains (claims, pharmacy, care management) to resolve member identity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_address` (
    `member_address_id` BIGINT COMMENT 'Surrogate primary key for the address record.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the member to whom this address belongs.',
    `address_type` STRING COMMENT 'Classification of address purpose.. Valid values are `home|mailing|temporary|employer|other`',
    `census_tract` STRING COMMENT 'Census tract identifier for demographic analysis.. Valid values are `^d{11}$`',
    `change_reason` STRING COMMENT 'Reason for address change (e.g., member request, system update).',
    `city` STRING COMMENT 'City name of the address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code.. Valid values are `^[A-Z]{3}$`',
    `county_fips` STRING COMMENT 'Federal Information Processing Standard code for the county.. Valid values are `^d{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created in the data lake.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when the address became effective for the member.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `external_code` STRING COMMENT 'External identifier for the address from source system.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Patient.address)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geocode_accuracy_meters` STRING COMMENT 'Accuracy of the geocoding result in meters.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_primary` BOOLEAN COMMENT 'Indicates if this address is the primary address for the member.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude in decimal degrees.',
    `line1` STRING COMMENT 'Primary street address line.',
    `line2` STRING COMMENT 'Secondary address line (apartment, suite, etc.).',
    `line3` STRING COMMENT 'Additional address line if needed.',
    `line4` STRING COMMENT 'Additional address line if needed.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude in decimal degrees.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_address_status` STRING COMMENT 'Current lifecycle status of the address.. Valid values are `active|inactive|pending|terminated`',
    `postal_code` STRING COMMENT 'Five-digit ZIP code, optionally with ZIP+4.. Valid values are `^d{5}(-d{4})?$`',
    `priority_rank` STRING COMMENT 'Rank indicating priority among multiple concurrent addresses for the member (1 = highest).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date when the address was terminated or superseded.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the address record.',
    `verification_date` DATE COMMENT 'Date when address verification was performed.',
    `verification_status` STRING COMMENT 'USPS CASS certification status of the address.. Valid values are `verified|unverified|pending`',
    CONSTRAINT pk_member_address PRIMARY KEY(`member_address_id`)
) COMMENT 'Manages all physical and mailing addresses associated with a member, including home address, mailing address, temporary address, and employer address. Tracks address type, effective and termination dates, address verification status (USPS CASS-certified), county FIPS code, census tract, and geographic coordinates for network adequacy analysis. Supports multiple concurrent addresses with priority ranking. Used for premium billing, EOB mailing, provider directory access, and CMS geographic reporting. Maintains address history for audit and compliance purposes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_contact` (
    `member_contact_id` BIGINT COMMENT 'System-generated unique identifier for each contact record associated with a member.',
    `member_subscriber_id` BIGINT COMMENT 'add column subscriber_id (BIGINT) with FK to member.subscriber.subscriber_id - member contacts must link to the subscriber they belong to',
    `primary_member_subscriber_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
    `subscriber_id` BIGINT COMMENT '',
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
    `contact_name` STRING COMMENT 'Legal full name of the contact person (member, dependent, or other party).',
    `contact_type` STRING COMMENT 'Classification of the contact relationship to the member.. Valid values are `member|dependent|beneficiary|employer|provider|other`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the address.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `county_fips` STRING COMMENT 'Five‑digit Federal Information Processing Standard code for the county.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contact record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `email_address` STRING COMMENT 'Primary electronic mail address for the contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the contact.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Patient.contact)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `id_type` STRING COMMENT 'Type of identifier used for the contact (e.g., NPI, SSN).. Valid values are `NPI|SSN|MemberID|Other`',
    `id_value` DECIMAL(18,2) COMMENT 'The actual identifier value corresponding to contact_id_type.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this record is the members primary contact.',
    `language_preference` STRING COMMENT 'Members preferred language for communications.. Valid values are `en|es|fr|zh|other`',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent address verification event.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the address in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the address in decimal degrees.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|terminated|pending`',
    `notes` STRING COMMENT 'Free‑form notes related to the contact (e.g., preferred call times).',
    `opt_in_email` BOOLEAN COMMENT 'Indicates whether the member has consented to receive email communications.',
    `opt_in_robocall` BOOLEAN COMMENT 'Indicates whether the member permits automated voice calls.',
    `opt_in_sms` BOOLEAN COMMENT 'Indicates whether the member has consented to receive SMS messages.',
    `phone_home` STRING COMMENT 'Primary residential telephone number.',
    `phone_mobile` STRING COMMENT 'Cellular telephone number for mobile contact.',
    `phone_work` STRING COMMENT 'Telephone number associated with the contacts place of work.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.',
    `preferred_contact_method` STRING COMMENT 'Contact channel the member prefers for communications.. Valid values are `phone|email|mail|sms`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `relationship` STRING COMMENT 'Relationship of the contact to the member.. Valid values are `self|spouse|child|parent|guardian|other`',
    `state_province` STRING COMMENT 'State or province component of the address.',
    `tcp_a_consent_flag` BOOLEAN COMMENT 'True if the contact has provided consent under the Telephone Consumer Protection Act.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the contact record.',
    CONSTRAINT pk_member_contact PRIMARY KEY(`member_contact_id`)
) COMMENT 'Single source of truth for all member contact information and addresses. Manages physical and mailing addresses (home, mailing, temporary, employer), phone numbers (home, mobile, work), email addresses, and fax numbers. Tracks contact type, address type, effective and termination dates, address verification status (USPS CASS-certified), county FIPS code, census tract, geographic coordinates for network adequacy analysis, opt-in/opt-out status per channel (SMS, email, robocall), TCPA consent flags, and preferred contact method and language. Supports multiple concurrent addresses with priority ranking. Used for premium billing, EOB mailing, provider directory access, CMS geographic reporting, member services outreach, care management communications, and CAHPS survey administration. Maintains full address and contact history for audit and compliance purposes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`household` (
    `household_id` BIGINT COMMENT 'Primary key uniquely identifying the household.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the primary health plan associated with the household.',
    `subscriber_id` BIGINT COMMENT 'Member identifier for the head of household.',
    `aca_subsidy_eligible` BOOLEAN COMMENT 'Indicates if the household qualifies for ACA premium tax credits.',
    `city` STRING COMMENT 'City of the primary residence.',
    `cobra_coverage_flag` BOOLEAN COMMENT 'Indicates if any household member is covered under COBRA continuation.',
    `country` STRING COMMENT 'Three-letter ISO country code of the primary residence.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was first created in the system.',
    `creation_method` STRING COMMENT 'Method by which the household record was created.. Valid values are `online|call_center|agent|mail`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Date when the household ceased to be effective, if applicable.',
    `effective_start_date` DATE COMMENT 'Date when the household became effective for eligibility purposes.',
    `email_address` STRING COMMENT 'Primary email address for household communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `enrollment_status` STRING COMMENT 'Current enrollment status of the household in health plans.. Valid values are `enrolled|pending|terminated|withdrawn`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Group)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'Household income expressed as a percentage of the Federal Poverty Level.',
    `fpl_year` STRING COMMENT 'Year for which the Federal Poverty Level percentage is calculated.',
    `household_number` STRING COMMENT 'Unique household identifier assigned by the core administration system.',
    `household_status` STRING COMMENT 'Current lifecycle status of the household.. Valid values are `active|inactive|closed|pending`',
    `household_type` STRING COMMENT 'Classification of household composition.. Valid values are `single|family|group|other`',
    `income_source` STRING COMMENT 'Primary source of household income.. Valid values are `employment|self_employed|investment|government|other`',
    `income_verification_flag` BOOLEAN COMMENT 'Indicates whether household income has been verified.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_hispanic` BOOLEAN COMMENT 'Indicates if any household member identifies as Hispanic/Latino.',
    `is_multi_plan` BOOLEAN COMMENT 'Indicates if household members are enrolled in multiple plan types.',
    `is_veteran` BOOLEAN COMMENT 'Indicates if any household member is a veteran.',
    `language_preference` STRING COMMENT 'Preferred language for communications with the household.. Valid values are `en|es|fr|zh|other`',
    `last_eligibility_review_date` DATE COMMENT 'Date of the most recent eligibility determination review.',
    `last_modified_by` STRING COMMENT 'User or process that performed the most recent update.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicaid_eligible` BOOLEAN COMMENT 'Indicates if the household qualifies for Medicaid based on income and other criteria.',
    `household_name` STRING COMMENT 'Descriptive name for the household, often derived from head of household name.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the household.. Valid values are `^+?[0-9]{10,15}$`',
    `primary_address` STRING COMMENT 'Street address for the households primary residence.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Operational status of the record for data governance.. Valid values are `active|archived|deleted`',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk adjustment factor for the household used in actuarial calculations.',
    `size` STRING COMMENT 'Number of members (including dependents) in the household.',
    `special_program_eligibility` STRING COMMENT 'Eligibility for special programs such as Dual Eligible or Low Income.. Valid values are `dualeligible|low_income|none`',
    `state` STRING COMMENT 'State abbreviation of the primary residence.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Calculated subsidy amount for the household under ACA.',
    `tax_credit_amount` DECIMAL(18,2) COMMENT 'Total tax credit allocated to the household.',
    `total_income` DECIMAL(18,2) COMMENT 'Combined annual income of all household members for subsidy eligibility.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the household record.',
    `zip_code` STRING COMMENT 'Postal ZIP code of the primary residence.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Represents a family or household unit grouping subscribers and their dependents under a common household identifier. Tracks household composition, head of household designation, household size, income level for ACA subsidy eligibility and Medicaid MAGI calculations, and federal poverty level (FPL) percentage. Supports family deductible and out-of-pocket maximum aggregation, COB household relationship tracking, ACA marketplace household eligibility determinations, and premium tax credit calculations. Used for Medicaid household income verification and CMS enrollment reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` (
    `lob_assignment_id` BIGINT COMMENT 'Surrogate primary key for each LOB assignment record.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom this LOB assignment applies.',
    `care_management_eligibility_flag` BOOLEAN COMMENT 'Indicates eligibility for care management programs under this LOB.',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates whether the member has any chronic condition relevant to this LOB.',
    `cms_contract_number` STRING COMMENT 'Contract number assigned by CMS for the plan under this LOB.',
    `cms_region` STRING COMMENT 'Geographic region as defined by CMS for reporting.. Valid values are `NORTHEAST|MIDWEST|SOUTH|WEST`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the LOB assignment record was created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dual_eligible_flag` BOOLEAN COMMENT 'Indicates if member is dual eligible for Medicare and Medicaid.',
    `effective_date` DATE COMMENT 'Date when the LOB assignment becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hcc_risk_score_tier` STRING COMMENT 'Tier of hierarchical condition category risk score. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9|10 — promote to reference product]',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_assignment_status` STRING COMMENT 'Current lifecycle status of the LOB assignment.. Valid values are `active|inactive|terminated|pending`',
    `lob_code` STRING COMMENT 'Standard code representing the members line of business classification. [ENUM-REF-CANDIDATE: COMM|MEDI|MEDSUP|MEDICAID|CHIP|COBRA|INDIV|D_SNP — promote to reference product]',
    `lob_description` STRING COMMENT 'Human readable description of the LOB code.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `plan_benefit_package_code` STRING COMMENT 'Code identifying the specific benefit package associated with the LOB.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rising_risk_indicator` BOOLEAN COMMENT 'Flag indicating emerging risk trends for the member.',
    `risk_tier` STRING COMMENT 'Business-defined risk tier for the member under this LOB.. Valid values are `LOW|MEDIUM|HIGH|CATASTROPHIC`',
    `sdoh_risk_flag` BOOLEAN COMMENT 'Flag indicating elevated SDOH risk for the member.',
    `segmentation_model_version` STRING COMMENT 'Version identifier of the predictive segmentation model used.',
    `segmentation_source` STRING COMMENT 'Origin of the segmentation assignment.. Valid values are `PREDICTIVE|CLAIMS|CARE_MANAGER`',
    `snp_qualifying_condition` STRING COMMENT 'Clinical condition that qualifies the member for the SNP.',
    `snp_type` STRING COMMENT 'Type of SNP applicable to the member.. Valid values are `D-SNP|C-SNP|F-SNP|I-SNP`',
    `star_rating_cohort` STRING COMMENT 'Cohort used for CMS STAR rating calculations.. Valid values are `A|B|C|D|E|F`',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation where the member resides.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date when the LOB assignment ends or is scheduled to end; null if active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the LOB assignment record.',
    CONSTRAINT pk_lob_assignment PRIMARY KEY(`lob_assignment_id`)
) COMMENT 'Single source of truth for a members Line of Business classification, operational segmentation, and risk stratification. Tracks LOB code (Commercial, Medicare Advantage, Medicare Supplement, Medicaid, CHIP, COBRA, Individual/ACA Marketplace, Dual Eligible D-SNP), effective and termination dates, CMS contract number, plan benefit package (PBP) code, CMS region, and state program codes. Captures business-defined population segments: risk tier (low/medium/high/catastrophic), chronic condition flags, rising risk indicators, care management eligibility, HCC risk score tier, STAR rating cohort, dual eligible status, SNP type and qualifying conditions, SDOH risk flags, segmentation model version, and segmentation source (predictive model, claims-based, care manager assigned). Manages LOB transitions and supports CMS enrollment reporting, RAPS/EDPS submissions, MLR calculation, population health program targeting, and care management outreach prioritization. This is the operational classification record — distinct from analytics-derived scores.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` (
    `cobra_continuant_id` BIGINT COMMENT 'System-generated unique identifier for the COBRA continuant record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group that sponsored the original coverage.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which COBRA coverage is provided.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who is the COBRA continuant.',
    `transaction_id` BIGINT COMMENT 'Identifier of the original enrollment that triggered COBRA eligibility.',
    `cobra_continuant_status` STRING COMMENT 'Current lifecycle status of the COBRA coverage.. Valid values are `active|inactive|terminated|expired|pending`',
    `cobra_eligibility_indicator` BOOLEAN COMMENT 'Flag indicating whether the member is eligible for COBRA coverage.',
    `cobra_eligibility_reason` STRING COMMENT 'Free‑text explanation for eligibility determination.',
    `cobra_notice_sent_date` DATE COMMENT 'Date the required COBRA notice was mailed or emailed to the member.',
    `cobra_notice_type` STRING COMMENT 'Classification of the notice (e.g., initial election notice, reminder, final notice).. Valid values are `initial|reminder|final`',
    `coverage_end_date` DATE COMMENT 'Date coverage under COBRA ends, either by max period or termination.',
    `coverage_start_date` DATE COMMENT 'Date coverage under COBRA begins.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COBRA continuant record was first created.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `election_date` DATE COMMENT 'Date the member elected to continue coverage under COBRA.',
    `election_deadline` DATE COMMENT 'Last date by which the member must elect COBRA coverage.',
    `exhaustion_date` DATE COMMENT 'Date when coverage was exhausted due to reaching the maximum period.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_exhausted` BOOLEAN COMMENT 'True when the maximum COBRA coverage period has been reached.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_coverage_end_date` DATE COMMENT 'Calculated date when the maximum allowable COBRA period expires.',
    `max_coverage_months` STRING COMMENT 'Maximum number of months the member may receive COBRA coverage (e.g., 18, 29, 36).',
    `member_relationship` STRING COMMENT 'Relationship of the continuant to the primary employee (e.g., employee, spouse, child).. Valid values are `employee|spouse|child|parent|other`',
    `notes` STRING COMMENT 'Free‑text field for any additional comments or audit notes.',
    `payment_frequency` STRING COMMENT 'How often the premium is billed.. Valid values are `monthly|quarterly|annual`',
    `payment_method` STRING COMMENT 'Method used to collect the COBRA premium.. Valid values are `auto_debit|check|credit_card|other`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount (typically 102% of the group rate).',
    `premium_currency` STRING COMMENT 'Currency code for the premium amount.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `premium_due_date` DATE COMMENT 'Date by which the premium must be paid for the coverage month.',
    `premium_payment_date` DATE COMMENT 'Date the premium payment was actually received.',
    `premium_payment_status` STRING COMMENT 'Current status of premium payment for the coverage period.. Valid values are `paid|unpaid|partial|overdue`',
    `qualifying_event_date` DATE COMMENT 'Date on which the qualifying event occurred.',
    `qualifying_event_type` STRING COMMENT 'Type of event that caused loss of employer-sponsored coverage.. Valid values are `termination|reduction|divorce|death|medicare|dependent_loss`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `termination_date` DATE COMMENT 'Date when COBRA coverage was terminated before the scheduled end.',
    `termination_reason` STRING COMMENT 'Reason for early termination of COBRA coverage, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_cobra_continuant PRIMARY KEY(`cobra_continuant_id`)
) COMMENT 'Manages COBRA continuation coverage records for members who have lost employer-sponsored coverage due to qualifying events. Tracks qualifying event type (termination, reduction in hours, divorce, death, Medicare entitlement, dependent status loss), COBRA election date, election deadline, coverage start and end dates, maximum coverage period (18/29/36 months), premium amount (102% of group rate), payment status, and exhaustion date. Supports COBRA notice generation, election tracking, premium payment monitoring, and qualifying event triggering for the billing domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` (
    `pcp_assignment_id` BIGINT COMMENT 'Primary key for pcp_assignment',
    `assignment_rule_id` BIGINT COMMENT 'Reference to the rule used for automatic PCP assignment (e.g., newborn rule).',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required for compliance check that a PCP assignment respects an active provider contract; ensures network participation rules are enforced during PCP selection.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom the PCP is assigned.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: PCP assignment records must reference the provider entity to support network participation audits and accurate provider‑member linkage.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which the PCP belongs.',
    `assignment_reason` STRING COMMENT 'Free‑text explanation for why the PCP was assigned (e.g., member request, network requirement).',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the PCP assignment.. Valid values are `active|inactive|pending|terminated`',
    `assignment_type` STRING COMMENT 'Method by which the PCP was assigned: member‑selected, auto‑assigned by system, or plan‑assigned.. Valid values are `member_selected|auto_assigned|plan_assigned`',
    `change_reason` STRING COMMENT 'Reason for a change to the PCP assignment (e.g., member relocation, provider departure).',
    `change_timestamp` TIMESTAMP COMMENT 'Exact time when the most recent change to the assignment was recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PCP assignment record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when the PCP assignment becomes effective for the member.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_current` BOOLEAN COMMENT 'True if the assignment is the active PCP for the member at query time.',
    `is_primary` BOOLEAN COMMENT 'Indicates if this PCP is the members primary provider when multiple assignments exist.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_tier` STRING COMMENT 'Tier classification of the PCP within the plans provider network.. Valid values are `tier1|tier2|tier3|tier4`',
    `notes` STRING COMMENT 'Additional free‑form comments or audit notes about the assignment.',
    `panel_status` STRING COMMENT 'Indicates whether the PCP is currently in the members provider panel.. Valid values are `in_panel|out_of_panel|pending`',
    `pcp_specialty_code` STRING COMMENT 'Standardized code representing the PCPs clinical specialty.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `termination_date` DATE COMMENT 'Date when the PCP assignment ends or is scheduled to end; null if still active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the PCP assignment record.',
    CONSTRAINT pk_pcp_assignment PRIMARY KEY(`pcp_assignment_id`)
) COMMENT 'Tracks Primary Care Provider (PCP) assignments for members enrolled in HMO, POS, and other gatekeeper plan types. Records assigned PCP NPI, PCP effective and termination dates, assignment type (member-selected, auto-assigned, plan-assigned), PCP change reason, PCP panel status at time of assignment, and PCP network tier. Manages PCP change request history and auto-assignment rules for newborns and new enrollees. Used for care coordination, referral authorization, capitation payment calculation, and HEDIS PCP attribution. Integrates with provider and network domains.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`cob_record` (
    `cob_record_id` BIGINT COMMENT 'Primary key for cob_record',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom this COB record belongs.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: COORDINATION_OF_BENEFITS: COB process requires linking the other carrier name to its vendor record for data exchange and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Coordination of benefits processing must record the employee handling the COB record for compliance and audit.',
    `birthday_rule_applicable` BOOLEAN COMMENT 'Indicates whether the birthday rule is used to determine primary payer.',
    `cob_order` STRING COMMENT 'Sequencing of the carrier in the coordination of benefits hierarchy.. Valid values are `primary|secondary|tertiary`',
    `cob_record_number` STRING COMMENT 'Business identifier assigned to the COB record for external reference.',
    `cob_status` STRING COMMENT 'Current lifecycle status of the COB record.. Valid values are `active|inactive|pending|terminated`',
    `cob_verification_date` DATE COMMENT 'Date when the COB information was verified.',
    `coordination_of_benefits_rule` STRING COMMENT 'Rule applied to determine payer order (e.g., birthday rule).. Valid values are `birthday|plan|state|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COB record was first created in the data lake.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date the COB coverage becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_msp_compliant` BOOLEAN COMMENT 'Indicates compliance with Medicare Secondary Payer rules.',
    `is_subrogation_flag` BOOLEAN COMMENT 'True if the claim may be subject to subrogation based on this COB arrangement.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the COB arrangement.',
    `other_carrier_group_number` STRING COMMENT 'Group number or policy number of the other carrier.',
    `other_carrier_member_number` STRING COMMENT 'Member identifier assigned by the other carrier.',
    `other_carrier_name` STRING COMMENT 'Name of the other insurance carrier providing secondary or tertiary coverage.',
    `other_carrier_relationship_type` STRING COMMENT 'Nature of the relationship between the member and the other carrier.. Valid values are `employer_sponsored|individual|government|other`',
    `policy_type` STRING COMMENT 'Classification of the other carrier policy.. Valid values are `commercial|medicare|medicaid|auto|workers_comp|other`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `termination_date` DATE COMMENT 'Date the COB coverage ends or is terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COB record.',
    `verification_method` STRING COMMENT 'Method used to verify the COB information.. Valid values are `manual|electronic|auto`',
    CONSTRAINT pk_cob_record PRIMARY KEY(`cob_record_id`)
) COMMENT 'Members stored alternate-coverage record';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`consent` (
    `consent_id` BIGINT COMMENT 'Primary key for consent',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the consent.',
    `consent_witness_employee_id` BIGINT COMMENT 'Identifier of the system user who entered the consent.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member providing consent.',
    `authorized_recipient` STRING COMMENT 'Entity or individual authorized to receive the disclosed PHI.',
    `collection_method` STRING COMMENT 'Method used to collect the consent from the member.. Valid values are `written|electronic|verbal|attested`',
    `consent_date` DATE COMMENT 'Date when the consent was originally obtained.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent.. Valid values are `active|revoked|expired|pending|withdrawn`',
    `consent_type` STRING COMMENT 'Category of consent indicating purpose of authorized disclosure.. Valid values are `phid_disclosure|release_of_information|marketing_opt_in|research_participation|care_management|advance_directive`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `disclosure_scope` STRING COMMENT 'Description of the data elements or categories covered by the consent.',
    `effective_date` DATE COMMENT 'Date when the consent becomes effective for use.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the consent expires if not renewed.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Consent)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_42cfr_part2_applicable` BOOLEAN COMMENT 'Flag indicating if the consent is subject to 42 CFR Part 2 substance abuse privacy rules.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_electronic_signature` BOOLEAN COMMENT 'Indicates if the consent was captured with an electronic signature.',
    `is_minimum_necessary` BOOLEAN COMMENT 'Indicates whether the consent adheres to the HIPAA minimum necessary standard.',
    `language` STRING COMMENT 'Language in which the consent was provided.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free-text notes related to the consent record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `revocation_date` DATE COMMENT 'Date when the consent was revoked by the member.',
    `signature_timestamp` TIMESTAMP COMMENT 'Timestamp of the electronic signature capture.',
    `state_of_residence` STRING COMMENT 'State code of the members residence at time of consent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    `version` STRING COMMENT 'Version number of the consent document for audit tracking.',
    CONSTRAINT pk_consent PRIMARY KEY(`consent_id`)
) COMMENT 'Manages member consent and authorization records required under HIPAA Privacy Rule and state privacy laws. Tracks consent type (PHI disclosure authorization, ROI — Release of Information, marketing opt-in, research participation, care management program enrollment consent, advance directive), consent status (active, revoked, expired), consent date, expiration date, authorized recipient, scope of disclosure, revocation date, and consent collection method (written, electronic, verbal with attestation). Supports HIPAA minimum necessary standard, 42 CFR Part 2 (substance abuse), and state mental health privacy requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` (
    `disenrollment_id` BIGINT COMMENT 'Primary key for disenrollment',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who is being disenrolled.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan the member was enrolled in before disenrollment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for audit of disenrollment processing; regulatory reports require identifying the employee who processed each disenrollment.',
    `appeal_rights_notified` BOOLEAN COMMENT 'Indicates whether the member was notified of appeal rights.',
    `cobro_eligibility` BOOLEAN COMMENT 'Flag indicating if the member qualifies for COBRA continuation coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disenrollment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for any monetary amounts.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disenrollment_number` STRING COMMENT 'Business identifier assigned to the disenrollment event, used for external reporting and audit.',
    `disenrollment_status` STRING COMMENT 'Current processing status of the disenrollment request.. Valid values are `pending|processed|cancelled|reversed`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_timestamp` TIMESTAMP COMMENT 'Date and time when the disenrollment becomes effective for coverage purposes.',
    `eligibility_loss_indicator` BOOLEAN COMMENT 'True if disenrollment is due to loss of eligibility.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: EnrollmentRequest)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notice_sent_date` DATE COMMENT 'Date the required notice of disenrollment was sent to the member.',
    `processed_by` STRING COMMENT 'User or system identifier that processed the disenrollment.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when the disenrollment was processed.',
    `reason_code` STRING COMMENT 'Standardized code representing why the member is disenrolling.. Valid values are `voluntary|non_payment|eligibility_loss|plan_termination|death|fraud`',
    `reason_description` STRING COMMENT 'Free‑text description of the disenrollment reason.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `refund_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustments (e.g., fees, penalties) applied to the gross refund.',
    `refund_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount refunded to the member as part of disenrollment.',
    `refund_net_amount` DECIMAL(18,2) COMMENT 'Net amount actually paid to the member after adjustments.',
    `request_date` DATE COMMENT 'Date the member or source submitted the disenrollment request.',
    `source` STRING COMMENT 'Origin of the disenrollment request.. Valid values are `member|employer|cms|state_medicaid|provider`',
    `termination_type` STRING COMMENT 'Classification of the disenrollment termination.. Valid values are `voluntary|involuntary|death|fraud|relocation|plan_termination`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the disenrollment record.',
    CONSTRAINT pk_disenrollment PRIMARY KEY(`disenrollment_id`)
) COMMENT 'Captures the formal disenrollment event when a member voluntarily or involuntarily terminates health plan coverage. Records disenrollment effective date, disenrollment reason code (voluntary termination, non-payment of premium, loss of eligibility, plan termination, death, fraud, relocation out of service area), disenrollment request date, source of disenrollment (member request, employer group, CMS, state Medicaid agency), notice sent date, and appeal rights notification. Supports CMS disenrollment reporting for Medicare Advantage, Medicaid managed care disenrollment rules, and COBRA qualifying event triggering.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`segment` (
    `segment_id` BIGINT COMMENT 'Primary key for segment',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the last audit action.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to which the segment applies.',
    `audit_reason` STRING COMMENT 'Reason or comment captured for the audit change.',
    `segment_category` STRING COMMENT 'High-level classification of the segment (e.g., risk, chronic, sdoh, hcc, star, dual, snp). [ENUM-REF-CANDIDATE: risk|chronic|sdoh|hcc|star|dual|snp — promote to reference product]',
    `chronic_condition_code` STRING COMMENT 'ICD‑10 code representing the chronic condition driving the segment.',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates whether the member has a chronic condition relevant to the segment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `segment_description` STRING COMMENT 'Detailed description of the segment criteria and purpose.',
    `dual_eligible` BOOLEAN COMMENT 'True if the member is eligible for both Medicare and Medicaid.',
    `effective_date` DATE COMMENT 'Date when the segment assignment becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'Date when the segment assignment ends or is superseded (nullable).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hcc_risk_score_tier` STRING COMMENT 'Tier of HCC risk score assigned to the member.. Valid values are `1|2|3|4|5`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_current` BOOLEAN COMMENT 'True if this record represents the members active segment.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `segment_name` STRING COMMENT 'Human‑readable name of the segment.',
    `notes` STRING COMMENT 'Free‑form notes related to the segment assignment.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `risk_tier` STRING COMMENT 'Risk tier assigned to the member within the segment.. Valid values are `low|medium|high|catastrophic`',
    `sdoh_risk_score` DECIMAL(18,2) COMMENT 'Numerical score (0‑100) quantifying social determinants of health risk.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment record.. Valid values are `active|inactive|archived`',
    `segmentation_model_version` STRING COMMENT 'Version identifier of the predictive or rules‑based model that generated the segment.',
    `segmentation_source` STRING COMMENT 'Origin of the segment assignment.. Valid values are `predictive|claims_based|care_manager_assigned`',
    `snp_eligibility` BOOLEAN COMMENT 'Indicates eligibility for a Special Needs Plan.',
    `star_rating_cohort` STRING COMMENT 'Star rating cohort classification for quality measurement programs.. Valid values are `1_star|2_star|3_star|4_star|5_star`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the segment record.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Classifies members into business-defined segments for population health management, risk stratification, and targeted outreach. Tracks segment type (risk tier: low/medium/high/catastrophic, chronic condition flag, rising risk indicator, care management eligibility, SDOH risk score, HCC risk score tier, STAR rating cohort, dual eligible status, SNP eligibility), segment effective date, segmentation model version, and segmentation source (predictive model, claims-based, care manager assigned). Used by care management, utilization management, and population health programs. Distinct from analytics — this is the operational classification record.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`id_card` (
    `id_card_id` BIGINT COMMENT 'Surrogate primary key for the ID card record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: ID cards are issued per health plan; linking enables tracking issuance per plan for regulatory reporting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the card is issued.',
    `barcode` STRING COMMENT 'Machine-readable barcode value encoded on the card.',
    `card_format` STRING COMMENT 'Delivery format of the card: physical plastic, digital image, or mobile app representation.. Valid values are `physical|digital|mobile`',
    `card_number` STRING COMMENT 'The alphanumeric identifier printed on the ID card, used for member identification.',
    `card_type` STRING COMMENT 'Category of coverage the card provides (e.g., medical, dental).. Valid values are `medical|dental|vision|pharmacy|combined`',
    `card_version` STRING COMMENT 'Version identifier for the card design/layout.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Standard copayment amount shown on the card for office visits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the card record was created in the system.',
    `customer_service_phone` STRING COMMENT 'Phone number printed on the card for member support.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_confirmation_date` DATE COMMENT 'Date when delivery of the card was confirmed.',
    `delivery_method` STRING COMMENT 'Method used to deliver the card to the member.. Valid values are `mail|courier|in_person|digital_download|mobile_push`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date after which the card is no longer valid.',
    `external_system_code` STRING COMMENT 'Identifier of the card record in the source operational system (e.g., Facets).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `group_number` STRING COMMENT 'Employer or group identifier shown on the card.',
    `id_card_status` STRING COMMENT 'Current lifecycle status of the card.. Valid values are `active|replaced|lost|stolen|expired|pending`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_primary` BOOLEAN COMMENT 'Indicates if this card is the members primary ID card.',
    `issue_date` DATE COMMENT 'Date the card was originally issued to the member.',
    `language_preference` STRING COMMENT 'Members preferred language for card language.. Valid values are `en|es|fr|zh|vi|ar`',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the card status last changed.',
    `magnetic_stripe_data` STRING COMMENT 'Data encoded on the magnetic stripe of the physical card.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `pcp_name` STRING COMMENT 'Name of the primary care physician displayed on HMO cards.',
    `pharmacy_bin` STRING COMMENT 'Bank Identification Number for pharmacy benefits.',
    `pharmacy_group_number` STRING COMMENT 'Group number used for pharmacy benefit routing.',
    `pharmacy_pcn` STRING COMMENT 'Processor Control Number for pharmacy claims.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `replacement_date` DATE COMMENT 'Date a replacement card was issued, if applicable.',
    `replacement_reason` STRING COMMENT 'Reason why the card was replaced.. Valid values are `damage|loss|theft|upgrade|member_request|expiration`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the card record.',
    CONSTRAINT pk_id_card PRIMARY KEY(`id_card_id`)
) COMMENT 'Manages the issuance and tracking of member health insurance ID cards (physical and digital). Records card issue date, card type (medical, dental, vision, pharmacy, combined), card format (physical, digital/mobile), card status (active, replaced, lost/stolen, expired), plan name on card, group number, member ID displayed, PCP name (for HMO cards), copay amounts displayed, pharmacy BIN/PCN/Group numbers, and customer service phone numbers. Tracks card replacement requests, reason for replacement, and delivery confirmation. Supports member services ID card fulfillment workflows and digital ID card provisioning via member portal.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` (
    `authorized_representative_id` BIGINT COMMENT 'Primary key for authorized_representative',
    `authorization_document_id` BIGINT COMMENT 'Reference to the stored document that grants the authorization.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the last audit action on the record.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the member for whom the representative is authorized.',
    `audit_reason` STRING COMMENT 'Reason provided for the audit change.',
    `authorization_end_date` DATE COMMENT 'Date when the representatives authority expires or is terminated.',
    `authorization_scope` STRING COMMENT 'Scope of actions the representative is permitted to perform on behalf of the member.. Valid values are `appeal_only|grievance_only|all_actions`',
    `authorization_start_date` DATE COMMENT 'Date when the representatives authority becomes effective.',
    `authorization_status` STRING COMMENT 'Status of the authorization request process before it becomes active.. Valid values are `pending|approved|denied|withdrawn`',
    `authorized_representative_status` STRING COMMENT 'Current lifecycle status of the authorization.. Valid values are `active|inactive|revoked|expired`',
    `bar_number` STRING COMMENT 'Professional bar registration number for attorney representatives.',
    `contact_address_line1` STRING COMMENT 'First line of the representatives mailing address.',
    `contact_city` STRING COMMENT 'City of the representatives mailing address.',
    `contact_country_code` STRING COMMENT 'Three-letter ISO country code of the representatives mailing address.. Valid values are `^[A-Z]{3}$`',
    `contact_email` STRING COMMENT 'Primary email address for the representative.',
    `contact_phone` STRING COMMENT 'Primary phone number for the representative.',
    `contact_postal_code` STRING COMMENT 'Postal/ZIP code of the representatives mailing address.',
    `contact_state_code` STRING COMMENT 'State abbreviation for the representatives mailing address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorized representative record was created.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `document_reference` STRING COMMENT 'External reference or path to the authorization document (e.g., URL or file ID).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the authorization became effective (derived from start date).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_primary_representative` BOOLEAN COMMENT 'Indicates whether this representative is the primary point of contact for the member.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the professional license.',
    `license_state` STRING COMMENT 'State or jurisdiction that issued the professional license.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free-text field for additional comments or remarks about the authorization.',
    `professional_license_number` STRING COMMENT 'License number for non-attorney professionals (e.g., healthcare provider license).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `relationship_to_member` STRING COMMENT 'Describes the legal or personal relationship between the representative and the member.. Valid values are `spouse|parent|child|legal_guardian|friend|other`',
    `representative_name` STRING COMMENT 'Legal full name of the authorized representative.',
    `representative_type` STRING COMMENT 'Category of the representative based on role and relationship to member.. Valid values are `attorney|patient_advocate|family_power_of_attorney|provider_representative|other`',
    `revocation_date` DATE COMMENT 'Date when the authorization was formally revoked, if applicable.',
    `revocation_reason` STRING COMMENT 'Reason provided for revoking the representatives authority.',
    `termination_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the authorization terminated (derived from end date).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_authorized_representative PRIMARY KEY(`authorized_representative_id`)
) COMMENT 'Master record for individuals or entities authorized to act on behalf of a member in the appeals and grievances process — attorneys, patient advocates, family members with POA, and provider representatives. Captures representative type, authorization scope (appeal only, grievance only, all actions), authorization start and end dates, authorization document reference, relationship to member, contact information, and bar number or professional license where applicable. Distinct from the member record in the member domain. SSOT for appeal representation authority.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`policy` (
    `policy_id` BIGINT COMMENT 'Primary key for policy',
    `health_plan_id` BIGINT COMMENT 'Reference to the plan or product associated with the policy.',
    `identity_id` BIGINT COMMENT 'Reference to the insured member associated with the policy.',
    `parent_policy_id` BIGINT COMMENT 'Self-referencing FK on policy (parent_policy_id)',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to member.subscriber. Business justification: Policy is a child of subscriber; adding subscriber_id FK establishes the 1:N relationship and removes the silo.',
    `coverage_end_date` DATE COMMENT 'Date when coverage under the policy ends.',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary limit for covered services under the policy.',
    `coverage_limit_currency` STRING COMMENT 'Currency code for the coverage limit amount.',
    `coverage_limit_type` STRING COMMENT 'Scope of the coverage limit (e.g., lifetime, annual).',
    `coverage_start_date` DATE COMMENT 'Date when coverage under the policy begins.',
    `coverage_status` STRING COMMENT 'Current status of the coverage portion of the policy.',
    `coverage_type` STRING COMMENT 'Type of coverage plan (e.g., HMO, PPO).',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the insured must pay before coverage applies.',
    `deductible_currency` STRING COMMENT 'Currency code for the deductible amount.',
    `effective_date` DATE COMMENT 'Date when the policy becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the policy expires if not renewed.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `out_of_pocket_max_amount` DECIMAL(18,2) COMMENT 'Maximum amount the insured pays in a benefit year.',
    `out_of_pocket_max_currency` STRING COMMENT 'Currency code for the out-of-pocket maximum amount.',
    `policy_number` STRING COMMENT 'Human-readable policy number assigned by the insurer.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the policy.',
    `policy_type` STRING COMMENT 'Classification of the policy based on the insured entity type.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Amount to be paid for the policy coverage.',
    `premium_currency` STRING COMMENT 'Currency code for the premium amount.',
    `premium_frequency` STRING COMMENT 'Frequency at which the premium is billed.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
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
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master reference table for policy. Referenced by policy_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` (
    `authorization_document_id` BIGINT COMMENT 'Primary key for authorization_document',
    `identity_id` BIGINT COMMENT 'Unique identifier for the insured member.',
    `parent_authorization_document_id` BIGINT COMMENT 'Self-referencing FK on authorization_document (parent_authorization_document_id)',
    `provider_id` BIGINT COMMENT 'Unique identifier for the healthcare provider.',
    `authorization_document_status` STRING COMMENT 'Current lifecycle state of the authorization (e.g., active, pending, approved, denied, cancelled).',
    `authorization_number` STRING COMMENT 'External reference number assigned to the authorization.',
    `authorization_type` STRING COMMENT 'Category of authorization (e.g., pre_authorization, post_authorization, coverage_authorization).',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when the authorization becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the authorization expires or is no longer valid.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: DocumentReference)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_address` STRING COMMENT 'Residential address of the member.',
    `member_dob` DATE COMMENT 'Members date of birth.',
    `member_email` STRING COMMENT 'Primary email address of the member.',
    `member_gender` STRING COMMENT 'Members gender.',
    `member_name` STRING COMMENT 'Legal name of the member.',
    `member_phone` STRING COMMENT 'Primary contact phone number for the member.',
    `member_ssn` STRING COMMENT 'Members SSN for identification.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_authorization_document PRIMARY KEY(`authorization_document_id`)
) COMMENT 'Master reference table for authorization_document. Referenced by authorization_document_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` (
    `assignment_rule_id` BIGINT COMMENT 'Primary key for assignment_rule',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - assignment rules are scoped to plans for PCP auto-assignment',
    `parent_assignment_rule_id` BIGINT COMMENT 'Self-referencing FK on assignment_rule (parent_assignment_rule_id)',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the rule record was first created.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the rule becomes effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the rule ceases to be effective (nullable for open-ended).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rule_action` STRING COMMENT 'Action to be taken when the rule is satisfied.',
    `rule_category` STRING COMMENT 'Secondary classification grouping within the rule type.',
    `rule_criteria` STRING COMMENT 'Criteria or conditions that trigger the rule.',
    `rule_description` STRING COMMENT 'Detailed description of the assignment rules purpose and logic.',
    `rule_expression` STRING COMMENT 'Expression or formula that defines the rule logic.',
    `rule_immutable_date` DATE COMMENT 'Date when the rule was marked immutable.',
    `rule_immutable_reason` STRING COMMENT 'Explanation for why the rule is immutable.',
    `rule_is_custom` BOOLEAN COMMENT 'Flag indicating if the rule is user-defined.',
    `rule_is_default` BOOLEAN COMMENT 'Flag indicating if the rule is the default for its category.',
    `rule_is_immutable` BOOLEAN COMMENT 'Flag indicating if the rule cannot be modified after creation.',
    `rule_is_system` BOOLEAN COMMENT 'Flag indicating if the rule is system-generated.',
    `rule_lifecycle_status` STRING COMMENT 'Lifecycle stage of the rule (e.g., proposed, approved, retired).',
    `rule_logic` STRING COMMENT 'Detailed logic steps or algorithm for the rule.',
    `rule_name` STRING COMMENT 'Human-readable name of the assignment rule.',
    `rule_order` STRING COMMENT 'Sequence order for rule evaluation within a group.',
    `rule_priority` STRING COMMENT 'Numeric priority used to resolve conflicts between overlapping rules.',
    `rule_scope` STRING COMMENT 'Scope of the rule (e.g., member, plan, product).',
    `rule_scope_description` STRING COMMENT 'Detailed description of the rules scope.',
    `rule_source_code` STRING COMMENT 'Identifier of the rule in the source system.',
    `rule_source_description` STRING COMMENT 'Description of the rule in the source system.',
    `rule_source_system` STRING COMMENT 'Name of the system where the rule originates.',
    `rule_source_version` STRING COMMENT 'Version of the rule in the source system.',
    `rule_status` STRING COMMENT 'Current operational status of the rule (e.g., active, inactive, draft).',
    `rule_subtype` STRING COMMENT 'Fine-grained subtype for the rule.',
    `rule_type` STRING COMMENT 'Primary classification of the rule (e.g., eligibility, benefit, coverage).',
    `rule_version` STRING COMMENT 'Version identifier for the rule.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule record.',
    `updated_by` BIGINT COMMENT 'Identifier of the user or system that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` BIGINT COMMENT 'Identifier of the user or system that created the rule.',
    CONSTRAINT pk_assignment_rule PRIMARY KEY(`assignment_rule_id`)
) COMMENT 'Master reference table for assignment_rule. Referenced by assignment_rule_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` (
    `member_eligibility_span_id` BIGINT COMMENT 'Primary key for eligibility_span',
    `member_enrollment2_id` BIGINT COMMENT 'Unique identifier for the enrollment record associated with this eligibility span',
    `subscriber_id` BIGINT COMMENT 'Identifier of the subscriber associated with this eligibility span',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Coverage.CoverageEligibilityResponse)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_member_eligibility_span PRIMARY KEY(`member_eligibility_span_id`)
) COMMENT 'Eligibility Span entity for member domain';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` (
    `member_enrollment2_id` BIGINT COMMENT 'Primary key for enrollment',
    `care_enrollment2_id` BIGINT COMMENT 'SSOT reference to care.care_enrollment',
    `health_plan_id` BIGINT COMMENT '',
    `member_enrollment_id` BIGINT COMMENT 'SSOT primary key',
    `subscriber_id` BIGINT COMMENT '',
    `auto_renewal_flag` BOOLEAN COMMENT 'Auto renewal flag',
    `channel` STRING COMMENT 'Enrollment channel',
    `coverage_end_date` DATE COMMENT 'The date when the members coverage under this enrollment ends',
    `coverage_level` STRING COMMENT 'Coverage level.',
    `coverage_start_date` DATE COMMENT 'The date when the members coverage begins under this enrollment',
    `coverage_status_code` STRING COMMENT 'Code indicating the coverage status of the member enrollment',
    `coverage_tier` STRING COMMENT 'Coverage tier',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dependents_covered_count` STRING COMMENT 'Number of dependents covered under this enrollment',
    `effective_date` DATE COMMENT 'Enrollment effective date.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `election_source_code` STRING COMMENT '',
    `enrollment_status` STRING COMMENT 'Enrollment status.',
    `enrollment_type` STRING COMMENT 'Type of enrollment.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: EnrollmentRequest)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `paid_through_date` DATE COMMENT '',
    `premium_amount` DECIMAL(18,2) COMMENT 'Premium amount',
    `prior_coverage_indicator` BOOLEAN COMMENT 'Prior coverage indicator',
    `reason` STRING COMMENT 'Reason for enrollment.',
    `reason_code` STRING COMMENT 'Enrollment reason code',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `sep_reason_code` STRING COMMENT '',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Subsidy amount',
    `termination_date` DATE COMMENT 'Enrollment termination date.',
    `tier_level_code` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp.',
    CONSTRAINT pk_member_enrollment2 PRIMARY KEY(`member_enrollment2_id`)
) COMMENT 'HEALTH PLAN enrollment (distinct from care.enrollment care management program enrollment). Enrollment entity for member domain';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` (
    `member_lifecycle_event_id` BIGINT COMMENT 'System-generated unique identifier for each member lifecycle event record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Required for CMS lifecycle event reports that must identify the specific health plan affected (e.g., plan termination, enrollment change).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lifecycle events may be initiated by an employee; required for internal workflow tracking and reporting.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom the lifecycle event applies.',
    `contract_lifecycle_event2_id` BIGINT COMMENT 'SSOT reference to canonical lifecycle_event master contract.contract_lifecycle_event',
    `credential_lifecycle_event_id` BIGINT COMMENT '',
    `appeal_rights_notification_flag` BOOLEAN COMMENT 'True if the member was notified of appeal rights related to the event.',
    `chip_aging_out_flag` BOOLEAN COMMENT 'True when the member ages out of the Children’s Health Insurance Program.',
    `cms_reporting_indicator` BOOLEAN COMMENT 'Indicates whether the event must be reported to CMS for regulatory compliance.',
    `cobra_qualifying_event_flag` BOOLEAN COMMENT 'True if the event triggers COBRA continuation rights.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first created in the data lake.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disability_determination_flag` BOOLEAN COMMENT 'True if the event includes a determination of disability status.',
    `disenrollment_reason_code` STRING COMMENT 'Standard code describing why the member is disenrolling (e.g., voluntary, non‑payment, death).',
    `disenrollment_request_date` DATE COMMENT 'Date the member or employer submitted a request to disenroll, if applicable.',
    `disenrollment_source` STRING COMMENT 'Origin of the disenrollment request (member request, employer, CMS, state Medicaid agency).',
    `documentation_received_flag` BOOLEAN COMMENT 'Indicates whether required supporting documentation for the event has been received (true) or is pending (false).',
    `effective_date` DATE COMMENT 'Date on which the eligibility or benefit change resulting from the event becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_description` STRING COMMENT 'Free‑text description providing additional context for the event.',
    `event_reason_code` STRING COMMENT 'Code indicating the business reason for the event, such as voluntary termination, loss of eligibility, or plan termination.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event was recorded in the source system.',
    `event_type_code` STRING COMMENT 'Standard code representing the type of lifecycle event (e.g., birth, marriage, death, disenrollment).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `incarceration_release_flag` BOOLEAN COMMENT 'True when the event records incarceration or release of the member.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicaid_eligibility_gain_flag` BOOLEAN COMMENT 'True when the event results in new Medicaid eligibility.',
    `medicaid_eligibility_loss_flag` BOOLEAN COMMENT 'True when the event causes loss of Medicaid eligibility.',
    `medicare_entitlement_flag` BOOLEAN COMMENT 'True if the event confers Medicare entitlement.',
    `member_lifecycle_event_status` STRING COMMENT 'Current lifecycle status of the event record.. Valid values are `active|inactive|closed`',
    `notice_sent_date` DATE COMMENT 'Date on which the required member notice (e.g., COBRA notice) was sent.',
    `plan_termination_flag` BOOLEAN COMMENT 'Indicates whether the event is due to termination of the members health plan.',
    `qualified_life_event_flag` BOOLEAN COMMENT 'True if the event qualifies as a life event for enrollment changes (e.g., marriage, birth).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `relocation_effective_date` DATE COMMENT 'Date the members relocation becomes effective for eligibility purposes.',
    `relocation_state_code` STRING COMMENT 'Two‑letter state abbreviation where the member is relocating, if applicable.',
    `source_record_reference` STRING COMMENT 'Identifier of the original record in the source system.',
    `special_enrollment_period_flag` BOOLEAN COMMENT 'Indicates whether the event creates a Special Enrollment Period under ACA regulations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the event record.',
    `verification_status` STRING COMMENT 'Current verification state of the event information.. Valid values are `pending|verified|rejected`',
    CONSTRAINT pk_member_lifecycle_event PRIMARY KEY(`member_lifecycle_event_id`)
) COMMENT 'Single source of truth for all significant member lifecycle events that trigger eligibility changes, enrollment actions, or benefit modifications. Event types include: birth, adoption, marriage, divorce, death, disenrollment (voluntary/involuntary termination with full disenrollment detail), loss of other coverage, gain of other coverage, relocation, Medicare entitlement, Medicaid eligibility gain/loss, CHIP aging-out, disability determination, incarceration/release, and plan termination. Records event date, event type code, event reason code, documentation received flag, verification status, effective date of resulting eligibility change, source system, notice sent date, appeal rights notification flag, and CMS/state reporting indicators. For disenrollment events: captures disenrollment request date, disenrollment reason code (voluntary termination, non-payment, loss of eligibility, plan termination, death, fraud, relocation out of service area), source of disenrollment (member request, employer group, CMS, state Medicaid agency), COBRA qualifying event trigger flag, and appeal rights notification. Supports Special Enrollment Period (SEP) processing, QLE workflows, CMS SEP reporting, CMS disenrollment reporting for Medicare Advantage, and Medicaid managed care disenrollment rules.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_communication` (
    `member_communication_id` BIGINT COMMENT 'Unique surrogate key for each communication record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Communications (ID cards, benefit notices) must be linked to the members active health plan for ACA disclosure and audit compliance.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member who is the recipient or sender of the communication.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: PHARMACY_BENEFIT_MANAGEMENT: Member pharmacy BIN/PCN data must be linked to the contracted pharmacy vendor for claim routing and CMS reporting.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: Personalized communications (e.g., welcome letters) need a direct link to the provider to pull correct PCP details for each member.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Communications to members are often sent by a staff employee; tracking sender supports compliance and quality monitoring.',
    `acknowledgment_status` STRING COMMENT 'Indicates whether the member has acknowledged receipt of the communication.. Valid values are `ACKNOWLEDGED|NOT_ACKNOWLEDGED|PENDING`',
    `body` STRING COMMENT 'Full textual content of the communication (may be truncated for storage).',
    `card_format` STRING COMMENT 'Delivery format of the ID card (physical mail, digital PDF, or mobile app).. Valid values are `PHYSICAL|DIGITAL|MOBILE`',
    `card_status` STRING COMMENT 'Current lifecycle status of the ID card.. Valid values are `ACTIVE|REPLACED|LOST_STOLEN|EXPIRED`',
    `card_type` STRING COMMENT 'Type of ID card referenced when the communication involves card issuance.. Valid values are `MEDICAL|DENTAL|VISION|PHARMACY|COMBINED`',
    `channel` STRING COMMENT 'Medium used to deliver the communication.. Valid values are `MAIL|EMAIL|SMS|PHONE|PORTAL`',
    `communication_number` STRING COMMENT 'Human‑readable identifier assigned to the communication for tracking and reference.',
    `communication_type` STRING COMMENT 'Category of the outbound/inbound communication (e.g., Explanation of Benefits, Welcome Kit, ID Card, Annual Notice of Change, Evidence of Coverage, Summary of Benefits and Coverage).. Valid values are `EOB|WELCOME_KIT|ID_CARD|ANOC|EOC|SBC`',
    `copay_amount` DECIMAL(18,2) COMMENT 'Standard copay amount displayed on the ID card.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the communication record was first created in the data warehouse.',
    `customer_service_phone` STRING COMMENT 'Contact phone number for member inquiries, displayed on the communication or card.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_confirmation` BOOLEAN COMMENT 'True when delivery of the communication has been confirmed (e.g., signed receipt).',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date‑time when the communication was successfully delivered to the member (if applicable).',
    `effective_date` DATE COMMENT 'Date on which the communication becomes effective (e.g., start of coverage notice).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date after which the communication is no longer considered active (e.g., card expiry).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Communication)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `group_number` STRING COMMENT 'Employer or group identifier shown on the ID card.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language_code` STRING COMMENT 'Two‑letter ISO 639‑1 code representing the language of the communication.. Valid values are `^[a-z]{2}$`',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_communication_status` STRING COMMENT 'Current processing state of the communication.. Valid values are `PENDING|SENT|DELIVERED|FAILED|BOUNCED|ACKNOWLEDGED`',
    `member_id_displayed` STRING COMMENT 'Member identifier printed on the ID card (may be masked for privacy).',
    `pharmacy_bin` STRING COMMENT 'Bank Identification Number for pharmacy claims shown on the card.',
    `pharmacy_group_number` STRING COMMENT 'Group number for pharmacy benefits displayed on the card.',
    `pharmacy_pcn` STRING COMMENT 'Processor Control Number for pharmacy claims shown on the card.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_flag` BOOLEAN COMMENT 'True when the communication satisfies a mandatory regulatory requirement (e.g., CMS‑mandated notice).',
    `replacement_reason` STRING COMMENT 'Reason why an ID card was re‑issued (e.g., lost, stolen, expired).',
    `send_timestamp` TIMESTAMP COMMENT 'Date‑time when the communication was sent or initiated.',
    `subject` STRING COMMENT 'Subject line or title of the communication.',
    `template_version` STRING COMMENT 'Version identifier of the communication template used.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the communication record.',
    CONSTRAINT pk_member_communication PRIMARY KEY(`member_communication_id`)
) COMMENT 'Tracks all outbound and inbound communications with members and manages ID card issuance and fulfillment. Communication types include: EOB mailings, welcome kits, ID card issuance (physical and digital), Annual Notice of Change (ANOC), Evidence of Coverage (EOC), SBC (Summary of Benefits and Coverage), care gap notifications, wellness program invitations, and regulatory notices. Records communication type, channel (mail, email, SMS, phone, portal), send date, delivery status, template version, regulatory requirement flag (e.g., CMS-mandated notice), language used, and member acknowledgment status. For ID card communications: tracks card type (medical, dental, vision, pharmacy, combined), card format (physical, digital/mobile), card status (active, replaced, lost/stolen, expired), plan name on card, group number, member ID displayed, PCP name (for HMO cards), copay amounts displayed, pharmacy BIN/PCN/Group numbers, customer service phone numbers, replacement reason, and delivery confirmation. Supports CMS notice compliance tracking, NCQA member communication standards, member engagement measurement, and digital ID card provisioning via member portal. [SSOT Master for communication concept across domains]';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` (
    `member_grievance2_id` BIGINT COMMENT 'System‑generated unique identifier for each grievance record.',
    `appeal_grievance2_id` BIGINT COMMENT 'Foreign key linking this domain-specific grievance record to the single source of truth in appeal.appeal_grievance',
    `benefit_package_id` BIGINT COMMENT 'Identifier of the specific benefit package linked to the members coverage.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or investigator assigned to handle the grievance.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is enrolled at the time of the grievance.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who filed the grievance.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: Grievances are often filed against a specific provider; linking enables tracking, reporting, and regulatory compliance.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Grievance Management Report requires linking each grievance to the provider network involved, enabling compliance tracking and root‑cause analysis.',
    `cms_reportable_indicator` BOOLEAN COMMENT 'True if the grievance is reportable under CMS grievance reporting requirements (e.g., Medicare Advantage).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grievance record was first created in the data warehouse.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for the disputed amount.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary amount that the member is contesting, if applicable (e.g., billing dispute).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Communication)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `grievance_number` STRING COMMENT 'Business‑visible identifier assigned to the grievance, often used in member communications and regulatory reporting.',
    `grievance_source` STRING COMMENT 'Channel through which the grievance was received.. Valid values are `call_center|online_portal|mail|in_person`',
    `investigation_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the investigation concluded.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the investigation of the grievance began.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `issue_category_code` STRING COMMENT 'More granular classification of the grievance issue within the selected grievance type.',
    `lob_code` STRING COMMENT 'Code identifying the line of business (e.g., commercial, Medicare, Medicaid, CHIP) associated with the member.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_grievance_status` STRING COMMENT 'Current lifecycle state of the grievance.. Valid values are `open|in_review|resolved|closed|withdrawn`',
    `member_satisfaction_score` STRING COMMENT 'Member‑reported satisfaction rating of the grievance resolution on a 1‑5 scale.',
    `received_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the grievance was first recorded in the system.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the grievance must be reported to regulatory bodies (true) or not (false).',
    `resolution_date` DATE COMMENT 'Calendar date on which the grievance was formally resolved.',
    `resolution_description` STRING COMMENT 'Narrative details of the actions taken or explanation provided to resolve the grievance.',
    `resolution_type_code` STRING COMMENT 'Indicates how the grievance was addressed, e.g., corrective action, explanation, refund, no action, or other.. Valid values are `corrective_action|explanation|refund|no_action|other`',
    `state_code` STRING COMMENT 'Two‑letter US state abbreviation where the grievance originated or is applicable.. Valid values are `^[A-Z]{2}$`',
    `type_code` STRING COMMENT 'Categorizes the grievance by primary concern area such as quality of care, access, provider attitude, billing/financial, or benefit/coverage.. Valid values are `quality_of_care|access|attitude|billing|benefit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grievance record.',
    CONSTRAINT pk_member_grievance2 PRIMARY KEY(`member_grievance2_id`)
) COMMENT 'Operational record of formal member grievances (non-appeal complaints) filed against the health plan regarding service quality, access to care, provider behavior, billing disputes, or administrative issues. Tracks grievance receipt date, grievance type code (quality of care, access, attitude/service, billing/financial, benefit/coverage), issue category, member-reported description, assigned investigator, investigation timeline, resolution date, resolution type, resolution description, member satisfaction with resolution, regulatory reporting flag, and CMS/state DOI reportable indicator. Distinct from the appeal domain which handles coverage determination and claim denial disputes — grievances are expressions of dissatisfaction, not requests for coverage reversal. Supports CMS grievance reporting requirements for Medicare Advantage (42 CFR §422.564) and Medicaid managed care (42 CFR §438.402), state DOI complaint reporting, and NCQA accreditation standards (CR standards).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_grievance` (
    `member_grievance_id` BIGINT COMMENT 'Primary key for member_grievance',
    CONSTRAINT pk_member_grievance PRIMARY KEY(`member_grievance_id`)
) COMMENT 'General member complaint';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` (
    `member_enrollment_id` BIGINT COMMENT 'Primary key for member_enrollment',
    `coverage_start_date` DATE COMMENT '',
    `coverage_end_date` DATE COMMENT '',
    `coverage_status_code` STRING COMMENT '',
    `election_source_code` STRING COMMENT '',
    `sep_reason_code` STRING COMMENT '',
    `premium_amount` DECIMAL(18,2) COMMENT '',
    `subsidy_amount` DECIMAL(18,2) COMMENT '',
    `tier_level_code` STRING COMMENT '',
    `dependents_covered_count` BIGINT COMMENT '',
    `paid_through_date` DATE COMMENT '',
    CONSTRAINT pk_member_enrollment PRIMARY KEY(`member_enrollment_id`)
) COMMENT 'HEALTH PLAN enrollment';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_member_address_id` FOREIGN KEY (`member_address_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_address`(`member_address_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_member_contact_id` FOREIGN KEY (`member_contact_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_contact`(`member_contact_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ADD CONSTRAINT `fk_member_member_address_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ADD CONSTRAINT `fk_member_member_contact_member_subscriber_id` FOREIGN KEY (`member_subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ADD CONSTRAINT `fk_member_member_contact_primary_member_subscriber_id` FOREIGN KEY (`primary_member_subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ADD CONSTRAINT `fk_member_member_contact_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ADD CONSTRAINT `fk_member_household_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ADD CONSTRAINT `fk_member_lob_assignment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_assignment_rule_id` FOREIGN KEY (`assignment_rule_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`assignment_rule`(`assignment_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ADD CONSTRAINT `fk_member_segment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ADD CONSTRAINT `fk_member_authorized_representative_authorization_document_id` FOREIGN KEY (`authorization_document_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`authorization_document`(`authorization_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ADD CONSTRAINT `fk_member_authorized_representative_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_parent_policy_id` FOREIGN KEY (`parent_policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ADD CONSTRAINT `fk_member_authorization_document_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ADD CONSTRAINT `fk_member_authorization_document_parent_authorization_document_id` FOREIGN KEY (`parent_authorization_document_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`authorization_document`(`authorization_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ADD CONSTRAINT `fk_member_assignment_rule_parent_assignment_rule_id` FOREIGN KEY (`parent_assignment_rule_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`assignment_rule`(`assignment_rule_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_member_enrollment2_id` FOREIGN KEY (`member_enrollment2_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_enrollment2`(`member_enrollment2_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ADD CONSTRAINT `fk_member_member_enrollment2_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ADD CONSTRAINT `fk_member_member_enrollment2_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ADD CONSTRAINT `fk_member_member_lifecycle_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ADD CONSTRAINT `fk_member_member_communication_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ADD CONSTRAINT `fk_member_member_grievance2_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`member` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`member` SET TAGS ('pii_domain' = 'member');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_subdomain' = 'core_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_fhir_resource' = 'Patient');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `coordinator_id` SET TAGS ('pii_business_glossary_term' = 'Primary Care Coordinator Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Primary Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Sales Rep Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `member_address_id` SET TAGS ('pii_business_glossary_term' = 'Member Address Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `member_address_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `member_address_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `member_address_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `member_address_id` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `member_contact_id` SET TAGS ('pii_business_glossary_term' = 'Member Contact Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `member_contact_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('pii_business_glossary_term' = 'Annual Income');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('pii_business_glossary_term' = 'CHIP Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('pii_natural_key_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('pii_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('pii_value_regex' = 'citizen|permanent_resident|non_resident|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `cob_indicator` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `cob_indicator` SET TAGS ('pii_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `consent_to_electronic_communication` SET TAGS ('pii_business_glossary_term' = 'Electronic Communication Consent');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'hmo|ppo|epo|pos|hdhp|hsa');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('pii_fhir_element' = 'birthDate');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('pii_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('pii_value_regex' = 'yes|no|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `enrollment_source` SET TAGS ('pii_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `enrollment_source` SET TAGS ('pii_value_regex' = 'online|call_center|agent|mail|broker');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC) Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('pii_business_glossary_term' = 'Deceased Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('pii_fhir_element' = 'deceasedBoolean');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('pii_value_regex' = 'en|es|fr|zh|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('pii_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('pii_language_preference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Last Name (Family Name)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|chip|group|individual');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('pii_business_glossary_term' = 'Marital Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('pii_value_regex' = 'single|married|divorced|widowed|separated|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('pii_fhir_element' = 'maritalStatus');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('pii_business_glossary_term' = 'Medicaid Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `primary_contact_method` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `primary_contact_method` SET TAGS ('pii_value_regex' = 'phone|email|mail|portal');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_business_glossary_term' = 'Race/Ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_value_regex' = 'white|black|asian|hispanic|native_american|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_fhir_element_extension' = 'us-core-race');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_value_regex' = '^(d{3}-d{2}-d{4})$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_ssn' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('pii_business_glossary_term' = 'Subscriber Number (Policy Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('pii_business_glossary_term' = 'Subscriber Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('pii_fhir_element' = 'active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('pii_business_glossary_term' = 'Tobacco Use Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('pii_value_regex' = 'current|former|never|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('pii_tobacco_use_status' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('pii_business_glossary_term' = 'Veteran Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('pii_veteran_status' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_subdomain' = 'core_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_fhir_resource' = 'Patient');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `dependent_id` SET TAGS ('pii_business_glossary_term' = 'Dependent Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Subscriber Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line1` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line2` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line2` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_line2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `age_out_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Age-Out Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `chip_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'CHIP Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `country` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Dependent Date of Birth (DOB)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_fhir_element' = 'birthDate');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('pii_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'Dependent First Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_business_glossary_term' = 'Dependent Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `is_primary_contact` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('pii_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Dependent Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `medicaid_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Medicaid Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Dependent Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|inactive|deleted|archived');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_end_date` SET TAGS ('pii_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_start_date` SET TAGS ('pii_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('pii_business_glossary_term' = 'Dependent Relationship Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('pii_value_regex' = 'spouse|domestic_partner|child|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `sequence_number` SET TAGS ('pii_business_glossary_term' = 'Dependent Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `sequence_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_value_regex' = '^d{3}-d{2}-d{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('pii_ssn' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `student_status` SET TAGS ('pii_business_glossary_term' = 'Student Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `student_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `student_status` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_subdomain' = 'core_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_fhir_resource' = 'Patient');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Identity Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Group Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Plan Assigned Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Member Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Member Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('pii_business_glossary_term' = 'Member Citizenship Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('pii_value_regex' = 'citizen|non_citizen|permanent_resident|temporary_resident|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Member City');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('pii_city' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Member Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('pii_country' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Member Date of Birth');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('pii_fhir_element' = 'birthDate');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `eligibility_status` SET TAGS ('pii_business_glossary_term' = 'Member Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `eligibility_status` SET TAGS ('pii_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('pii_business_glossary_term' = 'Member Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `enrollment_effective_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('pii_business_glossary_term' = 'Member Ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('pii_fhir_element_extension' = 'us-core-ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('pii_business_glossary_term' = 'External Subscriber Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('pii_external_subscriber_number' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'Member First Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('pii_business_glossary_term' = 'Member Full Legal Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('pii_fhir_element' = 'name.text');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('pii_business_glossary_term' = 'Member Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('pii_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('pii_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Member Preferred Language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('pii_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('pii_language_preference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Member Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('pii_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|chip|group');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('pii_business_glossary_term' = 'Member Marital Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('pii_value_regex' = 'single|married|divorced|widowed|separated|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('pii_fhir_element' = 'maritalStatus');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('pii_business_glossary_term' = 'Member Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('pii_fhir_element' = 'active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_type` SET TAGS ('pii_business_glossary_term' = 'Member Type (Subscriber or Dependent)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_type` SET TAGS ('pii_value_regex' = 'subscriber|dependent|spouse|child|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Member Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Member Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Member Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('pii_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `primary_contact_method` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `primary_contact_method` SET TAGS ('pii_value_regex' = 'email|phone|mail|portal');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('pii_business_glossary_term' = 'Member Race');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('pii_fhir_element_extension' = 'us-core-race');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('pii_business_glossary_term' = 'Relationship to Subscriber');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('pii_value_regex' = 'self|spouse|child|parent|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Member Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('pii_business_glossary_term' = 'Social Security Number Hash');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('pii_ssn' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'Member State');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('pii_state' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'unverified|pending|verified|failed');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_patient_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_subdomain' = 'core_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_fhir_resource' = 'Patient.address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `member_address_id` SET TAGS ('pii_business_glossary_term' = 'Member Address ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `member_address_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `member_address_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `member_address_id` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `subscriber_id` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `address_type` SET TAGS ('pii_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `address_type` SET TAGS ('pii_value_regex' = 'home|mailing|temporary|employer|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `address_type` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `address_type` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `census_tract` SET TAGS ('pii_business_glossary_term' = 'Census Tract Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `census_tract` SET TAGS ('pii_value_regex' = '^d{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `census_tract` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `census_tract` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `change_reason` SET TAGS ('pii_business_glossary_term' = 'Address Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `country_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `country_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `country_code` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `county_fips` SET TAGS ('pii_business_glossary_term' = 'County FIPS Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `county_fips` SET TAGS ('pii_value_regex' = '^d{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `county_fips` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `county_fips` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `external_code` SET TAGS ('pii_business_glossary_term' = 'External Address ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `external_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `geocode_accuracy_meters` SET TAGS ('pii_business_glossary_term' = 'Geocode Accuracy (Meters)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Is Primary Address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `latitude` SET TAGS ('pii_geolocation' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1 (Street Address)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line1` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2 (Apartment/Suite)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line2` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line3` SET TAGS ('pii_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line3` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line3` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line4` SET TAGS ('pii_business_glossary_term' = 'Address Line 4');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line4` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `line4` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `longitude` SET TAGS ('pii_geolocation' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `member_address_status` SET TAGS ('pii_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `member_address_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `member_address_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `member_address_status` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `member_address_status` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'ZIP Code (Postal Code)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `postal_code` SET TAGS ('pii_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `postal_code` SET TAGS ('pii_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `priority_rank` SET TAGS ('pii_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code (US Postal)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `state_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Address Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_address` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_subdomain' = 'core_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_fhir_resource' = 'Patient.contact');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `member_contact_id` SET TAGS ('pii_business_glossary_term' = 'Member Contact Identifier (MCID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `primary_member_subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Subscriber Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_cass_certified` SET TAGS ('pii_business_glossary_term' = 'CASS Certified Flag (CASS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_cass_certified` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_cass_certified` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_cass_certified` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_effective_date` SET TAGS ('pii_business_glossary_term' = 'Address Effective Date (AED)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_effective_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_effective_date` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_effective_date` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('pii_business_glossary_term' = 'Geocode Accuracy (GEO_ACC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_source` SET TAGS ('pii_business_glossary_term' = 'Geocode Source (GEO_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_source` SET TAGS ('pii_value_regex' = 'USPS|Google|HERE|Other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_source` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_source` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_geocode_source` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_line2` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_priority_rank` SET TAGS ('pii_business_glossary_term' = 'Address Priority Rank (APR)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_priority_rank` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_priority_rank` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_priority_rank` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_source_system` SET TAGS ('pii_business_glossary_term' = 'Address Source System (ASS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_source_system` SET TAGS ('pii_value_regex' = 'Facets|QNXT|CRM|Other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_source_system` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_source_system` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_source_system` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_termination_date` SET TAGS ('pii_business_glossary_term' = 'Address Termination Date (ATD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_termination_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_termination_date` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_termination_date` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_type` SET TAGS ('pii_business_glossary_term' = 'Address Type (AT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_type` SET TAGS ('pii_value_regex' = 'home|mailing|temporary|employer|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_type` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_type` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_verification_status` SET TAGS ('pii_business_glossary_term' = 'Address Verification Status (AVS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_verification_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_verification_status` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `address_verification_status` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `census_tract` SET TAGS ('pii_business_glossary_term' = 'Census Tract (CT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `census_tract` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `census_tract` SET TAGS ('pii_census_tract' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `census_tract` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `census_tract` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_business_glossary_term' = 'Contact Full Name (CFN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `contact_type` SET TAGS ('pii_business_glossary_term' = 'Contact Type (CT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `contact_type` SET TAGS ('pii_value_regex' = 'member|dependent|beneficiary|employer|provider|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code (CC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `country_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `country_code` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `country_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `country_code` SET TAGS ('pii_country_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `country_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `county_fips` SET TAGS ('pii_business_glossary_term' = 'County FIPS Code (FIPS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `county_fips` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `county_fips` SET TAGS ('pii_county_fips' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `county_fips` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `county_fips` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `email_address` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_business_glossary_term' = 'Fax Number (FAX)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `id_type` SET TAGS ('pii_business_glossary_term' = 'Contact Identifier Type (CID_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `id_type` SET TAGS ('pii_value_regex' = 'NPI|SSN|MemberID|Other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `id_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `id_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `id_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `id_value` SET TAGS ('pii_business_glossary_term' = 'Contact Identifier Value (CID_VAL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `id_value` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `id_value` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Flag (PRIMARY)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference (LANG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `language_preference` SET TAGS ('pii_value_regex' = 'en|es|fr|zh|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `language_preference` SET TAGS ('pii_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `language_preference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `language_preference` SET TAGS ('pii_language_preference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `language_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `language_preference` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `last_verified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Verification Timestamp (LVT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `latitude` SET TAGS ('pii_geolocation' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `longitude` SET TAGS ('pii_geolocation' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `member_contact_status` SET TAGS ('pii_business_glossary_term' = 'Contact Status (CSTAT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `member_contact_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Contact Notes (CNOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `opt_in_email` SET TAGS ('pii_business_glossary_term' = 'Email Opt‑In Flag (EMAIL_OPT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `opt_in_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `opt_in_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `opt_in_email` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `opt_in_robocall` SET TAGS ('pii_business_glossary_term' = 'Robocall Opt‑In Flag (RC_OPT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `opt_in_sms` SET TAGS ('pii_business_glossary_term' = 'SMS Opt‑In Flag (SMS_OPT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_home` SET TAGS ('pii_business_glossary_term' = 'Home Phone Number (HPN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_home` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_home` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_home` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_home` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_mobile` SET TAGS ('pii_business_glossary_term' = 'Mobile Phone Number (MPN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_mobile` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_mobile` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_mobile` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_mobile` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_work` SET TAGS ('pii_business_glossary_term' = 'Work Phone Number (WPN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_work` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_work` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_work` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `phone_work` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Method (PCM)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('pii_value_regex' = 'phone|email|mail|sms');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `relationship` SET TAGS ('pii_business_glossary_term' = 'Contact Relationship (CREL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `relationship` SET TAGS ('pii_value_regex' = 'self|spouse|child|parent|guardian|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `relationship` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `relationship` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `relationship` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State or Province (ST)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `state_province` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `state_province` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `tcp_a_consent_flag` SET TAGS ('pii_business_glossary_term' = 'TCPA Consent Flag (TCPA)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_subdomain' = 'core_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_fhir_resource' = 'Group');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_id` SET TAGS ('pii_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Primary Plan ID (PRIMARY_PLAN_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Head of Household Member ID (HOH_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `aca_subsidy_eligible` SET TAGS ('pii_business_glossary_term' = 'ACA Subsidy Eligibility Flag (ACA_SUBSIDY_ELIG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `cobra_coverage_flag` SET TAGS ('pii_business_glossary_term' = 'COBRA Coverage Flag (COBRA_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country Code (COUNTRY)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `country` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `country` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `country` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `creation_method` SET TAGS ('pii_business_glossary_term' = 'Household Creation Method (CREATION_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `creation_method` SET TAGS ('pii_value_regex' = 'online|call_center|agent|mail');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address (EMAIL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `email_address` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status (ENRL_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `enrollment_status` SET TAGS ('pii_value_regex' = 'enrolled|pending|terminated|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_business_glossary_term' = 'Federal Poverty Level Percentage (FPL_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `fpl_year` SET TAGS ('pii_business_glossary_term' = 'FPL Year (FPL_YEAR)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_number` SET TAGS ('pii_business_glossary_term' = 'Household Number (HHLD_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_status` SET TAGS ('pii_business_glossary_term' = 'Household Status (HHLD_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_type` SET TAGS ('pii_business_glossary_term' = 'Household Type (HHLD_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_type` SET TAGS ('pii_value_regex' = 'single|family|group|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `income_source` SET TAGS ('pii_business_glossary_term' = 'Income Source (INCOME_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `income_source` SET TAGS ('pii_value_regex' = 'employment|self_employed|investment|government|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `income_source` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `income_source` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `income_verification_flag` SET TAGS ('pii_business_glossary_term' = 'Income Verification Flag (INCOME_VERIF_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `is_hispanic` SET TAGS ('pii_business_glossary_term' = 'Hispanic Ethnicity Flag (HISPANIC_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `is_hispanic` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `is_hispanic` SET TAGS ('pii_is_hispanic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `is_multi_plan` SET TAGS ('pii_business_glossary_term' = 'Multi-Plan Household Flag (MULTI_PLAN_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `is_veteran` SET TAGS ('pii_business_glossary_term' = 'Veteran Status Flag (VETERAN_FLG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `is_veteran` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `is_veteran` SET TAGS ('pii_is_veteran' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference (LANG_PREF)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `language_preference` SET TAGS ('pii_value_regex' = 'en|es|fr|zh|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `language_preference` SET TAGS ('pii_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `language_preference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `language_preference` SET TAGS ('pii_language_preference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `language_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `language_preference` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `last_eligibility_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Eligibility Review Date (ELIG_REVIEW_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By (MOD_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `medicaid_eligible` SET TAGS ('pii_business_glossary_term' = 'Medicaid Eligibility Flag (MEDICAID_ELIG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `medicaid_eligible` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `medicaid_eligible` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_name` SET TAGS ('pii_business_glossary_term' = 'Household Name (HHLD_NAME)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `household_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Contact Phone Number (PHONE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `phone_number` SET TAGS ('pii_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `primary_address` SET TAGS ('pii_business_glossary_term' = 'Primary Address (ADDRESS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `primary_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `primary_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `primary_address` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status (REC_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|archived|deleted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Household Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `risk_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `risk_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `risk_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `size` SET TAGS ('pii_business_glossary_term' = 'Household Size (HHLD_SIZE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `special_program_eligibility` SET TAGS ('pii_business_glossary_term' = 'Special Program Eligibility (SPEC_PROG_ELIG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `special_program_eligibility` SET TAGS ('pii_value_regex' = 'dualeligible|low_income|none');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State (STATE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `state` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount (SUBSIDY_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `tax_credit_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Credit Amount (TAX_CREDIT_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `tax_credit_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `tax_credit_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `tax_credit_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `total_income` SET TAGS ('pii_business_glossary_term' = 'Total Household Income (HHLD_INCOME)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `total_income` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `total_income` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `total_income` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'ZIP Code (ZIP)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `zip_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `zip_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`household` ALTER COLUMN `zip_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_subdomain' = 'core_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Line of Business Assignment ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `care_management_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Care Management Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_business_glossary_term' = 'CMS Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `cms_region` SET TAGS ('pii_business_glossary_term' = 'CMS Region');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `cms_region` SET TAGS ('pii_value_regex' = 'NORTHEAST|MIDWEST|SOUTH|WEST');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `dual_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Dual Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `dual_eligible_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `dual_eligible_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('pii_business_glossary_term' = 'HCC Risk Score Tier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_assignment_status` SET TAGS ('pii_business_glossary_term' = 'LOB Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_assignment_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_description` SET TAGS ('pii_business_glossary_term' = 'Line of Business Description');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `plan_benefit_package_code` SET TAGS ('pii_business_glossary_term' = 'Plan Benefit Package (PBP) Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `plan_benefit_package_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `rising_risk_indicator` SET TAGS ('pii_business_glossary_term' = 'Rising Risk Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('pii_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('pii_value_regex' = 'LOW|MEDIUM|HIGH|CATASTROPHIC');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `sdoh_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health (SDOH) Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `segmentation_model_version` SET TAGS ('pii_business_glossary_term' = 'Segmentation Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `segmentation_source` SET TAGS ('pii_business_glossary_term' = 'Segmentation Source');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `segmentation_source` SET TAGS ('pii_value_regex' = 'PREDICTIVE|CLAIMS|CARE_MANAGER');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('pii_business_glossary_term' = 'SNP Qualifying Condition');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('pii_business_glossary_term' = 'Special Needs Plan (SNP) Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('pii_value_regex' = 'D-SNP|C-SNP|F-SNP|I-SNP');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `star_rating_cohort` SET TAGS ('pii_business_glossary_term' = 'STAR Rating Cohort');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `star_rating_cohort` SET TAGS ('pii_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('pii_state_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_subdomain' = 'coverage_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `cobra_continuant_id` SET TAGS ('pii_business_glossary_term' = 'COBRA Continuant Identifier (CCID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Identifier (EGID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Identifier (PID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (MID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `transaction_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Identifier (EID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `cobra_continuant_status` SET TAGS ('pii_business_glossary_term' = 'COBRA Coverage Status (CCS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `cobra_continuant_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|expired|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `cobra_eligibility_indicator` SET TAGS ('pii_business_glossary_term' = 'COBRA Eligibility Indicator (CEI)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `cobra_eligibility_reason` SET TAGS ('pii_business_glossary_term' = 'COBRA Eligibility Reason (CER)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `cobra_notice_sent_date` SET TAGS ('pii_business_glossary_term' = 'COBRA Notice Sent Date (CNSD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `cobra_notice_type` SET TAGS ('pii_business_glossary_term' = 'COBRA Notice Type (CNT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `cobra_notice_type` SET TAGS ('pii_value_regex' = 'initial|reminder|final');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date (CED)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date (CSD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `election_date` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Date (CED)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `election_deadline` SET TAGS ('pii_business_glossary_term' = 'COBRA Election Deadline (CEDL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `exhaustion_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Exhaustion Date (CED)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `is_exhausted` SET TAGS ('pii_business_glossary_term' = 'Coverage Exhausted Indicator (CEI)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `max_coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Maximum Coverage Exhaustion Date (MCED)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `max_coverage_months` SET TAGS ('pii_business_glossary_term' = 'Maximum Coverage Months (MCM)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `member_relationship` SET TAGS ('pii_business_glossary_term' = 'Member Relationship (MR)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `member_relationship` SET TAGS ('pii_value_regex' = 'employee|spouse|child|parent|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `member_relationship` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `member_relationship` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Administrative Notes (AN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `payment_frequency` SET TAGS ('pii_business_glossary_term' = 'Payment Frequency (PF)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `payment_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method (PM)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'auto_debit|check|credit_card|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'COBRA Premium Amount (CPA)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `premium_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `premium_amount` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `premium_currency` SET TAGS ('pii_business_glossary_term' = 'Premium Currency (PC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `premium_currency` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `premium_due_date` SET TAGS ('pii_business_glossary_term' = 'Premium Due Date (PDD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `premium_payment_date` SET TAGS ('pii_business_glossary_term' = 'Premium Payment Date (PPD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `premium_payment_status` SET TAGS ('pii_business_glossary_term' = 'Premium Payment Status (PPS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `premium_payment_status` SET TAGS ('pii_value_regex' = 'paid|unpaid|partial|overdue');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `qualifying_event_date` SET TAGS ('pii_business_glossary_term' = 'Qualifying Event Date (QED)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `qualifying_event_type` SET TAGS ('pii_business_glossary_term' = 'Qualifying Event Type (QET)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `qualifying_event_type` SET TAGS ('pii_value_regex' = 'termination|reduction|divorce|death|medicare|dependent_loss');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Date (CTD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Reason (CTR)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cobra_continuant` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_subdomain' = 'coverage_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `pcp_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Pcp Assignment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_rule_id` SET TAGS ('pii_business_glossary_term' = 'Auto‑Assignment Rule ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID (Member Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider Assignment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider Assignment Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_value_regex' = 'member_selected|auto_assigned|plan_assigned');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `change_reason` SET TAGS ('pii_business_glossary_term' = 'PCP Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `change_timestamp` SET TAGS ('pii_business_glossary_term' = 'PCP Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date (Assignment Start Date)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `is_current` SET TAGS ('pii_business_glossary_term' = 'Current Assignment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Primary PCP Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Provider Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `panel_status` SET TAGS ('pii_business_glossary_term' = 'Provider Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `panel_status` SET TAGS ('pii_value_regex' = 'in_panel|out_of_panel|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `pcp_specialty_code` SET TAGS ('pii_business_glossary_term' = 'Provider Specialty Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `pcp_specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date (Assignment End Date)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('pii_subdomain' = 'coverage_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_record_id` SET TAGS ('pii_business_glossary_term' = 'Cob Record Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Other Carrier Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('pii_business_glossary_term' = 'Birthday Rule Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_order` SET TAGS ('pii_business_glossary_term' = 'COB Order');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_order` SET TAGS ('pii_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_record_number` SET TAGS ('pii_business_glossary_term' = 'COB Record Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_record_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_record_number` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_status` SET TAGS ('pii_business_glossary_term' = 'COB Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `cob_verification_date` SET TAGS ('pii_business_glossary_term' = 'COB Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `coordination_of_benefits_rule` SET TAGS ('pii_business_glossary_term' = 'COB Rule Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `coordination_of_benefits_rule` SET TAGS ('pii_value_regex' = 'birthday|plan|state|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `is_msp_compliant` SET TAGS ('pii_business_glossary_term' = 'MSP Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `is_subrogation_flag` SET TAGS ('pii_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'COB Notes');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_group_number` SET TAGS ('pii_business_glossary_term' = 'Other Carrier Group Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_group_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_group_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_group_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_group_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_group_number` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_member_number` SET TAGS ('pii_business_glossary_term' = 'Other Carrier Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_member_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_member_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_member_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_member_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_member_number` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_business_glossary_term' = 'Other Carrier Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_relationship_type` SET TAGS ('pii_business_glossary_term' = 'Other Carrier Relationship Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `other_carrier_relationship_type` SET TAGS ('pii_value_regex' = 'employer_sponsored|individual|government|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `policy_type` SET TAGS ('pii_business_glossary_term' = 'Policy Type (COB)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `policy_type` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|auto|workers_comp|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`cob_record` ALTER COLUMN `verification_method` SET TAGS ('pii_value_regex' = 'manual|electronic|auto');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_subdomain' = 'engagement_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_fhir_resource' = 'Consent');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `consent_id` SET TAGS ('pii_business_glossary_term' = 'Consent Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `consent_witness_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `consent_witness_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `consent_witness_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `authorized_recipient` SET TAGS ('pii_business_glossary_term' = 'Authorized Recipient');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `authorized_recipient` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `authorized_recipient` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `collection_method` SET TAGS ('pii_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `collection_method` SET TAGS ('pii_value_regex' = 'written|electronic|verbal|attested');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `consent_status` SET TAGS ('pii_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `consent_status` SET TAGS ('pii_value_regex' = 'active|revoked|expired|pending|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `consent_type` SET TAGS ('pii_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `consent_type` SET TAGS ('pii_value_regex' = 'phid_disclosure|release_of_information|marketing_opt_in|research_participation|care_management|advance_directive');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `disclosure_scope` SET TAGS ('pii_business_glossary_term' = 'Scope of Disclosure');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `is_42cfr_part2_applicable` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `is_electronic_signature` SET TAGS ('pii_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `is_minimum_necessary` SET TAGS ('pii_business_glossary_term' = 'Minimum Necessary Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `language` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `language` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Consent Notes');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `revocation_date` SET TAGS ('pii_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `signature_timestamp` SET TAGS ('pii_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `signature_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `signature_timestamp` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `state_of_residence` SET TAGS ('pii_business_glossary_term' = 'Member State of Residence');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `state_of_residence` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `state_of_residence` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `state_of_residence` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `state_of_residence` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `state_of_residence` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`consent` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Consent Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_subdomain' = 'coverage_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_fhir_resource' = 'EnrollmentRequest');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_id` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Prior Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `appeal_rights_notified` SET TAGS ('pii_business_glossary_term' = 'Appeal Rights Notified');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `cobro_eligibility` SET TAGS ('pii_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_status` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_status` SET TAGS ('pii_value_regex' = 'pending|processed|cancelled|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_timestamp` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Effective Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `eligibility_loss_indicator` SET TAGS ('pii_business_glossary_term' = 'Eligibility Loss Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `notice_sent_date` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Notice Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `processed_by` SET TAGS ('pii_business_glossary_term' = 'Processed By');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `processed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `reason_code` SET TAGS ('pii_value_regex' = 'voluntary|non_payment|eligibility_loss|plan_termination|death|fraud');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Refund Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_gross_amount` SET TAGS ('pii_business_glossary_term' = 'Refund Gross Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_gross_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_gross_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_net_amount` SET TAGS ('pii_business_glossary_term' = 'Refund Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_net_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_net_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `source` SET TAGS ('pii_value_regex' = 'member|employer|cms|state_medicaid|provider');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `termination_type` SET TAGS ('pii_business_glossary_term' = 'Termination Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `termination_type` SET TAGS ('pii_value_regex' = 'voluntary|involuntary|death|fraud|relocation|plan_termination');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_subdomain' = 'engagement_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_id` SET TAGS ('pii_business_glossary_term' = 'Segment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Audit User Identifier (AUD_USER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (MID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `audit_reason` SET TAGS ('pii_business_glossary_term' = 'Audit Reason (AUD_REASON)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_category` SET TAGS ('pii_business_glossary_term' = 'Segment Category (SCAT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_code` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition ICD Code (CCICD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Flag (CCF)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CRE_TSTMP)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_description` SET TAGS ('pii_business_glossary_term' = 'Segment Description (SDESC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `dual_eligible` SET TAGS ('pii_business_glossary_term' = 'Dual Eligible Status (DUAL_ELIG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `dual_eligible` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `dual_eligible` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `dual_eligible` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Segment Effective Date (SEG_EFF_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Segment End Date (SEG_END_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category Risk Score Tier (HCC_RSK_TIER)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('pii_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `is_current` SET TAGS ('pii_business_glossary_term' = 'Current Segment Indicator (CURR_IND)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_name` SET TAGS ('pii_business_glossary_term' = 'Segment Name (SNM)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Segment Notes (SEG_NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `notes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_business_glossary_term' = 'Risk Tier (RTIER)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_value_regex' = 'low|medium|high|catastrophic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `risk_tier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `sdoh_risk_score` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health Risk Score (SDOH_RS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `sdoh_risk_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `sdoh_risk_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_status` SET TAGS ('pii_business_glossary_term' = 'Segment Record Status (SEG_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segment_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segmentation_model_version` SET TAGS ('pii_business_glossary_term' = 'Segmentation Model Version (SEG_MODEL_VER)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segmentation_source` SET TAGS ('pii_business_glossary_term' = 'Segmentation Source (SEG_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `segmentation_source` SET TAGS ('pii_value_regex' = 'predictive|claims_based|care_manager_assigned');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `snp_eligibility` SET TAGS ('pii_business_glossary_term' = 'Special Needs Plan Eligibility (SNP_ELIG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `snp_eligibility` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `snp_eligibility` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `star_rating_cohort` SET TAGS ('pii_business_glossary_term' = 'Star Rating Cohort (STAR_COHORT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `star_rating_cohort` SET TAGS ('pii_value_regex' = '1_star|2_star|3_star|4_star|5_star');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPD_TSTMP)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_subdomain' = 'engagement_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_fhir_resource' = 'Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `id_card_id` SET TAGS ('pii_business_glossary_term' = 'ID Card ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('pii_business_glossary_term' = 'Card Barcode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('pii_barcode' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_format` SET TAGS ('pii_business_glossary_term' = 'Card Format');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_format` SET TAGS ('pii_value_regex' = 'physical|digital|mobile');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('pii_business_glossary_term' = 'Card Number (ID Card Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_type` SET TAGS ('pii_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_type` SET TAGS ('pii_value_regex' = 'medical|dental|vision|pharmacy|combined');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_version` SET TAGS ('pii_business_glossary_term' = 'Card Version Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Amount Displayed');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_business_glossary_term' = 'Customer Service Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('pii_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Card Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'mail|courier|in_person|digital_download|mobile_push');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Card Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `external_system_code` SET TAGS ('pii_business_glossary_term' = 'External System Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `external_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('pii_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('pii_group_number' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `id_card_status` SET TAGS ('pii_business_glossary_term' = 'Card Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `id_card_status` SET TAGS ('pii_value_regex' = 'active|replaced|lost|stolen|expired|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Is Primary Card Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Card Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('pii_value_regex' = 'en|es|fr|zh|vi|ar');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('pii_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('pii_language_preference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `magnetic_stripe_data` SET TAGS ('pii_business_glossary_term' = 'Magnetic Stripe Data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `magnetic_stripe_data` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `magnetic_stripe_data` SET TAGS ('pii_magnetic_stripe_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `magnetic_stripe_data` SET TAGS ('pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pcp_name` SET TAGS ('pii_business_glossary_term' = 'Primary Care Physician Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pcp_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pcp_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pcp_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_bin` SET TAGS ('pii_business_glossary_term' = 'Pharmacy BIN (Bank Identification Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_bin` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_bin` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_bin` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_group_number` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Group Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_group_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_group_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_group_number` SET TAGS ('pii_pharmacy_group_number' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_pcn` SET TAGS ('pii_business_glossary_term' = 'Pharmacy PCN (Processor Control Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_pcn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_pcn` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_pcn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `replacement_date` SET TAGS ('pii_business_glossary_term' = 'Card Replacement Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `replacement_reason` SET TAGS ('pii_business_glossary_term' = 'Card Replacement Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `replacement_reason` SET TAGS ('pii_value_regex' = 'damage|loss|theft|upgrade|member_request|expiration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` SET TAGS ('pii_subdomain' = 'engagement_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorized_representative_id` SET TAGS ('pii_business_glossary_term' = 'Authorized Representative Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorization_document_id` SET TAGS ('pii_business_glossary_term' = 'Authorization Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Audit User ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `audit_reason` SET TAGS ('pii_business_glossary_term' = 'Audit Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorization_end_date` SET TAGS ('pii_business_glossary_term' = 'Authorization End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorization_scope` SET TAGS ('pii_business_glossary_term' = 'Authorization Scope');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorization_scope` SET TAGS ('pii_value_regex' = 'appeal_only|grievance_only|all_actions');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorization_start_date` SET TAGS ('pii_business_glossary_term' = 'Authorization Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorization_status` SET TAGS ('pii_business_glossary_term' = 'Authorization Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorization_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorized_representative_status` SET TAGS ('pii_business_glossary_term' = 'Authorized Representative Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `authorized_representative_status` SET TAGS ('pii_value_regex' = 'active|inactive|revoked|expired');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `bar_number` SET TAGS ('pii_business_glossary_term' = 'Bar Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `bar_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `bar_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `bar_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `bar_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `bar_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `bar_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_address_line1` SET TAGS ('pii_business_glossary_term' = 'Contact Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_address_line1` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_address_line1` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_city` SET TAGS ('pii_business_glossary_term' = 'Contact City');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_city` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_country_code` SET TAGS ('pii_business_glossary_term' = 'Contact Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_country_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_country_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_country_code` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_country_code` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_country_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_postal_code` SET TAGS ('pii_business_glossary_term' = 'Contact Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_postal_code` SET TAGS ('pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_postal_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_state_code` SET TAGS ('pii_business_glossary_term' = 'Contact State Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_state_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `contact_state_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Authorization Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `effective_timestamp` SET TAGS ('pii_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `is_primary_representative` SET TAGS ('pii_business_glossary_term' = 'Primary Representative Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `license_state` SET TAGS ('pii_business_glossary_term' = 'License State');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `license_state` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `professional_license_number` SET TAGS ('pii_business_glossary_term' = 'Professional License Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `professional_license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `professional_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `professional_license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `professional_license_number` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `professional_license_number` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `professional_license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `relationship_to_member` SET TAGS ('pii_business_glossary_term' = 'Relationship to Member');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `relationship_to_member` SET TAGS ('pii_value_regex' = 'spouse|parent|child|legal_guardian|friend|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `relationship_to_member` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `relationship_to_member` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `representative_name` SET TAGS ('pii_business_glossary_term' = 'Authorized Representative Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `representative_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `representative_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `representative_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `representative_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `representative_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `representative_type` SET TAGS ('pii_business_glossary_term' = 'Authorized Representative Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `representative_type` SET TAGS ('pii_value_regex' = 'attorney|patient_advocate|family_power_of_attorney|provider_representative|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `revocation_date` SET TAGS ('pii_business_glossary_term' = 'Authorization Revocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `revocation_reason` SET TAGS ('pii_business_glossary_term' = 'Authorization Revocation Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `termination_timestamp` SET TAGS ('pii_business_glossary_term' = 'Termination Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorized_representative` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_subdomain' = 'reference_administration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_fhir_resource' = 'Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `parent_policy_id` SET TAGS ('pii_business_glossary_term' = 'Parent Policy Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `parent_policy_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `subscriber_id` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_limit_amount` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_limit_currency` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_limit_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Limit Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `deductible_currency` SET TAGS ('pii_business_glossary_term' = 'Deductible Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `out_of_pocket_max_amount` SET TAGS ('pii_business_glossary_term' = 'Out Of Pocket Max Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `out_of_pocket_max_currency` SET TAGS ('pii_business_glossary_term' = 'Out Of Pocket Max Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('pii_policy_number' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_status` SET TAGS ('pii_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_type` SET TAGS ('pii_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_currency` SET TAGS ('pii_business_glossary_term' = 'Premium Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_frequency` SET TAGS ('pii_business_glossary_term' = 'Premium Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_amount` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_currency` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_deductible_currency` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Deductible Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_out_of_pocket_max_amount` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Out Of Pocket Max Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_out_of_pocket_max_currency` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Out Of Pocket Max Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_premium_amount` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_premium_currency` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Premium Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `renewal_status` SET TAGS ('pii_business_glossary_term' = 'Policy Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Policy Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Policy Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` SET TAGS ('pii_subdomain' = 'reference_administration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` SET TAGS ('pii_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `authorization_document_id` SET TAGS ('pii_business_glossary_term' = 'Authorization Document Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `parent_authorization_document_id` SET TAGS ('pii_business_glossary_term' = 'Parent Authorization Document Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `parent_authorization_document_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `provider_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `provider_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `authorization_document_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `authorization_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `authorization_type` SET TAGS ('pii_business_glossary_term' = 'Authorization Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_address` SET TAGS ('pii_business_glossary_term' = 'Member Address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_address` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_address` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_dob` SET TAGS ('pii_business_glossary_term' = 'Member Dob');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_dob` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_dob` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_dob` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_dob` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_dob` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_email` SET TAGS ('pii_business_glossary_term' = 'Member Email');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_email` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_email` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_gender` SET TAGS ('pii_business_glossary_term' = 'Member Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_gender` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_gender` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_gender` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_gender` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_name` SET TAGS ('pii_business_glossary_term' = 'Member Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_phone` SET TAGS ('pii_business_glossary_term' = 'Member Phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_ssn` SET TAGS ('pii_business_glossary_term' = 'Member Ssn');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_ssn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_ssn` SET TAGS ('pii_national_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_ssn` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_ssn` SET TAGS ('pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_ssn` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_ssn` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `member_ssn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`authorization_document` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` SET TAGS ('pii_subdomain' = 'reference_administration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `assignment_rule_id` SET TAGS ('pii_business_glossary_term' = 'Assignment Rule Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `parent_assignment_rule_id` SET TAGS ('pii_business_glossary_term' = 'Parent Assignment Rule Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `parent_assignment_rule_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_action` SET TAGS ('pii_business_glossary_term' = 'Rule Action');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_category` SET TAGS ('pii_business_glossary_term' = 'Rule Category');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_criteria` SET TAGS ('pii_business_glossary_term' = 'Rule Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_description` SET TAGS ('pii_business_glossary_term' = 'Rule Description');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_expression` SET TAGS ('pii_business_glossary_term' = 'Rule Expression');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_immutable_date` SET TAGS ('pii_business_glossary_term' = 'Rule Immutable Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_immutable_reason` SET TAGS ('pii_business_glossary_term' = 'Rule Immutable Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_is_custom` SET TAGS ('pii_business_glossary_term' = 'Rule Is Custom');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_is_default` SET TAGS ('pii_business_glossary_term' = 'Rule Is Default');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_is_immutable` SET TAGS ('pii_business_glossary_term' = 'Rule Is Immutable');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_is_system` SET TAGS ('pii_business_glossary_term' = 'Rule Is System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Rule Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_logic` SET TAGS ('pii_business_glossary_term' = 'Rule Logic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_order` SET TAGS ('pii_business_glossary_term' = 'Rule Order');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_priority` SET TAGS ('pii_business_glossary_term' = 'Rule Priority');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_scope` SET TAGS ('pii_business_glossary_term' = 'Rule Scope');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_scope_description` SET TAGS ('pii_business_glossary_term' = 'Rule Scope Description');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_source_code` SET TAGS ('pii_business_glossary_term' = 'Rule Source Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_source_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_source_description` SET TAGS ('pii_business_glossary_term' = 'Rule Source Description');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_source_system` SET TAGS ('pii_business_glossary_term' = 'Rule Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_source_version` SET TAGS ('pii_business_glossary_term' = 'Rule Source Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_status` SET TAGS ('pii_business_glossary_term' = 'Rule Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_subtype` SET TAGS ('pii_business_glossary_term' = 'Rule Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_type` SET TAGS ('pii_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `rule_version` SET TAGS ('pii_business_glossary_term' = 'Rule Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`assignment_rule` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_subdomain' = 'coverage_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_fhir_resource' = 'Coverage.CoverageEligibilityResponse');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_table_name' = 'eligibility_span');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('pii_business_glossary_term' = 'Eligibility Span Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_subdomain' = 'coverage_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_fhir_resource' = 'EnrollmentRequest');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_ssot_source_domain' = 'member');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_table_name' = 'enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `member_enrollment2_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `member_enrollment2_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `coverage_level` SET TAGS ('pii_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `coverage_tier` SET TAGS ('pii_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `enrollment_type` SET TAGS ('pii_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `premium_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `premium_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `prior_coverage_indicator` SET TAGS ('pii_business_glossary_term' = 'Prior Coverage Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_subsidy_amount' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `subsidy_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_subdomain' = 'reference_administration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_ssot_source_domain' = 'member');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_ssot_duplicate_of' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_ssot_alias_of' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_ssot_canonical' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_ssot_master' = 'contract.contract_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_ssot_concept' = 'member_lifecycle_event');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `member_lifecycle_event_id` SET TAGS ('pii_business_glossary_term' = 'Member Lifecycle Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Initiated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID (Unique Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `contract_lifecycle_event2_id` SET TAGS ('pii_business_glossary_term' = 'Contract Contract Lifecycle Event Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `contract_lifecycle_event2_id` SET TAGS ('pii_ssot_canonical' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `credential_lifecycle_event_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `appeal_rights_notification_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Rights Notification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `chip_aging_out_flag` SET TAGS ('pii_business_glossary_term' = 'CHIP Aging‑Out Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `cms_reporting_indicator` SET TAGS ('pii_business_glossary_term' = 'CMS Reporting Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `cobra_qualifying_event_flag` SET TAGS ('pii_business_glossary_term' = 'COBRA Qualifying Event Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `disability_determination_flag` SET TAGS ('pii_business_glossary_term' = 'Disability Determination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `disability_determination_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `disability_determination_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `disenrollment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `disenrollment_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `disenrollment_request_date` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `disenrollment_source` SET TAGS ('pii_business_glossary_term' = 'Disenrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `documentation_received_flag` SET TAGS ('pii_business_glossary_term' = 'Documentation Received Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `event_description` SET TAGS ('pii_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `event_reason_code` SET TAGS ('pii_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `event_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `event_type_code` SET TAGS ('pii_business_glossary_term' = 'Event Type Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `event_type_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `incarceration_release_flag` SET TAGS ('pii_business_glossary_term' = 'Incarceration/Release Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `medicaid_eligibility_gain_flag` SET TAGS ('pii_business_glossary_term' = 'Medicaid Eligibility Gain Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `medicaid_eligibility_loss_flag` SET TAGS ('pii_business_glossary_term' = 'Medicaid Eligibility Loss Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `medicare_entitlement_flag` SET TAGS ('pii_business_glossary_term' = 'Medicare Entitlement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `member_lifecycle_event_status` SET TAGS ('pii_business_glossary_term' = 'Event Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `member_lifecycle_event_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `notice_sent_date` SET TAGS ('pii_business_glossary_term' = 'Notice Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `plan_termination_flag` SET TAGS ('pii_business_glossary_term' = 'Plan Termination Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `qualified_life_event_flag` SET TAGS ('pii_business_glossary_term' = 'Qualified Life Event Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `relocation_effective_date` SET TAGS ('pii_business_glossary_term' = 'Relocation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `relocation_state_code` SET TAGS ('pii_business_glossary_term' = 'Relocation State Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `relocation_state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `relocation_state_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `relocation_state_code` SET TAGS ('pii_relocation_state_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `special_enrollment_period_flag` SET TAGS ('pii_business_glossary_term' = 'Special Enrollment Period Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_lifecycle_event` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'pending|verified|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_subdomain' = 'engagement_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_fhir_resource' = 'Communication');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_ssot_source_domain' = 'member');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_ssot_master' = 'communication');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_ssot_canonical' = 'member.member_communication');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_ssot_concept' = 'member_communication');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `member_communication_id` SET TAGS ('pii_business_glossary_term' = 'Member Communication ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Communication Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Sent By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Member Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_value_regex' = 'ACKNOWLEDGED|NOT_ACKNOWLEDGED|PENDING');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `body` SET TAGS ('pii_business_glossary_term' = 'Communication Body');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `card_format` SET TAGS ('pii_business_glossary_term' = 'ID Card Format');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `card_format` SET TAGS ('pii_value_regex' = 'PHYSICAL|DIGITAL|MOBILE');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `card_status` SET TAGS ('pii_business_glossary_term' = 'ID Card Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `card_status` SET TAGS ('pii_value_regex' = 'ACTIVE|REPLACED|LOST_STOLEN|EXPIRED');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `card_type` SET TAGS ('pii_business_glossary_term' = 'ID Card Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `card_type` SET TAGS ('pii_value_regex' = 'MEDICAL|DENTAL|VISION|PHARMACY|COMBINED');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `channel` SET TAGS ('pii_value_regex' = 'MAIL|EMAIL|SMS|PHONE|PORTAL');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `communication_number` SET TAGS ('pii_business_glossary_term' = 'Communication Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `communication_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `communication_type` SET TAGS ('pii_business_glossary_term' = 'Communication Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `communication_type` SET TAGS ('pii_value_regex' = 'EOB|WELCOME_KIT|ID_CARD|ANOC|EOC|SBC');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copayment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_business_glossary_term' = 'Customer Service Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `customer_service_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `delivery_confirmation` SET TAGS ('pii_business_glossary_term' = 'Delivery Confirmation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `delivery_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `group_number` SET TAGS ('pii_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `group_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `group_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `group_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `language_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `language_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `language_code` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `member_communication_status` SET TAGS ('pii_business_glossary_term' = 'Communication Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `member_communication_status` SET TAGS ('pii_value_regex' = 'PENDING|SENT|DELIVERED|FAILED|BOUNCED|ACKNOWLEDGED');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `member_id_displayed` SET TAGS ('pii_business_glossary_term' = 'Member ID (Displayed)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `member_id_displayed` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `member_id_displayed` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `member_id_displayed` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `member_id_displayed` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `pharmacy_bin` SET TAGS ('pii_business_glossary_term' = 'Pharmacy BIN');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `pharmacy_group_number` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Group Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `pharmacy_group_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `pharmacy_group_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `pharmacy_group_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `pharmacy_pcn` SET TAGS ('pii_business_glossary_term' = 'Pharmacy PCN');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `regulatory_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `replacement_reason` SET TAGS ('pii_business_glossary_term' = 'Card Replacement Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `send_timestamp` SET TAGS ('pii_business_glossary_term' = 'Send Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `subject` SET TAGS ('pii_business_glossary_term' = 'Communication Subject');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `template_version` SET TAGS ('pii_business_glossary_term' = 'Template Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_communication` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_subdomain' = 'engagement_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_fhir_resource' = 'Communication');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_ssot_source_domain' = 'appeal');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_ssot_master' = 'grievance');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_ssot_role' = 'satellite');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_ssot_concept' = 'member_grievance');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `member_grievance2_id` SET TAGS ('pii_business_glossary_term' = 'Member Grievance Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `appeal_grievance2_id` SET TAGS ('pii_business_glossary_term' = 'Reference to SSOT master appeal.appeal_grievance');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `appeal_grievance2_id` SET TAGS ('pii_ssot_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `benefit_package_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Package Identifier (BP_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Investigator Identifier (INV_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier (PLAN_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member Identifier (MEM_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Grievance Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `cms_reportable_indicator` SET TAGS ('pii_business_glossary_term' = 'CMS Reportable Indicator (CMS_IND)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `disputed_amount` SET TAGS ('pii_business_glossary_term' = 'Disputed Amount (DIS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `grievance_number` SET TAGS ('pii_business_glossary_term' = 'Grievance Number (GRV_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `grievance_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `grievance_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `grievance_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `grievance_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `grievance_source` SET TAGS ('pii_business_glossary_term' = 'Grievance Source (GRV_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `grievance_source` SET TAGS ('pii_value_regex' = 'call_center|online_portal|mail|in_person');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `investigation_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Investigation End Timestamp (INV_END_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Investigation Start Timestamp (INV_START_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `issue_category_code` SET TAGS ('pii_business_glossary_term' = 'Issue Category Code (ISS_CAT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `issue_category_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business Code (LOB_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `member_grievance_status` SET TAGS ('pii_business_glossary_term' = 'Grievance Status (GRV_STS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `member_grievance_status` SET TAGS ('pii_value_regex' = 'open|in_review|resolved|closed|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `member_satisfaction_score` SET TAGS ('pii_business_glossary_term' = 'Member Satisfaction Score (SAT_SCORE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Grievance Received Timestamp (GRV_RCV_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reporting Flag (REG_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date (RES_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `resolution_description` SET TAGS ('pii_business_glossary_term' = 'Resolution Description (RES_DESC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `resolution_type_code` SET TAGS ('pii_business_glossary_term' = 'Resolution Type Code (RES_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `resolution_type_code` SET TAGS ('pii_value_regex' = 'corrective_action|explanation|refund|no_action|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `resolution_type_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code (ST_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_state_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `type_code` SET TAGS ('pii_business_glossary_term' = 'Grievance Type Code (GRV_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `type_code` SET TAGS ('pii_value_regex' = 'quality_of_care|access|attitude|billing|benefit');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `type_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance` SET TAGS ('pii_subdomain' = 'engagement_tracking');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_grievance` ALTER COLUMN `member_grievance_id` SET TAGS ('pii_business_glossary_term' = 'member_grievance Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` SET TAGS ('pii_subdomain' = 'coverage_enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`member_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'member_enrollment Identifier');
