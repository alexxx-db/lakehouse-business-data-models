-- Schema for Domain: provider | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`provider` COMMENT 'Authoritative domain for all healthcare providers — physicians, hospitals, clinics, ancillary providers, facilities, and DME suppliers. Owns NPI-based provider identity, specialty taxonomy codes, licensure, practice locations, participation status, and provider directory information. Supports provider directory accuracy mandates (CMS, NCQA) and serves as the SSOT for provider identity. Source system: Cactus or ProviderSource.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`specialty` (
    `specialty_id` BIGINT COMMENT 'Primary key for specialty',
    `provider_id` BIGINT COMMENT 'Reference to the healthcare provider who holds this specialty designation. Links to the provider master entity.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients for this specialty. True if accepting; False if panel is closed. Used for provider directory accuracy.',
    `board_certified_flag` BOOLEAN COMMENT 'Indicates whether the provider is board certified in this specialty. True if certified by a recognized medical board; False otherwise.',
    `specialty_category` STRING COMMENT 'High-level grouping of the specialty into major healthcare service categories for network adequacy and reporting purposes. [ENUM-REF-CANDIDATE: allopathic_osteopathic|dental|behavioral_health|chiropractic|podiatric|nursing|pharmacy|ancillary — 8 candidates stripped; promote to reference product]',
    `certification_date` DATE COMMENT 'The date on which the provider was initially certified by the board in this specialty. Format: yyyy-MM-dd.',
    `certification_expiration_date` DATE COMMENT 'The date on which the board certification expires and requires renewal. Null if certification does not expire or is lifetime. Format: yyyy-MM-dd.',
    `certification_number` STRING COMMENT 'The unique certification number or identifier issued by the certifying board for this specialty. Used for verification purposes.',
    `certifying_board_name` STRING COMMENT 'The name of the medical board or certifying organization that granted board certification for this specialty (e.g., American Board of Internal Medicine, American Board of Surgery). Null if not board certified.',
    `specialty_code` STRING COMMENT 'The National Uniform Claim Committee (NUCC) Health Care Provider Taxonomy Code representing the providers specialty classification. Ten-digit alphanumeric code with an X in the 11th position.. Valid values are `^[0-9]{10}X$`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credentialing_effective_date` DATE COMMENT 'The date on which the providers credentialing for this specialty became effective within the health plans network. Format: yyyy-MM-dd.',
    `credentialing_end_date` DATE COMMENT 'The date on which the providers credentialing for this specialty ended or will end. Null if currently active with no planned end date. Format: yyyy-MM-dd.',
    `credentialing_review_date` DATE COMMENT 'The date of the most recent credentialing review or recredentialing for this specialty. NCQA requires recredentialing at least every three years. Format: yyyy-MM-dd.',
    `credentialing_status` STRING COMMENT 'The current credentialing status of the provider for this specific specialty within the health plans network. Active indicates the provider is credentialed and authorized to provide services in this specialty.. Valid values are `active|inactive|pending|suspended|expired|revoked`',
    `current_record_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the specialty record. True for the current record; False for historical versions. Supports slowly changing dimension (SCD) Type 2 historization.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'The date on which the provider stopped practicing in this specialty, if applicable. Null if the provider is still actively practicing in this specialty. Format: yyyy-MM-dd.',
    `fellowship_completed_flag` BOOLEAN COMMENT 'Indicates whether the provider completed a fellowship program in this specialty or subspecialty. True if fellowship training was completed; False otherwise.',
    `fellowship_completion_date` DATE COMMENT 'The date on which the provider completed the fellowship program. Format: yyyy-MM-dd. Null if no fellowship was completed.',
    `fellowship_program_name` STRING COMMENT 'The name of the fellowship program and institution where the provider completed subspecialty training. Null if no fellowship was completed.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PractitionerRole.specialty)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hedis_specialty_flag` BOOLEAN COMMENT 'Indicates whether this specialty is relevant for HEDIS measure attribution and quality reporting. True if the specialty is used in HEDIS measure calculations; False otherwise.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `specialty_name` STRING COMMENT 'The human-readable name of the specialty (e.g., Cardiology, Orthopedic Surgery, Family Medicine). Corresponds to the specialty taxonomy code.',
    `network_adequacy_category` STRING COMMENT 'The network adequacy category or specialty grouping used for regulatory reporting and network adequacy analysis. Maps specialty to state-specific or CMS network adequacy standards.',
    `next_credentialing_review_date` DATE COMMENT 'The scheduled date for the next credentialing review or recredentialing for this specialty. Used for compliance tracking and proactive credentialing management. Format: yyyy-MM-dd.',
    `pcp_eligible_flag` BOOLEAN COMMENT 'Indicates whether this specialty qualifies the provider to serve as a Primary Care Provider (PCP) for member assignment. True for specialties such as Family Medicine, Internal Medicine, Pediatrics, and General Practice.',
    `primary_specialty_flag` BOOLEAN COMMENT 'Identifies the providers primary specialty.',
    `recertification_cycle_years` STRING COMMENT 'The number of years in the recertification cycle (e.g., 10 years for most ABMS boards). Null if recertification is not required.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the board certification requires periodic recertification or maintenance of certification (MOC). True if recertification is required; False if lifetime certification.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this specialty record was first created in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `record_effective_date` DATE COMMENT 'The date from which this version of the specialty record is effective for business purposes. Supports slowly changing dimension (SCD) Type 2 historization. Format: yyyy-MM-dd.',
    `record_end_date` DATE COMMENT 'The date on which this version of the specialty record ceased to be effective. Null for the current active record. Supports slowly changing dimension (SCD) Type 2 historization. Format: yyyy-MM-dd.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this specialty record was last updated in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_system_code` STRING COMMENT 'The unique identifier for this specialty record in the source system. Used for data lineage, reconciliation, and troubleshooting.',
    `specialist_referral_required_flag` BOOLEAN COMMENT 'Indicates whether members require a referral from their PCP to see this provider in this specialty, based on plan type (e.g., HMO requires referrals; PPO typically does not). True if referral is required; False otherwise.',
    `specialty_type` STRING COMMENT 'Indicates whether this is the providers primary specialty, secondary specialty, or tertiary specialty. Primary specialty is the main area of practice; secondary and tertiary are additional areas of expertise.. Valid values are `primary|secondary|tertiary`',
    `start_date` DATE COMMENT 'The date on which the provider began practicing in this specialty. Used to calculate years of experience and for credentialing verification. Format: yyyy-MM-dd.',
    `subspecialty_code` STRING COMMENT 'Additional NUCC taxonomy code representing a subspecialty within the primary specialty (e.g., Interventional Cardiology within Cardiology). Null if no subspecialty designation.',
    `subspecialty_name` STRING COMMENT 'The human-readable name of the subspecialty, if applicable. Provides additional granularity beyond the primary specialty for network adequacy and member search.',
    `taxonomy_code` STRING COMMENT 'Provider taxonomy code; reference attribute, not a contract artifact.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether the provider offers telehealth or telemedicine services for this specialty. True if telehealth services are available; False otherwise. Important for provider directory accuracy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `years_in_specialty` STRING COMMENT 'The number of years the provider has been practicing in this specialty. Calculated from the date the provider first began practicing in this specialty area.',
    CONSTRAINT pk_specialty PRIMARY KEY(`specialty_id`)
) COMMENT 'Tracks all specialty and sub-specialty designations for a provider, including primary and secondary specialties, NUCC taxonomy codes, board certification details, certification body, certification date, expiration date, and specialty-level credentialing status. A provider may hold multiple specialties across different taxonomies. Supports network adequacy analysis by specialty and HEDIS measure attribution.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` (
    `practice_location_id` BIGINT COMMENT 'Unique identifier for the practice location. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for location‑level expense budgeting and cost allocation reports required by finance for each practice site.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each practice location has a site manager employee responsible for daily operations, patient flow, and regulatory compliance.',
    `provider_id` BIGINT COMMENT 'State-specific Medicaid provider identifier for this practice location. Required for Medicaid claims submission.',
    `practice_medicare_enrolled_provider_id` BIGINT COMMENT 'Medicare provider identifier (PTAN or legacy OSCAR number) for this practice location. Required for Medicare Advantage claims.',
    `primary_provider_id` BIGINT COMMENT 'Reference to the primary provider associated with this practice location. A provider may have multiple practice locations.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether this practice location is currently accepting new patients. Critical for member provider search and network adequacy.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the practice location meets ADA accessibility requirements.',
    `address_line_1` STRING COMMENT 'Primary street address of the practice location (street number and name).',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, building, or unit number.',
    `city` STRING COMMENT 'City name of the practice location.',
    `county_name` STRING COMMENT 'County name where the practice location is situated. Used for network adequacy geographic access analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this practice location record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `directory_display_flag` BOOLEAN COMMENT 'Indicates whether this practice location should be displayed in the member-facing provider directory. May be false even if active (e.g., administrative locations).',
    `effective_date` DATE COMMENT 'Date when this practice location became active in the provider network.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `email_address` STRING COMMENT 'Primary email contact for the practice location for administrative and member communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the practice location used for prior authorization and medical records transmission.. Valid values are `^[0-9]{10}$`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Location)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fips_code` STRING COMMENT '5-digit FIPS county code for geographic identification and network adequacy reporting.. Valid values are `^[0-9]{5}$`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages spoken by staff at this practice location (e.g., English, Spanish, Mandarin). Supports member language access requirements.',
    `last_verified_date` DATE COMMENT 'Date when the practice location information was last verified for accuracy. CMS requires quarterly verification for provider directory data.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the practice location in decimal degrees. Used for time/distance network adequacy calculations.',
    `location_name` STRING COMMENT 'Business name or designation of the practice location (e.g., Main Street Family Medicine, Downtown Urgent Care Center).',
    `location_type` STRING COMMENT 'Classification of the practice location type indicating the care delivery setting.. Valid values are `office|hospital|clinic|urgent_care|telehealth_only|ambulatory_surgery_center`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the practice location in decimal degrees. Used for time/distance network adequacy calculations.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_group_name` STRING COMMENT 'Name of the medical group or practice organization that operates this location. Used for provider directory grouping and network reporting.',
    `npi` STRING COMMENT '10-digit National Provider Identifier for this practice location if it has a Type 2 (organizational) NPI. May be null if location uses only the providers individual NPI.. Valid values are `^[0-9]{10}$`',
    `office_hours` STRING COMMENT 'Operating hours of the practice location (e.g., Mon-Fri 8:00 AM - 5:00 PM, Sat 9:00 AM - 1:00 PM). Free-text field for member-facing display.',
    `parking_available_flag` BOOLEAN COMMENT 'Indicates whether on-site or nearby parking is available for patients.',
    `participation_status` STRING COMMENT 'Current participation status of this practice location in the provider network. Determines whether location appears in member-facing provider directory.. Valid values are `active|inactive|suspended|terminated|pending_credentialing`',
    `patient_age_maximum` STRING COMMENT 'Maximum patient age accepted at this practice location (e.g., 18 for pediatrics only). Null if no maximum restriction.',
    `patient_age_minimum` STRING COMMENT 'Minimum patient age accepted at this practice location (e.g., 0 for all ages, 18 for adults only). Null if no minimum restriction.',
    `patient_gender_restriction` STRING COMMENT 'Gender restriction for patients served at this location (e.g., female_only for womens health clinics).. Valid values are `all|male_only|female_only`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the practice location (10-digit format without formatting).. Valid values are `^[0-9]{10}$`',
    `public_transportation_access_flag` BOOLEAN COMMENT 'Indicates whether the practice location is accessible via public transportation.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Current status of this practice location record in the data warehouse. Supports soft-delete and historical tracking.. Valid values are `active|inactive|deleted|archived`',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `state_code` STRING COMMENT 'Two-letter state abbreviation (e.g., CA, NY, TX).. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'Federal Tax Identification Number (EIN) for the practice location or medical group. Used for claims payment and 1099 reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `telehealth_available_flag` BOOLEAN COMMENT 'Indicates whether telehealth services are available at this practice location.',
    `termination_date` DATE COMMENT 'Date when this practice location was terminated from the provider network. Null if currently active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this practice location record was last modified.',
    `verification_method` STRING COMMENT 'Method used for the most recent verification of practice location information.. Valid values are `phone_verification|site_visit|provider_attestation|electronic_verification`',
    `wheelchair_accessible_flag` BOOLEAN COMMENT 'Indicates whether the practice location has wheelchair accessibility features (ramps, elevators, accessible restrooms).',
    `zip_code` STRING COMMENT '5-digit or ZIP+4 postal code for the practice location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_practice_location PRIMARY KEY(`practice_location_id`)
) COMMENT 'Represents a physical or virtual practice location where a provider delivers care. Captures address (street, city, state, ZIP+4), county, FIPS code, geolocation (lat/long), phone, fax, office hours, accessibility features (ADA compliance, wheelchair access), telehealth availability, accepting new patients flag by location, patient age/population restrictions, and location type (office, hospital, urgent care, telehealth-only). Supports CMS provider directory accuracy requirements, network adequacy geographic access standards (time/distance), and member-facing provider search. A provider may have multiple practice locations; each location may serve multiple providers.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`license` (
    `license_id` BIGINT COMMENT 'Primary key for license',
    `provider_id` BIGINT COMMENT 'Reference to the healthcare provider who holds this license. Links to the provider master entity.',
    `recredential_cycle_id` BIGINT COMMENT 'Reference to the credentialing or recredentialing cycle during which this license was verified. Links to credentialing workflow tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: License verification is performed by a credentialing staff employee; linking enables audit trails and compliance reporting.',
    `attestation_date` DATE COMMENT 'The date the provider attested to the accuracy and currency of this license information. Used for credentialing and recredentialing cycles.',
    `authorized_schedules` STRING COMMENT 'For DEA and CDS registrations, the controlled substance schedules the provider is authorized to prescribe (Schedule II, III, IV, V). Stored as comma-separated list. Critical for pharmacy benefit management and prior authorization workflows.',
    `compact_participation_flag` BOOLEAN COMMENT 'Indicates whether this license is part of an interstate licensure compact (e.g., Interstate Medical Licensure Compact, Nurse Licensure Compact). True if the license grants multi-state practice privileges; false otherwise.',
    `compact_privilege_states` STRING COMMENT 'Comma-separated list of state abbreviations where the provider has practice privileges under the interstate compact. Used for multi-state network adequacy and provider directory management.',
    `compact_type` STRING COMMENT 'The specific interstate licensure compact this license participates in. IMLC is Interstate Medical Licensure Compact for physicians. Populated only when compact_participation_flag is true. [ENUM-REF-CANDIDATE: imlc|nurse_licensure_compact|psychology_compact|physical_therapy_compact|ems_compact|counseling_compact|none — 7 candidates stripped; promote to reference product]',
    `continuing_education_hours_required` DECIMAL(18,2) COMMENT 'The number of continuing education or CME hours required per renewal cycle to maintain this license. Varies by state and license type.',
    `continuing_education_required_flag` BOOLEAN COMMENT 'Indicates whether continuing education (CE) or continuing medical education (CME) is required to maintain this license. True if CE/CME is mandatory for renewal; false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disciplinary_action_date` DATE COMMENT 'The date disciplinary action was taken against the license. Used for credentialing review timelines and risk assessment.',
    `disciplinary_action_details` STRING COMMENT 'Detailed description of any disciplinary actions, sanctions, or restrictions imposed by the licensing authority. Includes nature of violation, dates, and resolution. Populated only when disciplinary_action_flag is true.',
    `disciplinary_action_flag` BOOLEAN COMMENT 'Indicates whether any disciplinary action has been taken against this license by the issuing authority. True if disciplinary action exists; false otherwise. Critical for credentialing risk assessment.',
    `effective_date` DATE COMMENT 'The date the license becomes valid and the provider is authorized to practice under this credential. May differ from issue date for renewals or reinstatements.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'The date the license expires and is no longer valid unless renewed. Critical for credentialing compliance and provider directory accuracy. Null for licenses with no expiration.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner.qualification)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `issue_date` DATE COMMENT 'The date the license or registration was originally issued by the licensing authority. Used to calculate license tenure and verify historical credentialing timelines.',
    `issuing_authority` STRING COMMENT 'The regulatory body or government agency that issued the license or registration. Examples include State Medical Board, State Board of Nursing, Drug Enforcement Administration (DEA), State Pharmacy Board, or Centers for Medicare and Medicaid Services (CMS).',
    `issuing_state` STRING COMMENT 'The U.S. state or territory that issued the license. Uses two-letter state abbreviation. Critical for multi-state licensure tracking and Interstate Medical Licensure Compact compliance. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|DC — 51 candidates stripped; promote to reference product]',
    `license_number` STRING COMMENT 'The unique license or registration number issued by the licensing authority. For DEA registrations, this is the DEA number; for state medical licenses, this is the state-issued license number.',
    `license_status` STRING COMMENT 'Current status of the license or registration in its lifecycle. Active indicates the license is valid and in good standing; suspended, revoked, or expired indicate the provider cannot practice under this credential. [ENUM-REF-CANDIDATE: active|inactive|suspended|revoked|expired|surrendered|pending_renewal|probation|restricted — 9 candidates stripped; promote to reference product]',
    `license_type` STRING COMMENT 'The category of professional license or registration. Includes state medical licenses (MD, DO), nursing licenses (RN, LPN, NP), DEA controlled substance registrations, state CDS permits, pharmacy licenses, and other professional certifications. [ENUM-REF-CANDIDATE: medical_license|nursing_license|dea_registration|cds_permit|pharmacy_license|dental_license|optometry_license|podiatry_license|chiropractic_license|physical_therapy_license|occupational_therapy_license|behavioral_health_license|advanced_practice_license|physician_assistant_license|other — 15 candidates stripped; promote to reference product]',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `practice_restrictions` STRING COMMENT 'Any limitations or restrictions placed on the license by the issuing authority. May include supervision requirements, practice setting restrictions, or specific clinical limitations.',
    `primary_source_verification_date` DATE COMMENT 'The date the license was last verified directly with the issuing authority (primary source). NCQA requires PSV within 180 days of credentialing decision and every 36 months thereafter.',
    `primary_source_verification_method` STRING COMMENT 'The method used to verify the license with the primary source. Includes online state board portals, written correspondence, phone verification, third-party credentialing services, or automated API integration.. Valid values are `online_portal|written_correspondence|phone_verification|third_party_service|automated_api`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time this license record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `record_current_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the license record. True for the current record; false for historical versions. Supports Type 2 slowly changing dimension queries.',
    `record_effective_timestamp` TIMESTAMP COMMENT 'The date and time from which this version of the license record is effective for business reporting. Supports Type 2 slowly changing dimension tracking.',
    `record_end_timestamp` TIMESTAMP COMMENT 'The date and time when this version of the license record was superseded by a new version. Null for the current active record. Supports Type 2 slowly changing dimension tracking.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time this license record was last modified in the data platform. Used for change tracking and audit purposes.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `renewal_cycle_months` STRING COMMENT 'The number of months between required renewals for this license type. Common values are 12, 24, or 36 months depending on state and license type.',
    `renewal_date` DATE COMMENT 'The date the license was last renewed. Used to track renewal cycles and ensure continuous licensure for credentialing purposes.',
    `scope_of_practice` STRING COMMENT 'Description of the clinical activities and services the provider is authorized to perform under this license. Varies by license type and state regulations. Used for state-specific scope-of-practice validation.',
    `source_system_code` STRING COMMENT 'The unique identifier for this license record in the source operational system. Used for data lineage and reconciliation.',
    `telemedicine_authorized_flag` BOOLEAN COMMENT 'Indicates whether the provider is authorized to deliver telemedicine services under this license. True if telemedicine practice is permitted; false otherwise. Critical for virtual care network management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `verification_source` STRING COMMENT 'The specific entity or system used to perform primary source verification. Examples include state medical board website, NPDB, third-party credentialing verification organization (CVO), or automated verification service.',
    `verification_url` STRING COMMENT 'The web address of the state licensing board or regulatory authority where the license can be verified online. Used for automated primary source verification workflows.',
    CONSTRAINT pk_license PRIMARY KEY(`license_id`)
) COMMENT 'Single source of truth for all professional licenses, certifications, and regulatory registrations held by a provider. Covers state medical licenses (MD, DO, NP, PA, RN, LCSW, LPC, etc.), DEA controlled substance registrations (including authorized schedules II-V and registration state), CDS (state-level controlled dangerous substance) permits, state pharmacy licenses, and other regulatory registrations. Stores license/registration type, issuing authority (state medical board, state nursing board, DEA, CMS, state pharmacy board), license or registration number, authorized schedules (for DEA/CDS), issue date, expiration date, renewal date, status (active, suspended, revoked, expired, surrendered, pending renewal), disciplinary action flags, disciplinary action details, and primary source verification (PSV) date and source. Supports NCQA credentialing standards for PSV, multi-state licensure tracking via Interstate Medical Licensure Compact, controlled substance prescribing authorization, pharmacy benefit management workflows, and state-specific scope-of-practice validation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` (
    `affiliation_id` BIGINT COMMENT 'Primary key for affiliation',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Affiliation coordination is handled by a specific employee who manages contracts, privileges, and network status for each affiliation.',
    `facility_id` BIGINT COMMENT 'add column facility_id (BIGINT) with FK to provider.facility.facility_id - affiliations link to facilities not just group_practices',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: affiliation should reference the medical group (group_practice) it belongs to; the existing column name does not match target PK naming, so a new FK column is added and the generic column removed.',
    `provider_id` BIGINT COMMENT 'Reference to the individual provider (physician, nurse practitioner, or other healthcare professional) who holds this affiliation. Links to the provider master entity.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether the provider is accepting new patients through this affiliation. True indicates accepting new patients; False indicates not accepting new patients.',
    `admitting_privileges_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether the provider has admitting privileges at the affiliated hospital or facility. True indicates admitting privileges are granted; False indicates no admitting privileges.',
    `affiliation_status` STRING COMMENT 'Current lifecycle status of the provider affiliation. Indicates whether the affiliation is active and in effect, inactive, suspended, pending approval, or terminated.. Valid values are `active|inactive|suspended|pending|terminated`',
    `affiliation_type` STRING COMMENT 'Categorical classification of the affiliation relationship. Indicates whether the provider is affiliated with a medical group, Independent Practice Association (IPA), Accountable Care Organization (ACO), health system, hospital, or other facility type.. Valid values are `medical_group|ipa|aco|health_system|hospital|facility`',
    `billing_npi` STRING COMMENT 'The National Provider Identifier (NPI) used for billing purposes in this affiliation context. May represent the organizational NPI (Type 2) of the affiliated entity.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this affiliation record was first created in the system. Used for audit trail and data lineage tracking.',
    `credentialing_verification_date` DATE COMMENT 'The date on which the providers credentials and affiliation with the organization were last verified. Used to track compliance with credentialing re-verification requirements.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department_name` STRING COMMENT 'The name of the department, division, or service line within the affiliated organization where the provider practices. Examples include Cardiology, Emergency Medicine, Orthopedic Surgery, Primary Care.',
    `directory_display_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether this affiliation should be displayed in the member-facing provider directory. True indicates the affiliation is publicly visible; False indicates it is for internal use only.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'The date on which the provider affiliation ended or is scheduled to end. Null for open-ended affiliations that are currently active.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PractitionerRole)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_by` STRING COMMENT 'The user ID or system identifier of the person or process that last updated this affiliation record. Supports audit and accountability requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this affiliation record was last modified. Used for audit trail and change tracking.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_staff_category` STRING COMMENT 'The category of medical staff membership the provider holds at the affiliated hospital or facility. Categories include Active Staff, Courtesy Staff, Consulting Staff, Honorary Staff, Affiliate Staff, and Provisional Staff.. Valid values are `active|courtesy|consulting|honorary|affiliate|provisional`',
    `network_participation_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether this affiliation makes the provider eligible for participation in the health plans provider network. True indicates network participation; False indicates non-participating affiliation.',
    `next_credentialing_due_date` DATE COMMENT 'The date by which the next credentialing verification for this affiliation is due. Supports proactive credentialing workflow management.',
    `notes` STRING COMMENT 'Free-text field for capturing additional notes, comments, or special instructions related to the provider affiliation. May include details about practice restrictions, scheduling notes, or administrative remarks.',
    `primary_affiliation_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether this is the providers primary organizational affiliation. True indicates this is the main affiliation; False indicates a secondary or additional affiliation.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `role_title` STRING COMMENT 'The providers role or title within the affiliated organization. Examples include Staff Physician, Medical Director, Department Chair, Attending Physician, Consulting Physician.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this affiliation record in the source system. Used for traceability and reconciliation with upstream systems.',
    `start_date` DATE COMMENT 'The date on which the provider affiliation became effective. Represents the beginning of the provider-organization relationship.',
    `tin` STRING COMMENT 'The Tax Identification Number (TIN) or Employer Identification Number (EIN) under which the provider bills for services rendered through this affiliation. Used for claims routing and payment processing.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this affiliation record. Supports audit and accountability requirements.',
    CONSTRAINT pk_affiliation PRIMARY KEY(`affiliation_id`)
) COMMENT 'Captures the organizational affiliations of individual providers — medical group memberships, IPA affiliations, ACO participation, health system relationships, and hospital associations. Stores affiliation type, affiliated organization (group practice or facility reference), affiliation start and end dates, department, role, and active status. Supports provider directory accuracy, network configuration, claims routing logic, and understanding of provider-to-organization hierarchies. For hospital-based providers, captures the association with the facility where the provider practices.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` (
    `group_practice_id` BIGINT COMMENT 'Primary key for group_practice',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Group practice financial statements require linking each practice group to its cost center for consolidated reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Group Practice Management requires a designated practice manager employee overseeing operations, staffing, and compliance for the group.',
    `provider_id` BIGINT COMMENT 'The state-assigned Medicaid provider identifier for the group practice, used for Medicaid claims submission.',
    `group_medicare_provider_id` BIGINT COMMENT 'The Medicare-assigned provider identifier for the group practice, used for Medicare claims submission and enrollment.',
    `accepting_new_patients` BOOLEAN COMMENT 'Indicates whether the group practice is currently accepting new patients. Used for provider directory accuracy and member access.',
    `accessibility_accommodations` STRING COMMENT 'Description of accessibility accommodations available at the group practice (e.g., wheelchair access, hearing loop, accessible exam tables) to comply with ADA requirements.',
    `aco_name` STRING COMMENT 'The name of the ACO in which the group practice participates, if applicable.',
    `aco_participant` BOOLEAN COMMENT 'Indicates whether the group practice participates in an Accountable Care Organization (ACO) for value-based care arrangements.',
    `address_line_1` STRING COMMENT 'The primary street address line 1 of the group practices main location or headquarters.',
    `address_line_2` STRING COMMENT 'The primary street address line 2 (suite, floor, building) of the group practices main location.',
    `city` STRING COMMENT 'The city where the group practices primary location is situated.',
    `cms_certification_number` STRING COMMENT 'The CMS Certification Number (CCN) assigned to FQHC, RHC, or other certified facilities. Required for Medicare/Medicaid billing.',
    `county` STRING COMMENT 'The county in which the group practices primary location is located. Used for network adequacy and geographic access reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this group practice record was first created in the provider management system.',
    `credentialing_date` DATE COMMENT 'The date on which the group practice was initially credentialed and approved for network participation.',
    `credentialing_status` STRING COMMENT 'The current credentialing status of the group practice within the health plans credentialing process.. Valid values are `initial|recredentialing|approved|denied|expired`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_source_system` STRING COMMENT 'The name of the source system from which this group practice record originated (e.g., Cactus, ProviderSource, NPPES).',
    `doing_business_as_name` STRING COMMENT 'The trade name or DBA name under which the group practice operates, if different from the legal name.',
    `effective_date` DATE COMMENT 'The date on which the group practices participation in the health plan network became effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `email_address` STRING COMMENT 'The primary email address for administrative and contracting communications with the group practice.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'The fax number for the group practice, used for prior authorization and medical records transmission.. Valid values are `^+?[0-9]{10,15}$`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `group_name` STRING COMMENT 'The legal business name of the medical group, physician organization, or practice entity as registered with state authorities and CMS.',
    `group_npi` STRING COMMENT 'The 10-digit Type 2 NPI assigned to the group practice organization by CMS. This is the organizational NPI distinct from individual provider NPIs.. Valid values are `^[0-9]{10}$`',
    `group_size` STRING COMMENT 'The total number of individual providers (physicians, nurse practitioners, physician assistants) affiliated with and practicing under this group.',
    `group_type` STRING COMMENT 'Classification of the group practice organizational structure: solo practice (single physician), single specialty group, multi-specialty group, Independent Practice Association (IPA), Federally Qualified Health Center (FQHC), or Rural Health Clinic (RHC).. Valid values are `solo_practice|single_specialty_group|multi_specialty_group|ipa|fqhc|rhc`',
    `hospital_affiliation` STRING COMMENT 'The name of the primary hospital or health system with which the group practice is affiliated or has admitting privileges.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language_services_offered` STRING COMMENT 'Comma-separated list of languages in which the group practice offers clinical services, used for provider directory cultural competency and member access.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `participation_status` STRING COMMENT 'The current participation status of the group practice in the health plans provider network. Active indicates the group is contracted and accepting members.. Valid values are `active|inactive|suspended|terminated|pending_credentialing`',
    `pcmh_recognition_level` STRING COMMENT 'The NCQA PCMH recognition level achieved by the group practice (Level 1, 2, or 3), with Level 3 being the highest.. Valid values are `level_1|level_2|level_3`',
    `pcmh_recognized` BOOLEAN COMMENT 'Indicates whether the group practice has achieved NCQA Patient-Centered Medical Home (PCMH) recognition, qualifying for enhanced reimbursement and quality incentives.',
    `phone_number` STRING COMMENT 'The primary contact phone number for the group practice.. Valid values are `^+?[0-9]{10,15}$`',
    `primary_specialty` STRING COMMENT 'The primary medical specialty or service focus of the group practice (e.g., Family Medicine, Cardiology, Orthopedic Surgery, Multi-Specialty).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recredentialing_due_date` DATE COMMENT 'The date by which the group practice must complete recredentialing to maintain network participation. NCQA requires recredentialing at least every 36 months.',
    `state` STRING COMMENT 'The two-letter state abbreviation for the group practices primary location.. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'The federal tax identification number (TIN/EIN) assigned to the group practice by the IRS. Used for claims payment and 1099 reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `taxonomy_code` STRING COMMENT 'The 10-character alphanumeric taxonomy code identifying the groups primary classification, specialty, and area of practice per the NUCC taxonomy.. Valid values are `^[0-9]{10}[X]$`',
    `telehealth_enabled` BOOLEAN COMMENT 'Indicates whether the group practice offers telehealth or telemedicine services to members.',
    `termination_date` DATE COMMENT 'The date on which the group practices participation in the health plan network was terminated or is scheduled to terminate. Null for active participants.',
    `termination_reason` STRING COMMENT 'The reason for termination of the group practices network participation (e.g., voluntary withdrawal, quality issues, credentialing failure, contract non-renewal).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this group practice record was last modified in the provider management system.',
    `website_url` STRING COMMENT 'The public website URL for the group practice, used in provider directory listings.',
    `zip_code` STRING COMMENT 'The 5-digit or 9-digit ZIP code for the group practices primary location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_group_practice PRIMARY KEY(`group_practice_id`)
) COMMENT 'Represents a medical group, physician organization, IPA, or multi-specialty group practice as a distinct business entity with its own Type 2 NPI and TIN. Stores group name, group NPI, TIN/EIN, group type (solo practice, group practice, IPA, FQHC, RHC), primary specialty, address, phone, CMS certification number, and group size. Serves as the organizational parent for individual provider affiliations and supports group-level contracting and network participation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique identifier for the healthcare facility record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Facility operational costs are tracked against a cost center for capital budgeting and regulatory cost reporting.',
    `provider_id` BIGINT COMMENT 'FK to provider.provider for facilities that are providers with NPIs',
    `provider_provider_id` BIGINT COMMENT 'FK to provider.provider_provider; facilities are providers with NPIs.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the facility is currently accepting new patients. Used in provider directory and network adequacy reporting.',
    `accreditation_body` STRING COMMENT 'Organization that has accredited the facility. Values: joint_commission (The Joint Commission), dnv (DNV Healthcare), cihq (Center for Improvement in Healthcare Quality), aoa (American Osteopathic Association), aaahc (Accreditation Association for Ambulatory Health Care), achc (Accreditation Commission for Health Care), none (not accredited). [ENUM-REF-CANDIDATE: joint_commission|dnv|cihq|aoa|aaahc|achc|none — 7 candidates stripped; promote to reference product]',
    `accreditation_expiration_date` DATE COMMENT 'Date when the current accreditation expires. Null if facility is not accredited.',
    `address_line_1` STRING COMMENT 'Primary street address of the facility physical location.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number.',
    `bed_count` STRING COMMENT 'Total number of licensed beds at the facility. Used for network adequacy calculations and capacity planning.',
    `ccn` STRING COMMENT 'Six-character alphanumeric identifier assigned by CMS to Medicare/Medicaid certified facilities. Also known as Provider Number.. Valid values are `^[0-9A-Z]{6}$`',
    `city` STRING COMMENT 'City where the facility is located.',
    `clia_number` STRING COMMENT 'Ten-character identifier issued by CMS for facilities performing laboratory testing. Format: 2-digit state code + 1 letter + 7 digits.. Valid values are `^[0-9]{2}[A-Z][0-9]{7}$`',
    `county_name` STRING COMMENT 'County where the facility is located. Used for network adequacy geographic analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credentialing_effective_date` DATE COMMENT 'Date when the current credentialing approval became effective.',
    `credentialing_expiration_date` DATE COMMENT 'Date when the current credentialing approval expires and recredentialing is required.',
    `credentialing_status` STRING COMMENT 'Current status of the facility credentialing process. Indicates whether the facility has passed credentialing review and is approved for network participation.. Valid values are `approved|pending|expired|suspended|denied`',
    `critical_access_hospital_flag` BOOLEAN COMMENT 'Indicates whether the facility is designated as a Critical Access Hospital under the Medicare Rural Hospital Flexibility Program.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when the facility record or current participation status became effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `email_address` STRING COMMENT 'Primary email address for facility communications and electronic correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_services_flag` BOOLEAN COMMENT 'Indicates whether the facility provides 24/7 emergency department services.',
    `facility_type` STRING COMMENT 'Classification of the healthcare facility. Values: hospital (acute care hospital), snf (Skilled Nursing Facility), asc (Ambulatory Surgical Center), fqhc (Federally Qualified Health Center), rhc (Rural Health Clinic), behavioral_health (behavioral health facility). [ENUM-REF-CANDIDATE: hospital|snf|asc|fqhc|rhc|behavioral_health|home_health|hospice|dialysis_center|dme_supplier|ltac|irf|imaging_center — promote to reference product]. Valid values are `hospital|snf|asc|fqhc|rhc|behavioral_health`',
    `fax_number` STRING COMMENT 'Fax number for the facility, used for prior authorization and medical records transmission.. Valid values are `^+?[0-9]{10,15}$`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Location)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicaid_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified to participate in the Medicaid program.',
    `medicare_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified to participate in the Medicare program.',
    `facility_name` STRING COMMENT 'Legal name of the healthcare facility as registered with state and federal authorities.',
    `network_tier` STRING COMMENT 'Tiering classification of the facility within the provider network. Tier 1 is preferred/lowest cost-sharing. Out_of_network indicates non-participating facility.. Valid values are `tier_1|tier_2|tier_3|out_of_network`',
    `npi` STRING COMMENT 'Type 2 NPI assigned to the facility by CMS. Ten-digit unique organizational identifier required for HIPAA transactions.. Valid values are `^[0-9]{10}$`',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the facility. Values: for_profit (investor-owned), non_profit (tax-exempt), government (federal/state/local), tribal (Indian Health Service or tribal).. Valid values are `for_profit|non_profit|government|tribal`',
    `parent_organization_name` STRING COMMENT 'Name of the parent health system or organization that owns or operates the facility. Null if facility is independent.',
    `participation_status` STRING COMMENT 'Current status of the facility in the provider network. Indicates whether the facility is actively participating, suspended, or terminated.. Valid values are `active|inactive|suspended|terminated|pending`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the facility.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'Five or nine-digit ZIP code of the facility location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `quality_rating` DECIMAL(18,2) COMMENT 'Overall quality rating score for the facility on a scale of 1.00 to 5.00. Derived from CMS Star Ratings, HEDIS measures, or internal quality assessments.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the data platform.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was last updated in the data platform.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_system_code` STRING COMMENT 'Unique identifier for this facility in the source system. Used for data lineage and reconciliation.',
    `state_code` STRING COMMENT 'Two-letter state abbreviation where the facility is located.. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) assigned by IRS. Used for claims payment and 1099 reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `teaching_hospital_flag` BOOLEAN COMMENT 'Indicates whether the facility is a teaching hospital affiliated with a medical school and residency programs.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether the facility offers telehealth or virtual care services.',
    `termination_date` DATE COMMENT 'Date when the facility participation was terminated or is scheduled to terminate. Null if currently active.',
    `trauma_level` STRING COMMENT 'Trauma center designation level assigned by state or American College of Surgeons. Level 1 is highest capability. Not_designated indicates facility is not a trauma center.. Valid values are `level_1|level_2|level_3|level_4|level_5|not_designated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `website_url` STRING COMMENT 'Public website URL for the facility. Used in provider directory.',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master record for healthcare facilities — hospitals, SNFs, ASCs, FQHCs, RHCs, behavioral health facilities, home health agencies, hospices, dialysis centers, and DME suppliers. Stores facility name, facility type, CMS certification number (CCN), Medicare/Medicaid certification status, accreditation body (Joint Commission, DNV, CIHQ), accreditation expiration, bed count, trauma level, teaching hospital status, critical access hospital designation, CLIA number, and facility NPI. Distinct from individual provider records; supports institutional claims (837I) routing, network adequacy facility-type analysis, and CMS Star Rating facility attribution. Serves as the organizational anchor for hospital privilege tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` (
    `directory_entry_id` BIGINT COMMENT 'Primary key for directory_entry',
    `provider_directory_id` BIGINT COMMENT 'Unique identifier for the provider directory entry record. This is the primary key for the published directory entry, distinct from the internal provider master record.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Directory Publication Report requires contract details for each provider entry to determine network participation terms.',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan for which this directory entry is published. A provider may have multiple directory entries across different plans.',
    `provider_id` BIGINT COMMENT 'Reference to the internal provider master record. Links this published directory entry to the authoritative provider identity in the provider domain.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network in which this provider participates for this plan. Determines member access and cost-sharing tier.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients for this plan and network. Critical for directory accuracy and member access.',
    `accessibility_features` STRING COMMENT 'Description of accessibility features available at the practice location (wheelchair access, hearing loop, accessible parking). Supports ADA compliance and member access.',
    `attestation_method` STRING COMMENT 'Method used to verify the directory information with the provider. Documents the verification approach for audit and compliance purposes.. Valid values are `provider_portal|phone_verification|email_verification|site_visit|third_party_vendor`',
    `attestation_status` STRING COMMENT 'Status of the provider attestation or verification process for this directory entry. Tracks compliance with CMS directory accuracy requirements.. Valid values are `verified|pending_verification|failed_verification|not_verified`',
    `board_certifications` STRING COMMENT 'Comma-separated list of board certifications held by the provider. Demonstrates advanced training and specialty expertise.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `directory_display_name` STRING COMMENT 'Consumer-facing display name of the provider as it appears in the published directory. May differ from legal name for readability and member experience.',
    `directory_publication_date` DATE COMMENT 'Date when this directory entry was published or last updated in the member-facing provider directory. Required for CMS directory accuracy attestation.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gender` STRING COMMENT 'Gender of the provider. Some members have preferences for provider gender, particularly for primary care and OB/GYN services.. Valid values are `male|female|non_binary|not_disclosed`',
    `graduation_year` STRING COMMENT 'Year the provider graduated from medical school or professional training program. Helps members assess provider experience.',
    `hospital_affiliation` STRING COMMENT 'Name of hospital(s) where the provider has admitting privileges or primary affiliation. Important for continuity of care and member decision-making.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages spoken by the provider or available at the practice location. Critical for member access and cultural competency.',
    `last_verified_date` DATE COMMENT 'Date when the directory information was last verified with the provider or practice. CMS and state DOI mandate regular verification cycles (typically 90 days).',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medical_school` STRING COMMENT 'Name of the medical school or professional training institution where the provider received their degree. Provides credential transparency for members.',
    `network_tier` STRING COMMENT 'Cost-sharing tier for this provider within the plan network. Determines member copay, coinsurance, and out-of-pocket costs.. Valid values are `tier_1|tier_2|tier_3|preferred|standard|out_of_network`',
    `next_verification_due_date` DATE COMMENT 'Date by which the next directory verification must be completed to maintain compliance with CMS and state DOI accuracy mandates.',
    `npi` STRING COMMENT 'Ten-digit National Provider Identifier assigned by CMS. The authoritative unique identifier for healthcare providers in the United States.. Valid values are `^[0-9]{10}$`',
    `office_hours` STRING COMMENT 'Text description of office hours for the practice location. Helps members understand availability for appointment scheduling.',
    `participation_effective_date` DATE COMMENT 'Date when the providers participation in this plan and network became effective. Determines when members can access the provider at in-network rates.',
    `participation_status` STRING COMMENT 'Current status of the providers participation in this specific plan and network. Determines whether the directory entry is published to members.. Valid values are `active|inactive|suspended|terminated|pending`',
    `participation_termination_date` DATE COMMENT 'Date when the providers participation in this plan and network ended or will end. Critical for member notification and continuity of care transitions.',
    `pcp_flag` BOOLEAN COMMENT 'Indicates whether this provider is eligible to serve as a Primary Care Provider (PCP) for plan members. Relevant for HMO and POS plans requiring PCP selection.',
    `practice_address_line1` STRING COMMENT 'First line of the practice location street address where the provider sees patients. Published in member-facing directory for appointment scheduling.',
    `practice_address_line2` STRING COMMENT 'Second line of the practice location street address (suite, floor, building). Optional field for additional address detail.',
    `practice_city` STRING COMMENT 'City name of the practice location. Used for member search and network adequacy geographic analysis.',
    `practice_county` STRING COMMENT 'County name of the practice location. Required for state DOI network adequacy reporting and CMS service area compliance.',
    `practice_email` STRING COMMENT 'Email address for the practice location. May be published for member communication or used for administrative coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `practice_fax` STRING COMMENT 'Fax number for the practice location. Used for prior authorization submissions and medical records exchange.',
    `practice_location_name` STRING COMMENT 'Name of the practice location, clinic, or facility where the provider sees patients for this directory entry. A provider may have multiple directory entries for different locations.',
    `practice_phone` STRING COMMENT 'Primary phone number for the practice location. Published in directory for member appointment scheduling and inquiries.',
    `practice_state` STRING COMMENT 'Two-letter state abbreviation of the practice location. Critical for state-specific network adequacy and regulatory compliance.. Valid values are `^[A-Z]{2}$`',
    `practice_website_url` STRING COMMENT 'Website URL for the practice or provider. Published in directory to enable members to learn more about the provider and services offered.',
    `practice_zip_code` STRING COMMENT 'Five-digit or nine-digit ZIP code of the practice location. Used for member proximity search and network adequacy geo-access analysis.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `provider_type` STRING COMMENT 'High-level classification of the provider entity type. Determines directory presentation and search filtering options for members.. Valid values are `individual|group|facility|ancillary|dme_supplier|behavioral_health`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this directory entry record was first created in the data warehouse. Supports audit trail and data lineage tracking.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this directory entry record was last updated in the data warehouse. Tracks data freshness and change frequency.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_system_code` STRING COMMENT 'Unique identifier for this directory entry in the source system. Enables traceability and reconciliation with upstream provider management systems.',
    `specialty_display` STRING COMMENT 'Consumer-friendly specialty name displayed in the directory. Simplified from clinical taxonomy codes for member understanding.',
    `telehealth_available_flag` BOOLEAN COMMENT 'Indicates whether the provider offers telehealth or virtual visit services for this plan. Increasingly important for member access and convenience.',
    `tin` STRING COMMENT 'Nine-digit Tax Identification Number (EIN or SSN) associated with the provider or practice for billing and contracting purposes.. Valid values are `^[0-9]{9}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_directory_entry PRIMARY KEY(`directory_entry_id`)
) COMMENT 'Published provider directory record representing the consumer-facing view of a providers participation in a specific health plan and network. Captures provider display name, accepting new patients status, languages spoken, telehealth availability, network tier, plan participation, directory publication date, last verified date, and directory accuracy attestation status. Supports CMS and state DOI provider directory accuracy mandates (no-surprise billing, network adequacy). Distinct from the internal provider master — this is the published, plan-specific directory entry.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` (
    `npi_registry_sync_id` BIGINT COMMENT 'Unique identifier for each NPI registry synchronization event record.',
    `provider_id` BIGINT COMMENT 'Internal identifier linking this sync event to the provider master record in the Provider Management System.',
    `vendor_id` BIGINT COMMENT 'add column vendor_id (BIGINT) with FK to vendor.vendor.vendor_id - NPI sync source (NPPES) tracked as vendor',
    `address_discrepancy_detail` STRING COMMENT 'Detailed description of the address discrepancy found between internal and NPPES records, including field-level differences.',
    `address_discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was detected between the internal provider address and the NPPES registry address during this sync event.',
    `auto_applied_fields` STRING COMMENT 'Comma-separated list of field names that were automatically updated in the internal provider master record based on NPPES data during this sync event.',
    `auto_applied_update_flag` BOOLEAN COMMENT 'Indicates whether discrepancies found during this sync event were automatically applied to the internal provider master record without manual review.',
    `claims_submission_risk_flag` BOOLEAN COMMENT 'Indicates whether this sync event identified a risk to claims submission, such as a deactivated NPI that could cause claim rejections.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credential_discrepancy_detail` STRING COMMENT 'Detailed description of the credential discrepancy found between internal and NPPES records.',
    `credential_discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was detected between the internal provider credentials and the NPPES registry credentials during this sync event.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deactivation_reason_code` STRING COMMENT 'The CMS-defined code indicating the reason for NPI deactivation: DT (Death), DB (Doing Business As), FR (Fraud), OT (Other).. Valid values are `DT|DB|FR|OT`',
    `deactivation_reason_description` STRING COMMENT 'The full text description of the reason the NPI was deactivated in the NPPES registry.',
    `directory_accuracy_impact_flag` BOOLEAN COMMENT 'Indicates whether this sync event identified discrepancies that impact provider directory accuracy and CMS directory accuracy mandates.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `manual_review_assigned_to` STRING COMMENT 'The user ID or team name to whom this sync discrepancy has been assigned for manual review and resolution.',
    `manual_review_completed_date` DATE COMMENT 'The date on which manual review of this sync event discrepancy was completed and resolved.',
    `manual_review_reason` STRING COMMENT 'The business reason why this sync event requires manual review, such as critical field discrepancies, deactivated NPI, or conflicting data.',
    `manual_review_required_flag` BOOLEAN COMMENT 'Indicates whether this sync event identified discrepancies that require manual review and resolution by data stewardship or credentialing staff.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `match_status` STRING COMMENT 'The outcome of comparing the internal provider record against the NPPES registry data, indicating whether the NPI was found, matched, or has changed status.. Valid values are `Exact Match|Partial Match|Unmatched|Deactivated NPI|Reactivated NPI|New NPI Discovered`',
    `name_discrepancy_detail` STRING COMMENT 'Detailed description of the name discrepancy found between internal and NPPES records, including field-level differences.',
    `name_discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was detected between the internal provider name and the NPPES registry name during this sync event.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier queried against the CMS NPPES registry during this synchronization event.. Valid values are `^[0-9]{10}$`',
    `nppes_deactivation_date` DATE COMMENT 'The date the NPI was deactivated in the NPPES registry, if applicable, as retrieved during this sync event.',
    `nppes_enumeration_date` DATE COMMENT 'The date the NPI was originally enumerated in the NPPES registry as retrieved during this sync event.',
    `nppes_last_update_date` DATE COMMENT 'The date the NPI record was last updated in the NPPES registry as retrieved during this sync event.',
    `nppes_reactivation_date` DATE COMMENT 'The date the NPI was reactivated in the NPPES registry, if applicable, as retrieved during this sync event.',
    `nppes_response_code` STRING COMMENT 'The HTTP or API response code returned by the NPPES registry during this sync event.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this NPI registry sync event record was first created in the data warehouse.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this NPI registry sync event record was last updated in the data warehouse.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resolution_action` STRING COMMENT 'The action taken to resolve discrepancies identified during this sync event, indicating whether NPPES data was accepted, internal data was retained, or further escalation occurred.. Valid values are `Accept NPPES Data|Retain Internal Data|Hybrid Update|Escalate to Credentialing|No Action Required`',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the rationale and details of the resolution action taken for this sync event.',
    `source_system_code` STRING COMMENT 'The unique identifier for this sync event record in the source Provider Management System.',
    `sync_error_code` STRING COMMENT 'The error code returned if the sync event failed, indicating the technical or business reason for failure.',
    `sync_error_message` STRING COMMENT 'The detailed error message returned if the sync event failed, providing diagnostic information for troubleshooting.',
    `sync_run_date` DATE COMMENT 'The date on which this NPI registry synchronization event was executed.',
    `sync_run_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this NPI registry synchronization event was initiated.',
    `sync_source` STRING COMMENT 'The source system or method used to retrieve NPI data from the CMS NPPES registry for this synchronization event.. Valid values are `NPPES Weekly Dissemination File|NPPES API Real-Time Query|Manual Verification|Batch Import|Scheduled Job`',
    `sync_status` STRING COMMENT 'The current status of this NPI registry synchronization event in its processing lifecycle.. Valid values are `Completed|In Progress|Failed|Pending Review|Resolved`',
    `taxonomy_discrepancy_detail` STRING COMMENT 'Detailed description of the taxonomy code discrepancy found between internal and NPPES records, including specific taxonomy codes that differ.',
    `taxonomy_discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was detected between the internal provider taxonomy code and the NPPES registry taxonomy during this sync event.',
    `total_discrepancies_count` STRING COMMENT 'The total number of field-level discrepancies identified between the internal provider record and the NPPES registry data during this sync event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_npi_registry_sync PRIMARY KEY(`npi_registry_sync_id`)
) COMMENT 'Tracks synchronization events between the internal provider master and the CMS NPPES NPI Registry to maintain provider data quality and regulatory compliance. Records sync run date, NPI queried, match status (exact match, partial match, unmatched, deactivated NPI, reactivated NPI), fields compared and discrepancies found (name, address, taxonomy, enumeration date, deactivation reason), sync source (NPPES weekly dissemination file, NPPES API real-time query), auto-applied updates, and discrepancy flags requiring manual review. Critical for preventing claims submission with deactivated NPIs, supporting new provider discovery, and maintaining directory accuracy per CMS provider enrollment standards.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`sanction` (
    `sanction_id` BIGINT COMMENT 'Primary key for sanction',
    `exclusion_screening_id` BIGINT COMMENT 'Reference to the screening event that detected this sanction. Links to the screening event record for audit trail purposes.',
    `provider_id` BIGINT COMMENT 'Reference to the provider who is subject to this sanction. Links to the provider master entity.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes documenting the audit trail for this sanction record, including investigation details, stakeholder communications, and compliance actions taken.',
    `cms_report_date` DATE COMMENT 'The date on which this sanction was reported to CMS. Null if not yet reported or not reportable.',
    `cms_reportable_flag` BOOLEAN COMMENT 'Indicates whether this sanction must be reported to CMS as part of program integrity reporting requirements. True if reportable, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `current_record_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the sanction record. True for the current version, False for historical versions. Used for slowly changing dimension (SCD) Type 2 tracking.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exclusion_waiver_flag` BOOLEAN COMMENT 'Indicates whether a waiver or exception was granted allowing the provider to continue participation despite the sanction. True if waiver granted, False otherwise.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `match_details` STRING COMMENT 'Detailed information about the match found during screening, including match score, matching fields (name, NPI, DOB), and any discrepancies requiring manual review.',
    `ncqa_report_date` DATE COMMENT 'The date on which this sanction was reported to NCQA. Null if not yet reported or not reportable.',
    `ncqa_reportable_flag` BOOLEAN COMMENT 'Indicates whether this sanction must be reported to NCQA as part of credentialing and accreditation standards. True if reportable, False otherwise.',
    `notification_date` DATE COMMENT 'The date on which the sanction notification was sent to stakeholders. Null if notification has not been sent.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification was sent to relevant stakeholders (provider, network management, claims processing) about the sanction. True if sent, False otherwise.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier of the sanctioned provider. Required for OIG and SAM screening compliance.. Valid values are `^[0-9]{10}$`',
    `participation_impact` STRING COMMENT 'The impact of the sanction on the providers participation status and payment eligibility within the health plans network.. Valid values are `Immediate Termination|Suspension Pending Review|Payment Hold|No Impact - Monitoring Only`',
    `reason` STRING COMMENT 'Detailed explanation of the reason for the sanction, including the nature of the violation or adverse action (e.g., fraud, patient abuse, controlled substance violation).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this sanction record was first created in the data warehouse. Used for audit trail and data lineage.',
    `record_effective_date` DATE COMMENT 'The date from which this version of the sanction record is effective. Used for slowly changing dimension (SCD) Type 2 tracking.',
    `record_end_date` DATE COMMENT 'The date on which this version of the sanction record ceased to be effective. Null for the current version. Used for slowly changing dimension (SCD) Type 2 tracking.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this sanction record was last updated in the data warehouse. Used for audit trail and change tracking.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reinstatement_date` DATE COMMENT 'The date on which the provider was reinstated or the sanction was lifted. Null if the sanction is still active.',
    `resolution_action` STRING COMMENT 'The action taken by the credentialing or compliance team in response to the screening result and sanction identification.. Valid values are `Confirmed - Provider Terminated|Confirmed - Payment Hold|False Positive - No Action|Pending Investigation`',
    `resolution_date` DATE COMMENT 'The date on which the resolution action was completed and documented. Null if the sanction is still under investigation.',
    `sanction_date` DATE COMMENT 'The date on which the sanction or exclusion was officially imposed by the sanctioning authority.',
    `sanction_type` STRING COMMENT 'The category of sanction or exclusion imposed on the provider. Determines the scope and impact of the sanction on participation status.. Valid values are `OIG Exclusion|SAM Exclusion|State Medicaid Exclusion|DEA Revocation|Medical Board Action|Licensure Disciplinary Action`',
    `screened_by` STRING COMMENT 'Identifier of the staff member or automated system that performed the screening. May be a staff ID or system name (e.g., Automated Screening Service).',
    `screening_date` DATE COMMENT 'The date on which the screening was performed that identified this sanction. Required for monthly OIG/SAM screening compliance.',
    `screening_result` STRING COMMENT 'The outcome of the screening event: clear (no match), match found (confirmed sanction), or potential match requiring manual review.. Valid values are `Clear|Match Found|Potential Match - Manual Review Required`',
    `screening_source` STRING COMMENT 'The authoritative database or list consulted during the screening event (e.g., OIG LEIE, SAM.gov, state Medicaid exclusion lists).. Valid values are `OIG LEIE|SAM.gov|State Medicaid Exclusion List|EPLS|Manual Review`',
    `severity_level` STRING COMMENT 'The severity classification of the sanction, indicating the level of risk and impact on provider participation and payment eligibility.. Valid values are `Critical|High|Medium|Low`',
    `source` STRING COMMENT 'The authoritative body or system that issued the sanction (e.g., OIG, SAM.gov, State Medicaid Agency, DEA, State Medical Board).',
    `source_system_code` STRING COMMENT 'The unique identifier for this sanction record in the source system. Used for data lineage and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `waiver_expiration_date` DATE COMMENT 'The date on which the exclusion waiver expires and the sanction impact resumes. Null if no waiver granted or waiver is indefinite.',
    `waiver_reason` STRING COMMENT 'Explanation of the reason for granting an exclusion waiver, including business justification and regulatory approval details. Null if no waiver granted.',
    CONSTRAINT pk_sanction PRIMARY KEY(`sanction_id`)
) COMMENT 'Single source of truth for all sanctions, exclusions, adverse actions, and the periodic screening events that detect them. Captures sanction records: sanction type (OIG exclusion, SAM exclusion, state Medicaid exclusion, DEA revocation, medical board action, licensure disciplinary action), sanction source, sanction date, reinstatement date, sanction reason, severity level, and impact on participation status. Also captures screening events: screening date, screening source (OIG LEIE, SAM.gov, state Medicaid exclusion lists, EPLS), provider NPI screened, screening result (clear, match found, potential match requiring manual review), match details, resolution action, resolution date, and screened-by (staff ID or automated system). Supports mandatory monthly OIG/SAM exclusion screening compliance, NCQA credentialing standards, CMS program integrity requirements, Medicaid/Medicare fraud prevention, and complete audit trail for regulatory examinations. Critical for preventing payment to excluded providers and defending screening compliance during CMS and OIG audits.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` (
    `exclusion_screening_id` BIGINT COMMENT 'Unique identifier for the exclusion screening event record.',
    `employee_id` BIGINT COMMENT 'The system user identifier or employee ID of the individual or automated process that initiated the screening event.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider being screened against exclusion lists.',
    `vendor_id` BIGINT COMMENT 'add column vendor_id (BIGINT) with FK to vendor.vendor.vendor_id - exclusion screening uses external data sources',
    `audit_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this screening event has been flagged for audit review due to anomalies, policy violations, or regulatory examination requirements.',
    `audit_notes` STRING COMMENT 'Free-text notes documenting audit findings, reviewer comments, or regulatory examination references related to this screening event.',
    `cms_reporting_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this screening event must be included in CMS regulatory reporting submissions or program integrity audits.',
    `compliance_status` STRING COMMENT 'The compliance status of this screening event relative to regulatory requirements: compliant (on schedule), overdue (past due date), pending review (awaiting resolution), non-compliant (violation), or waived (exception granted).. Valid values are `Compliant|Overdue|Pending Review|Non-Compliant|Waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_source_version` STRING COMMENT 'The version or publication date of the exclusion list data source used for this screening, ensuring traceability to the specific list snapshot consulted.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `exclusion_effective_date` DATE COMMENT 'The date on which the exclusion became effective, as reported by the exclusion list source. Null if no match found.',
    `exclusion_end_date` DATE COMMENT 'The date on which the exclusion is scheduled to end or was lifted, if applicable. Null for indefinite exclusions or no match.',
    `exclusion_reason` STRING COMMENT 'The reason or statutory basis for the exclusion as reported by the exclusion list source (e.g., fraud, patient abuse, license revocation). Null if no match found.',
    `exclusion_type` STRING COMMENT 'The scope of the exclusion found: Federal (Medicare/Medicaid), State (state-specific Medicaid), Both (federal and state), or None (no exclusion).. Valid values are `Federal|State|Both|None`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `match_details` STRING COMMENT 'Detailed narrative or structured information about the match, including matched data elements, exclusion list entry identifiers, and any discrepancies requiring review.',
    `match_type` STRING COMMENT 'The type of match logic that triggered a positive or potential screening result, indicating which data elements matched the exclusion list entry.. Valid values are `Exact NPI Match|Name and DOB Match|Name and Address Match|Partial Match|No Match`',
    `next_screening_due_date` DATE COMMENT 'The date by which the next exclusion screening is required for this provider to maintain compliance with CMS monthly screening mandates.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier of the provider being screened, as assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `prior_screening_date` DATE COMMENT 'The date of the most recent prior exclusion screening for this provider, used to track screening cadence and compliance with monthly requirements.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this exclusion screening record was first created in the system.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this exclusion screening record was last modified or updated.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `resolution_action` STRING COMMENT 'The action taken by the health plan in response to the screening result: no action (clear result), provider termination, contract suspension, pending manual review, false positive confirmation, or waiver granted per policy.. Valid values are `No Action Required|Provider Terminated|Contract Suspended|Manual Review Pending|False Positive Confirmed|Waiver Granted`',
    `resolution_date` DATE COMMENT 'The date on which the resolution action was completed or the screening result was finalized. Null if resolution is still pending.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution process, including rationale for the action taken, supporting evidence reviewed, and any exceptions or waivers applied.',
    `screened_by_name` STRING COMMENT 'The full name of the individual or system process that performed the screening, for audit trail purposes.',
    `screening_date` DATE COMMENT 'The date on which the exclusion screening was performed.',
    `screening_frequency` STRING COMMENT 'The scheduled frequency or trigger for this screening event: monthly (CMS-required), quarterly, annual, ad hoc (event-driven), or initial credentialing.. Valid values are `Monthly|Quarterly|Annual|Ad Hoc|Initial Credentialing`',
    `screening_method` STRING COMMENT 'The method or channel used to perform the exclusion screening: automated batch process, manual lookup by staff, real-time API integration, or third-party vendor service.. Valid values are `Automated Batch|Manual Lookup|API Integration|Third-Party Vendor`',
    `screening_result` STRING COMMENT 'The outcome of the exclusion screening: Clear (no match), Match Found (confirmed exclusion), Potential Match (requires manual review), Inconclusive (insufficient data), or Error (screening system failure).. Valid values are `Clear|Match Found|Potential Match|Inconclusive|Error`',
    `screening_source` STRING COMMENT 'The authoritative exclusion list source(s) checked during this screening event (OIG List of Excluded Individuals and Entities, System for Award Management, state Medicaid exclusion lists, or General Services Administration Excluded Parties List System).. Valid values are `OIG LEIE|SAM.gov|State Medicaid Exclusion|GSA EPLS|Multiple Sources`',
    `screening_vendor` STRING COMMENT 'The name of the third-party vendor or service provider used to perform the exclusion screening, if applicable. Null for in-house screenings.',
    `source_system_code` STRING COMMENT 'The unique identifier for this exclusion screening record in the source system, used for data lineage and reconciliation.',
    `state_reporting_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this screening event must be reported to state Department of Insurance or Medicaid agencies per state-specific requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vendor_transaction_reference` STRING COMMENT 'The unique transaction or reference identifier assigned by the third-party screening vendor for this screening event, used for vendor reconciliation and support.',
    CONSTRAINT pk_exclusion_screening PRIMARY KEY(`exclusion_screening_id`)
) COMMENT 'Tracks the periodic OIG/SAM exclusion screening events performed against the provider roster. Records screening date, screening source (OIG LEIE, SAM.gov, state Medicaid exclusion list), provider NPI screened, screening result (clear, match found, potential match), match details, resolution action, and screened by. Supports monthly CMS-required exclusion screening compliance, audit trail for regulatory examinations, and Medicaid/Medicare program integrity requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` (
    `participation_status_id` BIGINT COMMENT 'Unique identifier for the provider participation status record.',
    `provider_contract_id` BIGINT COMMENT 'Identifier of the provider contract governing this participation relationship. Links to the provider contract entity.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with this participation status. Links to the plan master entity.',
    `provider_id` BIGINT COMMENT 'Identifier of the healthcare provider whose participation status is being tracked. Links to the provider master entity.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network in which the provider participates. Links to the network master entity.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients within this network and plan. Critical for provider directory accuracy and member access to care.',
    `claims_adjudication_flag` BOOLEAN COMMENT 'Indicates whether claims from this provider should be adjudicated as in-network for this plan and network. This is the authoritative flag for claims processing network determination.',
    `participation_status_code` STRING COMMENT 'Current participation status of the provider within the network and plan. Active status indicates the provider is eligible for in-network claims adjudication. This is the authoritative field for network participation determination.. Valid values are `ACTIVE|INACTIVE|TERMINATED|SUSPENDED|PENDING_CREDENTIALING|PENDING_CONTRACTING`',
    `continuity_of_care_end_date` DATE COMMENT 'The date through which continuity of care provisions apply for members in active treatment with this provider. Allows in-network benefits to continue for a transition period after provider termination.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credentialing_approval_date` DATE COMMENT 'The date on which the provider was approved through the credentialing process for this participation arrangement.',
    `credentialing_status` STRING COMMENT 'The current credentialing status of the provider for this participation arrangement. Credentialing approval is a prerequisite for active participation status.. Valid values are `INITIAL|RECREDENTIALING|APPROVED|DENIED|EXPIRED|UNDER_REVIEW`',
    `current_record_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the participation status record. True for the most recent version, false for historical versions.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `directory_display_flag` BOOLEAN COMMENT 'Indicates whether the provider should be displayed in the member-facing provider directory for this network and plan. May be false during pending credentialing or for providers with restricted panel status.',
    `effective_date` DATE COMMENT 'The date on which this participation status becomes effective. Claims with service dates on or after this date are subject to this participation status for network determination.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT 'The line of business for which this participation status applies. Determines the regulatory framework and benefit structure applicable to this participation relationship.. Valid values are `COMMERCIAL|MEDICARE_ADVANTAGE|MEDICAID|CHIP|MARKETPLACE|QHP`',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_notification_date` DATE COMMENT 'The date on which affected members were notified of the provider participation status change. Required for regulatory compliance with provider termination notification requirements.',
    `member_notification_method` STRING COMMENT 'The communication channel used to notify members of the provider participation status change.. Valid values are `MAIL|EMAIL|PORTAL|PHONE|SMS`',
    `participation_status_name` STRING COMMENT 'Human-readable description of the participation status code.',
    `network_tier_code` STRING COMMENT 'The network tier assignment for this provider participation. Determines member cost-sharing levels in tiered network products.. Valid values are `TIER_1|TIER_2|TIER_3|PREFERRED|STANDARD|OUT_OF_NETWORK`',
    `next_recredentialing_date` DATE COMMENT 'The date by which the provider must complete recredentialing to maintain active participation status. Typically occurs every 24-36 months per NCQA standards.',
    `panel_status` STRING COMMENT 'Indicates whether the provider panel is open to new member assignments. Closed or restricted panels may still serve existing members but do not accept new PCP assignments.. Valid values are `OPEN|CLOSED|RESTRICTED`',
    `participation_category` STRING COMMENT 'The category of participation indicating the scope of services the provider is authorized to deliver under this arrangement.. Valid values are `FULL|LIMITED|ANCILLARY|FACILITY|DME`',
    `pcp_flag` BOOLEAN COMMENT 'Indicates whether the provider is participating as a primary care provider in this network and plan. Determines PCP assignment eligibility for HMO and POS products.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this participation status record was first created in the data platform.',
    `record_effective_date` DATE COMMENT 'The business effective date of this participation status record version. Used for slowly changing dimension type 2 historization.',
    `record_end_date` DATE COMMENT 'The business end date of this participation status record version. Null for the current active version. Used for slowly changing dimension type 2 historization.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this participation status record was last updated in the data platform.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_sanction_flag` BOOLEAN COMMENT 'Indicates whether the provider is currently under regulatory sanction that affects their participation status. Sanctions may be imposed by state medical boards, CMS, or other regulatory bodies.',
    `risk_arrangement_code` STRING COMMENT 'The financial risk arrangement under which the provider participates. Indicates whether the provider is paid fee-for-service, capitation, or under a value-based care model.. Valid values are `FFS|CAPITATION|SHARED_SAVINGS|BUNDLED_PAYMENT|VBC`',
    `sanction_effective_date` DATE COMMENT 'The date on which a regulatory sanction affecting participation status became effective.',
    `sanction_end_date` DATE COMMENT 'The date on which a regulatory sanction affecting participation status is scheduled to end or was lifted.',
    `source_system_code` STRING COMMENT 'The unique identifier for this participation status record in the source system. Used for data lineage and reconciliation.',
    `specialist_flag` BOOLEAN COMMENT 'Indicates whether the provider is participating as a specialist in this network and plan. Used for network adequacy reporting and referral management.',
    `status_change_trigger` STRING COMMENT 'The business event or process that triggered this participation status change. Used for audit trail and root cause analysis of network changes. [ENUM-REF-CANDIDATE: CREDENTIALING_DECISION|CONTRACT_EXECUTION|CONTRACT_TERMINATION|SANCTION_IMPOSED|VOLUNTARY_REQUEST|NETWORK_CHANGE|RECREDENTIALING_OUTCOME — 7 candidates stripped; promote to reference product]',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether the provider offers telehealth services under this participation arrangement. Required for provider directory display and member access to virtual care.',
    `termination_date` DATE COMMENT 'The date on which this participation status ends. Null for active, ongoing participation. Claims with service dates after this date are subject to out-of-network adjudication unless continuity of care provisions apply.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for participation termination. Required for regulatory reporting and member notification requirements.. Valid values are `VOLUNTARY_WITHDRAWAL|CONTRACT_EXPIRATION|CREDENTIALING_FAILURE|QUALITY_ISSUE|SANCTION|NETWORK_REDESIGN`',
    `termination_reason_description` STRING COMMENT 'Detailed explanation of the termination reason. Provides additional context beyond the standardized termination reason code.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_participation_status PRIMARY KEY(`participation_status_id`)
) COMMENT 'Tracks the participation status history of a provider within a specific health plan, network, and line of business (LOB). Records participation status (active, inactive, terminated, suspended, pending credentialing), effective date, termination date, termination reason code, LOB (commercial, Medicare Advantage, Medicaid, CHIP, marketplace/QHP), network ID, and status change trigger (credentialing decision, contract termination, sanction, voluntary withdrawal). This is the authoritative record for claims adjudication in-network/out-of-network determination. Supports member notification requirements for provider terminations, continuity of care provisions, and regulatory reporting of network changes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` (
    `dea_registration_id` BIGINT COMMENT 'Primary key for dea_registration',
    `license_id` BIGINT COMMENT 'add column license_id (BIGINT) with FK to provider.license.license_id - DEA registrations are paired with state licenses',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: dea_registration must be linked to the core provider entity to avoid silo; provider_npi is redundant once provider_id is present.',
    `controlled_substance_authorized_flag` BOOLEAN COMMENT 'True if the provider is authorized to prescribe controlled substances.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `current_record_flag` BOOLEAN COMMENT 'True if this row represents the current active registration for the provider.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dea_number` STRING COMMENT 'Unique DEA registration number assigned to the provider for controlled substance prescribing.. Valid values are `^[A-Z]{2}d{7}$`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date the DEA registration expires unless renewed.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `issue_date` DATE COMMENT 'Date the DEA registration became effective.',
    `issuing_agency` STRING COMMENT 'Agency that issued the DEA registration (typically DEA).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DEA registration record.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free-text field for any additional comments or remarks about the registration.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DEA registration record was first created in the system.',
    `record_end_date` DATE COMMENT 'Date the record became inactive (e.g., when registration was revoked).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `registration_state` STRING COMMENT 'Two-letter US state code where the DEA registration was issued. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product]',
    `registration_status` STRING COMMENT 'Current lifecycle status of the DEA registration.. Valid values are `active|expired|revoked|surrendered|pending`',
    `registration_type` STRING COMMENT 'Indicates whether the registration is for an individual provider or an organization.. Valid values are `individual|organization`',
    `schedule_authorized` STRING COMMENT 'DEA schedule(s) the provider is authorized to prescribe (II, III, IV, V).. Valid values are `II|III|IV|V`',
    `source_system_code` STRING COMMENT 'Unique identifier of the DEA registration record in the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `verification_date` DATE COMMENT 'Date the DEA registration information was last verified against the primary source.',
    CONSTRAINT pk_dea_registration PRIMARY KEY(`dea_registration_id`)
) COMMENT 'Tracks Drug Enforcement Administration (DEA) registration records for providers authorized to prescribe controlled substances. Stores DEA registration number, DEA schedules authorized (II, III, IV, V), registration state, issue date, expiration date, registration status (active, expired, revoked, surrendered), and primary source verification date. Required for NCQA credentialing standards for prescribing providers and supports pharmacy benefit management and prior authorization workflows.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` (
    `obligation_compliance_id` BIGINT COMMENT '',
    `provider_id` BIGINT COMMENT '',
    `obligation_id` BIGINT COMMENT '',
    `obligation_mapping_id` BIGINT COMMENT '',
    `compliance_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `evidence_received_date` DATE COMMENT '',
    `next_review_date` DATE COMMENT '',
    `finding_severity_code` STRING COMMENT '',
    `remediation_plan_text` STRING COMMENT '',
    CONSTRAINT pk_obligation_compliance PRIMARY KEY(`obligation_compliance_id`)
) COMMENT 'This association captures the compliance relationship between a provider and a regulatory obligation. Each record links one provider to one regulatory obligation and stores compliance_status and last_assessment_date, which are specific to that link.. Existence Justification: Providers must meet many regulatory obligations, and each regulatory obligation applies to many providers. The compliance team actively tracks the compliance status and assessment dates for each provider‑obligation pair, creating a distinct record for every association. This operational process requires a many‑to‑many association with its own attributes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` (
    `audit_assignment_id` BIGINT COMMENT '',
    `provider_id` BIGINT COMMENT '',
    `audit_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `assignment_status_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `termination_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `assigned_date` DATE COMMENT '',
    `due_date` DATE COMMENT '',
    `completion_date` DATE COMMENT '',
    `audit_status_code` STRING COMMENT '',
    `audit_score` DECIMAL(18,2) COMMENT '',
    `findings_count` BIGINT COMMENT '',
    CONSTRAINT pk_audit_assignment PRIMARY KEY(`audit_assignment_id`)
) COMMENT 'Association representing the assignment of an audit engagement to a provider, capturing the scope and period specific to that provider.. Existence Justification: A provider can be subject to multiple audit engagements, and each audit engagement can cover multiple providers. The audit‑provider link is actively managed by compliance teams, who assign audits to providers and record scope and period for each association.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` (
    `outreach_campaign_id` BIGINT COMMENT 'Primary key for outreach_campaign',
    `employee_id` BIGINT COMMENT 'add column owner_employee_id (BIGINT) with FK to workforce.employee.employee_id - campaigns have an owner',
    `parent_outreach_campaign_id` BIGINT COMMENT 'Self-referencing FK on outreach_campaign (parent_outreach_campaign_id)',
    `provider_network_id` BIGINT COMMENT 'add column provider_network_id (BIGINT) with FK to network.provider_network.provider_network_id - campaigns target specific networks',
    `approval_by` STRING COMMENT 'Email address of the user who approved or rejected the campaign.',
    `approval_comments` STRING COMMENT 'Comments or notes provided during the approval process.',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the campaign was approved or rejected.',
    `campaign_approval_status` STRING COMMENT 'Current approval state of the campaign.',
    `campaign_budget` DECIMAL(18,2) COMMENT 'Allocated budget for the campaign in the campaign currency.',
    `campaign_channel` STRING COMMENT 'Specific channel used for the campaign such as web, mobile app, email, SMS, phone, mail, or social media. [ENUM-REF-CANDIDATE: web|mobile_app|email|sms|phone|mail|social_media — promote to reference product]',
    `campaign_created_at` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created.',
    `campaign_created_by` STRING COMMENT 'Email address of the user who created the campaign record.',
    `campaign_currency` STRING COMMENT 'ISO 4217 three-letter currency code for budget and spend amounts.',
    `campaign_description` STRING COMMENT 'Detailed description of the outreach campaign objectives and scope.',
    `campaign_frequency` STRING COMMENT 'How often the campaign is executed or repeated.',
    `campaign_goal` STRING COMMENT 'Primary objective or KPI the campaign aims to achieve.',
    `campaign_metric` STRING COMMENT 'Metric used to measure campaign performance (e.g., response rate, conversion rate).',
    `campaign_name` STRING COMMENT 'Human-readable name of the outreach campaign.',
    `campaign_owner` STRING COMMENT 'Full name of the individual responsible for the campaign.',
    `campaign_spend` DECIMAL(18,2) COMMENT 'Actual spend incurred for the campaign to date.',
    `campaign_target_audience` STRING COMMENT 'Broad description of the audience the campaign is intended to reach.',
    `campaign_target_audience_age_range` STRING COMMENT 'Age range of the target audience (e.g., 18-25).',
    `campaign_target_audience_demographics` STRING COMMENT 'Demographic attributes of the target audience (e.g., age, gender, income).',
    `campaign_target_audience_description` STRING COMMENT 'Detailed description of the target audience characteristics.',
    `campaign_target_audience_gender` STRING COMMENT 'Gender distribution of the target audience.',
    `campaign_target_audience_geo` STRING COMMENT 'ISO 3166-1 alpha-3 country code(s) representing the geographic focus of the campaign.',
    `campaign_target_audience_income_range` STRING COMMENT 'Income bracket of the target audience.',
    `campaign_target_audience_insurance_type` STRING COMMENT 'Type of insurance coverage held by the target audience.',
    `campaign_target_audience_member_since_date` DATE COMMENT 'Date when the target audience members became part of the insurers system.',
    `campaign_target_audience_member_status` STRING COMMENT 'Current membership status of the target audience within the insurers system.',
    `campaign_target_audience_plan_type` STRING COMMENT 'Plan tier of the target audiences insurance coverage.',
    `campaign_target_audience_size` BIGINT COMMENT 'Estimated number of individuals in the target audience.',
    `campaign_type` STRING COMMENT 'Mode of outreach such as email, SMS, phone, mail, in-person, digital, or social media. [ENUM-REF-CANDIDATE: email|sms|phone|mail|in_person|digital|social_media — promote to reference product]',
    `campaign_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    `campaign_updated_by` STRING COMMENT 'Email address of the user who last updated the campaign record.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the campaign becomes effective and starts reaching the target audience.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the campaign ends or is no longer effective.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the campaign (e.g., active, paused, completed, archived).',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `owner_department` STRING COMMENT 'Department or business unit where the campaign owner is based.',
    `owner_email` STRING COMMENT 'Email address of the campaign owner.',
    `owner_phone` STRING COMMENT 'Primary phone number of the campaign owner.',
    `owner_role` STRING COMMENT 'Role or title of the campaign owner within the organization.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_outreach_campaign PRIMARY KEY(`outreach_campaign_id`)
) COMMENT 'Master reference table for outreach_campaign. Referenced by campaign_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`provider` (
    `provider_id` BIGINT COMMENT 'Primary key for provider',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_npi_registry_sync_id` BIGINT COMMENT 'Foreign key to provider.npi_registry_sync.npi_registry_sync_id',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_provider PRIMARY KEY(`provider_id`)
) COMMENT 'SSOT owner for the provider entity (merged provider/provider_provider). Canonical provider master.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` (
    `provider_directory_verification_id` BIGINT COMMENT 'System‑generated unique identifier for each provider directory verification record.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or automated system that performed the verification.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider whose directory information is being verified.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `current_record_flag` BOOLEAN COMMENT 'Indicates whether this row represents the current active version of the verification record.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fields_verified` STRING COMMENT 'Pipe‑separated list of provider directory fields that were verified in this event (e.g., address|phone|specialty|accepting_patients).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_verification_date` DATE COMMENT 'Scheduled future date for the next required verification of this providers directory information.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured during the verification process.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the verification record was first inserted into the lakehouse.',
    `record_effective_date` DATE COMMENT 'Date from which this version of the verification record is considered effective (SCD Type 2).',
    `record_end_date` DATE COMMENT 'Date when this version of the verification record ceased to be effective; null if current.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the verification record.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_system_code` STRING COMMENT 'Native identifier of the verification record in the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `verification_method` STRING COMMENT 'Channel used to conduct the verification (e.g., phone call, mailed questionnaire, online portal, provider attestation).. Valid values are `phone|mail|online|attestation`',
    `verification_number` STRING COMMENT 'Business‑visible sequential number assigned to the verification event for tracking and reporting.',
    `verification_outcome` STRING COMMENT 'Result of the verification activity indicating whether the record was confirmed, required an update, could not be reached, or the provider was removed from the directory.. Valid values are `confirmed|updated|unable_to_reach|removed`',
    `verification_status` STRING COMMENT 'Current lifecycle status of the verification record.. Valid values are `pending|completed|failed|cancelled`',
    `verification_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the verification activity was performed.',
    CONSTRAINT pk_provider_directory_verification PRIMARY KEY(`provider_directory_verification_id`)
) COMMENT 'Tracks the outreach and verification events conducted to confirm provider directory accuracy as required by CMS and state DOI mandates. Records verification method (phone, mail, online portal, attestation), verification date, verified by (staff ID or automated system), verification outcome (confirmed, updated, unable to reach, removed), fields verified (address, phone, accepting patients, specialty), and next scheduled verification date. Supports CMS quarterly directory accuracy reporting and no-surprise billing compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` (
    `provider_outreach_id` BIGINT COMMENT 'Unique identifier for the provider outreach event. Primary key for the provider outreach data product.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Outreach compliance tracking ties outreach actions to the governing contract to ensure activities meet contractual obligations.',
    `employee_id` BIGINT COMMENT 'Identifier of the health plan staff member who conducted this outreach event, supporting workforce tracking and audit trails.',
    `outreach_campaign_id` BIGINT COMMENT 'Identifier of the broader outreach campaign or initiative that this outreach event is part of, supporting batch verification and reporting.',
    `provider_id` BIGINT COMMENT 'Identifier of the healthcare provider who is the subject of this outreach event. Links to the provider master data.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Vendor Outreach Management process tracks outreach activities from providers to vendors for credentialing and compliance.',
    `accepting_patients_verified_flag` BOOLEAN COMMENT 'Indicator of whether the provider accepting new patients status was verified during this outreach event.',
    `address_verified_flag` BOOLEAN COMMENT 'Indicator of whether the provider practice address was verified during this outreach event.',
    `attempt_count` STRING COMMENT 'Number of outreach attempts made for this specific outreach event or campaign, tracking persistence in reaching the provider.',
    `attestation_date` DATE COMMENT 'Date when the provider attestation or confirmation was received, supporting regulatory audit trails.',
    `attestation_method` STRING COMMENT 'Method or channel through which the provider attestation was received.. Valid values are `online_portal|email|mail|fax|phone|in_person`',
    `attestation_received_flag` BOOLEAN COMMENT 'Indicator of whether a formal attestation or confirmation document was received from the provider during this outreach event.',
    `compliance_quarter` STRING COMMENT 'Fiscal or calendar quarter for which this outreach event supports directory accuracy compliance reporting (e.g., Q1 2024).',
    `contact_email_address` STRING COMMENT 'Email address used to reach the provider during this outreach event.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the provider or authorized representative who was contacted during this outreach event.',
    `contact_phone_number` STRING COMMENT 'Phone number used to reach the provider during this outreach event.',
    `contact_reached_flag` BOOLEAN COMMENT 'Indicator of whether the provider or their authorized representative was successfully reached during this outreach event.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `current_record_flag` BOOLEAN COMMENT 'Indicator of whether this is the current active version of the outreach record, supporting Type 2 slowly changing dimension logic.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `data_updated_flag` BOOLEAN COMMENT 'Indicator of whether provider directory data was modified or corrected as a result of this outreach event.',
    `data_verified_flag` BOOLEAN COMMENT 'Indicator of whether provider directory data was successfully verified or confirmed during this outreach event.',
    `directory_removal_flag` BOOLEAN COMMENT 'Indicator of whether the provider was removed from the directory as a result of this outreach event (e.g., unable to reach, no longer participating).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fields_verified` STRING COMMENT 'Comma-separated list or description of specific provider data fields that were verified during this outreach event (e.g., address, phone, accepting patients, specialty, hours).',
    `follow_up_reason` STRING COMMENT 'Description of why follow-up outreach is required, providing context for next steps and escalation.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicator of whether additional follow-up outreach is required based on the outcome of this event.',
    `hours_verified_flag` BOOLEAN COMMENT 'Indicator of whether the provider office hours were verified during this outreach event.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_verification_date` DATE COMMENT 'Scheduled date for the next directory verification outreach event with this provider, supporting quarterly verification compliance.',
    `notes` STRING COMMENT 'Free-text notes or comments documenting details of the outreach conversation, provider responses, and any issues encountered.',
    `outcome` STRING COMMENT 'Result or disposition of the outreach attempt, indicating whether contact was successful and what action was taken.. Valid values are `reached|confirmed|updated|voicemail|no_response|unable_to_reach`',
    `outreach_date` DATE COMMENT 'Date when the outreach event was conducted or attempted. Primary business event date for this transaction.',
    `outreach_method` STRING COMMENT 'Communication channel or medium used to conduct the outreach event with the provider.. Valid values are `phone|email|mail|portal|fax|in_person`',
    `outreach_status` STRING COMMENT 'Current lifecycle status of the outreach event, tracking progression from initiation through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `outreach_timestamp` TIMESTAMP COMMENT 'Precise date and time when the outreach event was initiated or conducted, supporting detailed audit trails and SLA tracking.',
    `outreach_type` STRING COMMENT 'Category of outreach activity conducted with the provider. Determines the business purpose and workflow for the outreach event.. Valid values are `directory_verification|credentialing_follow_up|contract_execution|network_recruitment|data_quality_correction|recredentialing_reminder`',
    `phone_verified_flag` BOOLEAN COMMENT 'Indicator of whether the provider phone number was verified during this outreach event.',
    `purpose` STRING COMMENT 'Detailed description of the specific business purpose or objective for this outreach event, providing context beyond the outreach type.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this outreach record was first created in the data platform, supporting audit trails and data lineage.',
    `record_effective_date` DATE COMMENT 'Date from which this outreach record version is effective, supporting temporal data management and historical analysis.',
    `record_end_date` DATE COMMENT 'Date until which this outreach record version is effective, supporting temporal data management and historical analysis. Null indicates current record.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this outreach record was last modified in the data platform, supporting change tracking and audit trails.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `reference_number` STRING COMMENT 'Business-facing reference number or tracking code for this outreach event, used for audit trails and provider communications.',
    `removal_reason` STRING COMMENT 'Description of why the provider was removed from the directory, supporting compliance documentation and audit trails.',
    `source_system_code` STRING COMMENT 'Unique identifier for this outreach event in the source operational system, supporting data lineage and reconciliation.',
    `specialty_verified_flag` BOOLEAN COMMENT 'Indicator of whether the provider specialty information was verified during this outreach event.',
    `staff_member_name` STRING COMMENT 'Name of the health plan staff member or provider relations representative who conducted this outreach event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_provider_outreach PRIMARY KEY(`provider_outreach_id`)
) COMMENT 'Single source of truth for all outreach, verification, and communication events with providers. Covers directory verification outreach (phone, mail, online portal, attestation), credentialing follow-up, contract execution outreach, network recruitment contacts, and ad-hoc provider communications. Records outreach type, outreach date, outreach purpose (directory verification, re-credentialing reminder, contract renewal, network recruitment, data quality correction), outreach method (phone, email, mail, portal, fax, in-person), outreach outcome (reached, confirmed, updated, voicemail, no response, unable to reach, removed from directory), fields verified (address, phone, accepting patients, specialty, hours), staff member conducting outreach, next scheduled verification date, follow-up required flag, and attempt count. Supports CMS quarterly directory accuracy reporting, no-surprise billing compliance, state DOI directory accuracy mandates, provider relations workflows, and regulatory audit trails. This is the authoritative record for demonstrating directory verification compliance during CMS and state audits.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` (
    `provider_network_participation2_id` BIGINT COMMENT 'Primary key for the NetworkParticipation association',
    `facility_id` BIGINT COMMENT 'Foreign key linking to the facility',
    `fee_schedule_id` BIGINT COMMENT 'FK to fee schedule - participation records reference fee schedules',
    `par_agreement_id` BIGINT COMMENT 'FK to par agreement - participation linked to participating provider agreement',
    `provider_contract_id` BIGINT COMMENT 'FK to the provider contract governing participation terms',
    `provider_id` BIGINT COMMENT '',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to the provider network',
    `accepting_new_patients` BOOLEAN COMMENT 'Accepting new patients flag',
    `capitation_eligible_flag` BOOLEAN COMMENT 'Flag indicating capitation eligibility',
    `contract_type` STRING COMMENT 'Contract type',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `credentialing_status` STRING COMMENT 'Credentialing status',
    `credentialing_status_code` STRING COMMENT 'Credentialing status code',
    `current_panel_size` STRING COMMENT 'Current panel size',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `directory_display_flag` BOOLEAN COMMENT '',
    `effective_date` DATE COMMENT 'Date the facilitys participation became effective',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_practitioner_role_identifier` STRING COMMENT 'FHIR PractitionerRole resource identifier for interoperability',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `geographic_restriction` STRING COMMENT 'Geographic area restriction for this network participation',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT '',
    `master_entity_identifier` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_tier` STRING COMMENT 'Tier classification of the facility within the network (e.g., Tier 1, Tier 2)',
    `panel_capacity` STRING COMMENT 'Panel capacity',
    `par_agreement_signed_date` DATE COMMENT 'Date the participation agreement was signed',
    `par_indicator` BOOLEAN COMMENT 'Participating indicator.',
    `participation_effective_date` DATE COMMENT 'Participation effective date',
    `participation_role` STRING COMMENT 'Role within the network (PCP, specialist, ancillary).',
    `participation_status` STRING COMMENT 'Current in‑network or out‑of‑network status for the facility in this network',
    `participation_status_code` STRING COMMENT 'Participation status code',
    `participation_termination_date` DATE COMMENT 'Participation termination date',
    `participation_tier_code` STRING COMMENT 'Participation tier code',
    `participation_type` STRING COMMENT 'Type of participation',
    `quality_score` DECIMAL(18,2) COMMENT 'Quality score',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT '',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT '',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recredential_due_date` DATE COMMENT 'Date by which recredentialing must be completed to maintain participation',
    `reimbursement_arrangement` STRING COMMENT '',
    `reimbursement_method` STRING COMMENT '',
    `specialty_restriction` STRING COMMENT 'Any specialty restrictions on the participation scope',
    `status_code` STRING COMMENT '',
    `termination_date` DATE COMMENT 'Date the facilitys participation ends or is scheduled to end',
    `termination_reason` STRING COMMENT '',
    `tier_code` STRING COMMENT '',
    `tier_level` STRING COMMENT 'Network tier level',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp.',
    `vbc_eligible_flag` BOOLEAN COMMENT 'Flag indicating value-based care eligibility',
    CONSTRAINT pk_provider_network_participation2 PRIMARY KEY(`provider_network_participation2_id`)
) COMMENT 'Represents the contractual participation of a healthcare facility in a provider network. Each record links one facility to one network and stores attributes that describe the nature of that participation.. Existence Justification: A healthcare facility can belong to multiple provider networks simultaneously, and each provider network includes many facilities. The relationship is actively managed (contracts/agreements) and carries attributes such as participation status and effective/termination dates.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` (
    `provider_network_participation_id` BIGINT COMMENT 'Primary key for provider_network_participation',
    `fee_schedule_id` BIGINT COMMENT '',
    `par_agreement_id` BIGINT COMMENT '',
    `capitation_eligible_flag` BOOLEAN COMMENT '',
    `credentialing_status_code` STRING COMMENT '',
    `participation_effective_date` DATE COMMENT '',
    `participation_status_code` STRING COMMENT '',
    `participation_termination_date` DATE COMMENT '',
    `tier_code` STRING COMMENT '',
    `vbc_eligible_flag` BOOLEAN COMMENT '',
    `participation_tier_code` STRING COMMENT '',
    CONSTRAINT pk_provider_network_participation PRIMARY KEY(`provider_network_participation_id`)
) COMMENT 'Tracks provider participation in network arrangements, including effective dates, termination dates, and participation status.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`provider`.`provider_provider` (
    `provider_id` BIGINT COMMENT 'Primary key for provider_provider',
    `fhir_practitioner_resource_id` STRING COMMENT '',
    CONSTRAINT pk_provider_provider PRIMARY KEY(`provider_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ADD CONSTRAINT `fk_provider_practice_location_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ADD CONSTRAINT `fk_provider_practice_location_practice_medicare_enrolled_provider_id` FOREIGN KEY (`practice_medicare_enrolled_provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ADD CONSTRAINT `fk_provider_practice_location_primary_provider_id` FOREIGN KEY (`primary_provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ADD CONSTRAINT `fk_provider_license_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_group_practice_id` FOREIGN KEY (`group_practice_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`group_practice`(`group_practice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ADD CONSTRAINT `fk_provider_group_practice_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ADD CONSTRAINT `fk_provider_group_practice_group_medicare_provider_id` FOREIGN KEY (`group_medicare_provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ADD CONSTRAINT `fk_provider_facility_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ADD CONSTRAINT `fk_provider_facility_provider_provider_id` FOREIGN KEY (`provider_provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider_provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ADD CONSTRAINT `fk_provider_directory_entry_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ADD CONSTRAINT `fk_provider_npi_registry_sync_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_exclusion_screening_id` FOREIGN KEY (`exclusion_screening_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`exclusion_screening`(`exclusion_screening_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ADD CONSTRAINT `fk_provider_exclusion_screening_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ADD CONSTRAINT `fk_provider_participation_status_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_license_id` FOREIGN KEY (`license_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`license`(`license_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` ADD CONSTRAINT `fk_provider_obligation_compliance_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` ADD CONSTRAINT `fk_provider_audit_assignment_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ADD CONSTRAINT `fk_provider_outreach_campaign_parent_outreach_campaign_id` FOREIGN KEY (`parent_outreach_campaign_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`outreach_campaign`(`outreach_campaign_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ADD CONSTRAINT `fk_provider_provider_directory_verification_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ADD CONSTRAINT `fk_provider_provider_outreach_outreach_campaign_id` FOREIGN KEY (`outreach_campaign_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`outreach_campaign`(`outreach_campaign_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ADD CONSTRAINT `fk_provider_provider_outreach_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ADD CONSTRAINT `fk_provider_provider_network_participation2_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`facility`(`facility_id`);
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ADD CONSTRAINT `fk_provider_provider_network_participation2_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `vibe_health_insurance_v1`.`provider`.`provider`(`provider_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`provider` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`provider` SET TAGS ('pii_domain' = 'provider');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_subdomain' = 'provider_identity');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_fhir_resource' = 'PractitionerRole.specialty');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Specialty Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `board_certified_flag` SET TAGS ('pii_business_glossary_term' = 'Board Certified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `specialty_category` SET TAGS ('pii_business_glossary_term' = 'Specialty Category');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `certification_date` SET TAGS ('pii_business_glossary_term' = 'Board Certification Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `certification_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Board Certification Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `certification_number` SET TAGS ('pii_business_glossary_term' = 'Board Certification Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `certification_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `certification_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `certifying_board_name` SET TAGS ('pii_business_glossary_term' = 'Certifying Board Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Taxonomy Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `specialty_code` SET TAGS ('pii_value_regex' = '^[0-9]{10}X$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `specialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `credentialing_effective_date` SET TAGS ('pii_business_glossary_term' = 'Specialty Credentialing Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `credentialing_end_date` SET TAGS ('pii_business_glossary_term' = 'Specialty Credentialing End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `credentialing_review_date` SET TAGS ('pii_business_glossary_term' = 'Specialty Credentialing Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Specialty Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|suspended|expired|revoked');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `current_record_flag` SET TAGS ('pii_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Specialty Practice End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fellowship_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Fellowship Completed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fellowship_completion_date` SET TAGS ('pii_business_glossary_term' = 'Fellowship Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fellowship_program_name` SET TAGS ('pii_business_glossary_term' = 'Fellowship Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `hedis_specialty_flag` SET TAGS ('pii_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Specialty Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `specialty_name` SET TAGS ('pii_business_glossary_term' = 'Specialty Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `network_adequacy_category` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `next_credentialing_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Specialty Credentialing Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `pcp_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider (PCP) Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `recertification_cycle_years` SET TAGS ('pii_business_glossary_term' = 'Recertification Cycle Years');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `recertification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_effective_date` SET TAGS ('pii_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_end_date` SET TAGS ('pii_business_glossary_term' = 'Record End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `specialist_referral_required_flag` SET TAGS ('pii_business_glossary_term' = 'Specialist Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `specialty_type` SET TAGS ('pii_business_glossary_term' = 'Specialty Type Classification');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `specialty_type` SET TAGS ('pii_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Specialty Practice Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `subspecialty_code` SET TAGS ('pii_business_glossary_term' = 'Subspecialty Taxonomy Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `subspecialty_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `subspecialty_name` SET TAGS ('pii_business_glossary_term' = 'Subspecialty Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`specialty` ALTER COLUMN `years_in_specialty` SET TAGS ('pii_business_glossary_term' = 'Years in Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_subdomain' = 'provider_identity');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_fhir_resource' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `practice_location_id` SET TAGS ('pii_business_glossary_term' = 'Practice Location Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Location Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Medicaid Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `practice_medicare_enrolled_provider_id` SET TAGS ('pii_business_glossary_term' = 'Medicare Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `primary_provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `ada_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `address_line_1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `address_line_2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `county_name` SET TAGS ('pii_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `directory_display_flag` SET TAGS ('pii_business_glossary_term' = 'Directory Display Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `email_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `email_address` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fax_number` SET TAGS ('pii_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fax_number` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fax_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fips_code` SET TAGS ('pii_business_glossary_term' = 'Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fips_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `fips_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `languages_spoken` SET TAGS ('pii_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `location_name` SET TAGS ('pii_business_glossary_term' = 'Practice Location Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `location_type` SET TAGS ('pii_business_glossary_term' = 'Practice Location Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `location_type` SET TAGS ('pii_value_regex' = 'office|hospital|clinic|urgent_care|telehealth_only|ambulatory_surgery_center');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `medical_group_name` SET TAGS ('pii_business_glossary_term' = 'Medical Group Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `medical_group_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `medical_group_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `office_hours` SET TAGS ('pii_business_glossary_term' = 'Office Hours');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `parking_available_flag` SET TAGS ('pii_business_glossary_term' = 'Parking Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `participation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|terminated|pending_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `patient_age_maximum` SET TAGS ('pii_business_glossary_term' = 'Patient Age Maximum');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `patient_age_minimum` SET TAGS ('pii_business_glossary_term' = 'Patient Age Minimum');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `patient_gender_restriction` SET TAGS ('pii_business_glossary_term' = 'Patient Gender Restriction');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `patient_gender_restriction` SET TAGS ('pii_value_regex' = 'all|male_only|female_only');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `patient_gender_restriction` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `patient_gender_restriction` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `public_transportation_access_flag` SET TAGS ('pii_business_glossary_term' = 'Public Transportation Access Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|inactive|deleted|archived');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `tax_identifier` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `tax_identifier` SET TAGS ('pii_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `tax_identifier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `tax_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `telehealth_available_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `verification_method` SET TAGS ('pii_value_regex' = 'phone_verification|site_visit|provider_attestation|electronic_verification');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `wheelchair_accessible_flag` SET TAGS ('pii_business_glossary_term' = 'Wheelchair Accessible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `zip_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `zip_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`practice_location` ALTER COLUMN `zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_subdomain' = 'provider_identity');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_fhir_resource' = 'Practitioner.qualification');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `license_id` SET TAGS ('pii_business_glossary_term' = 'License Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `recredential_cycle_id` SET TAGS ('pii_business_glossary_term' = 'Credentialing Cycle Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'License Verifier Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `attestation_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `authorized_schedules` SET TAGS ('pii_business_glossary_term' = 'Authorized Controlled Substance Schedules');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `compact_participation_flag` SET TAGS ('pii_business_glossary_term' = 'Interstate Compact Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `compact_privilege_states` SET TAGS ('pii_business_glossary_term' = 'Compact Privilege States');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `compact_type` SET TAGS ('pii_business_glossary_term' = 'Interstate Compact Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `continuing_education_hours_required` SET TAGS ('pii_business_glossary_term' = 'Continuing Education Hours Required');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `continuing_education_required_flag` SET TAGS ('pii_business_glossary_term' = 'Continuing Education Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `disciplinary_action_date` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `disciplinary_action_details` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Details');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `disciplinary_action_details` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `disciplinary_action_flag` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `issuing_authority` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `issuing_state` SET TAGS ('pii_business_glossary_term' = 'Issuing State');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `license_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `license_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `license_status` SET TAGS ('pii_business_glossary_term' = 'License Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `license_type` SET TAGS ('pii_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `practice_restrictions` SET TAGS ('pii_business_glossary_term' = 'Practice Restrictions');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `primary_source_verification_date` SET TAGS ('pii_business_glossary_term' = 'Primary Source Verification (PSV) Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `primary_source_verification_method` SET TAGS ('pii_business_glossary_term' = 'Primary Source Verification (PSV) Method');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `primary_source_verification_method` SET TAGS ('pii_value_regex' = 'online_portal|written_correspondence|phone_verification|third_party_service|automated_api');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_current_flag` SET TAGS ('pii_business_glossary_term' = 'Record Current Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_effective_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Effective Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `renewal_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Renewal Cycle Months');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `scope_of_practice` SET TAGS ('pii_business_glossary_term' = 'Scope of Practice');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `telemedicine_authorized_flag` SET TAGS ('pii_business_glossary_term' = 'Telemedicine Authorized Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `verification_source` SET TAGS ('pii_business_glossary_term' = 'Verification Source');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`license` ALTER COLUMN `verification_url` SET TAGS ('pii_business_glossary_term' = 'License Verification Uniform Resource Locator (URL)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_subdomain' = 'network_participation');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_fhir_resource' = 'PractitionerRole');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `affiliation_id` SET TAGS ('pii_business_glossary_term' = 'Affiliation Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Affiliation Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `group_practice_id` SET TAGS ('pii_business_glossary_term' = 'Provider Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `admitting_privileges_flag` SET TAGS ('pii_business_glossary_term' = 'Admitting Privileges Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('pii_business_glossary_term' = 'Affiliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('pii_business_glossary_term' = 'Affiliation Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('pii_value_regex' = 'medical_group|ipa|aco|health_system|hospital|facility');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `billing_npi` SET TAGS ('pii_business_glossary_term' = 'Billing National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `billing_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `billing_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `credentialing_verification_date` SET TAGS ('pii_business_glossary_term' = 'Credentialing Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `department_name` SET TAGS ('pii_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `directory_display_flag` SET TAGS ('pii_business_glossary_term' = 'Directory Display Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Affiliation End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_business_glossary_term' = 'Medical Staff Category');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_value_regex' = 'active|courtesy|consulting|honorary|affiliate|provisional');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `network_participation_flag` SET TAGS ('pii_business_glossary_term' = 'Network Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `next_credentialing_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Credentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Affiliation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `primary_affiliation_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Affiliation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `role_title` SET TAGS ('pii_business_glossary_term' = 'Role Title');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Affiliation Source Record Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Affiliation Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `tin` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `tin` SET TAGS ('pii_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `tin` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`affiliation` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_subdomain' = 'provider_identity');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `group_practice_id` SET TAGS ('pii_business_glossary_term' = 'Group Practice Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Group Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'State Medicaid Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `group_medicare_provider_id` SET TAGS ('pii_business_glossary_term' = 'Medicare Provider Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `accepting_new_patients` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `accessibility_accommodations` SET TAGS ('pii_business_glossary_term' = 'Accessibility Accommodations');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `aco_name` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `aco_participant` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Participant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Primary Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `address_line_1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Primary Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `address_line_2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Certification Number (CCN)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `county` SET TAGS ('pii_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `credentialing_date` SET TAGS ('pii_business_glossary_term' = 'Initial Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'initial|recredentialing|approved|denied|expired');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `data_source_system` SET TAGS ('pii_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Network Participation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `email_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `email_address` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fax_number` SET TAGS ('pii_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fax_number` SET TAGS ('pii_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fax_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `group_name` SET TAGS ('pii_business_glossary_term' = 'Group Practice Legal Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `group_npi` SET TAGS ('pii_business_glossary_term' = 'Group National Provider Identifier (NPI) - Type 2');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `group_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `group_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `group_size` SET TAGS ('pii_business_glossary_term' = 'Group Size (Provider Count)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `group_type` SET TAGS ('pii_business_glossary_term' = 'Group Practice Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `group_type` SET TAGS ('pii_value_regex' = 'solo_practice|single_specialty_group|multi_specialty_group|ipa|fqhc|rhc');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `hospital_affiliation` SET TAGS ('pii_business_glossary_term' = 'Hospital Affiliation Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `language_services_offered` SET TAGS ('pii_business_glossary_term' = 'Language Services Offered');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `participation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|terminated|pending_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `pcmh_recognition_level` SET TAGS ('pii_business_glossary_term' = 'Patient-Centered Medical Home (PCMH) Recognition Level');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `pcmh_recognition_level` SET TAGS ('pii_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `pcmh_recognized` SET TAGS ('pii_business_glossary_term' = 'Patient-Centered Medical Home (PCMH) Recognition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('pii_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `primary_specialty` SET TAGS ('pii_business_glossary_term' = 'Primary Medical Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `recredentialing_due_date` SET TAGS ('pii_business_glossary_term' = 'Recredentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `state` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `tax_identifier` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN) / Employer Identification Number (EIN)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `tax_identifier` SET TAGS ('pii_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `tax_identifier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `tax_identifier` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `taxonomy_code` SET TAGS ('pii_business_glossary_term' = 'Healthcare Provider Taxonomy Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `taxonomy_code` SET TAGS ('pii_value_regex' = '^[0-9]{10}[X]$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `taxonomy_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_business_glossary_term' = 'Telehealth Services Enabled Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Network Participation Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `zip_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `zip_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`group_practice` ALTER COLUMN `zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_subdomain' = 'provider_identity');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_fhir_resource' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `facility_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `bed_count` SET TAGS ('pii_business_glossary_term' = 'Licensed Bed Count');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `ccn` SET TAGS ('pii_business_glossary_term' = 'CMS Certification Number (CCN)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `ccn` SET TAGS ('pii_value_regex' = '^[0-9A-Z]{6}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `clia_number` SET TAGS ('pii_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `clia_number` SET TAGS ('pii_value_regex' = '^[0-9]{2}[A-Z][0-9]{7}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `clia_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `county_name` SET TAGS ('pii_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `credentialing_effective_date` SET TAGS ('pii_business_glossary_term' = 'Credentialing Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'approved|pending|expired|suspended|denied');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `critical_access_hospital_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Access Hospital (CAH) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `email_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `email_address` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `emergency_services_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Services Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `facility_type` SET TAGS ('pii_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `facility_type` SET TAGS ('pii_value_regex' = 'hospital|snf|asc|fqhc|rhc|behavioral_health');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fax_number` SET TAGS ('pii_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fax_number` SET TAGS ('pii_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fax_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `medicaid_certified_flag` SET TAGS ('pii_business_glossary_term' = 'Medicaid Certified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `medicare_certified_flag` SET TAGS ('pii_business_glossary_term' = 'Medicare Certified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `facility_name` SET TAGS ('pii_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `ownership_type` SET TAGS ('pii_value_regex' = 'for_profit|non_profit|government|tribal');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `parent_organization_name` SET TAGS ('pii_business_glossary_term' = 'Parent Organization Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `participation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('pii_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `postal_code` SET TAGS ('pii_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `quality_rating` SET TAGS ('pii_business_glossary_term' = 'Quality Rating Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `tax_identifier` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `tax_identifier` SET TAGS ('pii_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `tax_identifier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `tax_identifier` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `teaching_hospital_flag` SET TAGS ('pii_business_glossary_term' = 'Teaching Hospital Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `trauma_level` SET TAGS ('pii_business_glossary_term' = 'Trauma Center Designation Level');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `trauma_level` SET TAGS ('pii_value_regex' = 'level_1|level_2|level_3|level_4|level_5|not_designated');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`facility` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_subdomain' = 'network_participation');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `directory_entry_id` SET TAGS ('pii_business_glossary_term' = 'Directory Entry Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `provider_directory_id` SET TAGS ('pii_business_glossary_term' = 'Provider Directory Entry ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `accessibility_features` SET TAGS ('pii_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `attestation_method` SET TAGS ('pii_business_glossary_term' = 'Attestation Method');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `attestation_method` SET TAGS ('pii_value_regex' = 'provider_portal|phone_verification|email_verification|site_visit|third_party_vendor');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `attestation_status` SET TAGS ('pii_business_glossary_term' = 'Directory Attestation Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `attestation_status` SET TAGS ('pii_value_regex' = 'verified|pending_verification|failed_verification|not_verified');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `board_certifications` SET TAGS ('pii_business_glossary_term' = 'Board Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `directory_display_name` SET TAGS ('pii_business_glossary_term' = 'Provider Directory Display Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `directory_publication_date` SET TAGS ('pii_business_glossary_term' = 'Directory Publication Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `gender` SET TAGS ('pii_business_glossary_term' = 'Provider Gender');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `gender` SET TAGS ('pii_value_regex' = 'male|female|non_binary|not_disclosed');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `gender` SET TAGS ('pii_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `graduation_year` SET TAGS ('pii_business_glossary_term' = 'Graduation Year');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `hospital_affiliation` SET TAGS ('pii_business_glossary_term' = 'Hospital Affiliation');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `languages_spoken` SET TAGS ('pii_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `medical_school` SET TAGS ('pii_business_glossary_term' = 'Medical School');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `medical_school` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `medical_school` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|preferred|standard|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `next_verification_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `office_hours` SET TAGS ('pii_business_glossary_term' = 'Office Hours');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `participation_effective_date` SET TAGS ('pii_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Plan Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `participation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `participation_termination_date` SET TAGS ('pii_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `pcp_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider (PCP) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_business_glossary_term' = 'Practice Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_address_line2` SET TAGS ('pii_business_glossary_term' = 'Practice Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_city` SET TAGS ('pii_business_glossary_term' = 'Practice City');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_county` SET TAGS ('pii_business_glossary_term' = 'Practice County');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_email` SET TAGS ('pii_business_glossary_term' = 'Practice Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_fax` SET TAGS ('pii_business_glossary_term' = 'Practice Fax Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_fax` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_fax` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_location_name` SET TAGS ('pii_business_glossary_term' = 'Practice Location Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_phone` SET TAGS ('pii_business_glossary_term' = 'Practice Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_state` SET TAGS ('pii_business_glossary_term' = 'Practice State');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_website_url` SET TAGS ('pii_business_glossary_term' = 'Practice Website URL');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_zip_code` SET TAGS ('pii_business_glossary_term' = 'Practice ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_zip_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_zip_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `practice_zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `provider_type` SET TAGS ('pii_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `provider_type` SET TAGS ('pii_value_regex' = 'individual|group|facility|ancillary|dme_supplier|behavioral_health');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `specialty_display` SET TAGS ('pii_business_glossary_term' = 'Specialty Display Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `telehealth_available_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `tin` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `tin` SET TAGS ('pii_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `tin` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`directory_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `npi_registry_sync_id` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI) Registry Sync ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `address_discrepancy_detail` SET TAGS ('pii_business_glossary_term' = 'Address Discrepancy Detail');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `address_discrepancy_detail` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `address_discrepancy_detail` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `address_discrepancy_flag` SET TAGS ('pii_business_glossary_term' = 'Address Discrepancy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `address_discrepancy_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `address_discrepancy_flag` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `auto_applied_fields` SET TAGS ('pii_business_glossary_term' = 'Auto-Applied Fields');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `auto_applied_update_flag` SET TAGS ('pii_business_glossary_term' = 'Auto-Applied Update Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `claims_submission_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Claims Submission Risk Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `credential_discrepancy_detail` SET TAGS ('pii_business_glossary_term' = 'Credential Discrepancy Detail');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `credential_discrepancy_flag` SET TAGS ('pii_business_glossary_term' = 'Credential Discrepancy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `deactivation_reason_code` SET TAGS ('pii_business_glossary_term' = 'Deactivation Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `deactivation_reason_code` SET TAGS ('pii_value_regex' = 'DT|DB|FR|OT');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `deactivation_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `deactivation_reason_description` SET TAGS ('pii_business_glossary_term' = 'Deactivation Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `directory_accuracy_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Directory Accuracy Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `manual_review_assigned_to` SET TAGS ('pii_business_glossary_term' = 'Manual Review Assigned To');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `manual_review_completed_date` SET TAGS ('pii_business_glossary_term' = 'Manual Review Completed Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `manual_review_reason` SET TAGS ('pii_business_glossary_term' = 'Manual Review Reason');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `manual_review_required_flag` SET TAGS ('pii_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `match_status` SET TAGS ('pii_business_glossary_term' = 'Match Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `match_status` SET TAGS ('pii_value_regex' = 'Exact Match|Partial Match|Unmatched|Deactivated NPI|Reactivated NPI|New NPI Discovered');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `name_discrepancy_detail` SET TAGS ('pii_business_glossary_term' = 'Name Discrepancy Detail');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `name_discrepancy_flag` SET TAGS ('pii_business_glossary_term' = 'Name Discrepancy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `nppes_deactivation_date` SET TAGS ('pii_business_glossary_term' = 'National Plan and Provider Enumeration System (NPPES) Deactivation Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `nppes_enumeration_date` SET TAGS ('pii_business_glossary_term' = 'National Plan and Provider Enumeration System (NPPES) Enumeration Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `nppes_last_update_date` SET TAGS ('pii_business_glossary_term' = 'National Plan and Provider Enumeration System (NPPES) Last Update Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `nppes_reactivation_date` SET TAGS ('pii_business_glossary_term' = 'National Plan and Provider Enumeration System (NPPES) Reactivation Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `nppes_response_code` SET TAGS ('pii_business_glossary_term' = 'National Plan and Provider Enumeration System (NPPES) Response Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `nppes_response_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `resolution_action` SET TAGS ('pii_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `resolution_action` SET TAGS ('pii_value_regex' = 'Accept NPPES Data|Retain Internal Data|Hybrid Update|Escalate to Credentialing|No Action Required');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `sync_error_code` SET TAGS ('pii_business_glossary_term' = 'Synchronization Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `sync_error_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `sync_error_message` SET TAGS ('pii_business_glossary_term' = 'Synchronization Error Message');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `sync_run_date` SET TAGS ('pii_business_glossary_term' = 'Synchronization Run Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `sync_run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Synchronization Run Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `sync_source` SET TAGS ('pii_business_glossary_term' = 'Synchronization Source');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `sync_source` SET TAGS ('pii_value_regex' = 'NPPES Weekly Dissemination File|NPPES API Real-Time Query|Manual Verification|Batch Import|Scheduled Job');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `sync_status` SET TAGS ('pii_business_glossary_term' = 'Synchronization Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `sync_status` SET TAGS ('pii_value_regex' = 'Completed|In Progress|Failed|Pending Review|Resolved');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `taxonomy_discrepancy_detail` SET TAGS ('pii_business_glossary_term' = 'Taxonomy Discrepancy Detail');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `taxonomy_discrepancy_flag` SET TAGS ('pii_business_glossary_term' = 'Taxonomy Discrepancy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `total_discrepancies_count` SET TAGS ('pii_business_glossary_term' = 'Total Discrepancies Count');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`npi_registry_sync` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `sanction_id` SET TAGS ('pii_business_glossary_term' = 'Sanction Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `exclusion_screening_id` SET TAGS ('pii_business_glossary_term' = 'Screening Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `audit_trail_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `cms_report_date` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Report Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `cms_reportable_flag` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Reportable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `current_record_flag` SET TAGS ('pii_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `exclusion_waiver_flag` SET TAGS ('pii_business_glossary_term' = 'Exclusion Waiver Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `match_details` SET TAGS ('pii_business_glossary_term' = 'Match Details');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `ncqa_report_date` SET TAGS ('pii_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Report Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `ncqa_reportable_flag` SET TAGS ('pii_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Reportable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `notification_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `participation_impact` SET TAGS ('pii_business_glossary_term' = 'Participation Impact');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `participation_impact` SET TAGS ('pii_value_regex' = 'Immediate Termination|Suspension Pending Review|Payment Hold|No Impact - Monitoring Only');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Sanction Reason');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_effective_date` SET TAGS ('pii_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_end_date` SET TAGS ('pii_business_glossary_term' = 'Record End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `reinstatement_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `resolution_action` SET TAGS ('pii_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `resolution_action` SET TAGS ('pii_value_regex' = 'Confirmed - Provider Terminated|Confirmed - Payment Hold|False Positive - No Action|Pending Investigation');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `sanction_date` SET TAGS ('pii_business_glossary_term' = 'Sanction Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `sanction_type` SET TAGS ('pii_business_glossary_term' = 'Sanction Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `sanction_type` SET TAGS ('pii_value_regex' = 'OIG Exclusion|SAM Exclusion|State Medicaid Exclusion|DEA Revocation|Medical Board Action|Licensure Disciplinary Action');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `screened_by` SET TAGS ('pii_business_glossary_term' = 'Screened By');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `screening_date` SET TAGS ('pii_business_glossary_term' = 'Screening Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `screening_result` SET TAGS ('pii_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `screening_result` SET TAGS ('pii_value_regex' = 'Clear|Match Found|Potential Match - Manual Review Required');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `screening_source` SET TAGS ('pii_business_glossary_term' = 'Screening Source');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `screening_source` SET TAGS ('pii_value_regex' = 'OIG LEIE|SAM.gov|State Medicaid Exclusion List|EPLS|Manual Review');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Sanction Source');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `waiver_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`sanction` ALTER COLUMN `waiver_reason` SET TAGS ('pii_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_screening_id` SET TAGS ('pii_business_glossary_term' = 'Exclusion Screening ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Screened By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `audit_flag` SET TAGS ('pii_business_glossary_term' = 'Audit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `audit_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `cms_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'Compliant|Overdue|Pending Review|Non-Compliant|Waived');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `data_source_version` SET TAGS ('pii_business_glossary_term' = 'Data Source Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_effective_date` SET TAGS ('pii_business_glossary_term' = 'Exclusion Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_end_date` SET TAGS ('pii_business_glossary_term' = 'Exclusion End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_reason` SET TAGS ('pii_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_type` SET TAGS ('pii_business_glossary_term' = 'Exclusion Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `exclusion_type` SET TAGS ('pii_value_regex' = 'Federal|State|Both|None');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `match_details` SET TAGS ('pii_business_glossary_term' = 'Match Details');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `match_type` SET TAGS ('pii_business_glossary_term' = 'Match Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `match_type` SET TAGS ('pii_value_regex' = 'Exact NPI Match|Name and DOB Match|Name and Address Match|Partial Match|No Match');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `next_screening_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Screening Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `prior_screening_date` SET TAGS ('pii_business_glossary_term' = 'Prior Screening Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `resolution_action` SET TAGS ('pii_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `resolution_action` SET TAGS ('pii_value_regex' = 'No Action Required|Provider Terminated|Contract Suspended|Manual Review Pending|False Positive Confirmed|Waiver Granted');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screened_by_name` SET TAGS ('pii_business_glossary_term' = 'Screened By Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_date` SET TAGS ('pii_business_glossary_term' = 'Screening Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_frequency` SET TAGS ('pii_business_glossary_term' = 'Screening Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_frequency` SET TAGS ('pii_value_regex' = 'Monthly|Quarterly|Annual|Ad Hoc|Initial Credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_method` SET TAGS ('pii_business_glossary_term' = 'Screening Method');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_method` SET TAGS ('pii_value_regex' = 'Automated Batch|Manual Lookup|API Integration|Third-Party Vendor');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_result` SET TAGS ('pii_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_result` SET TAGS ('pii_value_regex' = 'Clear|Match Found|Potential Match|Inconclusive|Error');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_source` SET TAGS ('pii_business_glossary_term' = 'Screening Source');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_source` SET TAGS ('pii_value_regex' = 'OIG LEIE|SAM.gov|State Medicaid Exclusion|GSA EPLS|Multiple Sources');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `screening_vendor` SET TAGS ('pii_business_glossary_term' = 'Screening Vendor');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `state_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'State Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`exclusion_screening` ALTER COLUMN `vendor_transaction_reference` SET TAGS ('pii_business_glossary_term' = 'Vendor Transaction ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_subdomain' = 'network_participation');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `participation_status_id` SET TAGS ('pii_business_glossary_term' = 'Participation Status ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `claims_adjudication_flag` SET TAGS ('pii_business_glossary_term' = 'Claims Adjudication Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `participation_status_code` SET TAGS ('pii_business_glossary_term' = 'Participation Status Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `participation_status_code` SET TAGS ('pii_value_regex' = 'ACTIVE|INACTIVE|TERMINATED|SUSPENDED|PENDING_CREDENTIALING|PENDING_CONTRACTING');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `participation_status_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `continuity_of_care_end_date` SET TAGS ('pii_business_glossary_term' = 'Continuity of Care End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `credentialing_approval_date` SET TAGS ('pii_business_glossary_term' = 'Credentialing Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'INITIAL|RECREDENTIALING|APPROVED|DENIED|EXPIRED|UNDER_REVIEW');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `current_record_flag` SET TAGS ('pii_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `directory_display_flag` SET TAGS ('pii_business_glossary_term' = 'Directory Display Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'COMMERCIAL|MEDICARE_ADVANTAGE|MEDICAID|CHIP|MARKETPLACE|QHP');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `member_notification_date` SET TAGS ('pii_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `member_notification_method` SET TAGS ('pii_business_glossary_term' = 'Member Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `member_notification_method` SET TAGS ('pii_value_regex' = 'MAIL|EMAIL|PORTAL|PHONE|SMS');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `participation_status_name` SET TAGS ('pii_business_glossary_term' = 'Participation Status Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `network_tier_code` SET TAGS ('pii_business_glossary_term' = 'Network Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `network_tier_code` SET TAGS ('pii_value_regex' = 'TIER_1|TIER_2|TIER_3|PREFERRED|STANDARD|OUT_OF_NETWORK');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `network_tier_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `next_recredentialing_date` SET TAGS ('pii_business_glossary_term' = 'Next Recredentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `panel_status` SET TAGS ('pii_business_glossary_term' = 'Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `panel_status` SET TAGS ('pii_value_regex' = 'OPEN|CLOSED|RESTRICTED');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `participation_category` SET TAGS ('pii_business_glossary_term' = 'Participation Category');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `participation_category` SET TAGS ('pii_value_regex' = 'FULL|LIMITED|ANCILLARY|FACILITY|DME');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `pcp_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Care Provider (PCP) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_effective_date` SET TAGS ('pii_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_end_date` SET TAGS ('pii_business_glossary_term' = 'Record End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `regulatory_sanction_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Sanction Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `risk_arrangement_code` SET TAGS ('pii_business_glossary_term' = 'Risk Arrangement Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `risk_arrangement_code` SET TAGS ('pii_value_regex' = 'FFS|CAPITATION|SHARED_SAVINGS|BUNDLED_PAYMENT|VBC');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `risk_arrangement_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `sanction_effective_date` SET TAGS ('pii_business_glossary_term' = 'Sanction Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `sanction_end_date` SET TAGS ('pii_business_glossary_term' = 'Sanction End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `specialist_flag` SET TAGS ('pii_business_glossary_term' = 'Specialist Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `status_change_trigger` SET TAGS ('pii_business_glossary_term' = 'Status Change Trigger');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_value_regex' = 'VOLUNTARY_WITHDRAWAL|CONTRACT_EXPIRATION|CREDENTIALING_FAILURE|QUALITY_ISSUE|SANCTION|NETWORK_REDESIGN');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `termination_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `termination_reason_description` SET TAGS ('pii_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`participation_status` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_subdomain' = 'provider_identity');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_registration_id` SET TAGS ('pii_business_glossary_term' = 'Dea Registration Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `controlled_substance_authorized_flag` SET TAGS ('pii_business_glossary_term' = 'Controlled Substance Authorization Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `current_record_flag` SET TAGS ('pii_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_business_glossary_term' = 'DEA Registration Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_value_regex' = '^[A-Z]{2}d{7}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `dea_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'DEA Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'DEA Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `issuing_agency` SET TAGS ('pii_business_glossary_term' = 'Issuing Agency');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'DEA Registration Notes');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `record_end_date` SET TAGS ('pii_business_glossary_term' = 'Record End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_state` SET TAGS ('pii_business_glossary_term' = 'DEA Registration State');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_status` SET TAGS ('pii_business_glossary_term' = 'DEA Registration Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_status` SET TAGS ('pii_value_regex' = 'active|expired|revoked|surrendered|pending');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_type` SET TAGS ('pii_business_glossary_term' = 'DEA Registration Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `registration_type` SET TAGS ('pii_value_regex' = 'individual|organization');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `schedule_authorized` SET TAGS ('pii_business_glossary_term' = 'Authorized DEA Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `schedule_authorized` SET TAGS ('pii_value_regex' = 'II|III|IV|V');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`dea_registration` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Primary Source Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_association_edges' = 'provider.provider_provider,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`obligation_compliance` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_association_edges' = 'provider.provider_provider,compliance.audit_engagement');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`audit_assignment` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_subdomain' = 'outreach_verification');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `outreach_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Outreach Campaign Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `parent_outreach_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Parent Outreach Campaign Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `parent_outreach_campaign_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `approval_by` SET TAGS ('pii_business_glossary_term' = 'Approval By');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `approval_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `approval_by` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `approval_comments` SET TAGS ('pii_business_glossary_term' = 'Approval Comments');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_approval_status` SET TAGS ('pii_business_glossary_term' = 'Campaign Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_budget` SET TAGS ('pii_business_glossary_term' = 'Campaign Budget');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_channel` SET TAGS ('pii_business_glossary_term' = 'Campaign Channel');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_created_at` SET TAGS ('pii_business_glossary_term' = 'Campaign Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_created_by` SET TAGS ('pii_business_glossary_term' = 'Campaign Created By');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_created_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_created_by` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_currency` SET TAGS ('pii_business_glossary_term' = 'Campaign Currency');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_description` SET TAGS ('pii_business_glossary_term' = 'Campaign Description');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_frequency` SET TAGS ('pii_business_glossary_term' = 'Campaign Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_goal` SET TAGS ('pii_business_glossary_term' = 'Campaign Goal');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_metric` SET TAGS ('pii_business_glossary_term' = 'Campaign Metric');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_name` SET TAGS ('pii_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_owner` SET TAGS ('pii_business_glossary_term' = 'Campaign Owner');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_owner` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_owner` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_spend` SET TAGS ('pii_business_glossary_term' = 'Campaign Spend');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_age_range` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Age Range');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_demographics` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Demographics');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_description` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Description');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_gender` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Gender');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_gender` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_geo` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Geo');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_income_range` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Income Range');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_insurance_type` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Insurance Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_member_since_date` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Member Since Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_member_status` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Member Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_plan_type` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_target_audience_size` SET TAGS ('pii_business_glossary_term' = 'Campaign Target Audience Size');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_type` SET TAGS ('pii_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_updated_at` SET TAGS ('pii_business_glossary_term' = 'Campaign Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_updated_by` SET TAGS ('pii_business_glossary_term' = 'Campaign Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_updated_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `campaign_updated_by` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `owner_department` SET TAGS ('pii_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `owner_email` SET TAGS ('pii_business_glossary_term' = 'Owner Email');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `owner_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `owner_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `owner_phone` SET TAGS ('pii_business_glossary_term' = 'Owner Phone');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `owner_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `owner_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `owner_role` SET TAGS ('pii_business_glossary_term' = 'Owner Role');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`outreach_campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_subdomain' = 'provider_identity');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_table_name' = 'provider');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `provider_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_subdomain' = 'outreach_verification');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `provider_directory_verification_id` SET TAGS ('pii_business_glossary_term' = 'Provider Directory Verification ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Verified By Staff ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `current_record_flag` SET TAGS ('pii_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `fields_verified` SET TAGS ('pii_business_glossary_term' = 'Fields Verified (FIELDS_VERIFIED)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `next_verification_date` SET TAGS ('pii_business_glossary_term' = 'Next Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_effective_date` SET TAGS ('pii_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_end_date` SET TAGS ('pii_business_glossary_term' = 'Record End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method (VER_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `verification_method` SET TAGS ('pii_value_regex' = 'phone|mail|online|attestation');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `verification_number` SET TAGS ('pii_business_glossary_term' = 'Verification Number (VER_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `verification_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `verification_outcome` SET TAGS ('pii_business_glossary_term' = 'Verification Outcome (VER_OUTCOME)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `verification_outcome` SET TAGS ('pii_value_regex' = 'confirmed|updated|unable_to_reach|removed');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status (VER_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'pending|completed|failed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_directory_verification` ALTER COLUMN `verification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_subdomain' = 'outreach_verification');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `provider_outreach_id` SET TAGS ('pii_business_glossary_term' = 'Provider Outreach ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outreach_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `accepting_patients_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting Patients Verified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `address_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Address Verified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `address_verified_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `address_verified_flag` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `attempt_count` SET TAGS ('pii_business_glossary_term' = 'Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `attestation_date` SET TAGS ('pii_business_glossary_term' = 'Attestation Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `attestation_method` SET TAGS ('pii_business_glossary_term' = 'Attestation Method');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `attestation_method` SET TAGS ('pii_value_regex' = 'online_portal|email|mail|fax|phone|in_person');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `attestation_received_flag` SET TAGS ('pii_business_glossary_term' = 'Attestation Received Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `compliance_quarter` SET TAGS ('pii_business_glossary_term' = 'Compliance Quarter');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_email_address` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_email_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_person_name` SET TAGS ('pii_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_person_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_person_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_phone_number` SET TAGS ('pii_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `contact_reached_flag` SET TAGS ('pii_business_glossary_term' = 'Contact Reached Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `current_record_flag` SET TAGS ('pii_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `data_updated_flag` SET TAGS ('pii_business_glossary_term' = 'Data Updated Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `data_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Data Verified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `directory_removal_flag` SET TAGS ('pii_business_glossary_term' = 'Directory Removal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `fields_verified` SET TAGS ('pii_business_glossary_term' = 'Fields Verified');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `follow_up_reason` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Reason');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `follow_up_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `hours_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Hours Verified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `next_verification_date` SET TAGS ('pii_business_glossary_term' = 'Next Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Outreach Notes');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Outreach Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outcome` SET TAGS ('pii_value_regex' = 'reached|confirmed|updated|voicemail|no_response|unable_to_reach');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outreach_date` SET TAGS ('pii_business_glossary_term' = 'Outreach Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outreach_method` SET TAGS ('pii_business_glossary_term' = 'Outreach Method');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outreach_method` SET TAGS ('pii_value_regex' = 'phone|email|mail|portal|fax|in_person');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outreach_status` SET TAGS ('pii_business_glossary_term' = 'Outreach Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outreach_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outreach_timestamp` SET TAGS ('pii_business_glossary_term' = 'Outreach Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outreach_type` SET TAGS ('pii_business_glossary_term' = 'Outreach Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `outreach_type` SET TAGS ('pii_value_regex' = 'directory_verification|credentialing_follow_up|contract_execution|network_recruitment|data_quality_correction|recredentialing_reminder');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `phone_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Phone Verified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `phone_verified_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `phone_verified_flag` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `purpose` SET TAGS ('pii_business_glossary_term' = 'Outreach Purpose');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_effective_date` SET TAGS ('pii_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_end_date` SET TAGS ('pii_business_glossary_term' = 'Record End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `reference_number` SET TAGS ('pii_business_glossary_term' = 'Outreach Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `removal_reason` SET TAGS ('pii_business_glossary_term' = 'Removal Reason');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `specialty_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Specialty Verified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `staff_member_name` SET TAGS ('pii_business_glossary_term' = 'Staff Member Name');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `staff_member_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_outreach` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_subdomain' = 'network_participation');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_association_edges' = 'provider.facility,network.provider_network');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `provider_network_participation2_id` SET TAGS ('pii_business_glossary_term' = 'Networkparticipation - Network Participation Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `facility_id` SET TAGS ('pii_business_glossary_term' = 'Networkparticipation - Facility Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Provider Contract');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Networkparticipation - Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `accepting_new_patients` SET TAGS ('pii_business_glossary_term' = 'Accepting New Patients');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `current_panel_size` SET TAGS ('pii_business_glossary_term' = 'Current Panel Size');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `directory_display_flag` SET TAGS ('pii_business_glossary_term' = 'Directory Display Flag');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_practitioner_role_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR PractitionerRole ID');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_practitioner_role_identifier` SET TAGS ('pii_fhir_mapping' = 'PractitionerRole');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `geographic_restriction` SET TAGS ('pii_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Lob Code');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `master_entity_identifier` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `panel_capacity` SET TAGS ('pii_business_glossary_term' = 'Panel Capacity');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `par_agreement_signed_date` SET TAGS ('pii_business_glossary_term' = 'PAR Agreement Signed Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `par_indicator` SET TAGS ('pii_business_glossary_term' = 'Par Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `participation_role` SET TAGS ('pii_business_glossary_term' = 'Participation Role');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `participation_type` SET TAGS ('pii_business_glossary_term' = 'Participation Type');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `recredential_due_date` SET TAGS ('pii_business_glossary_term' = 'Recredential Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `reimbursement_arrangement` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `reimbursement_method` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Method');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `specialty_restriction` SET TAGS ('pii_business_glossary_term' = 'Specialty Restriction');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `tier_level` SET TAGS ('pii_business_glossary_term' = 'Tier Level');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` SET TAGS ('pii_subdomain' = 'network_participation');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_network_participation` ALTER COLUMN `provider_network_participation_id` SET TAGS ('pii_business_glossary_term' = 'provider_network_participation Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_provider` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`provider`.`provider_provider` ALTER COLUMN `fhir_practitioner_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
