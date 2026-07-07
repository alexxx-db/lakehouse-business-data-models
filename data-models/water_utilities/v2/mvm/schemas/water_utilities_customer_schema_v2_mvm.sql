-- Schema for Domain: customer | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`customer` COMMENT 'Single source of truth for all water and wastewater service accounts including residential, commercial, industrial, and municipal customers. Manages customer profiles, service addresses, account hierarchies, customer segments, contact information, service agreements, and customer lifecycle from application through termination. SSOT for customer identity across all billing, metering, and service delivery systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` (
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer account referenced by each customer account record in the customer domain.',
    `organization_id` BIGINT COMMENT 'Unique identifier for the organization referenced by each customer account record in the customer domain.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: A customer account — especially residential — is held by an individual person. The customer_account table currently links to organization (for commercial accounts) but has no FK to person for resident',
    `account_class` STRING COMMENT 'The account class value recorded for each customer account in the customer domain.',
    `account_name` STRING COMMENT 'The account name used to identify each customer account record in the customer domain.',
    `account_number` STRING COMMENT 'The account number value recorded for each customer account in the customer domain.',
    `account_status` STRING COMMENT 'The account status value recorded for each customer account in the customer domain.',
    `account_type` STRING COMMENT 'The account type value recorded for each customer account in the customer domain.',
    `assistance_program_enrolled_flag` BOOLEAN COMMENT 'The assistance program enrolled flag value recorded for each customer account in the customer domain.',
    `autopay_enrolled_flag` BOOLEAN COMMENT 'The autopay enrolled flag value recorded for each customer account in the customer domain.',
    `average_monthly_consumption_gal` DECIMAL(18,2) COMMENT 'The average monthly consumption gal value recorded for each customer account in the customer domain.',
    `billing_cycle_code` STRING COMMENT 'The billing cycle code value recorded for each customer account in the customer domain.',
    `close_date` DATE COMMENT 'The close date associated with each customer account record in the customer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each customer account record in the customer domain.',
    `credit_rating` STRING COMMENT 'The credit rating value recorded for each customer account in the customer domain.',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'The current balance amount value recorded for each customer account in the customer domain.',
    `delinquency_count` STRING COMMENT 'The delinquency count value recorded for each customer account in the customer domain.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'The deposit amount value recorded for each customer account in the customer domain.',
    `language_preference` STRING COMMENT 'The language preference value recorded for each customer account in the customer domain.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The last payment amount value recorded for each customer account in the customer domain.',
    `last_payment_date` DATE COMMENT 'The last payment date associated with each customer account record in the customer domain.',
    `lien_flag` BOOLEAN COMMENT 'The lien flag value recorded for each customer account in the customer domain.',
    `meter_count` STRING COMMENT 'The meter count value recorded for each customer account in the customer domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each customer account record in the customer domain.',
    `open_date` DATE COMMENT 'The open date associated with each customer account record in the customer domain.',
    `paperless_billing_flag` BOOLEAN COMMENT 'The paperless billing flag value recorded for each customer account in the customer domain.',
    `past_due_amount` DECIMAL(18,2) COMMENT 'The past due amount value recorded for each customer account in the customer domain.',
    `payment_method` STRING COMMENT 'The payment method value recorded for each customer account in the customer domain.',
    `service_start_date` DATE COMMENT 'The service start date associated with each customer account record in the customer domain.',
    `shutoff_eligible_flag` BOOLEAN COMMENT 'The shutoff eligible flag value recorded for each customer account in the customer domain.',
    CONSTRAINT pk_customer_account PRIMARY KEY(`customer_account_id`)
) COMMENT 'Master record for every water and wastewater service account — residential, commercial, industrial, and municipal. Serves as the SSOT for customer identity across Oracle CC&B, SAP, AMI, and all downstream systems. Captures account number, account type (residential/commercial/industrial/municipal), account status (active/inactive/pending/suspended/terminated), service class, credit rating, account open date, account close date, language preference, paperless billing flag, autopay enrollment, lifecycle stage, and water budget allocation (where applicable). This is the primary anchor entity for the customer domain — all billing, metering, service delivery, and regulatory reporting references flow through this entity. [SSOT: reference view of canonical billing.billing_account] SSOT master for customer identity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`person` (
    `person_id` BIGINT COMMENT 'Unique identifier for the person record. Primary key for the person entity. Serves as the single source of truth for individual identity within the customer domain. Ref: AWWA.',
    `organization_id` BIGINT COMMENT 'Foreign key linking to customer.organization. Business justification: A person (account holder, co-applicant, or authorized contact) may be a representative or employee of a commercial/industrial organization. Linking person to organization via employer_organization_id ',
    `service_address_id` BIGINT COMMENT 'FK to service address per VREQ-035. Ref: AWWA.',
    `autopay_enrollment_date` DATE COMMENT 'The date when the person enrolled in or opted out of autopay in yyyy-MM-dd format. Used for payment preference tracking and billing operations. Ref: AWWA.',
    `autopay_enrollment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has enrolled in automatic payment (autopay) for their utility bills. True if enrolled in autopay, False otherwise. Used for payment processing and customer convenience tracking. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this person record was first created in the system in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trails, data lineage, and record lifecycle tracking. Ref: AWWA.',
    `credit_check_consent_date` DATE COMMENT 'The date when the person provided consent for credit check in yyyy-MM-dd format. Used for compliance documentation and audit trails. Ref: AWWA.',
    `credit_check_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has provided consent for the utility to perform a credit check. True if consent given, False otherwise. Required for deposit determination and account establishment. Ref: AWWA.',
    `customer_segment` STRING COMMENT 'The business segment classification of the person based on their primary account relationship. Used for rate classification, service level determination, and customer analytics. Aligns with rate schedule eligibility. Ref: AWWA.. Valid values are `residential|small_commercial|large_commercial|industrial|municipal|agricultural`',
    `data_sharing_consent_date` DATE COMMENT 'The date when the person provided or withdrew data sharing consent in yyyy-MM-dd format. Used for compliance documentation and privacy management. Ref: AWWA.',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has consented to sharing their data with third parties (e.g., energy efficiency program partners, government agencies, research organizations). True if consent given, False otherwise. Ref: AWWA.',
    `date_of_birth` DATE COMMENT 'The persons date of birth in yyyy-MM-dd format. Used for identity verification, age-based service eligibility (e.g., senior citizen rates), and compliance with age-restricted service programs. Ref: AWWA.',
    `disability_accommodation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person requires disability accommodations for service delivery, communications, or billing. True if accommodations required, False otherwise. Used to ensure accessible service delivery. Ref: AWWA.',
    `disability_accommodation_notes` STRING COMMENT 'Free-text notes describing specific disability accommodations required by the person (e.g., large print bills, TTY/TDD phone service, accessible meter location). Used to ensure appropriate service delivery and ADA compliance. Ref: AWWA.',
    `email_address` STRING COMMENT 'The primary email address for the person. Used for electronic billing, service notifications, CCR (Consumer Confidence Report) delivery, and digital customer communications. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `government_id_expiration_date` DATE COMMENT 'The expiration date of the government-issued identification document in yyyy-MM-dd format. Used to ensure identity verification documents remain current and valid. Ref: AWWA.',
    `government_id_issuing_state` STRING COMMENT 'The U.S. state or territory that issued the government identification document. Used for identity verification and fraud prevention. Two-letter state abbreviation (e.g., CA, NY, TX). Ref: AWWA.',
    `government_id_number_masked` STRING COMMENT 'The masked or partially redacted government-issued identification number (e.g., last 4 digits of SSN, masked drivers license number). Full number stored in secure vault; this field contains display-safe version for operational use. Ref: AWWA.',
    `government_id_type` STRING COMMENT 'The type of government-issued identification document provided by the person for identity verification during account application or service connection. Used to comply with customer identification requirements. Ref: AWWA.. Valid values are `drivers_license|state_id|passport|military_id|tribal_id|ssn`',
    `identity_verification_date` DATE COMMENT 'The date when the persons identity was successfully verified in yyyy-MM-dd format. Used for audit trails and compliance reporting on customer identification procedures. Ref: AWWA.',
    `identity_verification_method` STRING COMMENT 'The method used to verify the persons identity (in-person document review, online verification service, mail-in documentation, third-party identity verification service). Used for audit and compliance tracking. Ref: AWWA.. Valid values are `in_person|online|mail|third_party_service`',
    `identity_verification_status` STRING COMMENT 'The current status of the persons identity verification process. Indicates whether government-issued identification has been validated and approved for service connection and account establishment. Ref: AWWA.. Valid values are `verified|pending|failed|expired|not_required`',
    `language_preference` STRING COMMENT 'The persons preferred language for communications and service delivery. Three-letter ISO 639-2 language code. Used to ensure accessible customer service and compliance with language access requirements. [ENUM-REF-CANDIDATE: ENG|SPA|CHI|VIE|KOR|RUS|FRE|ARA|POR|OTH — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this person record was last updated in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trails, change tracking, and data synchronization across systems. Ref: AWWA.',
    `legal_first_name` STRING COMMENT 'The legal first name of the person as it appears on government-issued identification documents. Used for identity verification and legal correspondence. Ref: AWWA.',
    `legal_last_name` STRING COMMENT 'The legal last name (surname) of the person as it appears on government-issued identification documents. Used for identity verification and legal correspondence. Ref: AWWA.',
    `legal_middle_name` STRING COMMENT 'The legal middle name or initial of the person as it appears on government-issued identification documents. May be null if not provided. Ref: AWWA.',
    `life_support_equipment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person or household member relies on life-support medical equipment that requires uninterrupted water service. True if life-support equipment present, False otherwise. Used for service disconnection protection and emergency prioritization. Ref: AWWA.',
    `life_support_verification_date` DATE COMMENT 'The date when the life-support equipment status was verified by medical certification in yyyy-MM-dd format. Used for program compliance and annual recertification tracking. Ref: AWWA.',
    `low_income_assistance_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person is eligible for low-income assistance programs, rate discounts, or payment assistance based on income verification. True if eligible, False otherwise. Used for social equity program administration. Ref: AWWA.',
    `low_income_verification_date` DATE COMMENT 'The date when the persons low-income status was verified for assistance program eligibility in yyyy-MM-dd format. Used for program compliance and recertification tracking. Ref: AWWA.',
    `marketing_consent_date` DATE COMMENT 'The date when the person provided or withdrew marketing consent in yyyy-MM-dd format. Used for compliance documentation and preference management. Ref: AWWA.',
    `marketing_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has consented to receive marketing communications and promotional materials from the utility. True if consent given, False otherwise. Used to comply with marketing communication regulations. Ref: AWWA.',
    `new_attribute` STRING COMMENT 'The new attribute value recorded for each person in the customer domain.',
    `paperless_billing_enrollment_date` DATE COMMENT 'The date when the person enrolled in or opted out of paperless billing in yyyy-MM-dd format. Used for billing preference tracking and environmental impact reporting. Ref: AWWA.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has enrolled in paperless billing and prefers to receive bills electronically. True if enrolled in paperless billing, False if paper bills preferred. Ref: AWWA.',
    `person_status` STRING COMMENT 'The current lifecycle status of the person record. Active indicates the person is currently associated with one or more accounts. Inactive indicates no current account relationships. Deceased, merged, and duplicate statuses support data quality and master data management. Ref: AWWA.. Valid values are `active|inactive|deceased|merged|duplicate`',
    `person_type` STRING COMMENT 'The role or relationship type of the person within the customer domain. Distinguishes between account holders, co-applicants, authorized contacts, guarantors, and other person roles. One person may have multiple types across different accounts. Ref: AWWA.. Valid values are `account_holder|co_applicant|authorized_contact|guarantor|emergency_contact|property_owner`',
    `preferred_contact_method` STRING COMMENT 'The persons preferred method for receiving utility communications and notifications. Used to honor customer communication preferences and improve engagement rates. Ref: AWWA.. Valid values are `email|phone|sms|mail|portal`',
    `preferred_name` STRING COMMENT 'The name the person prefers to be called in day-to-day interactions, which may differ from their legal name. Used for customer service communications and personalization. Ref: AWWA.',
    `primary_phone` STRING COMMENT 'The primary contact phone number for the person. Used for service notifications, billing inquiries, outage alerts, and emergency communications. Format may include country code, area code, and extension. Ref: AWWA.',
    `primary_phone_type` STRING COMMENT 'The type of primary phone number (mobile, home, work, other). Used to determine appropriate communication channels and times for customer outreach. Ref: AWWA.. Valid values are `mobile|home|work|other`',
    `senior_citizen_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person qualifies as a senior citizen for age-based rate discounts or service programs. True if senior citizen, False otherwise. Age threshold defined by utility policy and regulatory requirements. Ref: AWWA.',
    `suffix` STRING COMMENT 'Generational or professional suffix appended to the persons legal name (e.g., Jr, Sr, II, III). Used to distinguish individuals with identical names. Ref: AWWA.. Valid values are `Jr|Sr|II|III|IV|V`',
    CONSTRAINT pk_person PRIMARY KEY(`person_id`)
) COMMENT 'Master record for individual persons associated with water utility accounts — account holders, co-applicants, authorized contacts, and guarantors. Captures legal name, date of birth, government ID type and masked number, primary phone, secondary phone, email address, preferred contact method, language preference, identity verification status, and privacy consent flags. Distinct from the account entity: one person may hold multiple accounts (e.g., landlord with multiple rental properties). SSOT for individual identity within the customer domain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`organization` (
    `organization_id` BIGINT COMMENT 'Unique system identifier for the organization entity. Primary key for commercial, industrial, and municipal organizations holding water and wastewater service accounts. Ref: AWWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Industrial user organizations hold compliance permits (IUPs). The organization product already carries denormalized iup_permit_number and iup_expiration_date — direct signals a FK to compliance_permit',
    `parent_organization_id` BIGINT COMMENT 'Reference to the parent organization in corporate hierarchies. Enables consolidated billing, enterprise account management, and multi-location reporting for corporate customers. Ref: AWWA.',
    `account_closed_date` DATE COMMENT 'Date when the organizations account was closed or terminated. Null for active accounts. Ref: AWWA.',
    `account_opened_date` DATE COMMENT 'Date when the organizations first service account was established with the utility. Used for customer tenure analysis and loyalty program eligibility. Ref: AWWA.',
    `account_status` STRING COMMENT 'Current lifecycle status of the organization account. Active accounts receive service; Suspended accounts have service restrictions; Closed accounts are terminated. Ref: AWWA.. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `annual_revenue_range` DECIMAL(18,2) COMMENT 'Estimated annual revenue range of the organization. Used for credit assessment, account prioritization, and business development targeting. Ref: AWWA.',
    `auto_pay_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the organization is enrolled in automatic payment processing. True if enrolled, False otherwise. Ref: AWWA.',
    `billing_address_line1` STRING COMMENT 'First line of the organizations billing address, typically street number and name. Used for invoice delivery and legal correspondence. Ref: AWWA.',
    `billing_address_line2` STRING COMMENT 'Second line of billing address for suite, floor, or department information. Ref: AWWA.',
    `billing_city` STRING COMMENT 'City name for the organizations billing address. Ref: AWWA.',
    `billing_country` STRING COMMENT 'Three-letter ISO country code for the organizations billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the organizations billing address. Ref: AWWA.. Valid values are `^d{5}(-d{4})?$`',
    `billing_state` STRING COMMENT 'Two-letter state code for the organizations billing address. Ref: AWWA.. Valid values are `^[A-Z]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the organization record was first created in the customer information system. Ref: AWWA.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the organization before service restrictions are applied. Expressed in USD. Ref: AWWA.',
    `credit_tier` STRING COMMENT 'Internal credit rating tier assigned to the organization based on payment history, financial strength, and risk assessment. Determines deposit requirements and payment terms. Ref: AWWA.. Valid values are `tier_1|tier_2|tier_3|tier_4|unrated`',
    `customer_segment` STRING COMMENT 'Business segment classification for the organization. Used for rate structure assignment, service level agreements, and market analysis. Ref: AWWA.. Valid values are `commercial|industrial|municipal|institutional|agricultural|government`',
    `dba_name` STRING COMMENT 'Trade name or fictitious business name under which the organization operates, if different from legal name. Used for customer-facing communications and service delivery. Ref: AWWA.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit held for the organization. Expressed in USD. Null if no deposit is required. Ref: AWWA.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required for this organization based on credit assessment. True if deposit is required, False otherwise. Ref: AWWA.',
    `employee_count_range` STRING COMMENT 'Estimated number of employees at the organization. Used for water demand forecasting and commercial rate structure assignment. [ENUM-REF-CANDIDATE: 1_to_10|11_to_50|51_to_200|201_to_500|501_to_1000|over_1000|unknown — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `federal_tax_number` STRING COMMENT 'IRS-issued Employer Identification Number (EIN) for tax reporting and identification purposes. Nine-digit number in format XX-XXXXXXX. Ref: AWWA.. Valid values are `^d{2}-d{7}$`',
    `incorporation_date` DATE COMMENT 'Date the organization was legally incorporated, registered, or chartered. Used for account tenure analysis and credit assessment. Ref: AWWA.',
    `incorporation_state` STRING COMMENT 'Two-letter state code where the organization is legally incorporated or registered. Used for jurisdictional compliance and legal correspondence. Ref: AWWA.. Valid values are `^[A-Z]{2}$`',
    `industrial_user_classification` STRING COMMENT 'EPA classification level for industrial users subject to pretreatment requirements. Categorical Industrial User (CIU) discharges regulated pollutants; Significant Industrial User (SIU) meets discharge thresholds; Non-Significant does not meet thresholds. Ref: AWWA.. Valid values are `categorical|significant|non_significant|not_applicable`',
    `industrial_user_flag` BOOLEAN COMMENT 'Indicates whether the organization is classified as an industrial user subject to pretreatment program requirements under the Clean Water Act. True if industrial user, False otherwise. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the organization record was last updated. Used for data synchronization and audit trail. Ref: AWWA.',
    `legal_name` STRING COMMENT 'The official registered legal name of the organization as filed with state incorporation documents or municipal charter. Used for contracts, billing, and regulatory reporting. Ref: AWWA.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code identifying the organizations primary industry sector. Used for industrial user classification, rate structure assignment, and regulatory reporting. Ref: AWWA.. Valid values are `^d{6}$`',
    `organization_type` STRING COMMENT 'Legal structure classification of the organization. Determines billing rules, credit policies, and regulatory treatment. Ref: AWWA.. Valid values are `corporation|llc|partnership|municipality|hoa|government_agency`',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the organization has opted for electronic billing only. True if paperless, False if paper invoices are required. Ref: AWWA.',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment after invoice date. Standard terms are typically 30 days; extended terms may be granted based on credit tier. Ref: AWWA.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for electronic billing, service notifications, and account correspondence. Ref: AWWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary authorized representative or contact person for the organization. Used for account management, billing inquiries, and service notifications. Ref: AWWA.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the organization contact. Used for urgent service notifications, outage alerts, and account inquiries. Ref: AWWA.. Valid values are `^+?1?d{10,15}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person within the organization (e.g., Facilities Manager, CFO, City Manager). Ref: AWWA.',
    `sic_code` STRING COMMENT 'Four-digit SIC code for legacy industry classification. Maintained for historical reporting and systems that have not migrated to NAICS. Ref: AWWA.. Valid values are `^d{4}$`',
    `special_billing_instructions` STRING COMMENT 'Free-text field for custom billing requirements, invoice formatting preferences, or special handling instructions for the organization account. Ref: AWWA.',
    `tax_exempt_certificate_number` STRING COMMENT 'State-issued tax exemption certificate number for organizations claiming tax-exempt status. Required for audit compliance. Ref: AWWA.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the organization is exempt from sales tax or utility taxes. True if tax-exempt (typically government entities), False otherwise. Ref: AWWA.',
    `website_url` STRING COMMENT 'Public website URL for the organization. Used for customer research and business development. Ref: AWWA.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master record for commercial, industrial, and municipal organizations that hold water and wastewater service accounts. Captures legal entity name, DBA name, federal tax ID (EIN), NAICS/SIC industry code, organization type (corporation/LLC/municipality/HOA/government), primary contact name, incorporation state, credit tier, industrial user classification (for IUP purposes), and parent organization reference for corporate hierarchies. Supports B2B account management and industrial pretreatment program tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`service_address` (
    `service_address_id` BIGINT COMMENT 'Unique identifier for the service address record. Primary key for the service address entity. Ref: AWWA.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service addresses fall within District Metered Areas for non-revenue water tracking, leak detection program management, and consumption pattern analysis. Essential for AWWA water audit compliance, tar',
    `address_effective_date` DATE COMMENT 'Date when this service address became effective and available for service delivery. Start of the address lifecycle. Ref: AWWA.',
    `address_end_date` DATE COMMENT 'Date when this service address was retired or became unavailable for service. Null if address is still active. Ref: AWWA.',
    `address_line_1` STRING COMMENT 'Primary street address line including house number, street name, and street type. First line of the physical service delivery location. Ref: AWWA.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment number, suite, unit, building, floor, or other location qualifier within the premise. Ref: AWWA.',
    `address_notes` STRING COMMENT 'Free-text notes or comments about the service address including special access instructions, delivery restrictions, or historical context. Ref: AWWA.',
    `address_source_system` STRING COMMENT 'Name of the source system or application that created or last updated this service address record (e.g., CC&B, GIS, CRM). Ref: AWWA.',
    `address_status` STRING COMMENT 'Lifecycle status of the service address record. Values: active (currently serviceable), inactive (temporarily not in use), pending (awaiting activation), retired (permanently closed). Ref: AWWA.. Valid values are `active|inactive|pending|retired`',
    `address_validation_status` STRING COMMENT 'Status indicating whether the address has been validated against USPS or other authoritative address databases. Values: validated, unvalidated, corrected, invalid. Ref: AWWA.. Valid values are `validated|unvalidated|corrected|invalid`',
    `apn` STRING COMMENT 'County assessor parcel number uniquely identifying the land parcel for property tax and ownership purposes. Links service address to GIS parcel data. Ref: AWWA.',
    `building_type` STRING COMMENT 'Type or classification of building structure at the service address (e.g., single-family, multi-family, office, retail, warehouse, school). Ref: AWWA.',
    `city` STRING COMMENT 'City or municipality name where the service address is located. Ref: AWWA.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the service address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish name where the service address is located. Used for regulatory reporting and jurisdictional compliance. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service address record was first created in the system. Audit trail for data lineage. Ref: AWWA.',
    `customer_class` STRING COMMENT 'Customer classification for rate and billing purposes. Values: residential, commercial, industrial, municipal, agricultural, institutional. Ref: AWWA.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `flood_zone_designation` STRING COMMENT 'FEMA flood zone classification (e.g., A, AE, X, VE) indicating flood risk level. Used for infrastructure planning and emergency response. Ref: AWWA.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique identifier linking this service address to the corresponding feature in the Esri ArcGIS spatial database for network modeling and asset management. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service address record was last updated or modified. Audit trail for change tracking. Ref: AWWA.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees (WGS84 datum). Used for GIS mapping, network modeling, and spatial analysis. Ref: AWWA.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees (WGS84 datum). Used for GIS mapping, network modeling, and spatial analysis. Ref: AWWA.',
    `meter_location_description` STRING COMMENT 'Free-text description of where the water meter is physically located at the premise (e.g., front yard, basement, alley, inside garage). Ref: AWWA.',
    `occupancy_status` STRING COMMENT 'Current occupancy status of the premise. Values: occupied, vacant, seasonal, under_construction. Ref: AWWA.. Valid values are `occupied|vacant|seasonal|under_construction`',
    `postal_code` STRING COMMENT 'Five-digit ZIP code or ZIP+4 format postal code for the service address. Used for mail delivery and geographic segmentation. Ref: AWWA.. Valid values are `^d{5}(-d{4})?$`',
    `pressure_zone` STRING COMMENT 'Water distribution pressure zone identifier indicating the hydraulic zone serving this address. Used for hydraulic modeling and pressure management. Ref: AWWA.',
    `service_territory_code` STRING COMMENT 'Code identifying the utility service territory or franchise area where the address is located. Determines regulatory jurisdiction and service provider. Ref: AWWA.',
    `service_type` STRING COMMENT 'Type of utility service(s) available at this address. Values: water_only, wastewater_only, water_and_wastewater, stormwater, reclaimed_water. Ref: AWWA.. Valid values are `water_only|wastewater_only|water_and_wastewater|stormwater|reclaimed_water`',
    `sewer_basin` STRING COMMENT 'Wastewater collection basin or drainage area identifier indicating which sewer system and treatment plant serve this address. Ref: AWWA.',
    `standardized_address` STRING COMMENT 'Fully standardized and concatenated address string following USPS formatting rules. Used for address matching and deduplication. Ref: AWWA.',
    `state_code` STRING COMMENT 'Two-letter state or province abbreviation following USPS standards (e.g., CA, TX, NY). Ref: AWWA.. Valid values are `^[A-Z]{2}$`',
    `within_service_boundary_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the address is within the utilitys authorized service boundary. True if within boundary, False if outside. Ref: AWWA.',
    CONSTRAINT pk_service_address PRIMARY KEY(`service_address_id`)
) COMMENT 'Physical location where water and/or wastewater service is delivered. Captures full street address, city, state, ZIP+4, county, parcel number (APN), GIS coordinates (latitude/longitude), service territory code, pressure zone, DMA (District Metered Area) code, sewer basin, flood zone designation, address validation status, and whether the address is within the utility service boundary. Linked to the distribution network and metering domains via service point. One address may have multiple active accounts over time (tenant turnover).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`premise` (
    `premise_id` BIGINT COMMENT 'Unique identifier for the premise record. Primary key representing the utilitys asset record for a serviceable location. Ref: AWWA.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Premises physically connect to specific distribution mains for water service delivery. Essential for hydraulic modeling, service line inventory (LCRR compliance), outage impact analysis, and main brea',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Premise-to-DMA assignment is essential for non-revenue water (NRW) accounting, leakage survey targeting, and minimum night flow analysis. The existing district_metered_area_code plain text column is',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Premise-level pressure zone assignment drives hydraulic modeling, fire flow adequacy analysis, and demand forecasting. The existing plain-text pressure_zone column on premise is a denormalization of',
    `sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sampling_point. Business justification: Lead and Copper Rule (LCR) tap sampling assigns specific sampling points to individual premises. Direct premise→quality_sampling_point FK supports LCR site tier assignment, premise-level monitoring pr',
    `service_address_id` BIGINT COMMENT 'Reference to the postal and Geographic Information System (GIS) address record for this premise. Links premise to distribution network location. Ref: AWWA.',
    `backflow_prevention_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires backflow prevention devices due to cross-connection hazards. Mandatory for commercial, industrial, and irrigation services per Safe Drinking Water Act (SDWA). Ref: AWWA.',
    `building_square_footage` DECIMAL(18,2) COMMENT 'Total conditioned floor area of structures on the premise in square feet. Used for commercial water demand forecasting and capacity fee assessments. Ref: AWWA.',
    `building_type` STRING COMMENT 'Physical structure classification of the building on the premise. Used for demand forecasting and infrastructure capacity planning. [ENUM-REF-CANDIDATE: detached_house|townhouse|apartment|office|retail|warehouse|manufacturing|school|hospital|government|mixed_use — 11 candidates stripped; promote to reference product]. Ref: AWWA.',
    `connection_fee_paid_amount` DECIMAL(18,2) COMMENT 'Total one-time connection or capacity fees paid for this premise to establish utility service. Includes system development charges and impact fees. Ref: AWWA.',
    `connection_fee_paid_date` DECIMAL(18,2) COMMENT 'Date when connection or capacity fees were paid for this premise. Used for revenue recognition and capital improvement program (CIP) funding tracking. Ref: AWWA.',
    `construction_year` STRING COMMENT 'Year the primary structure on the premise was originally constructed. Used for infrastructure age analysis and lead service line risk assessment per Lead and Copper Rule Revisions (LCRR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this premise record was first created in the utility system. Part of audit trail for data lineage and regulatory compliance. Ref: AWWA.',
    `effective_end_date` DATE COMMENT 'Date when this premise record was retired or became inactive. Null for currently active premises. Supports temporal data management and historical analysis. Ref: AWWA.',
    `effective_start_date` DATE COMMENT 'Date when this premise record became active and available for service connections. Supports temporal data management and historical analysis. Ref: AWWA.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Ground elevation of the premise in feet above mean sea level. Critical for hydraulic pressure calculations and gravity sewer flow analysis. Ref: AWWA.',
    `estimated_daily_demand_gallons` DECIMAL(18,2) COMMENT 'Projected average daily water consumption in gallons for this premise based on premise type, units, and historical usage patterns. Used for capacity planning and meter sizing. Ref: AWWA.',
    `fats_oils_grease_program_flag` BOOLEAN COMMENT 'Indicates whether the premise is subject to Fats, Oils, and Grease (FOG) control program requirements. Applicable to food service establishments to prevent Sanitary Sewer Overflows (SSO). Ref: AWWA.',
    `fire_protection_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires dedicated fire protection service (fire hydrant or sprinkler connection). Determines fire service charge applicability. Ref: AWWA.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the premise location in decimal degrees (WGS84 datum). Used for spatial analysis, hydraulic modeling, and field service dispatch. Ref: AWWA.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the premise location in decimal degrees (WGS84 datum). Used for spatial analysis, hydraulic modeling, and field service dispatch. Ref: AWWA.',
    `industrial_user_permit_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires an Industrial User Permit (IUP) for wastewater discharge due to industrial processes. Triggers pretreatment program compliance monitoring. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this premise record was most recently updated. Used for change tracking and data synchronization across systems. Ref: AWWA.',
    `lot_size_square_feet` DECIMAL(18,2) COMMENT 'Total land area of the premise parcel in square feet. Used for irrigation demand estimation and stormwater fee calculations. Ref: AWWA.',
    `low_income_assistance_eligible_flag` BOOLEAN COMMENT 'Indicates whether the premise qualifies for low-income customer assistance programs based on property characteristics or census tract designation. Used for rate discount eligibility. Ref: AWWA.',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Standard meter size in inches required or installed at this premise based on demand characteristics. Common sizes: 0.625, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0 inches. Ref: AWWA.',
    `number_of_units` STRING COMMENT 'Count of individual dwelling or tenant units within the premise. Applicable for multi-family residential and commercial properties. Used for equivalent dwelling unit (EDU) calculations. Ref: AWWA.',
    `parcel_number` STRING COMMENT 'County assessors parcel number (APN) or tax lot identifier for the property. Used for cross-reference with property tax records and GIS systems. Ref: AWWA.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `peak_demand_gpm` DECIMAL(18,2) COMMENT 'Estimated peak instantaneous water demand in Gallons Per Minute (GPM) for this premise. Used for hydraulic modeling and service line sizing. Ref: AWWA.',
    `premise_number` STRING COMMENT 'Externally-known business identifier for the premise, used in customer communications and field operations. Unique across the utility service territory. Ref: AWWA.. Valid values are `^[A-Z0-9]{6,20}$`',
    `premise_status` STRING COMMENT 'Current lifecycle status of the premise in the utilitys service inventory. Determines whether the premise is available for service connection. Ref: AWWA.. Valid values are `active|inactive|pending_construction|demolished|condemned|seasonal`',
    `premise_type` STRING COMMENT 'Classification of the premise based on its primary use and service characteristics. Determines applicable rate schedules and service requirements. Ref: AWWA.. Valid values are `single_family_residential|multi_family_residential|commercial|industrial|irrigation|fire_protection`',
    `reclaimed_water_service_available_flag` BOOLEAN COMMENT 'Indicates whether recycled or reclaimed water distribution infrastructure is available for non-potable uses such as irrigation. Part of water conservation programs. Ref: AWWA.',
    `service_line_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the water service line in inches. Determines flow capacity and pressure loss from main to premise. Ref: AWWA.',
    `service_line_material` STRING COMMENT 'Material composition of the water service line connecting the distribution main to the premise. Critical for Lead and Copper Rule Revisions (LCRR) compliance and lead service line inventory. [ENUM-REF-CANDIDATE: copper|galvanized_steel|lead|pvc|pex|hdpe|unknown — 7 candidates stripped; promote to reference product]',
    `sewer_lateral_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the sanitary sewer lateral in inches. Determines wastewater conveyance capacity from premise to collection system. Ref: AWWA.',
    `sewer_lateral_material` STRING COMMENT 'Material composition of the sanitary sewer lateral connecting the premise to the collection main. Used for Inflow and Infiltration (I&I) risk assessment. Ref: AWWA.. Valid values are `vitrified_clay|cast_iron|pvc|concrete|orangeburg|unknown`',
    `special_notes` STRING COMMENT 'Free-text field for operational notes, access instructions, or unique characteristics of the premise relevant to field service personnel and customer service representatives. Ref: AWWA.',
    `stormwater_service_available_flag` BOOLEAN COMMENT 'Indicates whether stormwater drainage infrastructure serves this premise. Determines applicability of stormwater utility fees. Ref: AWWA.',
    `wastewater_service_available_flag` BOOLEAN COMMENT 'Indicates whether sanitary sewer collection infrastructure is available to serve this premise. True if sewer mains are accessible within standard connection distance. Ref: AWWA.',
    `water_service_available_flag` BOOLEAN COMMENT 'Indicates whether potable water distribution infrastructure is available to serve this premise. True if water mains are accessible within standard connection distance. Ref: AWWA.',
    `zoning_classification` STRING COMMENT 'Municipal zoning code designation for the premise parcel. Determines permitted land uses and development density. Format varies by jurisdiction. Ref: AWWA.. Valid values are `^[A-Z]{1,3}-[0-9]{1,2}$`',
    CONSTRAINT pk_premise PRIMARY KEY(`premise_id`)
) COMMENT 'The physical property or facility at which utility service is provided, representing the utilitys view of a serviceable location independent of the customer occupying it. Captures premise type (single-family residential, multi-family, commercial, industrial, irrigation, fire protection), lot size, building type, number of units (for multi-family), number of fixture units (for capacity planning), zoning classification, construction year, lead service line status (known lead, galvanized requiring replacement, non-lead, unknown — per LCRR inventory), and whether the premise is subject to low-income assistance programs. Bridges the customer domain to the distribution network and metering domains. Distinct from service_address: a premise is the utilitys asset record for the location; service_address is the postal/GIS record.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` (
    `service_agreement_id` BIGINT COMMENT 'Unique identifier for the customer_service_agreement data product (auto-inserted pre-linking). Ref: AWWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Industrial pretreatment and reclaimed water service agreements are directly governed by a compliance permit (IUP/NPDES). Water utility operations require linking service agreements to their governing ',
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer account referenced by each service agreement record in the customer domain.',
    `meter_id` BIGINT COMMENT 'FK to metering.metering_meter. Ref: AWWA.',
    `parent_service_agreement_id` BIGINT COMMENT 'Parent agreement for sub-accounts. Ref: AWWA.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Service agreements contain denormalized address fields that should reference the service_address master. This eliminates redundancy and ensures address consistency. The service_address table is the au. Ref: AWWA.',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: A service agreement governs water delivery through a specific service line. This link is critical for LCRR compliance — utilities must identify which active service agreements cover lead service lines',
    `person_id` BIGINT COMMENT 'FK to customer.person (signatory). Ref: AWWA.',
    `agreement_number` STRING COMMENT 'Unique service agreement number. Ref: AWWA.',
    `agreement_status` STRING COMMENT 'Current status (active, pending, terminated, suspended). Ref: AWWA.',
    `agreement_type` STRING COMMENT 'Type of service agreement (water, sewer, reclaimed, fire_service). Ref: AWWA.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each service agreement in the customer domain.',
    `auto_renew` BOOLEAN COMMENT 'Flag indicating the agreement auto-renews at expiration. Ref: AWWA.',
    `auto_renewal` BOOLEAN COMMENT 'Auto-renewal enabled. Ref: AWWA.',
    `autopay_enrolled_flag` BOOLEAN COMMENT 'Whether automatic payment is enrolled. Ref: AWWA.',
    `average_daily_usage_gpd` DECIMAL(18,2) COMMENT 'Average daily usage in gallons per day. Ref: AWWA.',
    `average_monthly_usage_ccf` DECIMAL(18,2) COMMENT 'Average monthly usage in CCF. Ref: AWWA.',
    `backflow_device_required` STRING COMMENT 'Whether backflow prevention device is required. Ref: AWWA.',
    `billing_frequency` STRING COMMENT 'MONTHLY, QUARTERLY, ANNUAL. Ref: AWWA.',
    `budget_billing_flag` BOOLEAN COMMENT 'Enrolled in budget billing program. Ref: AWWA.',
    `bulk_water_flag` BOOLEAN COMMENT 'Whether this is a bulk water agreement. Ref: AWWA.',
    `service_agreement_category` STRING COMMENT 'The service agreement category value recorded for each service agreement in the customer domain.',
    `classification` STRING COMMENT 'The classification value recorded for each service agreement in the customer domain.',
    `service_agreement_code` STRING COMMENT 'The service agreement code value recorded for each service agreement in the customer domain.',
    `comments` STRING COMMENT 'The comments value recorded for each service agreement in the customer domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each service agreement in the customer domain.',
    `connection_fee` DECIMAL(18,2) COMMENT 'Connection fee charged. Ref: AWWA.',
    `connection_size_inches` DECIMAL(18,2) COMMENT 'Service connection size in inches. Ref: AWWA.',
    `contracted_demand_mgd` DECIMAL(18,2) COMMENT 'Contracted demand for bulk/special agreements in MGD. Ref: AWWA.',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp. Ref: AWWA.',
    `created_date` TIMESTAMP COMMENT 'Date the service agreement record was created. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: AWWA.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each service agreement in the customer domain.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Required deposit amount. Ref: AWWA.',
    `deposit_required` BOOLEAN COMMENT 'Whether a deposit is required for this agreement. Ref: AWWA.',
    `deposit_required_flag` BOOLEAN COMMENT 'The deposit required flag value recorded for each service agreement in the customer domain.',
    `deposit_waived` BOOLEAN COMMENT 'Whether deposit was waived. Ref: AWWA.',
    `service_agreement_description` STRING COMMENT 'The service agreement description value recorded for each service agreement in the customer domain.',
    `effective_date` TIMESTAMP COMMENT 'Date the agreement became effective. Ref: AWWA.',
    `effective_end_date` TIMESTAMP COMMENT 'Agreement effective end date. Ref: AWWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Agreement effective start date. Ref: AWWA.',
    `end_date` DATE COMMENT 'Agreement end date if applicable. Ref: AWWA.',
    `estimated_annual_usage_gal` STRING COMMENT 'Estimated annual usage in gallons. Ref: AWWA.',
    `estimated_annual_usage_gallons` DECIMAL(18,2) COMMENT 'Estimated annual water usage in gallons. Ref: AWWA.',
    `estimated_monthly_usage_gal` DECIMAL(18,2) COMMENT 'Estimated monthly usage in gallons. Ref: AWWA.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Date the agreement expires or was terminated. Ref: AWWA.',
    `fire_service_flag` BOOLEAN COMMENT 'Whether this is a fire service connection. Ref: AWWA.',
    `irrigation_flag` BOOLEAN COMMENT 'Whether this is an irrigation-only service. Ref: AWWA.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the service agreement record.',
    `is_budget_billing` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in budget/levelized billing. Ref: AWWA.',
    `is_master_agreement` BOOLEAN COMMENT 'Flag indicating this is a master service agreement. Ref: AWWA.',
    `last_modified_date` TIMESTAMP COMMENT 'Date the service agreement was last modified. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modification timestamp. Ref: AWWA.',
    `meter_read_cycle` STRING COMMENT 'The meter read cycle value recorded for each service agreement in the customer domain.',
    `meter_size_inches` STRING COMMENT 'Meter size in inches for this service. Ref: AWWA.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum monthly charge under this agreement. Ref: AWWA.',
    `monthly_base_charge` DECIMAL(18,2) COMMENT 'Monthly base charge. Ref: AWWA.',
    `monthly_base_charge_usd` DECIMAL(18,2) COMMENT 'The monthly base charge usd value recorded for each service agreement in the customer domain.',
    `monthly_charge_usd` DECIMAL(18,2) COMMENT 'The monthly charge usd value recorded for each service agreement in the customer domain.',
    `monthly_minimum_charge` STRING COMMENT 'Monthly minimum/base charge. Ref: AWWA.',
    `service_agreement_name` STRING COMMENT 'The service agreement name used to identify each service agreement record in the customer domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: AWWA.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Whether the customer receives electronic bills only. Ref: AWWA.',
    `peak_demand_gpm` DECIMAL(18,2) COMMENT 'Peak demand in GPM. Ref: AWWA.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each service agreement in the customer domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each service agreement in the customer domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each service agreement in the customer domain.',
    `rate_class` DECIMAL(18,2) COMMENT 'The rate class value recorded for each service agreement in the customer domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: AWWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each service agreement in the customer domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each service agreement in the customer domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each service agreement in the customer domain.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each service agreement record in the customer domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each service agreement in the customer domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each service agreement in the customer domain.',
    `service_agreement_number` STRING COMMENT 'The service agreement number value recorded for each service agreement in the customer domain.',
    `service_agreement_status` STRING COMMENT 'Lifecycle status of the record. Ref: AWWA.',
    `service_agreement_type` STRING COMMENT 'The service agreement type value recorded for each service agreement in the customer domain.',
    `service_class` STRING COMMENT 'Service class (residential, commercial, industrial). Ref: AWWA.',
    `service_type` STRING COMMENT 'Water, wastewater, both. Ref: AWWA.',
    `sewer_service_flag` BOOLEAN COMMENT 'Whether wastewater/sewer service is included. Ref: AWWA.',
    `signed_date` DATE COMMENT 'Date agreement was signed. Ref: AWWA.',
    `special_contract_flag` BOOLEAN COMMENT 'Whether a special contract applies. Ref: AWWA.',
    `special_terms` STRING COMMENT 'Special terms and conditions. Ref: AWWA.',
    `start_date` DATE COMMENT 'Agreement effective start date. Ref: AWWA.',
    `stormwater_service_flag` BOOLEAN COMMENT 'Whether stormwater service is included. Ref: AWWA.',
    `termination_date` TIMESTAMP COMMENT 'Actual termination date. Ref: AWWA.',
    `termination_notice_days` BIGINT COMMENT 'Required termination notice in days. Ref: AWWA.',
    `termination_reason` STRING COMMENT 'Reason for termination if agreement is closed. Ref: AWWA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each service agreement in the customer domain.',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp. Ref: AWWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: AWWA.',
    CONSTRAINT pk_service_agreement PRIMARY KEY(`service_agreement_id`)
) COMMENT 'The contractual relationship between a customer account and the utility for a specific service type (potable water, wastewater, recycled water, fire protection, irrigation) at a premise. Captures service agreement number, service type, rate schedule code, start date, end date, deposit amount, deposit waiver reason, service class, budget billing enrollment, and agreement status. This is the SSOT for what service a customer is contracted to receive and at what rate. Distinct from billing invoices (which are transactional) and from the rate schedule (which is a reference entity in the service domain).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`service_application` (
    `service_application_id` BIGINT COMMENT 'Unique identifier for the service application record. Primary key. Ref: AWWA.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Service applications capture applicant details that should reference the person master record. This eliminates data duplication and ensures applicant identity is properly managed. The person table con. Ref: AWWA.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service applications are for establishing service at specific premises. While service_address_id exists, the premise_id link is needed to reference the physical property record which contains addition. Ref: AWWA.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: New service applications require engineering review to verify adequate pressure and capacity in the target pressure zone before approval. Critical for ensuring system can support additional demand wit. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer (applicant) who submitted this service application. Links to the customer master record. Ref: AWWA.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: A service application, once approved, results in the creation of a service agreement. Linking service_application to the resulting service_agreement captures the full customer lifecycle from applicati',
    `service_address_id` BIGINT COMMENT 'Reference to the service address (premise) where water or wastewater service is being requested. Links to the service address master record. Ref: AWWA.',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: A new service application triggers service line installation or connection to an existing line. Linking application to service_line supports new connection workflow tracking, LCRR material classificat',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: New service connection approval requires verifying which treatment facility will serve the premise and confirming available capacity (design_capacity_mgd vs current_avg_flow_mgd). Capacity planning an',
    `sewer_service_connection_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_service_connection. Business justification: A sewer service application, when approved, results in creation of a sewer_service_connection. Linking the application to the resulting connection supports new service provisioning workflows, connecti',
    `application_number` STRING COMMENT 'Externally-visible unique application number assigned when the customer submits a service application. Used for customer communication and tracking. Ref: AWWA.. Valid values are `^APP-[0-9]{8,12}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the service application: submitted (initial state), under review (being processed by utility staff), approved (ready for service establishment), rejected (application denied), withdrawn (applicant cancelled), or pending payment (awaiting deposit or connection fee). Ref: AWWA.. Valid values are `submitted|under_review|approved|rejected|withdrawn|pending_payment`',
    `application_type` STRING COMMENT 'Type of service application: new service establishment, transfer of service to new occupant, service upgrade (larger meter or additional service), service downgrade, service termination, or reconnection after disconnection. Ref: AWWA.. Valid values are `new_service|transfer|upgrade|downgrade|termination|reconnection`',
    `approval_date` DATE COMMENT 'Date when the service application was approved by the utility, authorizing service establishment. Ref: AWWA.',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the service application was approved. Ref: AWWA.',
    `connection_fee_amount` DECIMAL(18,2) COMMENT 'One-time connection or service establishment fee charged to the applicant for initiating water or wastewater service at the premise. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this service application record was first created in the system. Ref: AWWA.',
    `credit_check_result` STRING COMMENT 'Outcome of the credit check: pass (credit meets utility standards), fail (credit does not meet standards, deposit required), insufficient history (no credit history available), or not applicable (credit check not performed). Ref: AWWA.. Valid values are `pass|fail|insufficient_history|not_applicable`',
    `credit_check_status` STRING COMMENT 'Status of credit check for the applicant: not required (based on service class or policy), pending (credit check requested), completed (credit check results received), or waived (credit check requirement waived by management). Ref: AWWA.. Valid values are `not_required|pending|completed|waived`',
    `credit_score` STRING COMMENT 'Numeric credit score obtained from credit bureau for the applicant, used to determine deposit requirements and service approval. Ref: AWWA.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit required from the applicant before service establishment. Null if no deposit is required. Ref: AWWA.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required from the applicant before service can be established, based on credit check results, service history, or utility policy. Ref: AWWA.',
    `identity_verification_method` STRING COMMENT 'Method used to verify the applicants identity: drivers license, passport, utility bill from previous address, government-issued ID, credit report, or in-person verification at utility office. Ref: AWWA.. Valid values are `drivers_license|passport|utility_bill|government_id|credit_report|in_person`',
    `identity_verification_status` STRING COMMENT 'Status of applicant identity verification process: not started, pending (documents submitted, under review), verified (identity confirmed), or failed (unable to verify identity). Ref: AWWA.. Valid values are `not_started|pending|verified|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this service application record was last updated or modified. Ref: AWWA.',
    `meter_size_requested` STRING COMMENT 'Size of water meter requested by the applicant or recommended by utility staff based on anticipated usage (e.g., 5/8 inch, 3/4 inch, 1 inch, 1.5 inch, 2 inch, etc.). Ref: AWWA.',
    `priority_level` STRING COMMENT 'Priority level assigned to the application for processing: low (standard processing), normal (default priority), high (expedited processing requested), or urgent (emergency service needed). Ref: AWWA.. Valid values are `low|normal|high|urgent`',
    `processing_notes` STRING COMMENT 'Free-text notes entered by utility staff during application review and processing, documenting special circumstances, follow-up actions, or additional context. Ref: AWWA.',
    `rejection_date` DATE COMMENT 'Date when the service application was rejected by the utility. Null if application was not rejected. Ref: AWWA.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the service application was rejected (e.g., failed credit check, incomplete documentation, service not available at address, outstanding balance from previous account). Ref: AWWA.',
    `rejection_reason_code` STRING COMMENT 'Standardized code categorizing the reason for application rejection: credit failure, incomplete documentation, service unavailable at location, outstanding balance from prior account, duplicate application, or invalid service address. Ref: AWWA.. Valid values are `credit_fail|incomplete_docs|service_unavailable|outstanding_balance|duplicate_application|invalid_address`',
    `requested_service_start_date` DATE COMMENT 'Date when the applicant requests water or wastewater service to begin at the service address. Ref: AWWA.',
    `review_completed_date` DATE COMMENT 'Date when the application review process was completed and a decision (approved or rejected) was made. Ref: AWWA.',
    `review_start_date` DATE COMMENT 'Date when utility staff began reviewing and processing the service application. Ref: AWWA.',
    `service_class_requested` STRING COMMENT 'Customer segment or service class requested: residential (single-family or multi-family), commercial (retail, office), industrial (manufacturing, processing), municipal (government facilities), agricultural (irrigation, livestock), or institutional (schools, hospitals). Ref: AWWA.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `service_type_requested` STRING COMMENT 'Type of utility service requested by the applicant: water only, wastewater (sewer) only, or combined water and wastewater service. Ref: AWWA.. Valid values are `water_only|wastewater_only|water_and_wastewater`',
    `sla_due_date` DATE COMMENT 'Target date by which the application should be reviewed and processed according to utility service level agreement standards. Ref: AWWA.',
    `submission_channel` STRING COMMENT 'Channel through which the customer submitted the service application: online customer portal, phone call to customer service, walk-in at utility office, postal mail, mobile app, or email. Ref: AWWA.. Valid values are `online_portal|phone|walk_in|mail|mobile_app|email`',
    `submission_date` DATE COMMENT 'Date when the customer submitted the service application. Ref: AWWA.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the service application was submitted by the customer or entered into the system. Ref: AWWA.',
    `withdrawn_date` DATE COMMENT 'Date when the applicant withdrew or cancelled the service application. Null if application was not withdrawn. Ref: AWWA.',
    `withdrawn_reason` STRING COMMENT 'Reason provided by the applicant for withdrawing the service application (e.g., changed mind, moved to different location, service no longer needed). Ref: AWWA.',
    CONSTRAINT pk_service_application PRIMARY KEY(`service_application_id`)
) COMMENT 'Record of a customers application to establish, transfer, or modify water and/or wastewater service. Captures application number, application type (new service, transfer, upgrade, downgrade, termination), applicant identity, requested service address, requested service start date, application submission channel (online, phone, walk-in), application status (submitted, under review, approved, rejected, withdrawn), identity verification outcome, credit check result, deposit requirement, and processing timestamps. Represents the start of the customer lifecycle. Sourced from Oracle CC&B and Microsoft Dynamics 365.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for each customer interaction record. Primary key. Ref: AWWA.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Customer interactions capture contact details that should reference the person master when the contact is a known person. This eliminates duplication of person contact information. Nullable as some in. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this interaction. Links to the customer account master record. Ref: AWWA.',
    `high_usage_alert_id` BIGINT COMMENT 'Foreign key linking to metering.high_usage_alert. Business justification: Customer service interactions are frequently initiated when a customer calls about a high-usage alert notification (high bill, suspected leak). Linking the interaction to the triggering alert supports',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Customer reports about hydrant problems (leaking, damaged, blocked access, vandalism) reference specific hydrant assets. Enables tracking of public-reported hydrant defects, prioritizing inspection/re. Ref: AWWA.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customer service interactions (billing dispute calls, high-bill inquiries) reference a specific invoice. Direct FK enables billing dispute resolution workflow, first-contact resolution tracking, and r',
    `network_valve_id` BIGINT COMMENT 'Foreign key linking to distribution.network_valve. Business justification: Customer reports about valve issues (leaking valve box, exposed valve, damaged cover) reference specific valve assets. Enables public-sourced defect identification, prioritizes valve maintenance, and. Ref: AWWA.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Customer interactions about payment confirmations, NSF fee disputes, and payment reversal inquiries reference a specific payment record. Direct FK enables payment dispute resolution tracking, customer',
    `service_address_id` BIGINT COMMENT 'Reference to the service address associated with this interaction. Null if interaction is not address-specific. Ref: AWWA.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Customer interactions may pertain to specific service agreements (e.g., questions about a particular service). This enables agreement-level interaction tracking. Nullable as some interactions are acco. Ref: AWWA.',
    `service_application_id` BIGINT COMMENT 'Foreign key linking to customer.service_application. Business justification: Customer interactions frequently reference a specific service application — for example, a customer calling to check on their new service application status, or a utility agent following up on a pendi',
    `accessibility_accommodation` STRING COMMENT 'Description of any accessibility accommodations provided during the interaction (e.g., TTY, large print, sign language). Null if no accommodation was required. Ref: AWWA.',
    `agent_name` STRING COMMENT 'Full name of the customer service agent who handled the interaction. Null for self-service interactions. Ref: AWWA.',
    `callback_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the requested callback was completed. Null if callback was not requested or not yet completed. Ref: AWWA.',
    `callback_requested_flag` BOOLEAN COMMENT 'Indicates whether the customer requested a callback from the utility. Ref: AWWA.',
    `case_number` STRING COMMENT 'Reference to a formal case or complaint record created in the CRM system as a result of this interaction. Null if no case was created. Ref: AWWA.. Valid values are `^CASE-[0-9]{8}$`',
    `interaction_category` STRING COMMENT 'High-level category grouping for the interaction type, used for reporting and analytics (e.g., billing, service delivery, water quality, account management). Ref: AWWA.',
    `channel` STRING COMMENT 'Channel through which the interaction occurred: inbound call, outbound call, web portal, mobile app, email, chat, walk-in visit, IVR self-service, or SMS. [ENUM-REF-CANDIDATE: inbound_call|outbound_call|web_portal|mobile_app|email|chat|walk_in|ivr|sms — 9 candidates stripped; promote to reference product]. Ref: AWWA.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction was formally closed. Null if interaction is not yet closed. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction record was first created in the system. Ref: AWWA.',
    `customer_satisfaction_score` STRING COMMENT 'Customer satisfaction rating provided by the customer after the interaction, typically on a scale of 1 to 5. Null if not captured. Ref: AWWA.',
    `interaction_description` STRING COMMENT 'Detailed narrative description of the interaction, including customer inquiry, issue reported, and any relevant context provided by the customer or agent. Ref: AWWA.',
    `duration_seconds` STRING COMMENT 'Total duration of the interaction in seconds, applicable primarily to call and chat channels. Null for asynchronous channels like email. Ref: AWWA.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the interaction was escalated to a supervisor, specialist, or higher tier of support.',
    `escalation_reason` STRING COMMENT 'Reason for escalating the interaction, such as complex technical issue, customer dissatisfaction, or policy exception required. Null if not escalated. Ref: AWWA.',
    `first_contact_resolution_flag` BOOLEAN COMMENT 'Indicates whether the interaction was resolved during the first contact without requiring follow-up. Key customer service performance indicator. Ref: AWWA.',
    `interaction_number` STRING COMMENT 'Business-facing unique identifier for the interaction, used for tracking and reference in customer communications. Ref: AWWA.. Valid values are `^INT-[0-9]{10}$`',
    `interaction_status` STRING COMMENT 'Current lifecycle status of the interaction: open, in progress, pending customer response, pending internal action, resolved, closed, or cancelled. [ENUM-REF-CANDIDATE: open|in_progress|pending_customer|pending_internal|resolved|closed|cancelled — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `interaction_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction was initiated or received by the utility. Primary business event timestamp for the interaction. Ref: AWWA.',
    `interaction_type` STRING COMMENT 'Classification of the interaction purpose: billing inquiry, service request, complaint, outage report, payment arrangement, or general inquiry. Ref: AWWA.. Valid values are `billing_inquiry|service_request|complaint|outage_report|payment_arrangement|general_inquiry`',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required or used during the interaction. Ref: AWWA.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language used during the interaction. [ENUM-REF-CANDIDATE: ENG|SPA|FRE|CHI|VIE|KOR|RUS|ARA|POR|GER — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction record was last updated or modified. Ref: AWWA.',
    `net_promoter_score` STRING COMMENT 'Net Promoter Score provided by the customer, typically on a scale of 0 to 10, measuring likelihood to recommend the utility. Null if not captured. Ref: AWWA.',
    `priority` STRING COMMENT 'Priority level assigned to the interaction based on urgency and impact: low, medium, high, urgent, or critical. Ref: AWWA.. Valid values are `low|medium|high|urgent|critical`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution provided, actions taken, and any follow-up required. Populated when interaction is resolved or closed. Ref: AWWA.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction was marked as resolved. Null if interaction is still open or in progress. Ref: AWWA.',
    `source_system_code` STRING COMMENT 'Unique identifier of the interaction record in the source system, used for traceability and reconciliation. Ref: AWWA.',
    `subcategory` STRING COMMENT 'Detailed subcategory within the interaction category, providing granular classification for analytics (e.g., high bill inquiry, leak report, water pressure issue). Ref: AWWA.',
    `subject` STRING COMMENT 'Brief subject or title summarizing the purpose or topic of the interaction. Ref: AWWA.',
    `survey_completed_flag` BOOLEAN COMMENT 'Indicates whether the customer completed a post-interaction satisfaction survey. Ref: AWWA.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Unified record of every customer-initiated or utility-initiated interaction, contact, and account note across all channels — inbound calls, outbound calls, web portal sessions, chat, email, walk-in visits, IVR self-service, and system-generated notes. Captures interaction date and time, channel, interaction type (billing inquiry, service request, complaint, outage report, payment arrangement, general inquiry, staff note, system alert), record subtype (structured interaction vs free-text note), duration, agent ID, note text (for unstructured entries), note visibility level (internal/external), resolution status, case or work order reference, workflow trigger flag, and customer satisfaction score if captured. Sourced from Microsoft Dynamics 365 CRM and Oracle CC&B. SSOT for all customer contact history and account annotations. Supports customer service continuity, dispute resolution, and field crew awareness (e.g., dangerous dog, locked gate, medical equipment dependency).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Unique identifier for the customer complaint record. Primary key. Ref: AWWA.',
    `accuracy_test_id` BIGINT COMMENT 'Foreign key linking to metering.accuracy_test. Business justification: Customer complaints about meter accuracy or billing disputes directly trigger meter accuracy tests (accuracy_test.complaint_triggered flag confirms this process). Linking complaint to the resulting ac',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Aggregating complaints by DMA reveals water loss patterns, quality issues, and pressure problems at the zone level. Supports NRW reduction programs, leak detection prioritization, and proactive main r. Ref: AWWA.',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Complaints about hydrant flushing causing discoloration, hydrant damage, or unauthorized use are directly associated with a specific hydrant. This link supports hydrant-level complaint history trackin',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Billing complaints (high-bill disputes, estimated read complaints) reference a specific invoice. Regulatory complaint tracking and state PUC reporting require linking formal complaints to the specific',
    `network_valve_id` BIGINT COMMENT 'Foreign key linking to distribution.network_valve. Business justification: Planned valve operations (shutdowns for maintenance) and unplanned valve failures directly cause customer pressure complaints and service interruptions. Linking complaint to network_valve enables valv',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to customer.interaction. Business justification: A customer complaint is typically initiated through a customer interaction (phone call, in-person visit, online submission). Linking customer_complaint to the originating interaction via originating_i',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Water quality complaints (taste, odor, discoloration, pressure) routinely reference the specific distribution main where the issue originates. Operations teams use this for targeted flushing, leak det. Ref: AWWA.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Pressure-related complaints must reference the pressure zone for operational dispatch and system performance analysis. Enables zone-level complaint trending, identifies chronic low-pressure areas, and. Ref: AWWA.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this complaint. Ref: AWWA.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Complaints capture reporter details that should reference the person master when the reporter is a known person. This eliminates duplication and enables proper reporter tracking. Nullable as some comp. Ref: AWWA.',
    `service_address_id` BIGINT COMMENT 'Reference to the service address where the complaint issue is occurring. Ref: AWWA.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Complaints may relate to specific service agreements (e.g., billing disputes for a particular service type). This provides more granular complaint tracking for accounts with multiple agreements. Nulla. Ref: AWWA.',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: Complaints about sewer odors, backups, or overflows must be mapped to the specific sewer network segment for infrastructure condition analysis, maintenance prioritization, and SSO risk reporting. Mirr',
    `high_usage_alert_id` BIGINT COMMENT 'Foreign key linking to metering.high_usage_alert. Business justification: A high-usage alert frequently generates a customer complaint (high bill dispute, suspected leak). Linking the complaint directly to the alert that triggered it closes the alert-to-complaint lifecycle,',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Complaint-driven sampling is a named operational workflow: when a customer reports taste, odor, or color issues, the utility collects a water sample at the premise. Direct FK enables complaint-to-samp',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Water quality complaints require facility-specific investigation and operator response. Linking complaints to serving facility enables proper routing to facility operators, coordinated sampling, and f. Ref: AWWA.',
    `actual_resolution_date` DATE COMMENT 'Actual date when the complaint was resolved and closed. Ref: AWWA.',
    `assigned_date` DATE COMMENT 'Date when the complaint was assigned to a resolution owner. Ref: AWWA.',
    `assigned_to_department` STRING COMMENT 'Department or functional area responsible for resolving the complaint, such as Customer Service, Water Quality, Distribution Operations and Maintenance (O&M), Billing, or Laboratory. Ref: AWWA.',
    `billing_adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of billing adjustment or credit issued to the customer as a result of the complaint resolution, if applicable. Ref: AWWA.',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint type. Water quality includes turbidity, discoloration, and contaminant concerns. Billing disputes cover charges, meter reads, and rate application. Service interruption includes planned and unplanned outages. Pressure issues cover low or high Pounds per Square Inch (PSI). Regulatory complaints are those escalated to state primacy agencies or Public Utilities Commission (PUC). [ENUM-REF-CANDIDATE: water_quality|billing_dispute|service_interruption|pressure_issue|odor_taste|leak|meter_accuracy|customer_service|regulatory|other — 10 candidates stripped; promote to reference product]. Ref: AWWA.',
    `compensation_provided_flag` BOOLEAN COMMENT 'Indicates whether any form of compensation, credit, or goodwill gesture was provided to the customer as part of the complaint resolution. Ref: AWWA.',
    `complaint_number` STRING COMMENT 'Externally visible unique complaint tracking number assigned by the Customer Information System (CIS) or Customer Care and Billing (CC&B) system. Ref: AWWA.',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the complaint in the resolution workflow. [ENUM-REF-CANDIDATE: open|in_progress|pending_customer|pending_investigation|resolved|closed|escalated|withdrawn — 8 candidates stripped; promote to reference product]. Ref: AWWA.',
    `contact_method` STRING COMMENT 'Channel through which the complaint was received by the utility. [ENUM-REF-CANDIDATE: phone|email|web_portal|mobile_app|in_person|mail|social_media — 7 candidates stripped; promote to reference product]. Ref: AWWA.',
    `corrective_action` STRING COMMENT 'Specific corrective action taken to address the root cause and prevent recurrence, such as infrastructure repair, meter replacement, billing adjustment, or process improvement. Ref: AWWA.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the complaint record was first created in the database. Ref: AWWA.',
    `customer_satisfaction_comments` STRING COMMENT 'Free-text feedback provided by the customer regarding their satisfaction with the complaint resolution process and outcome. Ref: AWWA.',
    `customer_satisfaction_rating` STRING COMMENT 'Customer satisfaction score provided by the customer after complaint resolution, typically on a scale of 1 to 5 or 1 to 10. Ref: AWWA.',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the complaint as reported by the customer, including symptoms, duration, and customer concerns. Ref: AWWA.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up action or customer contact to verify sustained resolution. Ref: AWWA.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up action or monitoring is required after initial complaint resolution. Ref: AWWA.',
    `internal_notes` STRING COMMENT 'Internal notes and comments for staff use, not visible to the customer, documenting investigation steps, coordination with other departments, and operational context. Ref: AWWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the complaint record was last updated. Ref: AWWA.',
    `priority_level` STRING COMMENT 'Urgency classification of the complaint based on health and safety risk, regulatory exposure, and customer impact. Critical includes Maximum Contaminant Level (MCL) exceedances and Sanitary Sewer Overflow (SSO) events. Ref: AWWA.. Valid values are `critical|high|medium|low`',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency involved if the complaint was escalated, such as state Department of Environmental Quality, Public Utilities Commission (PUC), or U.S. Environmental Protection Agency (EPA). Ref: AWWA.',
    `regulatory_case_number` STRING COMMENT 'Case or reference number assigned by the regulatory agency for tracking the escalated complaint. Ref: AWWA.',
    `regulatory_escalation_flag` BOOLEAN COMMENT 'Indicates whether the complaint was escalated to or originated from a regulatory agency such as state primacy agency, Public Utilities Commission (PUC), or U.S. Environmental Protection Agency (EPA). Ref: AWWA.',
    `regulatory_response_due_date` DATE COMMENT 'Date by which the utility must provide a formal response to the regulatory agency regarding the escalated complaint. Ref: AWWA.',
    `reported_date` DATE COMMENT 'Date when the complaint was first reported to the utility by the customer. Ref: AWWA.',
    `reported_timestamp` TIMESTAMP COMMENT 'Precise date and time when the complaint was logged into the system, including time zone offset. Ref: AWWA.',
    `resolution_description` STRING COMMENT 'Detailed narrative of the actions taken to resolve the complaint, including investigation findings, corrective actions, and customer communication. Ref: AWWA.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the complaint was marked as resolved, including time zone offset. Ref: AWWA.',
    `root_cause` STRING COMMENT 'Identified root cause of the complaint issue, such as main break, meter malfunction, billing system error, water treatment process deviation, or customer misunderstanding. Ref: AWWA.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: AWWA.',
    `subcategory` STRING COMMENT 'Detailed subcategory providing additional classification granularity within the primary complaint category. Examples: discoloration, chlorine_odor, high_bill, estimated_read, low_pressure, no_water, meter_leak, service_attitude. Ref: AWWA.',
    `target_resolution_date` DATE COMMENT 'Target date by which the complaint should be resolved, based on Service Level Agreement (SLA) commitments and regulatory requirements. Ref: AWWA.',
    `water_quality_test_required_flag` BOOLEAN COMMENT 'Indicates whether a water quality test was required or performed as part of the complaint investigation, particularly for complaints involving taste, odor, discoloration, or suspected contamination. Ref: AWWA.',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Formal record of a customer complaint or grievance filed with the utility, including water quality complaints, billing disputes, service interruption complaints, pressure complaints, odor/taste complaints, and regulatory complaints escalated to the state primacy agency or PUC. Captures complaint number, complaint category, complaint description, reported date, assigned resolution owner, target resolution date, actual resolution date, resolution description, regulatory escalation flag, and customer satisfaction outcome. Distinct from customer_interaction (which captures all contacts) — a complaint has its own formal resolution workflow and regulatory reporting obligations. [SSOT: Canonical source of truth for this concept across domains.] SSOT master for complaints.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`organization`(`organization_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ADD CONSTRAINT `fk_customer_person_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`organization`(`organization_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ADD CONSTRAINT `fk_customer_person_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`organization`(`organization_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_parent_service_agreement_id` FOREIGN KEY (`parent_service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_application_id` FOREIGN KEY (`service_application_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_application`(`service_application_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`interaction`(`interaction_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_water_utilities_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` SET TAGS ('dbx_subdomain' = 'account_identity');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` SET TAGS ('dbx_subdomain' = 'account_identity');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Organization Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `autopay_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `autopay_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enrollment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `credit_check_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Consent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `credit_check_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Consent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'residential|small_commercial|large_commercial|industrial|municipal|agricultural');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `data_sharing_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'Disability Accommodation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_notes` SET TAGS ('dbx_business_glossary_term' = 'Disability Accommodation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_notes` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_expiration_date` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Issuing State');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_issuing_state` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Number (Masked)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_type` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_type` SET TAGS ('dbx_value_regex' = 'drivers_license|state_id|passport|military_id|tribal_id|ssn');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_type` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'in_person|online|mail|third_party_service');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired|not_required');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `life_support_equipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Support Equipment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `life_support_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Life Support Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `low_income_assistance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `low_income_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Low Income Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `marketing_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `marketing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `paperless_billing_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `person_status` SET TAGS ('dbx_business_glossary_term' = 'Person Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `person_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deceased|merged|duplicate');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `person_type` SET TAGS ('dbx_business_glossary_term' = 'Person Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `person_type` SET TAGS ('dbx_value_regex' = 'account_holder|co_applicant|authorized_contact|guarantor|emergency_contact|property_owner');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mail|portal');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_value_regex' = 'mobile|home|work|other');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `senior_citizen_flag` SET TAGS ('dbx_business_glossary_term' = 'Senior Citizen Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'Jr|Sr|II|III|IV|V');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` SET TAGS ('dbx_subdomain' = 'account_identity');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `parent_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Range');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `auto_pay_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enrolled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `credit_tier` SET TAGS ('dbx_business_glossary_term' = 'Credit Tier Classification');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `credit_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|unrated');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `credit_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'commercial|industrial|municipal|institutional|agricultural|government');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `dba_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `employee_count_range` SET TAGS ('dbx_business_glossary_term' = 'Employee Count Range');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Employer Identification Number (EIN)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `industrial_user_classification` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Classification');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `industrial_user_classification` SET TAGS ('dbx_value_regex' = 'categorical|significant|non_significant|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `industrial_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Organization Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `legal_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_value_regex' = 'corporation|llc|partnership|municipality|hoa|government_agency');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?1?d{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `special_billing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Billing Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Organization Website URL');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_business_glossary_term' = 'Address End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_business_glossary_term' = 'Address Source System');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|corrected|invalid');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Assessor Parcel Number (APN)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural|institutional');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `flood_zone_designation` SET TAGS ('dbx_business_glossary_term' = 'Flood Zone Designation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `meter_location_description` SET TAGS ('dbx_business_glossary_term' = 'Meter Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'occupied|vacant|seasonal|under_construction');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP+4)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'water_only|wastewater_only|water_and_wastewater|stormwater|reclaimed_water');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `sewer_basin` SET TAGS ('dbx_business_glossary_term' = 'Sewer Basin');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_business_glossary_term' = 'Standardized Address');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `within_service_boundary_flag` SET TAGS ('dbx_business_glossary_term' = 'Within Service Boundary Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Connected Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `backflow_prevention_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `building_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Building Square Footage');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `connection_fee_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Paid Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `connection_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Paid Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `estimated_daily_demand_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Daily Demand (Gallons)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `fats_oils_grease_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Fats Oils and Grease (FOG) Program Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `fire_protection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Protection Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `industrial_user_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `lot_size_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Lot Size (Square Feet)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `low_income_assistance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Units');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `parcel_number` SET TAGS ('dbx_business_glossary_term' = 'Parcel Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `parcel_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `peak_demand_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (Gallons Per Minute - GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `premise_number` SET TAGS ('dbx_business_glossary_term' = 'Premise Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `premise_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `premise_status` SET TAGS ('dbx_business_glossary_term' = 'Premise Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `premise_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_construction|demolished|condemned|seasonal');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `premise_type` SET TAGS ('dbx_business_glossary_term' = 'Premise Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `premise_type` SET TAGS ('dbx_value_regex' = 'single_family_residential|multi_family_residential|commercial|industrial|irrigation|fire_protection');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `reclaimed_water_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Reclaimed Water Service Available Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_line_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Service Line Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_line_material` SET TAGS ('dbx_business_glossary_term' = 'Service Line Material');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `sewer_lateral_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Sewer Lateral Diameter (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `sewer_lateral_material` SET TAGS ('dbx_business_glossary_term' = 'Sewer Lateral Material');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `sewer_lateral_material` SET TAGS ('dbx_value_regex' = 'vitrified_clay|cast_iron|pvc|concrete|orangeburg|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `special_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `stormwater_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Service Available Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `wastewater_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Service Available Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `water_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Service Available Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_business_glossary_term' = 'Zoning Classification');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}-[0-9]{1,2}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_service_agreement');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `parent_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Agreement Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `auto_renew` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `autopay_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enrolled');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `average_monthly_usage_ccf` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Usage Ccf');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `budget_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `bulk_water_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Water Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `deposit_waived` SET TAGS ('dbx_business_glossary_term' = 'Deposit Waived');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `estimated_annual_usage_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Usage');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `is_budget_billing` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `is_master_agreement` SET TAGS ('dbx_business_glossary_term' = 'Is Master Agreement');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `monthly_charge_usd` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `peak_demand_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Gpm');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `sewer_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Sewer Service');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `special_contract_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `stormwater_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Service');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_application_id` SET TAGS ('dbx_business_glossary_term' = 'Service Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `sewer_service_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Service Connection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{8,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|rejected|withdrawn|pending_payment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'new_service|transfer|upgrade|downgrade|termination|reconnection');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Application Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `connection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `credit_check_result` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Result');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `credit_check_result` SET TAGS ('dbx_value_regex' = 'pass|fail|insufficient_history|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|waived');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `credit_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'drivers_license|passport|utility_bill|government_id|credit_report|in_person');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `meter_size_requested` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Requested');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Application Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `processing_notes` SET TAGS ('dbx_business_glossary_term' = 'Application Processing Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Application Rejection Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Application Rejection Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = 'credit_fail|incomplete_docs|service_unavailable|outstanding_balance|duplicate_application|invalid_address');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `requested_service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Application Review Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Application Review Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_class_requested` SET TAGS ('dbx_business_glossary_term' = 'Service Class Requested');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_class_requested` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural|institutional');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Service Type Requested');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_type_requested` SET TAGS ('dbx_value_regex' = 'water_only|wastewater_only|water_and_wastewater');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'online_portal|phone|walk_in|mail|mobile_app|email');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `withdrawn_date` SET TAGS ('dbx_business_glossary_term' = 'Application Withdrawn Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `withdrawn_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Withdrawn Reason');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Interaction Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `high_usage_alert_id` SET TAGS ('dbx_business_glossary_term' = 'High Usage Alert Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `network_valve_id` SET TAGS ('dbx_business_glossary_term' = 'Network Valve Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_application_id` SET TAGS ('dbx_business_glossary_term' = 'Service Application Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `accessibility_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `agent_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `callback_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Callback Completed Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `callback_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Callback Requested Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^CASE-[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_category` SET TAGS ('dbx_business_glossary_term' = 'Interaction Category');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_description` SET TAGS ('dbx_business_glossary_term' = 'Interaction Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration in Seconds');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `first_contact_resolution_flag` SET TAGS ('dbx_business_glossary_term' = 'First Contact Resolution (FCR) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_business_glossary_term' = 'Interaction Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_value_regex' = '^INT-[0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'billing_inquiry|service_request|complaint|outage_report|payment_arrangement|general_inquiry');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `net_promoter_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Interaction Priority');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent|critical');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subcategory');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `survey_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Survey Completed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `network_valve_id` SET TAGS ('dbx_business_glossary_term' = 'Network Valve Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Interaction Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `high_usage_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering High Usage Alert Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `assigned_to_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Department');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `billing_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `compensation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Provided Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `compensation_provided_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `compensation_provided_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Contact Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `customer_satisfaction_comments` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Comments');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `regulatory_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Escalation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `regulatory_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Complaint Subcategory');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `water_quality_test_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Test Required Flag');
