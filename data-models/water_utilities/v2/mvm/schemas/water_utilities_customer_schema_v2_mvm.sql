-- Schema for Domain: customer | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-10 20:15:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`customer` COMMENT 'Single source of truth for all water and wastewater service accounts including residential, commercial, industrial, and municipal customers. Manages customer profiles, service addresses, account hierarchies, customer segments, contact information, service agreements, and customer lifecycle from application through termination. SSOT for customer identity across all billing, metering, and service delivery systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` (
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer_account data product (auto-inserted pre-linking).',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: A customer account is held by a person (the account holder). This critical FK links the master account record to the individual person record. customer_account is the child in this relationship — one ',
    `organization_id` BIGINT COMMENT 'Foreign key linking to customer.organization. Business justification: Commercial and industrial customer accounts should reference the organization master record. This allows proper tracking of corporate account structures. The account table currently only has person_id',
    CONSTRAINT pk_customer_account PRIMARY KEY(`customer_account_id`)
) COMMENT 'Master record for every water and wastewater service account — residential, commercial, industrial, and municipal. Serves as the SSOT for customer identity across Oracle CC&B, SAP, AMI, and all downstream systems. Captures account number, account type (residential/commercial/industrial/municipal), account status (active/inactive/pending/suspended/terminated), service class, credit rating, account open date, account close date, language preference, paperless billing flag, autopay enrollment, lifecycle stage, and water budget allocation (where applicable). This is the primary anchor entity for the customer domain — all billing, metering, service delivery, and regulatory reporting references flow through this entity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`person` (
    `person_id` BIGINT COMMENT 'Unique identifier for the person record. Primary key for the person entity. Serves as the single source of truth for individual identity within the customer domain.',
    `service_address_id` BIGINT COMMENT 'add column service_address_id (BIGINT) with FK to customer.service_address.service_address_id - persons should be linkable to their primary residence address for correspondence and lead service line notifications',
    `autopay_enrollment_date` DATE COMMENT 'The date when the person enrolled in or opted out of autopay in yyyy-MM-dd format. Used for payment preference tracking and billing operations.',
    `autopay_enrollment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has enrolled in automatic payment (autopay) for their utility bills. True if enrolled in autopay, False otherwise. Used for payment processing and customer convenience tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this person record was first created in the system in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trails, data lineage, and record lifecycle tracking.',
    `credit_check_consent_date` DATE COMMENT 'The date when the person provided consent for credit check in yyyy-MM-dd format. Used for compliance documentation and audit trails.',
    `credit_check_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has provided consent for the utility to perform a credit check. True if consent given, False otherwise. Required for deposit determination and account establishment.',
    `customer_segment` STRING COMMENT 'The business segment classification of the person based on their primary account relationship. Used for rate classification, service level determination, and customer analytics. Aligns with rate schedule eligibility.. Valid values are `residential|small_commercial|large_commercial|industrial|municipal|agricultural`',
    `data_sharing_consent_date` DATE COMMENT 'The date when the person provided or withdrew data sharing consent in yyyy-MM-dd format. Used for compliance documentation and privacy management.',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has consented to sharing their data with third parties (e.g., energy efficiency program partners, government agencies, research organizations). True if consent given, False otherwise.',
    `date_of_birth` DATE COMMENT 'The persons date of birth in yyyy-MM-dd format. Used for identity verification, age-based service eligibility (e.g., senior citizen rates), and compliance with age-restricted service programs.',
    `disability_accommodation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person requires disability accommodations for service delivery, communications, or billing. True if accommodations required, False otherwise. Used to ensure accessible service delivery.',
    `disability_accommodation_notes` STRING COMMENT 'Free-text notes describing specific disability accommodations required by the person (e.g., large print bills, TTY/TDD phone service, accessible meter location). Used to ensure appropriate service delivery and ADA compliance.',
    `email_address` STRING COMMENT 'The primary email address for the person. Used for electronic billing, service notifications, CCR (Consumer Confidence Report) delivery, and digital customer communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `government_id_expiration_date` DATE COMMENT 'The expiration date of the government-issued identification document in yyyy-MM-dd format. Used to ensure identity verification documents remain current and valid.',
    `government_id_issuing_state` STRING COMMENT 'The U.S. state or territory that issued the government identification document. Used for identity verification and fraud prevention. Two-letter state abbreviation (e.g., CA, NY, TX).',
    `government_id_number_masked` STRING COMMENT 'The masked or partially redacted government-issued identification number (e.g., last 4 digits of SSN, masked drivers license number). Full number stored in secure vault; this field contains display-safe version for operational use.',
    `government_id_type` STRING COMMENT 'The type of government-issued identification document provided by the person for identity verification during account application or service connection. Used to comply with customer identification requirements.. Valid values are `drivers_license|state_id|passport|military_id|tribal_id|ssn`',
    `identity_verification_date` DATE COMMENT 'The date when the persons identity was successfully verified in yyyy-MM-dd format. Used for audit trails and compliance reporting on customer identification procedures.',
    `identity_verification_method` STRING COMMENT 'The method used to verify the persons identity (in-person document review, online verification service, mail-in documentation, third-party identity verification service). Used for audit and compliance tracking.. Valid values are `in_person|online|mail|third_party_service`',
    `identity_verification_status` STRING COMMENT 'The current status of the persons identity verification process. Indicates whether government-issued identification has been validated and approved for service connection and account establishment.. Valid values are `verified|pending|failed|expired|not_required`',
    `language_preference` STRING COMMENT 'The persons preferred language for communications and service delivery. Three-letter ISO 639-2 language code. Used to ensure accessible customer service and compliance with language access requirements. [ENUM-REF-CANDIDATE: ENG|SPA|CHI|VIE|KOR|RUS|FRE|ARA|POR|OTH — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this person record was last updated in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trails, change tracking, and data synchronization across systems.',
    `legal_first_name` STRING COMMENT 'The legal first name of the person as it appears on government-issued identification documents. Used for identity verification and legal correspondence.',
    `legal_last_name` STRING COMMENT 'The legal last name (surname) of the person as it appears on government-issued identification documents. Used for identity verification and legal correspondence.',
    `legal_middle_name` STRING COMMENT 'The legal middle name or initial of the person as it appears on government-issued identification documents. May be null if not provided.',
    `life_support_equipment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person or household member relies on life-support medical equipment that requires uninterrupted water service. True if life-support equipment present, False otherwise. Used for service disconnection protection and emergency prioritization.',
    `life_support_verification_date` DATE COMMENT 'The date when the life-support equipment status was verified by medical certification in yyyy-MM-dd format. Used for program compliance and annual recertification tracking.',
    `low_income_assistance_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person is eligible for low-income assistance programs, rate discounts, or payment assistance based on income verification. True if eligible, False otherwise. Used for social equity program administration.',
    `low_income_verification_date` DATE COMMENT 'The date when the persons low-income status was verified for assistance program eligibility in yyyy-MM-dd format. Used for program compliance and recertification tracking.',
    `marketing_consent_date` DATE COMMENT 'The date when the person provided or withdrew marketing consent in yyyy-MM-dd format. Used for compliance documentation and preference management.',
    `marketing_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has consented to receive marketing communications and promotional materials from the utility. True if consent given, False otherwise. Used to comply with marketing communication regulations.',
    `paperless_billing_enrollment_date` DATE COMMENT 'The date when the person enrolled in or opted out of paperless billing in yyyy-MM-dd format. Used for billing preference tracking and environmental impact reporting.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person has enrolled in paperless billing and prefers to receive bills electronically. True if enrolled in paperless billing, False if paper bills preferred.',
    `person_status` STRING COMMENT 'The current lifecycle status of the person record. Active indicates the person is currently associated with one or more accounts. Inactive indicates no current account relationships. Deceased, merged, and duplicate statuses support data quality and master data management.. Valid values are `active|inactive|deceased|merged|duplicate`',
    `person_type` STRING COMMENT 'The role or relationship type of the person within the customer domain. Distinguishes between account holders, co-applicants, authorized contacts, guarantors, and other person roles. One person may have multiple types across different accounts.. Valid values are `account_holder|co_applicant|authorized_contact|guarantor|emergency_contact|property_owner`',
    `preferred_contact_method` STRING COMMENT 'The persons preferred method for receiving utility communications and notifications. Used to honor customer communication preferences and improve engagement rates.. Valid values are `email|phone|sms|mail|portal`',
    `preferred_name` STRING COMMENT 'The name the person prefers to be called in day-to-day interactions, which may differ from their legal name. Used for customer service communications and personalization.',
    `primary_phone` STRING COMMENT 'The primary contact phone number for the person. Used for service notifications, billing inquiries, outage alerts, and emergency communications. Format may include country code, area code, and extension.',
    `primary_phone_type` STRING COMMENT 'The type of primary phone number (mobile, home, work, other). Used to determine appropriate communication channels and times for customer outreach.. Valid values are `mobile|home|work|other`',
    `senior_citizen_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person qualifies as a senior citizen for age-based rate discounts or service programs. True if senior citizen, False otherwise. Age threshold defined by utility policy and regulatory requirements.',
    `suffix` STRING COMMENT 'Generational or professional suffix appended to the persons legal name (e.g., Jr, Sr, II, III). Used to distinguish individuals with identical names.. Valid values are `Jr|Sr|II|III|IV|V`',
    CONSTRAINT pk_person PRIMARY KEY(`person_id`)
) COMMENT 'Master record for individual persons associated with water utility accounts — account holders, co-applicants, authorized contacts, and guarantors. Captures legal name, date of birth, government ID type and masked number, primary phone, secondary phone, email address, preferred contact method, language preference, identity verification status, and privacy consent flags. Distinct from the account entity: one person may hold multiple accounts (e.g., landlord with multiple rental properties). SSOT for individual identity within the customer domain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`organization` (
    `organization_id` BIGINT COMMENT 'Unique system identifier for the organization entity. Primary key for commercial, industrial, and municipal organizations holding water and wastewater service accounts.',
    `parent_organization_id` BIGINT COMMENT 'Reference to the parent organization in corporate hierarchies. Enables consolidated billing, enterprise account management, and multi-location reporting for corporate customers.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Organization currently stores primary contact details as denormalized strings (primary_contact_name, primary_contact_email, primary_contact_phone, primary_contact_title). Normalizing this to a FK to t',
    `account_closed_date` DATE COMMENT 'Date when the organizations account was closed or terminated. Null for active accounts.',
    `account_opened_date` DATE COMMENT 'Date when the organizations first service account was established with the utility. Used for customer tenure analysis and loyalty program eligibility.',
    `account_status` STRING COMMENT 'Current lifecycle status of the organization account. Active accounts receive service; Suspended accounts have service restrictions; Closed accounts are terminated.. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `annual_revenue_range` STRING COMMENT 'Estimated annual revenue range of the organization. Used for credit assessment, account prioritization, and business development targeting.. Valid values are `under_1m|1m_to_10m|10m_to_50m|50m_to_100m|over_100m|unknown`',
    `auto_pay_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the organization is enrolled in automatic payment processing. True if enrolled, False otherwise.',
    `billing_address_line1` STRING COMMENT 'First line of the organizations billing address, typically street number and name. Used for invoice delivery and legal correspondence.',
    `billing_address_line2` STRING COMMENT 'Second line of billing address for suite, floor, or department information.',
    `billing_city` STRING COMMENT 'City name for the organizations billing address.',
    `billing_country` STRING COMMENT 'Three-letter ISO country code for the organizations billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the organizations billing address.. Valid values are `^d{5}(-d{4})?$`',
    `billing_state` STRING COMMENT 'Two-letter state code for the organizations billing address.. Valid values are `^[A-Z]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the organization record was first created in the customer information system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the organization before service restrictions are applied. Expressed in USD.',
    `credit_tier` STRING COMMENT 'Internal credit rating tier assigned to the organization based on payment history, financial strength, and risk assessment. Determines deposit requirements and payment terms.. Valid values are `tier_1|tier_2|tier_3|tier_4|unrated`',
    `customer_segment` STRING COMMENT 'Business segment classification for the organization. Used for rate structure assignment, service level agreements, and market analysis.. Valid values are `commercial|industrial|municipal|institutional|agricultural|government`',
    `dba_name` STRING COMMENT 'Trade name or fictitious business name under which the organization operates, if different from legal name. Used for customer-facing communications and service delivery.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit held for the organization. Expressed in USD. Null if no deposit is required.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required for this organization based on credit assessment. True if deposit is required, False otherwise.',
    `employee_count_range` STRING COMMENT 'Estimated number of employees at the organization. Used for water demand forecasting and commercial rate structure assignment. [ENUM-REF-CANDIDATE: 1_to_10|11_to_50|51_to_200|201_to_500|501_to_1000|over_1000|unknown — 7 candidates stripped; promote to reference product]',
    `federal_tax_number` STRING COMMENT 'IRS-issued Employer Identification Number (EIN) for tax reporting and identification purposes. Nine-digit number in format XX-XXXXXXX.. Valid values are `^d{2}-d{7}$`',
    `incorporation_date` DATE COMMENT 'Date the organization was legally incorporated, registered, or chartered. Used for account tenure analysis and credit assessment.',
    `incorporation_state` STRING COMMENT 'Two-letter state code where the organization is legally incorporated or registered. Used for jurisdictional compliance and legal correspondence.. Valid values are `^[A-Z]{2}$`',
    `industrial_user_classification` STRING COMMENT 'EPA classification level for industrial users subject to pretreatment requirements. Categorical Industrial User (CIU) discharges regulated pollutants; Significant Industrial User (SIU) meets discharge thresholds; Non-Significant does not meet thresholds.. Valid values are `categorical|significant|non_significant|not_applicable`',
    `industrial_user_flag` BOOLEAN COMMENT 'Indicates whether the organization is classified as an industrial user subject to pretreatment program requirements under the Clean Water Act. True if industrial user, False otherwise.',
    `iup_expiration_date` DATE COMMENT 'Date when the current IUP permit expires and renewal is required. Used for compliance tracking and permit renewal notifications.',
    `iup_permit_number` STRING COMMENT 'Permit number issued for industrial users authorized to discharge wastewater into the municipal collection system. Required for tracking pretreatment compliance and discharge monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the organization record was last updated. Used for data synchronization and audit trail.',
    `legal_name` STRING COMMENT 'The official registered legal name of the organization as filed with state incorporation documents or municipal charter. Used for contracts, billing, and regulatory reporting.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code identifying the organizations primary industry sector. Used for industrial user classification, rate structure assignment, and regulatory reporting.. Valid values are `^d{6}$`',
    `organization_type` STRING COMMENT 'Legal structure classification of the organization. Determines billing rules, credit policies, and regulatory treatment.. Valid values are `corporation|llc|partnership|municipality|hoa|government_agency`',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the organization has opted for electronic billing only. True if paperless, False if paper invoices are required.',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment after invoice date. Standard terms are typically 30 days; extended terms may be granted based on credit tier.',
    `sic_code` STRING COMMENT 'Four-digit SIC code for legacy industry classification. Maintained for historical reporting and systems that have not migrated to NAICS.. Valid values are `^d{4}$`',
    `special_billing_instructions` STRING COMMENT 'Free-text field for custom billing requirements, invoice formatting preferences, or special handling instructions for the organization account.',
    `tax_exempt_certificate_number` STRING COMMENT 'State-issued tax exemption certificate number for organizations claiming tax-exempt status. Required for audit compliance.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the organization is exempt from sales tax or utility taxes. True if tax-exempt (typically government entities), False otherwise.',
    `website_url` STRING COMMENT 'Public website URL for the organization. Used for customer research and business development.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master record for commercial, industrial, and municipal organizations that hold water and wastewater service accounts. Captures legal entity name, DBA name, federal tax ID (EIN), NAICS/SIC industry code, organization type (corporation/LLC/municipality/HOA/government), primary contact name, incorporation state, credit tier, industrial user classification (for IUP purposes), and parent organization reference for corporate hierarchies. Supports B2B account management and industrial pretreatment program tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`service_address` (
    `service_address_id` BIGINT COMMENT 'Unique identifier for the service address record. Primary key for the service address entity.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service addresses fall within District Metered Areas for non-revenue water tracking, leak detection program management, and consumption pattern analysis. Essential for AWWA water audit compliance, tar',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to customer.parcel. Business justification: Service address is physically located on a land parcel; linking provides geographic context and eliminates isolated parcel table.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Pressure zone assignment of a service address determines service parameters, billing rate tiers, fire flow requirements, and hydraulic modeling. The existing plain-text pressure_zone column is a denor',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Service addresses added or modified through CIP work (subdivision developments, service area extensions, infrastructure upgrades). Essential for geographic expansion tracking, service territory planni',
    `address_effective_date` DATE COMMENT 'Date when this service address became effective and available for service delivery. Start of the address lifecycle.',
    `address_end_date` DATE COMMENT 'Date when this service address was retired or became unavailable for service. Null if address is still active.',
    `address_line_1` STRING COMMENT 'Primary street address line including house number, street name, and street type. First line of the physical service delivery location.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment number, suite, unit, building, floor, or other location qualifier within the premise.',
    `address_notes` STRING COMMENT 'Free-text notes or comments about the service address including special access instructions, delivery restrictions, or historical context.',
    `address_source_system` STRING COMMENT 'Name of the source system or application that created or last updated this service address record (e.g., CC&B, GIS, CRM).',
    `address_status` STRING COMMENT 'Lifecycle status of the service address record. Values: active (currently serviceable), inactive (temporarily not in use), pending (awaiting activation), retired (permanently closed).. Valid values are `active|inactive|pending|retired`',
    `address_validation_status` STRING COMMENT 'Status indicating whether the address has been validated against USPS or other authoritative address databases. Values: validated, unvalidated, corrected, invalid.. Valid values are `validated|unvalidated|corrected|invalid`',
    `apn` STRING COMMENT 'County assessor parcel number uniquely identifying the land parcel for property tax and ownership purposes. Links service address to GIS parcel data.',
    `building_type` STRING COMMENT 'Type or classification of building structure at the service address (e.g., single-family, multi-family, office, retail, warehouse, school).',
    `city` STRING COMMENT 'City or municipality name where the service address is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the service address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish name where the service address is located. Used for regulatory reporting and jurisdictional compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service address record was first created in the system. Audit trail for data lineage.',
    `customer_class` STRING COMMENT 'Customer classification for rate and billing purposes. Values: residential, commercial, industrial, municipal, agricultural, institutional.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `flood_zone_designation` STRING COMMENT 'FEMA flood zone classification (e.g., A, AE, X, VE) indicating flood risk level. Used for infrastructure planning and emergency response.',
    `gis_feature_code` STRING COMMENT 'Unique identifier linking this service address to the corresponding feature in the Esri ArcGIS spatial database for network modeling and asset management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service address record was last updated or modified. Audit trail for change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees (WGS84 datum). Used for GIS mapping, network modeling, and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees (WGS84 datum). Used for GIS mapping, network modeling, and spatial analysis.',
    `meter_location_description` STRING COMMENT 'Free-text description of where the water meter is physically located at the premise (e.g., front yard, basement, alley, inside garage).',
    `occupancy_status` STRING COMMENT 'Current occupancy status of the premise. Values: occupied, vacant, seasonal, under_construction.. Valid values are `occupied|vacant|seasonal|under_construction`',
    `postal_code` STRING COMMENT 'Five-digit ZIP code or ZIP+4 format postal code for the service address. Used for mail delivery and geographic segmentation.. Valid values are `^d{5}(-d{4})?$`',
    `service_territory_code` STRING COMMENT 'Code identifying the utility service territory or franchise area where the address is located. Determines regulatory jurisdiction and service provider.',
    `service_type` STRING COMMENT 'Type of utility service(s) available at this address. Values: water_only, wastewater_only, water_and_wastewater, stormwater, reclaimed_water.. Valid values are `water_only|wastewater_only|water_and_wastewater|stormwater|reclaimed_water`',
    `sewer_basin` STRING COMMENT 'Wastewater collection basin or drainage area identifier indicating which sewer system and treatment plant serve this address.',
    `standardized_address` STRING COMMENT 'Fully standardized and concatenated address string following USPS formatting rules. Used for address matching and deduplication.',
    `state_code` STRING COMMENT 'Two-letter state or province abbreviation following USPS standards (e.g., CA, TX, NY).. Valid values are `^[A-Z]{2}$`',
    `within_service_boundary_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the address is within the utilitys authorized service boundary. True if within boundary, False if outside.',
    CONSTRAINT pk_service_address PRIMARY KEY(`service_address_id`)
) COMMENT 'Physical location where water and/or wastewater service is delivered. Captures full street address, city, state, ZIP+4, county, parcel number (APN), GIS coordinates (latitude/longitude), service territory code, pressure zone, DMA (District Metered Area) code, sewer basin, flood zone designation, address validation status, and whether the address is within the utility service boundary. Linked to the distribution network and metering domains via service point. One address may have multiple active accounts over time (tenant turnover).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`premise` (
    `premise_id` BIGINT COMMENT 'Unique identifier for the premise record. Primary key representing the utilitys asset record for a serviceable location.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Premises physically connect to specific distribution mains for water service delivery. Essential for hydraulic modeling, service line inventory (LCRR compliance), outage impact analysis, and main brea',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: DMA assignment of premises is essential for NRW (non-revenue water) analysis, leakage attribution, and demand management reporting. The existing plain-text district_metered_area_code on premise is den',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Premise pressure zone assignment drives fire protection requirements, meter sizing, peak demand calculations, and hydraulic modeling. The existing plain-text pressure_zone column on premise is denorma',
    `service_address_id` BIGINT COMMENT 'Reference to the postal and Geographic Information System (GIS) address record for this premise. Links premise to distribution network location.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: A premise is classified by service class (residential, commercial, industrial, irrigation) which determines applicable rates, meter size standards, fire flow requirements, and regulatory reporting cat',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Each premise is served by a specific WTP. This link is essential for boil-water advisory notifications (identifying affected customers per facility), water quality complaint routing to the responsible',
    `territory_id` BIGINT COMMENT 'Reference to the geographic service territory in which this premise is located. Determines regulatory jurisdiction and operational district.',
    `backflow_prevention_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires backflow prevention devices due to cross-connection hazards. Mandatory for commercial, industrial, and irrigation services per Safe Drinking Water Act (SDWA).',
    `building_square_footage` DECIMAL(18,2) COMMENT 'Total conditioned floor area of structures on the premise in square feet. Used for commercial water demand forecasting and capacity fee assessments.',
    `building_type` STRING COMMENT 'Physical structure classification of the building on the premise. Used for demand forecasting and infrastructure capacity planning. [ENUM-REF-CANDIDATE: detached_house|townhouse|apartment|office|retail|warehouse|manufacturing|school|hospital|government|mixed_use — 11 candidates stripped; promote to reference product]',
    `connection_fee_paid_amount` DECIMAL(18,2) COMMENT 'Total one-time connection or capacity fees paid for this premise to establish utility service. Includes system development charges and impact fees.',
    `connection_fee_paid_date` DATE COMMENT 'Date when connection or capacity fees were paid for this premise. Used for revenue recognition and capital improvement program (CIP) funding tracking.',
    `construction_year` STRING COMMENT 'Year the primary structure on the premise was originally constructed. Used for infrastructure age analysis and lead service line risk assessment per Lead and Copper Rule Revisions (LCRR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this premise record was first created in the utility system. Part of audit trail for data lineage and regulatory compliance.',
    `effective_end_date` DATE COMMENT 'Date when this premise record was retired or became inactive. Null for currently active premises. Supports temporal data management and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this premise record became active and available for service connections. Supports temporal data management and historical analysis.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Ground elevation of the premise in feet above mean sea level. Critical for hydraulic pressure calculations and gravity sewer flow analysis.',
    `estimated_daily_demand_gallons` DECIMAL(18,2) COMMENT 'Projected average daily water consumption in gallons for this premise based on premise type, units, and historical usage patterns. Used for capacity planning and meter sizing.',
    `fats_oils_grease_program_flag` BOOLEAN COMMENT 'Indicates whether the premise is subject to Fats, Oils, and Grease (FOG) control program requirements. Applicable to food service establishments to prevent Sanitary Sewer Overflows (SSO).',
    `fire_protection_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires dedicated fire protection service (fire hydrant or sprinkler connection). Determines fire service charge applicability.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the premise location in decimal degrees (WGS84 datum). Used for spatial analysis, hydraulic modeling, and field service dispatch.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the premise location in decimal degrees (WGS84 datum). Used for spatial analysis, hydraulic modeling, and field service dispatch.',
    `industrial_user_permit_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires an Industrial User Permit (IUP) for wastewater discharge due to industrial processes. Triggers pretreatment program compliance monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this premise record was most recently updated. Used for change tracking and data synchronization across systems.',
    `lot_size_square_feet` DECIMAL(18,2) COMMENT 'Total land area of the premise parcel in square feet. Used for irrigation demand estimation and stormwater fee calculations.',
    `low_income_assistance_eligible_flag` BOOLEAN COMMENT 'Indicates whether the premise qualifies for low-income customer assistance programs based on property characteristics or census tract designation. Used for rate discount eligibility.',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Standard meter size in inches required or installed at this premise based on demand characteristics. Common sizes: 0.625, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0 inches.',
    `number_of_units` STRING COMMENT 'Count of individual dwelling or tenant units within the premise. Applicable for multi-family residential and commercial properties. Used for equivalent dwelling unit (EDU) calculations.',
    `parcel_number` STRING COMMENT 'County assessors parcel number (APN) or tax lot identifier for the property. Used for cross-reference with property tax records and GIS systems.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `peak_demand_gpm` DECIMAL(18,2) COMMENT 'Estimated peak instantaneous water demand in Gallons Per Minute (GPM) for this premise. Used for hydraulic modeling and service line sizing.',
    `premise_number` STRING COMMENT 'Externally-known business identifier for the premise, used in customer communications and field operations. Unique across the utility service territory.. Valid values are `^[A-Z0-9]{6,20}$`',
    `premise_status` STRING COMMENT 'Current lifecycle status of the premise in the utilitys service inventory. Determines whether the premise is available for service connection.. Valid values are `active|inactive|pending_construction|demolished|condemned|seasonal`',
    `premise_type` STRING COMMENT 'Classification of the premise based on its primary use and service characteristics. Determines applicable rate schedules and service requirements.. Valid values are `single_family_residential|multi_family_residential|commercial|industrial|irrigation|fire_protection`',
    `reclaimed_water_service_available_flag` BOOLEAN COMMENT 'Indicates whether recycled or reclaimed water distribution infrastructure is available for non-potable uses such as irrigation. Part of water conservation programs.',
    `service_line_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the water service line in inches. Determines flow capacity and pressure loss from main to premise.',
    `service_line_material` STRING COMMENT 'Material composition of the water service line connecting the distribution main to the premise. Critical for Lead and Copper Rule Revisions (LCRR) compliance and lead service line inventory. [ENUM-REF-CANDIDATE: copper|galvanized_steel|lead|pvc|pex|hdpe|unknown — 7 candidates stripped; promote to reference product]',
    `sewer_lateral_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the sanitary sewer lateral in inches. Determines wastewater conveyance capacity from premise to collection system.',
    `sewer_lateral_material` STRING COMMENT 'Material composition of the sanitary sewer lateral connecting the premise to the collection main. Used for Inflow and Infiltration (I&I) risk assessment.. Valid values are `vitrified_clay|cast_iron|pvc|concrete|orangeburg|unknown`',
    `special_notes` STRING COMMENT 'Free-text field for operational notes, access instructions, or unique characteristics of the premise relevant to field service personnel and customer service representatives.',
    `stormwater_service_available_flag` BOOLEAN COMMENT 'Indicates whether stormwater drainage infrastructure serves this premise. Determines applicability of stormwater utility fees.',
    `wastewater_service_available_flag` BOOLEAN COMMENT 'Indicates whether sanitary sewer collection infrastructure is available to serve this premise. True if sewer mains are accessible within standard connection distance.',
    `water_service_available_flag` BOOLEAN COMMENT 'Indicates whether potable water distribution infrastructure is available to serve this premise. True if water mains are accessible within standard connection distance.',
    `zoning_classification` STRING COMMENT 'Municipal zoning code designation for the premise parcel. Determines permitted land uses and development density. Format varies by jurisdiction.. Valid values are `^[A-Z]{1,3}-[0-9]{1,2}$`',
    CONSTRAINT pk_premise PRIMARY KEY(`premise_id`)
) COMMENT 'The physical property or facility at which utility service is provided, representing the utilitys view of a serviceable location independent of the customer occupying it. Captures premise type (single-family residential, multi-family, commercial, industrial, irrigation, fire protection), lot size, building type, number of units (for multi-family), number of fixture units (for capacity planning), zoning classification, construction year, lead service line status (known lead, galvanized requiring replacement, non-lead, unknown — per LCRR inventory), and whether the premise is subject to low-income assistance programs. Bridges the customer domain to the distribution network and metering domains. Distinct from service_address: a premise is the utilitys asset record for the location; service_address is the postal/GIS record.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` (
    `service_agreement_id` BIGINT COMMENT 'Unique identifier for the customer_service_agreement data product (auto-inserted pre-linking).',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: A service agreement is established for a specific service offering (potable water, recycled water, fire protection). The offering defines base rates, meter size requirements, and SLA terms. New servic',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service agreements are established for specific premises (physical properties). This FK links the contractual relationship to the physical location where service is provided. Currently service_agreeme',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Service agreements contain denormalized address fields that should reference the service_address master. This eliminates redundancy and ensures address consistency. The service_address table is the au',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Service class (residential, commercial, industrial) determines billing cycle, deposit requirements, and regulatory reporting category for a service agreement. Billing setup, rate schedule assignment, ',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: Each service agreement is subject to a specific tariff approved by the regulatory authority. Rate dispute resolution, regulatory reporting, and billing accuracy all require knowing which tariff govern',
    CONSTRAINT pk_service_agreement PRIMARY KEY(`service_agreement_id`)
) COMMENT 'The contractual relationship between a customer account and the utility for a specific service type (potable water, wastewater, recycled water, fire protection, irrigation) at a premise. Captures service agreement number, service type, rate schedule code, start date, end date, deposit amount, deposit waiver reason, service class, budget billing enrollment, and agreement status. This is the SSOT for what service a customer is contracted to receive and at what rate. Distinct from billing invoices (which are transactional) and from the rate schedule (which is a reference entity in the service domain).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`service_application` (
    `service_application_id` BIGINT COMMENT 'Unique identifier for the service application record. Primary key.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Service applications capture applicant details that should reference the person master record. This eliminates data duplication and ensures applicant identity is properly managed. The person table con',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Applications request specific service offerings (potable water, wastewater, reclaimed). Application review validates requested service against available offerings, calculates connection fees per offer',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service applications are for establishing service at specific premises. While service_address_id exists, the premise_id link is needed to reference the physical property record which contains addition',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: New service applications require engineering review to verify adequate pressure and capacity in the target pressure zone before approval. Critical for ensuring system can support additional demand wit',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer (applicant) who submitted this service application. Links to the customer master record.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: A service application, when approved, results in the creation of a service agreement. This FK captures the lifecycle link from application to the resulting agreement, enabling traceability of how each',
    `service_address_id` BIGINT COMMENT 'Reference to the service address (premise) where water or wastewater service is being requested. Links to the service address master record.',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: A service application specifies the requested service class (residential, commercial, industrial), which drives fee calculation, credit check requirements, and regulatory review. Replacing the denorma',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Applications must validate service address falls within utilitys franchise territory before approval. Required for capacity planning, infrastructure availability checks, regulatory jurisdiction deter',
    `application_number` STRING COMMENT 'Externally-visible unique application number assigned when the customer submits a service application. Used for customer communication and tracking.. Valid values are `^APP-[0-9]{8,12}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the service application: submitted (initial state), under review (being processed by utility staff), approved (ready for service establishment), rejected (application denied), withdrawn (applicant cancelled), or pending payment (awaiting deposit or connection fee).. Valid values are `submitted|under_review|approved|rejected|withdrawn|pending_payment`',
    `application_type` STRING COMMENT 'Type of service application: new service establishment, transfer of service to new occupant, service upgrade (larger meter or additional service), service downgrade, service termination, or reconnection after disconnection.. Valid values are `new_service|transfer|upgrade|downgrade|termination|reconnection`',
    `approval_date` DATE COMMENT 'Date when the service application was approved by the utility, authorizing service establishment.',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the service application was approved.',
    `connection_fee_amount` DECIMAL(18,2) COMMENT 'One-time connection or service establishment fee charged to the applicant for initiating water or wastewater service at the premise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this service application record was first created in the system.',
    `credit_check_result` STRING COMMENT 'Outcome of the credit check: pass (credit meets utility standards), fail (credit does not meet standards, deposit required), insufficient history (no credit history available), or not applicable (credit check not performed).. Valid values are `pass|fail|insufficient_history|not_applicable`',
    `credit_check_status` STRING COMMENT 'Status of credit check for the applicant: not required (based on service class or policy), pending (credit check requested), completed (credit check results received), or waived (credit check requirement waived by management).. Valid values are `not_required|pending|completed|waived`',
    `credit_score` STRING COMMENT 'Numeric credit score obtained from credit bureau for the applicant, used to determine deposit requirements and service approval.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit required from the applicant before service establishment. Null if no deposit is required.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required from the applicant before service can be established, based on credit check results, service history, or utility policy.',
    `identity_verification_method` STRING COMMENT 'Method used to verify the applicants identity: drivers license, passport, utility bill from previous address, government-issued ID, credit report, or in-person verification at utility office.. Valid values are `drivers_license|passport|utility_bill|government_id|credit_report|in_person`',
    `identity_verification_status` STRING COMMENT 'Status of applicant identity verification process: not started, pending (documents submitted, under review), verified (identity confirmed), or failed (unable to verify identity).. Valid values are `not_started|pending|verified|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this service application record was last updated or modified.',
    `meter_size_requested` STRING COMMENT 'Size of water meter requested by the applicant or recommended by utility staff based on anticipated usage (e.g., 5/8 inch, 3/4 inch, 1 inch, 1.5 inch, 2 inch, etc.).',
    `priority_level` STRING COMMENT 'Priority level assigned to the application for processing: low (standard processing), normal (default priority), high (expedited processing requested), or urgent (emergency service needed).. Valid values are `low|normal|high|urgent`',
    `processing_notes` STRING COMMENT 'Free-text notes entered by utility staff during application review and processing, documenting special circumstances, follow-up actions, or additional context.',
    `rejection_date` DATE COMMENT 'Date when the service application was rejected by the utility. Null if application was not rejected.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the service application was rejected (e.g., failed credit check, incomplete documentation, service not available at address, outstanding balance from previous account).',
    `rejection_reason_code` STRING COMMENT 'Standardized code categorizing the reason for application rejection: credit failure, incomplete documentation, service unavailable at location, outstanding balance from prior account, duplicate application, or invalid service address.. Valid values are `credit_fail|incomplete_docs|service_unavailable|outstanding_balance|duplicate_application|invalid_address`',
    `requested_service_start_date` DATE COMMENT 'Date when the applicant requests water or wastewater service to begin at the service address.',
    `review_completed_date` DATE COMMENT 'Date when the application review process was completed and a decision (approved or rejected) was made.',
    `review_start_date` DATE COMMENT 'Date when utility staff began reviewing and processing the service application.',
    `service_type_requested` STRING COMMENT 'Type of utility service requested by the applicant: water only, wastewater (sewer) only, or combined water and wastewater service.. Valid values are `water_only|wastewater_only|water_and_wastewater`',
    `sla_due_date` DATE COMMENT 'Target date by which the application should be reviewed and processed according to utility service level agreement standards.',
    `submission_channel` STRING COMMENT 'Channel through which the customer submitted the service application: online customer portal, phone call to customer service, walk-in at utility office, postal mail, mobile app, or email.. Valid values are `online_portal|phone|walk_in|mail|mobile_app|email`',
    `submission_date` DATE COMMENT 'Date when the customer submitted the service application.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the service application was submitted by the customer or entered into the system.',
    `withdrawn_date` DATE COMMENT 'Date when the applicant withdrew or cancelled the service application. Null if application was not withdrawn.',
    `withdrawn_reason` STRING COMMENT 'Reason provided by the applicant for withdrawing the service application (e.g., changed mind, moved to different location, service no longer needed).',
    CONSTRAINT pk_service_application PRIMARY KEY(`service_application_id`)
) COMMENT 'Record of a customers application to establish, transfer, or modify water and/or wastewater service. Captures application number, application type (new service, transfer, upgrade, downgrade, termination), applicant identity, requested service address, requested service start date, application submission channel (online, phone, walk-in), application status (submitted, under review, approved, rejected, withdrawn), identity verification outcome, credit check result, deposit requirement, and processing timestamps. Represents the start of the customer lifecycle. Sourced from Oracle CC&B and Microsoft Dynamics 365.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for each customer interaction record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: Customer service interactions (calls, portal sessions) are frequently about a specific service agreement — billing questions, service changes, contract renewals. CRM workflows and first-contact-resolu',
    `collection_system_blockage_id` BIGINT COMMENT 'Foreign key linking to wastewater.collection_system_blockage. Business justification: Customer service interactions about sewer backups must reference the associated blockage event. Agents need the blockage record to provide status, estimated clearance time, and document customer impac',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Customer interactions capture contact details that should reference the person master when the contact is a known person. This eliminates duplication of person contact information. Nullable as some in',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this interaction. Links to the customer account master record.',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Customer reports about hydrant problems (leaking, damaged, blocked access, vandalism) reference specific hydrant assets. Enables tracking of public-reported hydrant defects, prioritizing inspection/re',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Customer service interactions (outage calls, pressure complaints, road damage reports) are frequently triggered by main break events. Linking interactions to the specific main_break enables outage com',
    `network_valve_id` BIGINT COMMENT 'Foreign key linking to distribution.network_valve. Business justification: Customer reports about valve issues (leaking valve box, exposed valve, damaged cover) reference specific valve assets. Enables public-sourced defect identification, prioritizes valve maintenance, and',
    `order_id` BIGINT COMMENT 'Reference to a service request created as a result of this interaction. Null if no service request was generated.',
    `premise_id` BIGINT COMMENT 'Reference to the premise associated with this interaction. Null if interaction is not premise-specific.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Interactions capture customer reports of overflow events or utility communication about events affecting customers—event documentation and public notification tracking required for regulatory complian',
    `service_address_id` BIGINT COMMENT 'Reference to the service address associated with this interaction. Null if interaction is not address-specific.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Customer interactions may pertain to specific service agreements (e.g., questions about a particular service). This enables agreement-level interaction tracking. Nullable as some interactions are acco',
    `sso_event_id` BIGINT COMMENT 'Foreign key linking to wastewater.sso_event. Business justification: Customer service agents handling calls about sewage overflows need to reference the active SSO event record. This link enables agents to provide accurate status updates, log interaction context agains',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Customer inquiries about planned/ongoing CIP work in their area (timeline questions, service interruption notices, construction updates). Essential for public outreach tracking, stakeholder communicat',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Customer interactions may report violations or document utility response to violation-related inquiries—customer service and regulatory documentation requirement for tracking public complaints and res',
    `work_order_id` BIGINT COMMENT 'Reference to a work order created as a result of this interaction. Null if no work order was generated.',
    `accessibility_accommodation` STRING COMMENT 'Description of any accessibility accommodations provided during the interaction (e.g., TTY, large print, sign language). Null if no accommodation was required.',
    `agent_name` STRING COMMENT 'Full name of the customer service agent who handled the interaction. Null for self-service interactions.',
    `callback_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the requested callback was completed. Null if callback was not requested or not yet completed.',
    `callback_requested_flag` BOOLEAN COMMENT 'Indicates whether the customer requested a callback from the utility.',
    `case_number` STRING COMMENT 'Reference to a formal case or complaint record created in the CRM system as a result of this interaction. Null if no case was created.. Valid values are `^CASE-[0-9]{8}$`',
    `interaction_category` STRING COMMENT 'High-level category grouping for the interaction type, used for reporting and analytics (e.g., billing, service delivery, water quality, account management).',
    `channel` STRING COMMENT 'Channel through which the interaction occurred: inbound call, outbound call, web portal, mobile app, email, chat, walk-in visit, IVR self-service, or SMS. [ENUM-REF-CANDIDATE: inbound_call|outbound_call|web_portal|mobile_app|email|chat|walk_in|ivr|sms — 9 candidates stripped; promote to reference product]',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction was formally closed. Null if interaction is not yet closed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction record was first created in the system.',
    `customer_satisfaction_score` STRING COMMENT 'Customer satisfaction rating provided by the customer after the interaction, typically on a scale of 1 to 5. Null if not captured.',
    `interaction_description` STRING COMMENT 'Detailed narrative description of the interaction, including customer inquiry, issue reported, and any relevant context provided by the customer or agent.',
    `duration_seconds` STRING COMMENT 'Total duration of the interaction in seconds, applicable primarily to call and chat channels. Null for asynchronous channels like email.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the interaction was escalated to a supervisor, specialist, or higher tier of support.',
    `escalation_reason` STRING COMMENT 'Reason for escalating the interaction, such as complex technical issue, customer dissatisfaction, or policy exception required. Null if not escalated.',
    `first_contact_resolution_flag` BOOLEAN COMMENT 'Indicates whether the interaction was resolved during the first contact without requiring follow-up. Key customer service performance indicator.',
    `interaction_number` STRING COMMENT 'Business-facing unique identifier for the interaction, used for tracking and reference in customer communications.. Valid values are `^INT-[0-9]{10}$`',
    `interaction_status` STRING COMMENT 'Current lifecycle status of the interaction: open, in progress, pending customer response, pending internal action, resolved, closed, or cancelled. [ENUM-REF-CANDIDATE: open|in_progress|pending_customer|pending_internal|resolved|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `interaction_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction was initiated or received by the utility. Primary business event timestamp for the interaction.',
    `interaction_type` STRING COMMENT 'Classification of the interaction purpose: billing inquiry, service request, complaint, outage report, payment arrangement, or general inquiry.. Valid values are `billing_inquiry|service_request|complaint|outage_report|payment_arrangement|general_inquiry`',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required or used during the interaction.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language used during the interaction. [ENUM-REF-CANDIDATE: ENG|SPA|FRE|CHI|VIE|KOR|RUS|ARA|POR|GER — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction record was last updated or modified.',
    `net_promoter_score` STRING COMMENT 'Net Promoter Score provided by the customer, typically on a scale of 0 to 10, measuring likelihood to recommend the utility. Null if not captured.',
    `priority` STRING COMMENT 'Priority level assigned to the interaction based on urgency and impact: low, medium, high, urgent, or critical.. Valid values are `low|medium|high|urgent|critical`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution provided, actions taken, and any follow-up required. Populated when interaction is resolved or closed.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction was marked as resolved. Null if interaction is still open or in progress.',
    `source_system_code` STRING COMMENT 'Unique identifier of the interaction record in the source system, used for traceability and reconciliation.',
    `subcategory` STRING COMMENT 'Detailed subcategory within the interaction category, providing granular classification for analytics (e.g., high bill inquiry, leak report, water pressure issue).',
    `subject` STRING COMMENT 'Brief subject or title summarizing the purpose or topic of the interaction.',
    `survey_completed_flag` BOOLEAN COMMENT 'Indicates whether the customer completed a post-interaction satisfaction survey.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Unified record of every customer-initiated or utility-initiated interaction, contact, and account note across all channels — inbound calls, outbound calls, web portal sessions, chat, email, walk-in visits, IVR self-service, and system-generated notes. Captures interaction date and time, channel, interaction type (billing inquiry, service request, complaint, outage report, payment arrangement, general inquiry, staff note, system alert), record subtype (structured interaction vs free-text note), duration, agent ID, note text (for unstructured entries), note visibility level (internal/external), resolution status, case or work order reference, workflow trigger flag, and customer satisfaction score if captured. Sourced from Microsoft Dynamics 365 CRM and Oracle CC&B. SSOT for all customer contact history and account annotations. Supports customer service continuity, dispute resolution, and field crew awareness (e.g., dangerous dog, locked gate, medical equipment dependency).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Unique identifier for the customer complaint record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: Customer complaints about billing disputes, service quality, or contract terms are directly tied to a specific service agreement. Complaint resolution workflows, regulatory escalation tracking, and SL',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Billing complaints (disputed charges, incorrect amounts) must link directly to the specific invoice in question. Utility regulators require tracking billing complaints to specific invoices for dispute',
    `collection_system_blockage_id` BIGINT COMMENT 'Foreign key linking to wastewater.collection_system_blockage. Business justification: Customer complaints about sewage backup are directly linked to collection system blockage events. Utilities track complaint-to-blockage associations for response prioritization, customer impact report',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Aggregating complaints by DMA reveals water loss patterns, quality issues, and pressure problems at the zone level. Supports NRW reduction programs, leak detection prioritization, and proactive main r',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Main break events directly cause customer complaints about outages, low pressure, and discolored water. Linking complaints to the specific main_break record enables regulatory reporting of customers a',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Complaints about service quality, pressure, or water quality are categorized by service offering (potable, recycled, fire protection). Root cause analysis, regulatory reporting by service type, and of',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to customer.interaction. Business justification: A customer complaint is frequently filed during or as a result of a customer interaction (e.g., a call to the contact center). Linking customer_complaint to the originating interaction enables full tr',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Water quality complaints (taste, odor, discoloration, pressure) routinely reference the specific distribution main where the issue originates. Operations teams use this for targeted flushing, leak det',
    `premise_id` BIGINT COMMENT 'Reference to the premise associated with the complaint.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Pressure-related complaints must reference the pressure zone for operational dispatch and system performance analysis. Enables zone-level complaint trending, identifies chronic low-pressure areas, and',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this complaint.',
    `order_id` BIGINT COMMENT 'Reference to the service order created to address customer-facing service actions related to the complaint, such as meter test, service reconnection, or billing adjustment.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to address the physical or operational issue underlying the complaint, such as a repair, inspection, or maintenance activity in IBM Maximo Asset Management (CMMS).',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Customer complaints reporting sewage backups, odors, or surface discharge are primary detection mechanism for SSO/CSO events—operational reality requiring documented linkage for regulatory reporting.',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: customer_complaint has regulatory_escalation_flag, regulatory_case_number, and a plain-text regulatory_agency column — strong denormalization signals. Escalated complaints must be tracked against the ',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Complaints capture reporter details that should reference the person master when the reporter is a known person. This eliminates duplication and enables proper reporter tracking. Nullable as some comp',
    `sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sampling_point. Business justification: Water quality complaints (taste, odor, discoloration) are operationally linked to the nearest sampling point to trigger or reference quality testing. Complaint-to-sampling-point traceability is requir',
    `service_address_id` BIGINT COMMENT 'Reference to the service address where the complaint issue is occurring.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Complaints may relate to specific service agreements (e.g., billing disputes for a particular service type). This provides more granular complaint tracking for accounts with multiple agreements. Nulla',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: LCRR (Lead and Copper Rule Revisions) compliance requires tracking complaints tied to specific service lines for lead material inventory and remediation reporting. Water quality and pressure complaint',
    `sso_event_id` BIGINT COMMENT 'Foreign key linking to wastewater.sso_event. Business justification: Customer complaints about sewage overflow are directly linked to SSO events for regulatory reporting and root cause analysis. Utilities must correlate complaint volume with SSO events for EPA/state ag',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Complaints during construction (noise, access disruption, water discoloration during commissioning) must be tracked against the causing project for resolution, public relations, and project closeout d',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Water quality complaints trigger sample collection for investigation. Linking complaint to the resulting water_sample enables complaint-resolution traceability and regulatory audit trails. water_quali',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Customer complaints (water quality, odor, service issues) can trigger or provide evidence for regulatory violations—documented linkage required for enforcement case files and regulatory reporting.',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: Water quality complaints (taste, odor, color) are investigated by tracing the raw water source in use at the time. Regulatory escalation reporting and root-cause analysis require linking complaints to',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Water quality complaints require facility-specific investigation and operator response. Linking complaints to serving facility enables proper routing to facility operators, coordinated sampling, and f',
    `actual_resolution_date` DATE COMMENT 'Actual date when the complaint was resolved and closed.',
    `assigned_date` DATE COMMENT 'Date when the complaint was assigned to a resolution owner.',
    `assigned_to_department` STRING COMMENT 'Department or functional area responsible for resolving the complaint, such as Customer Service, Water Quality, Distribution Operations and Maintenance (O&M), Billing, or Laboratory.',
    `billing_adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of billing adjustment or credit issued to the customer as a result of the complaint resolution, if applicable.',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint type. Water quality includes turbidity, discoloration, and contaminant concerns. Billing disputes cover charges, meter reads, and rate application. Service interruption includes planned and unplanned outages. Pressure issues cover low or high Pounds per Square Inch (PSI). Regulatory complaints are those escalated to state primacy agencies or Public Utilities Commission (PUC). [ENUM-REF-CANDIDATE: water_quality|billing_dispute|service_interruption|pressure_issue|odor_taste|leak|meter_accuracy|customer_service|regulatory|other — 10 candidates stripped; promote to reference product]',
    `compensation_provided_flag` BOOLEAN COMMENT 'Indicates whether any form of compensation, credit, or goodwill gesture was provided to the customer as part of the complaint resolution.',
    `complaint_number` STRING COMMENT 'Externally visible unique complaint tracking number assigned by the Customer Information System (CIS) or Customer Care and Billing (CC&B) system.',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the complaint in the resolution workflow. [ENUM-REF-CANDIDATE: open|in_progress|pending_customer|pending_investigation|resolved|closed|escalated|withdrawn — 8 candidates stripped; promote to reference product]',
    `contact_method` STRING COMMENT 'Channel through which the complaint was received by the utility. [ENUM-REF-CANDIDATE: phone|email|web_portal|mobile_app|in_person|mail|social_media — 7 candidates stripped; promote to reference product]',
    `corrective_action` STRING COMMENT 'Specific corrective action taken to address the root cause and prevent recurrence, such as infrastructure repair, meter replacement, billing adjustment, or process improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the complaint record was first created in the database.',
    `customer_satisfaction_comments` STRING COMMENT 'Free-text feedback provided by the customer regarding their satisfaction with the complaint resolution process and outcome.',
    `customer_satisfaction_rating` STRING COMMENT 'Customer satisfaction score provided by the customer after complaint resolution, typically on a scale of 1 to 5 or 1 to 10.',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the complaint as reported by the customer, including symptoms, duration, and customer concerns.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up action or customer contact to verify sustained resolution.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up action or monitoring is required after initial complaint resolution.',
    `internal_notes` STRING COMMENT 'Internal notes and comments for staff use, not visible to the customer, documenting investigation steps, coordination with other departments, and operational context.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the complaint record was last updated.',
    `priority_level` STRING COMMENT 'Urgency classification of the complaint based on health and safety risk, regulatory exposure, and customer impact. Critical includes Maximum Contaminant Level (MCL) exceedances and Sanitary Sewer Overflow (SSO) events.. Valid values are `critical|high|medium|low`',
    `regulatory_case_number` STRING COMMENT 'Case or reference number assigned by the regulatory agency for tracking the escalated complaint.',
    `regulatory_escalation_flag` BOOLEAN COMMENT 'Indicates whether the complaint was escalated to or originated from a regulatory agency such as state primacy agency, Public Utilities Commission (PUC), or U.S. Environmental Protection Agency (EPA).',
    `regulatory_response_due_date` DATE COMMENT 'Date by which the utility must provide a formal response to the regulatory agency regarding the escalated complaint.',
    `reported_date` DATE COMMENT 'Date when the complaint was first reported to the utility by the customer.',
    `reported_timestamp` TIMESTAMP COMMENT 'Precise date and time when the complaint was logged into the system, including time zone offset.',
    `resolution_description` STRING COMMENT 'Detailed narrative of the actions taken to resolve the complaint, including investigation findings, corrective actions, and customer communication.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the complaint was marked as resolved, including time zone offset.',
    `root_cause` STRING COMMENT 'Identified root cause of the complaint issue, such as main break, meter malfunction, billing system error, water treatment process deviation, or customer misunderstanding.',
    `subcategory` STRING COMMENT 'Detailed subcategory providing additional classification granularity within the primary complaint category. Examples: discoloration, chlorine_odor, high_bill, estimated_read, low_pressure, no_water, meter_leak, service_attitude.',
    `target_resolution_date` DATE COMMENT 'Target date by which the complaint should be resolved, based on Service Level Agreement (SLA) commitments and regulatory requirements.',
    `water_quality_test_required_flag` BOOLEAN COMMENT 'Indicates whether a water quality test was required or performed as part of the complaint investigation, particularly for complaints involving taste, odor, discoloration, or suspected contamination.',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Formal record of a customer complaint or grievance filed with the utility, including water quality complaints, billing disputes, service interruption complaints, pressure complaints, odor/taste complaints, and regulatory complaints escalated to the state primacy agency or PUC. Captures complaint number, complaint category, complaint description, reported date, assigned resolution owner, target resolution date, actual resolution date, resolution description, regulatory escalation flag, and customer satisfaction outcome. Distinct from customer_interaction (which captures all contacts) — a complaint has its own formal resolution workflow and regulatory reporting obligations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`parcel` (
    `parcel_id` BIGINT COMMENT 'Primary key for parcel',
    `parent_parcel_id` BIGINT COMMENT 'Self-referencing FK on parcel (parent_parcel_id)',
    `territory_id` BIGINT COMMENT 'add column service_territory_id (BIGINT) with FK to service.territory.territory_id - parcels exist within service territories and this link is needed for service availability determination',
    `acquisition_date` DATE COMMENT 'Date the parcel was acquired by the current owner.',
    `address_line1` STRING COMMENT 'Primary street address of the parcel.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite, unit).',
    `area_sqft` DECIMAL(18,2) COMMENT 'Total land area of the parcel in square feet.',
    `cadastral_reference` STRING COMMENT 'Official cadastral registry identifier for the parcel.',
    `city` STRING COMMENT 'Municipality where the parcel is located.',
    `county` STRING COMMENT 'County jurisdiction of the parcel.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the parcel record was first created in the system.',
    `disposition_date` DATE COMMENT 'Date the parcel was transferred or disposed.',
    `geometry_wkt` STRING COMMENT 'Well-Known Text representation of the parcels spatial geometry.',
    `is_historical` BOOLEAN COMMENT 'Indicates whether the record represents a historical (true) or current (false) parcel.',
    `land_use_description` STRING COMMENT 'Narrative description of the parcels land use.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the parcel record.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the parcel centroid.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the parcel centroid.',
    `owner_contact_phone` STRING COMMENT 'Primary phone number for the parcel owner.',
    `owner_email` STRING COMMENT 'Primary email address for the parcel owner.',
    `owner_name` STRING COMMENT 'Name of the individual or entity that owns the parcel.',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the parcel.',
    `parcel_number` STRING COMMENT 'Human-readable parcel number used in field operations.',
    `parcel_status` STRING COMMENT 'Current lifecycle status of the parcel.',
    `parcel_type` STRING COMMENT 'Category of the parcel based on land use and zoning.',
    `state` STRING COMMENT 'State or province code where the parcel is located.',
    `tax_assessed_value` DECIMAL(18,2) COMMENT 'Assessed value of the parcel for property tax purposes.',
    `tax_assessment_year` STRING COMMENT 'Fiscal year of the tax assessment.',
    `valuation_usd` DECIMAL(18,2) COMMENT 'Assessed monetary value of the parcel in US dollars.',
    `zip_code` STRING COMMENT 'Postal code for the parcel location.',
    `zoning_code` STRING COMMENT 'Regulatory zoning classification code for the parcel.',
    CONSTRAINT pk_parcel PRIMARY KEY(`parcel_id`)
) COMMENT 'Master reference table for parcel. Referenced by parcel_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`organization`(`organization_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ADD CONSTRAINT `fk_customer_person_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`organization`(`organization_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`parcel`(`parcel_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`interaction`(`interaction_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ADD CONSTRAINT `fk_customer_parcel_parent_parcel_id` FOREIGN KEY (`parent_parcel_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`parcel`(`parcel_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_water_utilities_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_account');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'Disability Accommodation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_notes` SET TAGS ('dbx_business_glossary_term' = 'Disability Accommodation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `disability_accommodation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Issuing State');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_issuing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Number (Masked)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_number_masked` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_type` SET TAGS ('dbx_business_glossary_term' = 'Government Identification Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `government_id_type` SET TAGS ('dbx_value_regex' = 'drivers_license|state_id|passport|military_id|tribal_id|ssn');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'in_person|online|mail|third_party_service');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired|not_required');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `life_support_equipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Support Equipment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `life_support_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Life Support Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `low_income_assistance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `low_income_assistance_eligible_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `low_income_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Low Income Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `low_income_verification_date` SET TAGS ('dbx_pii_personal' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_value_regex' = 'mobile|home|work|other');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `primary_phone_type` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `senior_citizen_flag` SET TAGS ('dbx_business_glossary_term' = 'Senior Citizen Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'Jr|Sr|II|III|IV|V');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `parent_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Range');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_value_regex' = 'under_1m|1m_to_10m|10m_to_50m|50m_to_100m|over_100m|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `auto_pay_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enrolled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `billing_country` SET TAGS ('dbx_pii_personal' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `employee_count_range` SET TAGS ('dbx_business_glossary_term' = 'Employee Count Range');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Employer Identification Number (EIN)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_business_glossary_term' = 'State of Incorporation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `industrial_user_classification` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Classification');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `industrial_user_classification` SET TAGS ('dbx_value_regex' = 'categorical|significant|non_significant|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `industrial_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `iup_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `iup_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Organization Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_value_regex' = 'corporation|llc|partnership|municipality|hoa|government_agency');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `special_billing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Billing Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Organization Website URL');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_business_glossary_term' = 'Address End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_end_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_notes` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_business_glossary_term' = 'Address Source System');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_source_system` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|corrected|invalid');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Assessor Parcel Number (APN)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'water_only|wastewater_only|water_and_wastewater|stormwater|reclaimed_water');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `sewer_basin` SET TAGS ('dbx_business_glossary_term' = 'Sewer Basin');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_business_glossary_term' = 'Standardized Address');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `within_service_boundary_flag` SET TAGS ('dbx_business_glossary_term' = 'Within Service Boundary Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Connected Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `low_income_assistance_eligible_flag` SET TAGS ('dbx_pii_personal' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_application_id` SET TAGS ('dbx_business_glossary_term' = 'Service Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `collection_system_blockage_id` SET TAGS ('dbx_business_glossary_term' = 'Collection System Blockage Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `network_valve_id` SET TAGS ('dbx_business_glossary_term' = 'Network Valve Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `sso_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sso Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `accessibility_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `agent_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Invoice Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `collection_system_blockage_id` SET TAGS ('dbx_business_glossary_term' = 'Collection System Blockage Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Interaction Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Service Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `sso_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sso Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Source Water Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `regulatory_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Escalation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `regulatory_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Complaint Subcategory');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ALTER COLUMN `water_quality_test_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Test Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `parent_parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Parcel Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `parent_parcel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Area Sqft');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `cadastral_reference` SET TAGS ('dbx_business_glossary_term' = 'Cadastral Reference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `county` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Parcel Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Wkt');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `is_historical` SET TAGS ('dbx_business_glossary_term' = 'Is Historical');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `land_use_description` SET TAGS ('dbx_business_glossary_term' = 'Land Use Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Parcel Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Email');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `parcel_number` SET TAGS ('dbx_business_glossary_term' = 'Parcel Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `parcel_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `parcel_type` SET TAGS ('dbx_business_glossary_term' = 'Parcel Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `tax_assessed_value` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessed Value');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `tax_assessment_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Year');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `valuation_usd` SET TAGS ('dbx_business_glossary_term' = 'Valuation Usd');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `zoning_code` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code');
