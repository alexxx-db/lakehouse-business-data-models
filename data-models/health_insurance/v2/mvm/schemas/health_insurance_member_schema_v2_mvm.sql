-- Schema for Domain: member | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`member` COMMENT 'Single source of truth for all insured individuals — members, subscribers, dependents, and beneficiaries across commercial, Medicare, Medicaid, and CHIP lines of business. Owns member demographics, PII/PHI identity, eligibility status, LOB assignment, COBRA continuants, household relationships, and member lifecycle events. All other domains reference member identity via FK. Supports HIPAA privacy obligations and CMS enrollment reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`subscriber` (
    `subscriber_id` BIGINT COMMENT 'Primary key for subscriber',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Subscriber enrollment processing, premium billing, and benefit verification all require knowing the subscribers active benefit_package. Open enrollment and plan selection workflows depend on this lin',
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
    `address_id` BIGINT COMMENT 'Foreign key linking to member.member_address. Business justification: dependent has inline address fields (address_line1, address_line2, city, state, postal_code, country) that duplicate the authoritative member_address table. Adding member_address_id FK normalizes depe',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Dependents may be enrolled under a different benefit package than the subscriber (e.g., child-only plans, CHIP packages). Claims adjudication and eligibility verification for dependents require knowin',
    `contact_id` BIGINT COMMENT 'Foreign key linking to member.member_contact. Business justification: dependent has inline phone_number and email_address fields that duplicate the authoritative member_contact table. Adding member_contact_id FK normalizes dependent contact data to the single source of ',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Dependents have independent PCP assignments separate from the subscriber in health insurance operations. Care coordination, HEDIS reporting, and PCP panel management all require knowing each dependent',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: A dependent is covered under a specific policy. While policy already FKs to subscriber, the dependents coverage is under a specific policy instance (which may differ from the subscribers primary pol',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary member (subscriber) to whom this dependent is attached.',
    `age_out_eligibility_flag` BOOLEAN COMMENT 'True if the dependent is eligible for age-out coverage under plan rules.',
    `chip_eligibility_flag` BOOLEAN COMMENT 'Indicates eligibility for the Childrens Health Insurance Program.',
    `coverage_end_date` DATE COMMENT 'Date when dependents coverage terminated or is scheduled to end.',
    `coverage_start_date` DATE COMMENT 'Date when dependents coverage became effective.',
    `coverage_status` STRING COMMENT 'Current status of the dependents coverage.. Valid values are `active|inactive|terminated|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dependent record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data-quality score for ECM scoring.',
    `date_of_birth` DATE COMMENT 'Birth date of the dependent.',
    `disability_status` BOOLEAN COMMENT 'Indicates if the dependent has a documented disability.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
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
    `student_status` BOOLEAN COMMENT 'Indicates if the dependent is currently a student (True) or not (False).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dependent record.',
    CONSTRAINT pk_dependent PRIMARY KEY(`dependent_id`)
) COMMENT 'Master entity representing individuals covered under a subscribers health plan — spouses, domestic partners, children, and other qualifying dependents. Tracks relationship type to subscriber, dependent sequence number, student status, disability status, age-out eligibility rules, and CHIP/Medicaid eligibility indicators. Maintains its own demographic profile including DOB, gender, SSN, and language preference. Supports dependent verification workflows, age-out processing, and CMS CHIP enrollment reporting. Each dependent record is linked to a subscriber and an enrollment span.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`identity` (
    `identity_id` BIGINT COMMENT 'Primary key for identity',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Business process: Billing Account Management – each member identity must be linked to a billing account for premium collection, payment processing, and regulatory reporting.',
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
    CONSTRAINT pk_identity PRIMARY KEY(`identity_id`)
) COMMENT 'Authoritative identity resolution record for each unique insured individual (subscriber or dependent) assigned a unique member ID by the health plan. Stores the plan-assigned member ID (MBI for Medicare, Medicaid ID, commercial member ID), cross-reference IDs from source systems (Facets member ID, QNXT ID), alternate IDs (SSN hash, external subscriber ID from employer), and identity verification status. Manages member ID history and superseded IDs. This is the enterprise golden record for member identity used by all downstream domains (claims, pharmacy, care management) to resolve member identity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`address` (
    `address_id` BIGINT COMMENT 'Surrogate primary key for the address record.',
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
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Manages all physical and mailing addresses associated with a member, including home address, mailing address, temporary address, and employer address. Tracks address type, effective and termination dates, address verification status (USPS CASS-certified), county FIPS code, census tract, and geographic coordinates for network adequacy analysis. Supports multiple concurrent addresses with priority ranking. Used for premium billing, EOB mailing, provider directory access, and CMS geographic reporting. Maintains address history for audit and compliance purposes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`contact` (
    `contact_id` BIGINT COMMENT 'System-generated unique identifier for each contact record associated with a member.',
    `subscriber_id` BIGINT COMMENT 'add column subscriber_id (BIGINT) with FK to member.subscriber.subscriber_id - member contacts must link to the subscriber they belong to',
    `contact_subscriber_id` BIGINT COMMENT '',
    `primary_member_subscriber_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
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
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `relationship` STRING COMMENT 'Relationship of the contact to the member.. Valid values are `self|spouse|child|parent|guardian|other`',
    `state_province` STRING COMMENT 'State or province component of the address.',
    `tcp_a_consent_flag` BOOLEAN COMMENT 'True if the contact has provided consent under the Telephone Consumer Protection Act.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the contact record.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Single source of truth for all member contact information and addresses. Manages physical and mailing addresses (home, mailing, temporary, employer), phone numbers (home, mobile, work), email addresses, and fax numbers. Tracks contact type, address type, effective and termination dates, address verification status (USPS CASS-certified), county FIPS code, census tract, geographic coordinates for network adequacy analysis, opt-in/opt-out status per channel (SMS, email, robocall), TCPA consent flags, and preferred contact method and language. Supports multiple concurrent addresses with priority ranking. Used for premium billing, EOB mailing, provider directory access, CMS geographic reporting, member services outreach, care management communications, and CAHPS survey administration. Maintains full address and contact history for audit and compliance purposes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` (
    `lob_assignment_id` BIGINT COMMENT 'Surrogate primary key for each LOB assignment record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: LOB assignments map members to specific benefit packages within a line of business. CMS risk adjustment, care management eligibility, and SNP qualification all require this link. plan_benefit_package_',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom this LOB assignment applies.',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: LOB assignment drives care management program eligibility — Medicare SNP, Medicaid, and CHIP LOBs each map to specific programs. Health plan operations teams use this link to auto-enroll members in LO',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` (
    `pcp_assignment_id` BIGINT COMMENT 'Primary key for pcp_assignment',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: PCP assignments are benefit-package-specific — HMO packages require PCP assignment while PPO packages may not. Network adequacy reporting, care coordination, and auto-assignment logic all require know',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom the PCP is assigned.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: PCP assignment records must reference the provider entity to support network participation audits and accurate provider‑member linkage.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: PCP assignments are made in the context of a specific policy enrollment — a member enrolled in an HMO policy requires a PCP assignment for that policy. pcp_assignment currently links to subscriber, pr',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: A PCP may practice at multiple locations; the assignment must specify which location the member is assigned to for care coordination, network adequacy reporting, and directory accuracy. This is a stan',
    `provider_assignment_id` BIGINT COMMENT 'Foreign key linking to network.provider_assignment. Business justification: A members PCP selection must reference the providers active network participation record to validate panel capacity, credentialing status, and accepting-new-patients flag. Panel management, network ',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which the PCP belongs.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: PCP assignments are tier-specific — the tier governs member cost-sharing (copay differentials, prior auth requirements) for PCP visits and drives member steerage programs. Benefits administration and ',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` (
    `disenrollment_id` BIGINT COMMENT 'Primary key for disenrollment',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who is being disenrolled.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: A disenrollment event represents the formal termination of a members coverage under a specific policy. disenrollment currently links to subscriber and health_plan but has no direct policy_id FK. Addi',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan the member was enrolled in before disenrollment.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`id_card` (
    `id_card_id` BIGINT COMMENT 'Surrogate primary key for the ID card record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: ID cards are generated per benefit_package — copay amounts, pharmacy BIN/PCN, and network tier printed on the card are benefit-package-specific. ID card generation, reprinting workflows, and member po',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: ID cards are issued per health plan; linking enables tracking issuance per plan for regulatory reporting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the card is issued.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: ID card generation requires direct provider reference to print PCP name and contact details. The existing pcp_name column is a denormalized representation of the provider entity. Health insurance ID c',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: A member ID card represents proof of coverage under a specific policy. id_card currently links to identity and health_plan but has no direct policy_id FK. Adding policy_id ties each card issuance to t',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: ID cards must display the PCPs office address and phone number. practice_location holds the specific office address, hours, and contact info needed for card printing. This is a distinct operational n',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`policy` (
    `policy_id` BIGINT COMMENT 'Primary key for policy',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Policy enrollment, claims adjudication, and EOB generation all require knowing which benefit_package governs a members covered services and cost-sharing. A health insurance domain expert expects ever',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: A health insurance policy is associated with a specific formulary for the benefit year. During claim adjudication, PA processing, and member drug coverage inquiries, the system must identify which for',
    `health_plan_id` BIGINT COMMENT 'Reference to the plan or product associated with the policy.',
    `identity_id` BIGINT COMMENT 'Reference to the insured member associated with the policy.',
    `parent_policy_id` BIGINT COMMENT 'Self-referencing FK on policy (parent_policy_id)',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: A member policy is issued under a specific provider network governing in-network benefits, claims adjudication, and ID card generation. Benefits administrators and claims systems must resolve which ne',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: A policys premium is determined by the applicable rate record (age-rated, tobacco-surcharge, family-tier). Premium billing, rate reconciliation, ACA rate filing compliance, and renewal processing all',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` (
    `eligibility_span_id` BIGINT COMMENT 'Primary key for eligibility_span',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Eligibility verification and claims adjudication require knowing which benefit_package is active for a given eligibility span. Real-time eligibility (270/271 transactions) and CMS eligibility reportin',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: An eligibility span defines the period during which a member is eligible for benefits under a specific policy. member_eligibility_span currently only has subscriber_id, making it impossible to determi',
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
    CONSTRAINT pk_eligibility_span PRIMARY KEY(`eligibility_span_id`)
) COMMENT 'Eligibility Span entity for member domain';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`address`(`address_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`contact`(`contact_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ADD CONSTRAINT `fk_member_address_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ADD CONSTRAINT `fk_member_contact_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ADD CONSTRAINT `fk_member_contact_contact_subscriber_id` FOREIGN KEY (`contact_subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ADD CONSTRAINT `fk_member_contact_primary_member_subscriber_id` FOREIGN KEY (`primary_member_subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ADD CONSTRAINT `fk_member_lob_assignment_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ADD CONSTRAINT `fk_member_id_card_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`identity`(`identity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_parent_policy_id` FOREIGN KEY (`parent_policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ADD CONSTRAINT `fk_member_eligibility_span_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`policy`(`policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ADD CONSTRAINT `fk_member_eligibility_span_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_health_insurance_v1`.`member`.`subscriber`(`subscriber_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`member` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`member` SET TAGS ('dbx_domain' = 'member');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Coordinator Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_business_glossary_term' = 'Annual Income');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_business_glossary_term' = 'CHIP Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_natural_key_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|non_resident|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `consent_to_electronic_communication` SET TAGS ('dbx_business_glossary_term' = 'Electronic Communication Consent');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp|hsa');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_fhir_element' = 'birthDate');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'yes|no|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'online|call_center|agent|mail|broker');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_business_glossary_term' = 'Deceased Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_fhir_element' = 'deceasedBoolean');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_language_preference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (Family Name)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|chip|group|individual');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_fhir_element' = 'maritalStatus');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_pii_government_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|portal');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Race/Ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_value_regex' = 'white|black|asian|hispanic|native_american|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_fhir_element_extension' = 'us-core-race');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^(d{3}-d{2}-d{4})$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_ssn' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Number (Policy Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('dbx_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('dbx_pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('dbx_fhir_element' = 'active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Use Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_value_regex' = 'current|former|never|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_pii_tobacco_use_status' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_veteran_status' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Member Address Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Member Contact Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Member Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `age_out_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Age-Out Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `chip_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'CHIP Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Dependent Date of Birth (DOB)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_fhir_element' = 'birthDate');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent First Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Dependent Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `medicaid_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|archived');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Dependent Relationship Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'spouse|domestic_partner|child|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Dependent Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `sequence_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^d{3}-d{2}-d{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_ssn' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `student_status` SET TAGS ('dbx_business_glossary_term' = 'Student Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `student_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `student_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`dependent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Assigned Member Identifier (Member ID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Member Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('dbx_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line1` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Member Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('dbx_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `address_line2` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Member Citizenship Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'citizen|non_citizen|permanent_resident|temporary_resident|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Member City');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('dbx_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('dbx_pii_city' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Member Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('dbx_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('dbx_pii_country' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Member Date of Birth');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_fhir_element' = 'birthDate');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Member Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Member Ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_fhir_element_extension' = 'us-core-ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('dbx_business_glossary_term' = 'External Subscriber Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('dbx_pii_external_subscriber_number' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Member First Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Member Full Legal Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_fhir_element' = 'name.text');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Member Gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Member Preferred Language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('dbx_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_language_preference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Member Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|chip|group');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Member Marital Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|unknown');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_fhir_element' = 'maritalStatus');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('dbx_business_glossary_term' = 'Member Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('dbx_fhir_element' = 'active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_type` SET TAGS ('dbx_business_glossary_term' = 'Member Type (Subscriber or Dependent)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `member_type` SET TAGS ('dbx_value_regex' = 'subscriber|dependent|spouse|child|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Member Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Member Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Member Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|portal');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('dbx_business_glossary_term' = 'Member Race');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('dbx_fhir_element_extension' = 'us-core-race');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Subscriber');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number Hash');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_pii_tax_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_pii_ssn' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Member State');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('dbx_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('dbx_pii_state' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`identity` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|pending|verified|failed');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Member Address ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|mailing|temporary|employer|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_value_regex' = '^d{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Address Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_business_glossary_term' = 'County FIPS Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_value_regex' = '^d{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External Address ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `external_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `geocode_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy (Meters)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Address');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Street Address)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Apartment/Suite)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line4` SET TAGS ('dbx_business_glossary_term' = 'Address Line 4');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `line4` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code (Postal Code)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code (US Postal)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Member Contact Identifier (MCID)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `primary_member_subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_business_glossary_term' = 'CASS Certified Flag (CASS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Date (AED)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy (GEO_ACC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_business_glossary_term' = 'Geocode Source (GEO_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_value_regex' = 'USPS|Google|HERE|Other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Address Priority Rank (APR)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_business_glossary_term' = 'Address Source System (ASS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_value_regex' = 'Facets|QNXT|CRM|Other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Address Termination Date (ATD)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type (AT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|mailing|temporary|employer|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_type` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status (AVS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract (CT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `census_tract` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_census_tract' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `census_tract` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type (CT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'member|dependent|beneficiary|employer|provider|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (CC)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_country_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `county_fips` SET TAGS ('dbx_business_glossary_term' = 'County FIPS Code (FIPS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `county_fips` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `county_fips` SET TAGS ('dbx_pii_county_fips' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `county_fips` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `county_fips` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number (FAX)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier Type (CID_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_type` SET TAGS ('dbx_value_regex' = 'NPI|SSN|MemberID|Other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_value` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier Value (CID_VAL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `id_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag (PRIMARY)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_language_preference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp (LVT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `member_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (CSTAT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `member_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name (CFN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes (CNOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Opt‑In Flag (EMAIL_OPT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_robocall` SET TAGS ('dbx_business_glossary_term' = 'Robocall Opt‑In Flag (RC_OPT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Opt‑In Flag (SMS_OPT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_business_glossary_term' = 'Home Phone Number (HPN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number (MPN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number (WPN)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_postal_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method (PCM)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|sms');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `relationship` SET TAGS ('dbx_business_glossary_term' = 'Contact Relationship (CREL)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `relationship` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|guardian|other');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `relationship` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `relationship` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `relationship` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province (ST)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `tcp_a_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'TCPA Consent Flag (TCPA)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Line of Business Assignment ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `care_management_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Management Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_business_glossary_term' = 'CMS Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `cms_region` SET TAGS ('dbx_business_glossary_term' = 'CMS Region');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `cms_region` SET TAGS ('dbx_value_regex' = 'NORTHEAST|MIDWEST|SOUTH|WEST');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `dual_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `dual_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `dual_eligible_flag` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('dbx_business_glossary_term' = 'HCC Risk Score Tier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `hcc_risk_score_tier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'LOB Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `lob_description` SET TAGS ('dbx_business_glossary_term' = 'Line of Business Description');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `rising_risk_indicator` SET TAGS ('dbx_business_glossary_term' = 'Rising Risk Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CATASTROPHIC');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `sdoh_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `segmentation_model_version` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `segmentation_source` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Source');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `segmentation_source` SET TAGS ('dbx_value_regex' = 'PREDICTIVE|CLAIMS|CARE_MANAGER');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('dbx_business_glossary_term' = 'SNP Qualifying Condition');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_qualifying_condition` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('dbx_business_glossary_term' = 'Special Needs Plan (SNP) Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('dbx_value_regex' = 'D-SNP|C-SNP|F-SNP|I-SNP');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `snp_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `star_rating_cohort` SET TAGS ('dbx_business_glossary_term' = 'STAR Rating Cohort');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `star_rating_cohort` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_state_code' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`lob_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `pcp_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Assignment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID (Member Identifier)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Assignment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Assignment Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'member_selected|auto_assigned|plan_assigned');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'PCP Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PCP Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Assignment Start Date)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Current Assignment Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary PCP Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'in_panel|out_of_panel|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `pcp_specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Code (CPT/HCPCS)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `pcp_specialty_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Assignment End Date)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`pcp_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `appeal_rights_notified` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Notified');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `cobro_eligibility` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `disenrollment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cancelled|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Effective Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `eligibility_loss_indicator` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Loss Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Notice Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `processed_by` SET TAGS ('dbx_business_glossary_term' = 'Processed By');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'voluntary|non_payment|eligibility_loss|plan_termination|death|fraud');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Gross Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `refund_net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'member|employer|cms|state_medicaid|provider');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|death|fraud|relocation|plan_termination');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`disenrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `id_card_id` SET TAGS ('dbx_business_glossary_term' = 'ID Card ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Card Barcode');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('dbx_pii_barcode' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `barcode` SET TAGS ('dbx_pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_format` SET TAGS ('dbx_business_glossary_term' = 'Card Format');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_format` SET TAGS ('dbx_value_regex' = 'physical|digital|mobile');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('dbx_business_glossary_term' = 'Card Number (ID Card Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_number` SET TAGS ('dbx_pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|combined');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `card_version` SET TAGS ('dbx_business_glossary_term' = 'Card Version Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount Displayed');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Card Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|courier|in_person|digital_download|mobile_push');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Card Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `external_system_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('dbx_pii_group_number' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `group_number` SET TAGS ('dbx_pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `id_card_status` SET TAGS ('dbx_business_glossary_term' = 'Card Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `id_card_status` SET TAGS ('dbx_value_regex' = 'active|replaced|lost|stolen|expired|pending');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Card Flag');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Card Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|vi|ar');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_fhir_element' = 'communication.language');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_language_preference' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `magnetic_stripe_data` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Stripe Data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `magnetic_stripe_data` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `magnetic_stripe_data` SET TAGS ('dbx_pii_magnetic_stripe_data' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `magnetic_stripe_data` SET TAGS ('dbx_pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_bin` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy BIN (Bank Identification Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_bin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_bin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_bin` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_group_number` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Group Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_group_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_group_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_group_number` SET TAGS ('dbx_pii_pharmacy_group_number' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_pcn` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy PCN (Processor Control Number)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_pcn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_pcn` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `pharmacy_pcn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Card Replacement Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `replacement_reason` SET TAGS ('dbx_business_glossary_term' = 'Card Replacement Reason');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `replacement_reason` SET TAGS ('dbx_value_regex' = 'damage|loss|theft|upgrade|member_request|expiration');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`id_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `parent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Policy Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `parent_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `deductible_currency` SET TAGS ('dbx_business_glossary_term' = 'Deductible Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `out_of_pocket_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Out Of Pocket Max Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `out_of_pocket_max_currency` SET TAGS ('dbx_business_glossary_term' = 'Out Of Pocket Max Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_pii_policy_number' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_pii_member_id' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
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
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `master_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`member`.`eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
