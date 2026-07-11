-- Schema for Domain: customer | Business: Water_Utilities | Version: v2_ecm
-- Generated on: 2026-07-10 18:43:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`customer` COMMENT 'Single source of truth for all water and wastewater service accounts including residential, commercial, industrial, and municipal customers. Manages customer profiles, service addresses, account hierarchies, customer segments, contact information, service agreements, and customer lifecycle from application through termination. SSOT for customer identity across all billing, metering, and service delivery systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` (
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer_account data product (auto-inserted pre-linking).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Utilities assign customer accounts to cost centers for management accounting, enabling revenue and cost tracking by geographic district, service territory, or operational division. Standard practice f',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Water utilities assign each customer account to a specific fund (water, wastewater, stormwater) for GASB fund accounting and regulatory reporting. Essential for financial statement preparation and rat',
    `organization_id` BIGINT COMMENT 'Foreign key linking to customer.organization. Business justification: Commercial and industrial customer accounts should reference the organization master record. This allows proper tracking of corporate account structures. The account table currently only has person_id',
    `billing_account_id` BIGINT COMMENT '',
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
    `secondary_phone` STRING COMMENT 'An alternate contact phone number for the person. Used as backup contact method when primary phone is unavailable or for emergency escalation.',
    `secondary_phone_type` STRING COMMENT 'The type of secondary phone number (mobile, home, work, other). Used to determine appropriate communication channels and times for alternate contact.. Valid values are `mobile|home|work|other`',
    `senior_citizen_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the person qualifies as a senior citizen for age-based rate discounts or service programs. True if senior citizen, False otherwise. Age threshold defined by utility policy and regulatory requirements.',
    `suffix` STRING COMMENT 'Generational or professional suffix appended to the persons legal name (e.g., Jr, Sr, II, III). Used to distinguish individuals with identical names.. Valid values are `Jr|Sr|II|III|IV|V`',
    CONSTRAINT pk_person PRIMARY KEY(`person_id`)
) COMMENT 'Master record for individual persons associated with water utility accounts — account holders, co-applicants, authorized contacts, and guarantors. Captures legal name, date of birth, government ID type and masked number, primary phone, secondary phone, email address, preferred contact method, language preference, identity verification status, and privacy consent flags. Distinct from the account entity: one person may hold multiple accounts (e.g., landlord with multiple rental properties). SSOT for individual identity within the customer domain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`organization` (
    `organization_id` BIGINT COMMENT 'Unique system identifier for the organization entity. Primary key for commercial, industrial, and municipal organizations holding water and wastewater service accounts.',
    `parent_organization_id` BIGINT COMMENT 'Reference to the parent organization in corporate hierarchies. Enables consolidated billing, enterprise account management, and multi-location reporting for corporate customers.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Water utilities frequently have dual-role relationships where commercial/industrial customer organizations are also approved vendors (chemical suppliers, contractors, equipment providers). Tracking th',
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
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for electronic billing, service notifications, and account correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary authorized representative or contact person for the organization. Used for account management, billing inquiries, and service notifications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the organization contact. Used for urgent service notifications, outage alerts, and account inquiries.. Valid values are `^+?1?d{10,15}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person within the organization (e.g., Facilities Manager, CFO, City Manager).',
    `sic_code` STRING COMMENT 'Four-digit SIC code for legacy industry classification. Maintained for historical reporting and systems that have not migrated to NAICS.. Valid values are `^d{4}$`',
    `special_billing_instructions` STRING COMMENT 'Free-text field for custom billing requirements, invoice formatting preferences, or special handling instructions for the organization account.',
    `tax_exempt_certificate_number` STRING COMMENT 'State-issued tax exemption certificate number for organizations claiming tax-exempt status. Required for audit compliance.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the organization is exempt from sales tax or utility taxes. True if tax-exempt (typically government entities), False otherwise.',
    `website_url` STRING COMMENT 'Public website URL for the organization. Used for customer research and business development.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master record for commercial, industrial, and municipal organizations that hold water and wastewater service accounts. Captures legal entity name, DBA name, federal tax ID (EIN), NAICS/SIC industry code, organization type (corporation/LLC/municipality/HOA/government), primary contact name, incorporation state, credit tier, industrial user classification (for IUP purposes), and parent organization reference for corporate hierarchies. Supports B2B account management and industrial pretreatment program tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`service_address` (
    `service_address_id` BIGINT COMMENT 'Unique identifier for the service address record. Primary key for the service address entity.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Service addresses added or modified through CIP work (subdivision developments, service area extensions, infrastructure upgrades). Essential for geographic expansion tracking, service territory planni',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service addresses fall within District Metered Areas for non-revenue water tracking, leak detection program management, and consumption pattern analysis. Essential for AWWA water audit compliance, tar',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to customer.parcel. Business justification: Service address is physically located on a land parcel; linking provides geographic context and eliminates isolated parcel table.',
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
    `pressure_zone` STRING COMMENT 'Water distribution pressure zone identifier indicating the hydraulic zone serving this address. Used for hydraulic modeling and pressure management.',
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
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Premises created or significantly modified by CIP projects (new subdivisions, service area expansions, infrastructure replacements requiring new service lines). Critical for asset-to-project traceabil',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Premises physically connect to specific distribution mains for water service delivery. Essential for hydraulic modeling, service line inventory (LCRR compliance), outage impact analysis, and main brea',
    `service_address_id` BIGINT COMMENT 'Reference to the postal and Geographic Information System (GIS) address record for this premise. Links premise to distribution network location.',
    `territory_id` BIGINT COMMENT 'Reference to the geographic service territory in which this premise is located. Determines regulatory jurisdiction and operational district.',
    `backflow_prevention_required_flag` BOOLEAN COMMENT 'Indicates whether the premise requires backflow prevention devices due to cross-connection hazards. Mandatory for commercial, industrial, and irrigation services per Safe Drinking Water Act (SDWA).',
    `building_square_footage` DECIMAL(18,2) COMMENT 'Total conditioned floor area of structures on the premise in square feet. Used for commercial water demand forecasting and capacity fee assessments.',
    `building_type` STRING COMMENT 'Physical structure classification of the building on the premise. Used for demand forecasting and infrastructure capacity planning. [ENUM-REF-CANDIDATE: detached_house|townhouse|apartment|office|retail|warehouse|manufacturing|school|hospital|government|mixed_use — 11 candidates stripped; promote to reference product]',
    `connection_fee_paid_amount` DECIMAL(18,2) COMMENT 'Total one-time connection or capacity fees paid for this premise to establish utility service. Includes system development charges and impact fees.',
    `connection_fee_paid_date` DATE COMMENT 'Date when connection or capacity fees were paid for this premise. Used for revenue recognition and capital improvement program (CIP) funding tracking.',
    `construction_year` STRING COMMENT 'Year the primary structure on the premise was originally constructed. Used for infrastructure age analysis and lead service line risk assessment per Lead and Copper Rule Revisions (LCRR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this premise record was first created in the utility system. Part of audit trail for data lineage and regulatory compliance.',
    `district_metered_area_code` STRING COMMENT 'Code identifying the District Metered Area (DMA) for water loss management and Non-Revenue Water (NRW) tracking. Used for hydraulic zone analysis.. Valid values are `^DMA-[A-Z0-9]{3,10}$`',
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
    `pressure_zone` STRING COMMENT 'Hydraulic pressure zone designation for this premise within the distribution network. Determines operating Pounds per Square Inch (PSI) range and Pressure Reducing Valve (PRV) assignments.. Valid values are `^PZ-[A-Z0-9]{2,8}$`',
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
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Each service agreement tied to specific fund type (water/wastewater/stormwater/reclaimed) for proper revenue recognition and GASB compliance. Critical for multi-service utilities with separate fund ac',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service agreements are established for specific premises (physical properties). This FK links the contractual relationship to the physical location where service is provided. Currently service_agreeme',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Service agreements contain denormalized address fields that should reference the service_address master. This eliminates redundancy and ensures address consistency. The service_address table is the au',
    CONSTRAINT pk_service_agreement PRIMARY KEY(`service_agreement_id`)
) COMMENT 'The contractual relationship between a customer account and the utility for a specific service type (potable water, wastewater, recycled water, fire protection, irrigation) at a premise. Captures service agreement number, service type, rate schedule code, start date, end date, deposit amount, deposit waiver reason, service class, budget billing enrollment, and agreement status. This is the SSOT for what service a customer is contracted to receive and at what rate. Distinct from billing invoices (which are transactional) and from the rate schedule (which is a reference entity in the service domain).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` (
    `account_person_rel_id` BIGINT COMMENT 'Unique identifier for the account-person relationship record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the water utility account in this relationship. Links to the service account that the person is associated with.',
    `person_id` BIGINT COMMENT 'Reference to the person entity in this relationship. Links to the individual who has a role on the account.',
    `accessibility_requirements` STRING COMMENT 'Special accessibility or accommodation needs for this person when communicating about the account. May include requirements for large print, braille, TTY, or other assistive technologies.',
    `authorization_date` DATE COMMENT 'The date when this relationship was formally authorized or approved. Used for audit trail and compliance verification.',
    `authorization_document_reference` STRING COMMENT 'Reference number or identifier for the legal document or form that authorizes this relationship. May reference a power of attorney, lease agreement, or authorization form.',
    `billing_authority_flag` BOOLEAN COMMENT 'Indicates whether this person has authority to make billing decisions, dispute charges, or modify payment arrangements for the account. True if authorized, false otherwise.',
    `ccr_delivery_required_flag` BOOLEAN COMMENT 'Indicates whether this person must receive the annual Consumer Confidence Report for water quality as required by the Safe Drinking Water Act. True if delivery is required, false otherwise.',
    `created_by_user` STRING COMMENT 'The system user ID or username of the person who created this relationship record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'The date when this person-account relationship ended or will end. Null for open-ended relationships. Used for temporal tracking and historical analysis.',
    `effective_start_date` DATE COMMENT 'The date when this person-account relationship became active and legally binding. Used for temporal tracking and compliance reporting.',
    `emergency_contact_priority` STRING COMMENT 'The order in which this person should be contacted in case of emergency at the service address. Lower numbers indicate higher priority. Null if not an emergency contact.',
    `financial_responsibility_percentage` DECIMAL(18,2) COMMENT 'The percentage of account charges for which this person is financially responsible. Used in split-billing scenarios or shared responsibility arrangements. Value between 0.00 and 100.00.',
    `landlord_tenant_indicator` BOOLEAN COMMENT 'Specifies whether this person is the property owner (landlord), renter (tenant), owner-occupant, or property manager. Used for billing responsibility determination and compliance reporting.. Valid values are `landlord|tenant|owner_occupant|property_manager|not_applicable`',
    `language_preference` STRING COMMENT 'The preferred language for communications with this person regarding the account. Three-letter ISO 639-2 language code. Used for compliance with language access requirements. [ENUM-REF-CANDIDATE: ENG|SPA|CHI|FRE|VIE|KOR|RUS|ARA|POR|OTH — 10 candidates stripped; promote to reference product]',
    `last_modified_by_user` STRING COMMENT 'The system user ID or username of the person who last modified this relationship record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was most recently updated. Used for audit trail and change tracking.',
    `lcrr_notification_required_flag` BOOLEAN COMMENT 'Indicates whether this person must receive mandatory notifications under the EPA Lead and Copper Rule Revisions regarding lead service lines at the service address. True if notification is required, false otherwise.',
    `notification_preference` STRING COMMENT 'The preferred communication channel for sending notifications to this person regarding the account. Used for outage alerts, billing reminders, and compliance notifications.. Valid values are `email|sms|phone|mail|portal|none`',
    `relationship_notes` STRING COMMENT 'Free-form text field for additional information about this account-person relationship. May include special instructions, restrictions, or context relevant to customer service representatives.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the account-person relationship. Indicates whether the relationship is currently in effect or has been terminated.. Valid values are `active|inactive|pending|suspended|terminated`',
    `relationship_type` STRING COMMENT 'The role or capacity in which the person is associated with the account. Defines the nature of the relationship between the person and the service account.. Valid values are `primary_account_holder|co_applicant|authorized_representative|emergency_contact|third_party_notification|property_manager`',
    `service_authorization_flag` BOOLEAN COMMENT 'Indicates whether this person has authority to request service orders, schedule appointments, or authorize field work for the account. True if authorized, false otherwise.',
    `termination_date` DATE COMMENT 'The date when this relationship was formally terminated in the system. May differ from effective_end_date if termination was processed retroactively. Null for active relationships.',
    `termination_reason` STRING COMMENT 'The reason why this account-person relationship was terminated. Null for active relationships. Used for analytics and compliance reporting. [ENUM-REF-CANDIDATE: account_closed|person_removed|authorization_revoked|lease_ended|property_sold|death|customer_request|administrative — 8 candidates stripped; promote to reference product]',
    `third_party_payer_flag` BOOLEAN COMMENT 'Indicates whether this person is responsible for paying the bill on behalf of the primary account holder. True for third-party payers such as social service agencies or property managers, false otherwise.',
    `verification_date` DATE COMMENT 'The date when the persons identity and relationship authorization were last verified. Used for periodic re-verification requirements and audit compliance.',
    `verification_method` STRING COMMENT 'The method used to verify the persons identity and authorization for this relationship. Used for audit trail and fraud prevention analysis.. Valid values are `in_person|document_upload|phone_verification|email_verification|third_party_service|notarized_form`',
    `verification_status` STRING COMMENT 'Indicates whether the persons identity and authorization for this relationship have been verified. Used for fraud prevention and compliance with customer identification requirements.. Valid values are `verified|pending_verification|unverified|verification_failed|expired`',
    CONSTRAINT pk_account_person_rel PRIMARY KEY(`account_person_rel_id`)
) COMMENT 'Association entity capturing the relationship between a person and a water utility account, including the role the person plays (primary account holder, co-applicant, authorized representative, emergency contact, third-party notification recipient). Carries its own business data: relationship type, effective start date, effective end date, notification preferences for this role, and whether the person has billing authority. Supports scenarios such as landlord-tenant relationships, property managers, and third-party bill payers. Required for LCRR lead service line notification compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique identifier for the customer segment classification record. Primary key.',
    `territory_id` BIGINT COMMENT 'add column territory_id (BIGINT) with FK to service.territory.territory_id - customer segments may be territory-specific for rate-setting purposes',
    `approval_authority` STRING COMMENT 'Name of the regulatory body or internal authority that approved this segment definition. Examples: State PUC, Board of Directors, City Council.',
    `approval_date` DATE COMMENT 'Date when this customer segment definition was approved by the Public Utilities Commission (PUC) or governing board for rate-making purposes.',
    `assistance_program_eligible` BOOLEAN COMMENT 'Indicates whether customers in this segment are eligible for low-income assistance programs, payment plans, or rate discounts. True if eligible, False otherwise.',
    `average_monthly_usage_gallons` DECIMAL(18,2) COMMENT 'Average monthly water consumption in gallons for customers in this segment. Used for demand forecasting and rate impact analysis.',
    `ccr_distribution_required` BOOLEAN COMMENT 'Indicates whether customers in this segment must receive the annual Consumer Confidence Report (CCR) as required by the Safe Drinking Water Act (SDWA). True if required, False otherwise.',
    `segment_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the customer segment. Examples: LIRA (Low-Income Residential Assistance), LIU (Large Industrial User), MUN_WHSL (Municipal Wholesale), IRR (Irrigation-Only), FIRE_PROT (Fire Protection Only).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `conservation_target_pct` DECIMAL(18,2) COMMENT 'Target water conservation reduction percentage for this segment during drought or conservation programs. Expressed as a percentage (e.g., 15.00 for 15% reduction).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this customer segment record was first created in the system.',
    `customer_count` STRING COMMENT 'Current number of active customer accounts assigned to this segment. Updated periodically for reporting and forecasting purposes.',
    `demand_forecast_category` STRING COMMENT 'Category used for water demand forecasting and capacity planning. Segments with similar consumption patterns are grouped for predictive modeling.',
    `segment_description` STRING COMMENT 'Detailed description of the customer segment, including eligibility criteria, business purpose, and usage characteristics.',
    `effective_end_date` DATE COMMENT 'Date when this customer segment definition expires or is superseded. Null if the segment is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this customer segment definition becomes effective and can be used for customer assignment and billing.',
    `geographic_zone` STRING COMMENT 'Geographic zone, District Metered Area (DMA), or service territory identifier used for segmentation. Null if geography is not a segmentation criterion.',
    `industry_classification_code` STRING COMMENT 'NAICS (North American Industry Classification System) or SIC (Standard Industrial Classification) code for commercial and industrial segments. Used for regulatory reporting and demand forecasting.. Valid values are `^[0-9]{2,6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this customer segment record was last updated or modified.',
    `meter_size_range` STRING COMMENT 'Range of meter sizes (in inches) typically associated with this segment. Examples: 5/8-3/4 inch, 1-2 inch, 3+ inch. Used for infrastructure planning and rate design.',
    `segment_name` STRING COMMENT 'Full business name of the customer segment for display and reporting purposes.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this customer segment definition, eligibility criteria, or usage.',
    `priority_level` STRING COMMENT 'Service priority level for this segment during water shortage or emergency conditions. Critical segments (e.g., hospitals, fire protection) receive highest priority.. Valid values are `critical|high|medium|low`',
    `rate_case_docket_number` STRING COMMENT 'Regulatory docket or case number associated with the rate case that established or modified this customer segment. Used for audit trail and regulatory compliance.',
    `rate_tier` STRING COMMENT 'Applicable rate tier or rate schedule identifier associated with this customer segment. Links segment to pricing structure for billing purposes.',
    `regulatory_reporting_category` STRING COMMENT 'Category used for state and federal regulatory reporting, including EPA and state primacy agency reports. Examples: residential, commercial, industrial, public authority.',
    `revenue_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage of total utility revenue contributed by this customer segment. Used for rate design and financial planning. Expressed as a percentage (e.g., 25.50 for 25.5%).',
    `seasonal_variation_flag` BOOLEAN COMMENT 'Indicates whether this segment exhibits significant seasonal variation in water usage (e.g., irrigation customers with summer peaks). True if seasonal, False otherwise.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the customer segment. Active segments are available for customer assignment; pending segments are approved but not yet effective; retired segments are historical only.. Valid values are `active|inactive|pending|retired`',
    `segment_type` STRING COMMENT 'High-level classification of the customer segment by primary customer type.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `segmentation_basis` STRING COMMENT 'Primary criterion used to define and assign customers to this segment. Examples: usage volume thresholds, customer type classification, industry class (NAICS), geographic zone (DMA), income qualification, meter size. [ENUM-REF-CANDIDATE: usage_volume|customer_type|industry_class|geographic_zone|rate_class|service_type|income_level|meter_size — 8 candidates stripped; promote to reference product]',
    `service_class_code` STRING COMMENT 'Service class code from the Customer Information System (CIS) that maps to this segment. Used for integration with Oracle Utilities CC&B and billing systems.. Valid values are `^[A-Z0-9_]{1,10}$`',
    `usage_threshold_max_mgd` DECIMAL(18,2) COMMENT 'Maximum average daily water usage in Million Gallons per Day (MGD) allowed for assignment to this segment. Null if usage volume is not a segmentation criterion or if there is no upper limit.',
    `usage_threshold_min_mgd` DECIMAL(18,2) COMMENT 'Minimum average daily water usage in Million Gallons per Day (MGD) required for assignment to this segment. Null if usage volume is not a segmentation criterion.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Classification of customer accounts into business-defined segments for targeted service delivery, rate design, and regulatory reporting, including the full history of account-to-segment assignments. Captures segment code, segment name, segment description, segmentation basis (usage volume, customer type, industry class, geographic zone), effective date range, applicable rate tier, and per-account assignment records with assignment effective date, expiration date, assignment reason, and triggering source system or process (e.g., annual income recertification, usage threshold crossing, manual override). Examples include: residential low-income (LIRA), large industrial user (LIU), municipal wholesale, irrigation-only, and fire-protection-only. Used for CCR distribution targeting, assistance program eligibility, demand forecasting, and regulatory audits of segment change history.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` (
    `account_segment_assignment_id` BIGINT COMMENT 'Unique identifier for each account segment assignment record. Primary key for the account segment assignment entity.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that is being assigned to a segment. Links to the customer account master record.',
    `segment_id` BIGINT COMMENT 'Reference to the customer segment to which the account is assigned. Links to the customer segment master record.',
    `assignment_notes` STRING COMMENT 'General free-text notes field for capturing additional information about the segment assignment that does not fit into structured fields. May include customer service interactions, special circumstances, or operational reminders.',
    `assignment_number` STRING COMMENT 'Business-readable unique identifier for the segment assignment. Used for tracking and audit purposes in customer service and billing operations.. Valid values are `^ASG-[0-9]{10}$`',
    `assignment_reason_code` STRING COMMENT 'Standardized code indicating the business reason or trigger that caused the segment assignment. Examples include annual income recertification for low-income programs, usage threshold crossing for high-volume commercial customers, manual override by customer service representative, rate class change due to meter size upgrade, enrollment in conservation program, or regulatory mandate for special customer class.. Valid values are `INCOME_CERT|USAGE_THRESHOLD|MANUAL_OVERRIDE|RATE_CLASS_CHANGE|PROGRAM_ENROLLMENT|REGULATORY_MANDATE`',
    `assignment_reason_description` STRING COMMENT 'Free-text explanation providing additional context for the segment assignment. Captures details not conveyed by the reason code, such as specific program names, regulatory citation, or customer service notes.',
    `assignment_source_reference` STRING COMMENT 'External reference identifier from the source system that created the assignment. May contain transaction ID, batch job ID, API request ID, or other traceability information to support audit and troubleshooting.',
    `assignment_source_system` STRING COMMENT 'System or process that originated the segment assignment record. Identifies whether the assignment was created by the billing system (CC&B), customer information system (CIS), customer relationship management system (CRM), manual entry by staff, automated batch process, external API integration, or data migration activity. [ENUM-REF-CANDIDATE: CC&B|CIS|CRM|MANUAL|BATCH_PROCESS|API|DATA_MIGRATION — 7 candidates stripped; promote to reference product]',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the segment assignment. Active assignments are currently in effect; pending assignments are scheduled for future activation; expired assignments have passed their end date; superseded assignments have been replaced by newer assignments; cancelled assignments were terminated before their natural expiration.. Valid values are `active|inactive|pending|expired|superseded|cancelled`',
    `certification_date` DATE COMMENT 'Date when the customer or account was certified as eligible for the assigned segment. Particularly relevant for income-qualified programs, special assistance programs, or regulatory customer classes that require periodic recertification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment assignment record was first created in the system. Supports audit trail and data lineage tracking. Immutable after initial creation.',
    `effective_date` DATE COMMENT 'Date when the segment assignment becomes active and begins to apply to billing, rate schedules, and customer service policies. Must be on or before the current date for active assignments.',
    `expiration_date` DATE COMMENT 'Date when the segment assignment expires and is no longer in effect. Nullable for open-ended assignments. Used to support time-bound segment memberships such as temporary low-income assistance programs or seasonal rate classifications.',
    `is_primary_segment` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary segment assignment for the account. Only one assignment per account should be marked as primary at any given time. Primary segment drives default billing behavior and customer service routing.',
    `last_modified_by` STRING COMMENT 'User identifier or system process name that most recently modified the segment assignment record. Supports accountability and audit trail for data change events.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment assignment record was most recently updated. Tracks the last change to any field in the record. Updated automatically on every modification.',
    `override_authorized_by` STRING COMMENT 'Name or employee identifier of the staff member who authorized a manual override of the segment assignment. Required when override_flag is true. Supports audit trail and accountability for exception processing.',
    `override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment was manually overridden by authorized staff, bypassing normal automated assignment rules. Used for audit and compliance reporting to track exceptions to standard segmentation logic.',
    `override_justification` STRING COMMENT 'Free-text explanation of the business justification for manually overriding the segment assignment. Required when override_flag is true. Captures the reason for the exception to support regulatory audits and management review.',
    `priority_rank` STRING COMMENT 'Numeric ranking used to resolve conflicts when an account has multiple active segment assignments. Lower numbers indicate higher priority. Used by billing and rate engine to determine which segment rules apply when overlapping assignments exist.',
    `recertification_due_date` DATE COMMENT 'Date by which the customer must recertify their eligibility for the assigned segment. Used for programs requiring annual or periodic income verification, such as low-income assistance programs. Triggers customer notifications and workflow tasks.',
    `created_by` STRING COMMENT 'User identifier or system process name that created the segment assignment record. Supports accountability and audit trail for data creation events.',
    CONSTRAINT pk_account_segment_assignment PRIMARY KEY(`account_segment_assignment_id`)
) COMMENT 'Transactional record of a customer accounts assignment to a customer segment at a point in time. Captures the account, the assigned segment, assignment effective date, expiration date, assignment reason, and the source system or process that triggered the assignment (e.g., annual income recertification, usage threshold crossing, manual override). Maintains full history of segment changes to support regulatory audits and rate design analysis.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`service_application` (
    `service_application_id` BIGINT COMMENT 'Unique identifier for the service application record. Primary key.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Service applications capture applicant details that should reference the person master record. This eliminates data duplication and ensures applicant identity is properly managed. The person table con',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Service applications for new connections often trigger or relate to CIP projects (developer-funded infrastructure, capacity expansions). Critical for capacity planning, developer coordination, and con',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Applications request specific service offerings (potable water, wastewater, reclaimed). Application review validates requested service against available offerings, calculates connection fees per offer',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service applications are for establishing service at specific premises. While service_address_id exists, the premise_id link is needed to reference the physical property record which contains addition',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: New service applications require engineering review to verify adequate pressure and capacity in the target pressure zone before approval. Critical for ensuring system can support additional demand wit',
    `employee_id` BIGINT COMMENT 'User ID of the utility staff member who approved the service application.',
    `service_address_id` BIGINT COMMENT 'Reference to the service address (premise) where water or wastewater service is being requested. Links to the service address master record.',
    `service_assigned_to_user_employee_id` BIGINT COMMENT 'User ID of the utility staff member currently assigned to review and process this service application.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer (applicant) who submitted this service application. Links to the customer master record.',
    `service_customer_customer_account_id` BIGINT COMMENT 'Reference to the customer (applicant) who submitted this service application. Links to the customer master record.',
    `service_employee_id` BIGINT COMMENT 'User ID of the utility staff member who approved the service application.',
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
    `service_class_requested` STRING COMMENT 'Customer segment or service class requested: residential (single-family or multi-family), commercial (retail, office), industrial (manufacturing, processing), municipal (government facilities), agricultural (irrigation, livestock), or institutional (schools, hospitals).. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `service_type_requested` STRING COMMENT 'Type of utility service requested by the applicant: water only, wastewater (sewer) only, or combined water and wastewater service.. Valid values are `water_only|wastewater_only|water_and_wastewater`',
    `sla_due_date` DATE COMMENT 'Target date by which the application should be reviewed and processed according to utility service level agreement standards.',
    `submission_channel` STRING COMMENT 'Channel through which the customer submitted the service application: online customer portal, phone call to customer service, walk-in at utility office, postal mail, mobile app, or email.. Valid values are `online_portal|phone|walk_in|mail|mobile_app|email`',
    `submission_date` DATE COMMENT 'Date when the customer submitted the service application.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the service application was submitted by the customer or entered into the system.',
    `withdrawn_date` DATE COMMENT 'Date when the applicant withdrew or cancelled the service application. Null if application was not withdrawn.',
    `withdrawn_reason` STRING COMMENT 'Reason provided by the applicant for withdrawing the service application (e.g., changed mind, moved to different location, service no longer needed).',
    CONSTRAINT pk_service_application PRIMARY KEY(`service_application_id`)
) COMMENT 'Record of a customers application to establish, transfer, or modify water and/or wastewater service. Captures application number, application type (new service, transfer, upgrade, downgrade, termination), applicant identity, requested service address, requested service start date, application submission channel (online, phone, walk-in), application status (submitted, under review, approved, rejected, withdrawn), identity verification outcome, credit check result, deposit requirement, and processing timestamps. Represents the start of the customer lifecycle. Sourced from Oracle CC&B and Microsoft Dynamics 365.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` (
    `account_status_history_id` BIGINT COMMENT 'Unique identifier for each account status transition record. Primary key for the account status history log.',
    `employee_id` BIGINT COMMENT 'The system user identifier of the person or process that created this status history record. Supports audit trail and data quality investigations.',
    `account_employee_id` BIGINT COMMENT 'The system user identifier of the person who initiated or approved the status transition. May be a customer service representative, billing clerk, or system administrator.',
    `payment_plan_id` BIGINT COMMENT 'Reference to an active payment arrangement or installment plan associated with the status transition. Used to track compliance with payment agreements.',
    `account_payment_plan_id` BIGINT COMMENT 'Reference to an active payment arrangement or installment plan associated with the status transition. Used to track compliance with payment agreements.',
    `ar_transaction_id` BIGINT COMMENT 'The unique transaction or event identifier from the source system that generated this status history record. Enables traceability back to the originating system.',
    `billing_cycle_id` BIGINT COMMENT 'Reference to the billing cycle during which the status transition occurred. Used for financial period analysis and revenue recognition.',
    `case_id` BIGINT COMMENT 'Reference to the customer service case or dispute that is associated with this status transition. Used for tracking customer interactions and complaint resolution.',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Account status changes (service holds, disconnection restrictions) may be triggered by compliance violations—e.g., industrial user violations preventing disconnection per regulatory requirements.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that experienced the status transition. Links to the customer account master record.',
    `customer_complaint_id` BIGINT COMMENT 'Reference to the customer service case or dispute that is associated with this status transition. Used for tracking customer interactions and complaint resolution.',
    `read_id` BIGINT COMMENT 'Reference to the final or initial meter reading associated with the status transition, such as a final read at termination or initial read at activation.',
    `point_id` BIGINT COMMENT 'Reference to the physical service point (meter location) associated with the account at the time of the status transition. Links status changes to physical infrastructure.',
    `primary_account_employee_id` BIGINT COMMENT 'The system user identifier of the person who initiated or approved the status transition. May be a customer service representative, billing clerk, or system administrator.',
    `reversed_history_account_status_history_id` BIGINT COMMENT 'Reference to the original account status history record that this transition reverses or corrects. Maintains audit trail linkage for reversed transactions.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Account status transitions may be triggered by service agreement events (e.g., agreement activation, termination). This provides agreement-level status tracking context. Nullable as many status change',
    `work_order_id` BIGINT COMMENT 'Reference to the field service work order that triggered or resulted from the status transition, such as a disconnect or reconnect order.',
    `compliance_notes` STRING COMMENT 'Free-text field for documenting regulatory compliance considerations, special circumstances, or audit trail notes related to the status transition.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this status history record was created in the system. Used for audit trail and data lineage tracking.',
    `days_delinquent` STRING COMMENT 'The number of days the account was past due at the time of the status transition. Used for aging analysis and collections prioritization.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'The security deposit amount in USD held or required at the time of the status transition. Used for deposit refund processing and credit risk management.',
    `effective_date` DATE COMMENT 'The calendar date on which the new status became effective. May differ from transition timestamp for scheduled future status changes.',
    `initiated_by_system_code` STRING COMMENT 'The source system or channel that triggered the status transition. Distinguishes between automated system-driven changes and manual user actions. [ENUM-REF-CANDIDATE: CC&B|MAXIMO|CRM|BATCH_BILLING|AMI|MANUAL|IVR|PORTAL — 8 candidates stripped; promote to reference product]',
    `medical_certification_flag` BOOLEAN COMMENT 'Indicates whether a medical certification was on file at the time of the status transition, which may prevent service disconnection under state regulations.',
    `new_status_code` STRING COMMENT 'The status code of the account after this transition. Represents the to state in the status lifecycle. [ENUM-REF-CANDIDATE: PENDING|ACTIVE|SUSPENDED|FINAL_NOTICE|TERMINATED|INACTIVE|CLOSED|DELINQUENT — 8 candidates stripped; promote to reference product]',
    `notification_method` STRING COMMENT 'The communication channel used to notify the customer of the status change. Supports multi-channel customer communication tracking.. Valid values are `MAIL|EMAIL|SMS|PHONE|DOOR_HANGER|NONE`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a customer notification was sent regarding the status change. Required for regulatory compliance and customer service audit trails.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when the customer notification was sent. Used to verify compliance with advance notice requirements.',
    `outstanding_balance_amount` DECIMAL(18,2) COMMENT 'The total outstanding account balance in USD at the time of the status transition. Critical for non-payment related status changes and collections analytics.',
    `previous_status_code` STRING COMMENT 'The status code of the account immediately before this transition occurred. Represents the from state in the status lifecycle. [ENUM-REF-CANDIDATE: PENDING|ACTIVE|SUSPENDED|FINAL_NOTICE|TERMINATED|INACTIVE|CLOSED|DELINQUENT — 8 candidates stripped; promote to reference product]',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the status transition. Used for root cause analysis and regulatory reporting. [ENUM-REF-CANDIDATE: NON_PAYMENT|CUSTOMER_REQUEST|MOVE_OUT|POLICY_VIOLATION|SEASONAL|METER_ISSUE|FRAUD|BANKRUPTCY|DECEASED|ADMINISTRATIVE — 10 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Detailed free-text explanation of the reason for the status change. Provides additional context beyond the standardized reason code.',
    `reconnection_fee_amount` DECIMAL(18,2) COMMENT 'The reconnection or reactivation fee in USD charged for restoring service after suspension or termination. Supports revenue recognition and fee tracking.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether the status transition is subject to a regulatory hold or moratorium, such as winter shutoff protection or pandemic-related restrictions.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this status transition represents a reversal or correction of a previous status change. Used for audit trail integrity and dispute resolution.',
    `scheduled_flag` BOOLEAN COMMENT 'Indicates whether this status transition was scheduled in advance or occurred immediately. Used to distinguish planned versus reactive status changes.',
    `source_system_code` STRING COMMENT 'The originating system of record for this status history entry. Used for data lineage tracking and system integration reconciliation.. Valid values are `CC&B|MAXIMO|CRM|LEGACY|MIGRATION`',
    `transition_timestamp` TIMESTAMP COMMENT 'The exact date and time when the account status transition became effective. This is the business event timestamp for the status change.',
    CONSTRAINT pk_account_status_history PRIMARY KEY(`account_status_history_id`)
) COMMENT 'Immutable audit log of all status transitions for a customer account throughout its lifecycle (e.g., pending → active → suspended → final notice → terminated). Captures the previous status, new status, effective timestamp, reason code, initiating user or system, and any associated work order or case reference. Essential for regulatory compliance, dispute resolution, and customer lifecycle analytics. Supports SDWA and state primacy agency audit requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account or person this contact is associated with. Links contact to the customer master record in Oracle Utilities CC&B.',
    `contact_customer_customer_account_id` BIGINT COMMENT 'Reference to the customer account or person this contact is associated with. Links contact to the customer master record in Oracle Utilities CC&B.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Contact points (phone, email) may be associated with specific persons in addition to accounts. This allows tracking which person at an account uses which contact method. Nullable FK as some contacts a',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contact information verification (especially for emergency notifications, LCRR compliance) is performed by CSR staff. Data quality accountability and regulatory compliance requirement. New attribute n',
    `channel` STRING COMMENT 'The communication channel or medium through which this contact point operates. Supports multi-channel customer engagement including Consumer Confidence Report (CCR) delivery, boil-water notices, and outage notifications.. Valid values are `phone|email|sms|postal|portal|fax`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record. Active contacts are used for communications; inactive contacts are retained for history; invalid contacts have been identified as unreachable; pending_verification contacts await confirmation.. Valid values are `active|inactive|suspended|invalid|pending_verification`',
    `contact_type` STRING COMMENT 'Classification of the contact purpose. Indicates whether this contact is used for billing correspondence, service notifications, emergency alerts, legal notices, technical communications, or general customer service inquiries.. Valid values are `billing|service|emergency|legal_notice|technical|customer_service`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was first created in the data platform. Supports audit trail and data lineage tracking.',
    `delivery_failure_count` STRING COMMENT 'Count of failed communication delivery attempts to this contact. Used to identify problematic contacts and trigger validation workflows.',
    `delivery_success_count` STRING COMMENT 'Count of successful communication deliveries to this contact. Used to calculate contact reliability and quality scores.',
    `do_not_contact_flag` BOOLEAN COMMENT 'Boolean flag indicating customer has requested no contact through this channel except for legally required communications. Overrides opt-in preferences except for emergency and regulatory notifications.',
    `effective_end_date` DATE COMMENT 'Date after which this contact information is no longer active. Null for currently active contacts. Enables contact history tracking and audit trails.',
    `effective_start_date` DATE COMMENT 'Date from which this contact information becomes active and valid for use. Supports temporal contact management and future-dated contact changes.',
    `invalid_date` DATE COMMENT 'Date when this contact was marked as invalid. Used for data quality reporting and contact refresh prioritization.',
    `invalid_reason` STRING COMMENT 'Reason why this contact was marked as invalid. Populated when contact_status is set to invalid. Supports data quality improvement and contact cleansing workflows.. Valid values are `bounced_email|disconnected_phone|returned_mail|customer_reported|system_validation_failed`',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary contact point for the associated customer and contact type. Used to determine default communication channel for critical notifications.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether this contact information has been verified as accurate and reachable. Verification may occur through confirmation emails, SMS codes, or postal mail validation.',
    `label` STRING COMMENT 'Human-readable label or nickname for this contact (e.g., Home Phone, Work Email, Billing Address). Helps users distinguish between multiple contacts of the same type.',
    `language_preference` STRING COMMENT 'Preferred language for communications sent to this contact. Three-letter ISO 639-2 language code. Supports multilingual customer communications and regulatory compliance for non-English speaking customers. [ENUM-REF-CANDIDATE: ENG|SPA|FRE|CHI|VIE|KOR|RUS|ARA|POR|GER — 10 candidates stripped; promote to reference product]',
    `last_contact_date` DATE COMMENT 'Date when this contact point was last used for outbound communication. Used to track contact engagement and identify stale contact records.',
    `last_contact_type` STRING COMMENT 'Type of the last communication sent to this contact (e.g., bill, service alert, CCR, boil-water notice). Supports communication history analysis.',
    `notes` STRING COMMENT 'Free-text notes or comments about this contact record. May include special handling instructions, customer preferences, or historical context.',
    `opt_in_billing` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive billing-related communications through this contact channel. Supports compliance with communication preference regulations.',
    `opt_in_emergency` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive emergency alerts (e.g., boil-water notices, water quality advisories, Sanitary Sewer Overflow (SSO) notifications) through this contact channel. Typically defaults to true for critical public health communications.',
    `opt_in_marketing` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive marketing and promotional communications (e.g., conservation programs, new service offerings) through this contact channel.',
    `opt_in_service` BOOLEAN COMMENT 'Boolean flag indicating customer consent to receive service-related communications (e.g., planned outages, maintenance notifications) through this contact channel.',
    `opt_out_date` DATE COMMENT 'Date when the customer opted out of communications through this contact channel. Null if customer has not opted out. Used for compliance reporting and communication suppression.',
    `opt_out_reason` STRING COMMENT 'Free-text reason provided by customer for opting out of communications. Supports customer experience analysis and communication strategy improvement.',
    `quality_score` DECIMAL(18,2) COMMENT 'Data quality score for this contact record (0.00 to 100.00). Calculated based on verification status, recency, completeness, and delivery success rate. Used to prioritize contact data cleansing efforts.',
    `source_system_code` STRING COMMENT 'Unique identifier for this contact in the source system. Enables traceability back to the system of record and supports data reconciliation.',
    `time_zone` STRING COMMENT 'Time zone associated with this contact location (e.g., America/New_York, America/Los_Angeles). Used to schedule communications at appropriate local times and comply with TCPA calling hour restrictions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was last modified. Supports change tracking and data quality monitoring.',
    `value` DECIMAL(18,2) COMMENT 'The actual contact information value - phone number, email address, mailing address, SMS number, portal username, or fax number. Format varies by contact_channel. This is the primary contact data point.',
    `verification_date` DATE COMMENT 'Date when this contact information was last verified. Used to track data quality and trigger re-verification workflows for stale contact data.',
    `verification_method` STRING COMMENT 'Method used to verify this contact information. Tracks how the contact was validated to support audit and data quality reporting.. Valid values are `email_link|sms_code|postal_mail|phone_call|in_person|system_import`',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Master record of all contact points, communication preferences, and third-party notification arrangements associated with a customer account or person. Captures contact type (billing, service, emergency, legal notice, third-party notification), contact value, contact channel (phone/email/SMS/postal/portal), is_primary flag, is_verified flag, verification date, opt-in/opt-out status per communication channel, preferred language, notification trigger type (for third-party arrangements: pre-disconnect, outage, boil-water notice), ADA accommodation flags (large print, braille, TTY), relationship to account holder (for third-party contacts), effective date range, and consent documentation reference. Supports multi-channel customer communications including CCR delivery, boil-water notices, outage notifications, TCPA/CAN-SPAM compliance, EPA CCR electronic delivery rules, and state PUC consumer protection rules for third-party notification before disconnection.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` (
    `communication_preference_id` BIGINT COMMENT 'Unique identifier for the customer communication preference record.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for which these communication preferences apply.',
    `communication_customer_customer_account_id` BIGINT COMMENT 'Reference to the customer account for which these communication preferences apply.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Communication preferences may be person-specific within an account (e.g., different persons at same organization prefer different channels). This FK allows tracking individual preferences. Nullable as',
    `audio_format_required` BOOLEAN COMMENT 'Indicates whether the customer requires audio format (recorded or synthesized speech) for communications (ADA accommodation).',
    `bill_ready_channel` STRING COMMENT 'Preferred channel for bill ready notifications when a new bill is available.. Valid values are `email|sms|mail|portal|mobile_app`',
    `boil_water_notice_channel` STRING COMMENT 'Preferred channel for critical public health boil water advisories and rescissions.. Valid values are `email|sms|phone|mail|mobile_app`',
    `braille_required` BOOLEAN COMMENT 'Indicates whether the customer requires braille format for printed communications (ADA accommodation).',
    `ccr_delivery_channel` STRING COMMENT 'Preferred channel for annual Consumer Confidence Report (CCR) delivery as required by EPA.. Valid values are `email|mail|portal`',
    `ccr_electronic_consent` BOOLEAN COMMENT 'Indicates whether the customer has provided explicit consent to receive the annual CCR electronically instead of by mail, as permitted by EPA rules.',
    `ccr_electronic_consent_date` DATE COMMENT 'Date when the customer consented to electronic CCR delivery.',
    `conservation_alert_channel` STRING COMMENT 'Preferred channel for water conservation alerts, drought notices, and usage reduction requests.. Valid values are `email|sms|mail|mobile_app`',
    `contact_time_preference` STRING COMMENT 'Preferred time of day for non-urgent customer contact (morning, afternoon, evening, or anytime).. Valid values are `morning|afternoon|evening|anytime`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the communication preference record was first created.',
    `delinquency_notice_channel` STRING COMMENT 'Preferred channel for past-due payment reminders and service disconnection warnings.. Valid values are `email|sms|mail|phone`',
    `do_not_call` BOOLEAN COMMENT 'Indicates whether the customer has requested to be placed on the internal do-not-call list for non-essential phone communications.',
    `do_not_call_date` DATE COMMENT 'Date when the customer requested do-not-call status.',
    `ebill_enrollment_date` DATE COMMENT 'Date when the customer enrolled in electronic billing and paperless delivery.',
    `effective_date` DATE COMMENT 'Date when these communication preferences became effective for the customer.',
    `email_unsubscribe_date` DATE COMMENT 'Date when the customer unsubscribed from email communications (for non-transactional messages).',
    `expiration_date` DATE COMMENT 'Date when these communication preferences expire or are superseded by a new preference record (nullable for current preferences).',
    `large_print_required` BOOLEAN COMMENT 'Indicates whether the customer requires large print format for printed communications due to visual impairment (ADA accommodation).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the communication preference record was last modified.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive promotional and marketing communications.',
    `marketing_opt_in_date` DATE COMMENT 'Date when the customer opted in to marketing communications.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding special communication requirements or preference details.',
    `outage_alert_channel` STRING COMMENT 'Preferred channel for urgent service outage and restoration notifications.. Valid values are `email|sms|phone|mobile_app`',
    `paperless_billing_consent` BOOLEAN COMMENT 'Indicates whether the customer has consented to receive bills electronically instead of paper mail.',
    `payment_confirmation_channel` STRING COMMENT 'Preferred channel for payment confirmation receipts and acknowledgments.. Valid values are `email|sms|mail|portal|mobile_app`',
    `preference_status` STRING COMMENT 'Current status of the communication preference record (active, inactive, or suspended).. Valid values are `active|inactive|suspended`',
    `preferred_channel` STRING COMMENT 'Default channel for general customer communications (email, SMS, postal mail, phone, web portal, or mobile app).. Valid values are `email|sms|mail|phone|portal|mobile_app`',
    `preferred_language` STRING COMMENT 'Primary language preference for all customer communications (English, Spanish, French, Chinese, Vietnamese, or other).. Valid values are `en|es|fr|zh|vi|other`',
    `robocall_consent` BOOLEAN COMMENT 'Indicates whether the customer has consented to receive automated or pre-recorded voice calls.',
    `robocall_consent_date` DATE COMMENT 'Date when the customer provided robocall consent.',
    `service_appointment_channel` STRING COMMENT 'Preferred channel for service appointment confirmations, reminders, and technician arrival notifications.. Valid values are `email|sms|phone|mobile_app`',
    `sms_consent` BOOLEAN COMMENT 'Indicates whether the customer has provided explicit consent to receive SMS text message communications.',
    `sms_consent_date` DATE COMMENT 'Date when the customer provided SMS consent.',
    `sms_opt_out_date` DATE COMMENT 'Date when the customer opted out of SMS text message communications.',
    `tty_required` BOOLEAN COMMENT 'Indicates whether the customer requires TTY/TDD (Text Telephone/Telecommunications Device for the Deaf) for phone communications (ADA accommodation).',
    `update_source` STRING COMMENT 'Channel or system through which the preference update was received (customer portal, mobile app, call center, mail, or system).. Valid values are `customer_portal|mobile_app|call_center|mail|system`',
    `updated_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last updated the preference record.',
    CONSTRAINT pk_communication_preference PRIMARY KEY(`communication_preference_id`)
) COMMENT 'Customer-level record of preferred communication channels, languages, and notification opt-ins/opt-outs for each communication category. Captures preferred language, preferred channel per notification type (bill ready, payment confirmation, outage alert, boil-water notice, CCR delivery, delinquency notice), paperless billing consent, e-bill enrollment date, SMS consent, robocall consent, and ADA accommodation flags (large print, braille, TTY). Supports CAN-SPAM, TCPA compliance, and EPA CCR electronic delivery rules.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` (
    `assistance_program_id` BIGINT COMMENT 'Unique identifier for the customer_assistance_program data product (auto-inserted pre-linking).',
    `territory_id` BIGINT COMMENT 'add column territory_id (BIGINT) with FK to service.territory.territory_id - assistance programs are geographically scoped and need linkage to service territories for eligibility determination',
    `program_name` STRING COMMENT '',
    `program_description` STRING COMMENT '',
    `eligibility_criteria` STRING COMMENT '',
    `max_benefit_amount` DECIMAL(18,2) COMMENT '',
    `funding_source` STRING COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    `updated_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_assistance_program PRIMARY KEY(`assistance_program_id`)
) COMMENT 'Reference catalog of customer assistance and affordability programs offered by the utility, including low-income rate assistance (LIRA), payment assistance, leak adjustment programs, senior citizen discounts, medical baseline allowances, and lifeline rates. Captures program code, program name, program type, eligibility criteria description, benefit type (rate discount, bill credit, payment plan, usage allowance), funding source (utility-funded, state-funded, federal LIHEAP), maximum benefit amount, program start and end dates, and administering agency. Distinct from account-level enrollment (captured in assistance_enrollment).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` (
    `customer_assistance_enrollment_id` BIGINT COMMENT 'Unique identifier for the customer_assistance_enrollment data product (auto-inserted pre-linking).',
    `affordability_plan_id` BIGINT COMMENT 'Foreign key linking to service.affordability_plan. Business justification: Enrollments must reference which affordability plan (discount percentage, eligibility thresholds, benefit duration) applies. Required for billing discount calculation, recertification tracking, regula',
    `assistance_program_id` BIGINT COMMENT 'Foreign key linking to customer.assistance_program. Business justification: Enrollment records must reference the assistance program they enroll in; adds inbound to assistance_program and outbound from enrollment.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Assistance program costs allocated to specific funds (often separate assistance fund or general fund subsidy). Essential for rate case cost-of-service studies and regulatory reporting of assistance pr',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Low-income assistance enrollments funded by specific federal/state grants (LIHWAP, LIHEAP, utility assistance programs). Required for grant expenditure tracking, compliance reporting, and reimbursemen',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Assistance program enrollments may apply to specific service agreements rather than entire accounts. This allows agreement-level benefit tracking for accounts with multiple services. Nullable as some',
    `billing_assistance_enrollment_id` BIGINT COMMENT '',
    CONSTRAINT pk_customer_assistance_enrollment PRIMARY KEY(`customer_assistance_enrollment_id`)
) COMMENT 'Transactional record of a customer accounts enrollment in a utility assistance or affordability program. Captures enrollment date, expiration date, recertification due date, enrollment status (active, expired, suspended, pending recertification), benefit amount applied, income verification method, household size at enrollment, and the certifying agent. Tracks the full lifecycle of assistance program participation per account. Required for state public utilities commission reporting on affordability program reach and expenditure.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`account_note` (
    `account_note_id` BIGINT COMMENT 'Unique identifier for the account note record. Primary key.',
    `employee_id` BIGINT COMMENT 'User identifier of the utility staff member who created the note, or system identifier if the note was auto-generated (e.g., SYSTEM_AUTO, BILLING_ENGINE). Used for accountability and audit trail.',
    `account_reviewed_by_user_employee_id` BIGINT COMMENT 'User identifier of the supervisor or QA team member who reviewed the note. Null if not yet reviewed or review not required.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Notes documenting project-related customer communications, easement negotiations, temporary service arrangements, or construction impact acknowledgments. Critical for project stakeholder documentation',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Account notes document compliance-related restrictions, violation history, or special handling requirements for accounts with regulatory issues—critical operational context for customer service and bi',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account to which this note is attached. Links to the service account in the billing system.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Notes capture enforcement action impacts on customer accounts (payment plans, service restrictions, legal holds)—operational documentation requirement for coordinating compliance and customer service',
    `customer_complaint_id` BIGINT COMMENT 'Reference to a formal customer complaint record if this note documents or follows up on a complaint. Null if not associated with a complaint.',
    `primary_account_employee_id` BIGINT COMMENT 'User identifier of the utility staff member who created the note, or system identifier if the note was auto-generated (e.g., SYSTEM_AUTO, BILLING_ENGINE). Used for accountability and audit trail.',
    `order_id` BIGINT COMMENT 'Reference to a service order if this note was created in the context of a specific field service activity (e.g., meter installation, leak repair, disconnection). Null if not associated with a service order.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Notes may relate to specific service agreements (e.g., special billing arrangements for a particular service). This provides agreement-level note context. Nullable as many notes are account-level.',
    `alert_flag` BOOLEAN COMMENT 'Indicates whether this note triggers an alert or pop-up notification when the account is accessed by customer service representatives or field crews. True if alert is active, False otherwise.',
    `attachment_count` STRING COMMENT 'Number of file attachments (documents, images, recordings) associated with this note. Zero if no attachments. Attachments are stored separately and linked to the note.',
    `auto_generated_flag` BOOLEAN COMMENT 'Indicates whether the note was automatically generated by a system process (e.g., billing engine, workflow automation, IVR system) rather than manually entered by a user. True if auto-generated, False if manually created.',
    `character_count` STRING COMMENT 'Total number of characters in the note_text field. Used for reporting and data quality monitoring. Calculated at note creation and update.',
    `collections_hold_flag` BOOLEAN COMMENT 'Indicates whether the note places or documents a hold on collections activities (e.g., payment arrangement in place, dispute under review, bankruptcy filing). True if collections hold is active, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the note was originally created in the source system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_visible_flag` BOOLEAN COMMENT 'Indicates whether the note is visible to the customer through self-service channels (web portal, mobile app). True if customer can view, False if internal only. Subset of visibility_level logic for simplified customer portal filtering.',
    `expiration_date` DATE COMMENT 'Date when the note is no longer relevant or should be archived. Null for notes with indefinite relevance. Used for time-bound alerts (e.g., temporary medical baseline, seasonal access restrictions). Follows format yyyy-MM-dd.',
    `hazard_indicator_flag` BOOLEAN COMMENT 'Indicates whether the note contains information about a safety hazard or dangerous condition at the service address (e.g., aggressive dog, unstable structure, hazardous materials). True if hazard is present, False otherwise. Used to alert field crews.',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language in which the note was written: ENG (English), SPA (Spanish), CHI (Chinese), VIE (Vietnamese), KOR (Korean), TGL (Tagalog), FRE (French). Supports multilingual customer service operations. [ENUM-REF-CANDIDATE: ENG|SPA|CHI|VIE|KOR|TGL|FRE — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the note was last updated or edited. Null if the note has never been modified after creation. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the note is subject to legal hold for litigation, regulatory investigation, or legal discovery. True if legal hold applies, False otherwise. Prevents deletion or modification of the note.',
    `medical_baseline_flag` BOOLEAN COMMENT 'Indicates whether the note is related to a medical baseline or life-support equipment dependency at the service address. True if medical baseline applies, False otherwise. Triggers special handling for disconnection and outage notifications.',
    `note_author_name` STRING COMMENT 'Full name of the utility staff member who created the note, or system name if auto-generated. Provides human-readable identification of the note creator.',
    `note_category` STRING COMMENT 'Broad business category for the note: BILLING (payment arrangements, billing disputes), SERVICE_DELIVERY (service quality, outages), SAFETY (hazardous conditions, dangerous animals), REGULATORY (compliance holds, legal restrictions), CUSTOMER_PREFERENCE (communication preferences, special requests), PROPERTY_ACCESS (gate codes, access instructions).. Valid values are `BILLING|SERVICE_DELIVERY|SAFETY|REGULATORY|CUSTOMER_PREFERENCE|PROPERTY_ACCESS`',
    `note_status` STRING COMMENT 'Current lifecycle status of the note: ACTIVE (currently relevant and visible), ARCHIVED (retained for history but not actively displayed), DELETED (soft-deleted, retained for audit), EXPIRED (past expiration date, no longer applicable).. Valid values are `ACTIVE|ARCHIVED|DELETED|EXPIRED`',
    `note_text` STRING COMMENT 'Free-text content of the note entered by utility staff or generated by automated systems. May contain customer service observations, field crew instructions (e.g., dangerous dog, locked gate), dispute details, or special handling requirements.',
    `note_type_code` STRING COMMENT 'Classification of the note indicating its business purpose: GENERAL (routine account information), COLLECTIONS (payment or delinquency related), FIELD_SERVICE (field crew instructions or observations), COMPLAINT (customer complaint or dispute), LEGAL_HOLD (legal or regulatory restriction), MEDICAL_BASELINE (medical equipment dependency or special needs).. Valid values are `GENERAL|COLLECTIONS|FIELD_SERVICE|COMPLAINT|LEGAL_HOLD|MEDICAL_BASELINE`',
    `print_on_bill_flag` BOOLEAN COMMENT 'Indicates whether the note should be printed on the customers bill or included in bill messaging. True if note should appear on bill, False otherwise. Used for important customer communications (e.g., rate change notices, service reminders).',
    `priority_level` STRING COMMENT 'Urgency or importance level assigned to the note: LOW (informational), MEDIUM (standard attention), HIGH (requires prompt action), CRITICAL (immediate action required, safety or legal concern).. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `reviewed_flag` BOOLEAN COMMENT 'Indicates whether the note has been reviewed by a supervisor or quality assurance team member. True if reviewed, False if pending review. Used for quality control and training purposes.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the note was reviewed by a supervisor or QA team member. Null if not yet reviewed. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score ranging from -1.00 (very negative) to +1.00 (very positive), with 0.00 as neutral. Generated by natural language processing engine for customer-facing notes. Null if sentiment analysis not performed.',
    `visibility_level` STRING COMMENT 'Determines who can view the note: INTERNAL (utility staff only), EXTERNAL (visible to customer via self-service portal or printed on bill), RESTRICTED (limited to specific roles or departments, e.g., legal, management).. Valid values are `INTERNAL|EXTERNAL|RESTRICTED`',
    `workflow_trigger_flag` BOOLEAN COMMENT 'Indicates whether this note initiates an automated workflow or business process (e.g., escalation to supervisor, field service dispatch, collections hold). True if workflow is triggered, False otherwise.',
    CONSTRAINT pk_account_note PRIMARY KEY(`account_note_id`)
) COMMENT 'Free-text and structured notes attached to a customer account by utility staff or automated systems. Captures note type (general, collections, field service, complaint, legal hold, medical baseline, hazardous material), note text, note author (user ID), creation timestamp, visibility level (internal/external), and whether the note triggers a workflow or alert. Sourced from Oracle CC&B and Microsoft Dynamics 365 CRM. Supports customer service continuity, dispute resolution, and field crew awareness (e.g., dangerous dog, locked gate, medical equipment dependency).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for each customer interaction record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Customer inquiries about planned/ongoing CIP work in their area (timeline questions, service interruption notices, construction updates). Essential for public outreach tracking, stakeholder communicat',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Customer interactions may report violations or document utility response to violation-related inquiries—customer service and regulatory documentation requirement for tracking public complaints and res',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Customer interactions capture contact details that should reference the person master when the contact is a known person. This eliminates duplication of person contact information. Nullable as some in',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this interaction. Links to the customer account master record.',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Customer reports about hydrant problems (leaking, damaged, blocked access, vandalism) reference specific hydrant assets. Enables tracking of public-reported hydrant defects, prioritizing inspection/re',
    `employee_id` BIGINT COMMENT 'Identifier of the customer service agent or representative who handled the interaction. Null for self-service interactions.',
    `interaction_employee_id` BIGINT COMMENT 'Identifier of the customer service agent or representative who handled the interaction. Null for self-service interactions.',
    `network_valve_id` BIGINT COMMENT 'Foreign key linking to distribution.network_valve. Business justification: Customer reports about valve issues (leaking valve box, exposed valve, damaged cover) reference specific valve assets. Enables public-sourced defect identification, prioritizes valve maintenance, and',
    `order_id` BIGINT COMMENT 'Reference to a service request created as a result of this interaction. Null if no service request was generated.',
    `overflow_event_id` BIGINT COMMENT 'Foreign key linking to compliance.overflow_event. Business justification: Interactions capture customer reports of overflow events or utility communication about events affecting customers—event documentation and public notification tracking required for regulatory complian',
    `premise_id` BIGINT COMMENT 'Reference to the premise associated with this interaction. Null if interaction is not premise-specific.',
    `service_address_id` BIGINT COMMENT 'Reference to the service address associated with this interaction. Null if interaction is not address-specific.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Customer interactions may pertain to specific service agreements (e.g., questions about a particular service). This enables agreement-level interaction tracking. Nullable as some interactions are acco',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` (
    `customer_complaint_id` BIGINT COMMENT 'Unique identifier for the customer complaint record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Complaints during construction (noise, access disruption, water discoloration during commissioning) must be tracked against the causing project for resolution, public relations, and project closeout d',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Customer complaints (water quality, odor, service issues) can trigger or provide evidence for regulatory violations—documented linkage required for enforcement case files and regulatory reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user assigned as the resolution owner for this complaint.',
    `customer_employee_id` BIGINT COMMENT 'Reference to the employee or user assigned as the resolution owner for this complaint.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Aggregating complaints by DMA reveals water loss patterns, quality issues, and pressure problems at the zone level. Supports NRW reduction programs, leak detection prioritization, and proactive main r',
    `overflow_event_id` BIGINT COMMENT 'Foreign key linking to compliance.overflow_event. Business justification: Customer complaints reporting sewage backups, odors, or surface discharge are primary detection mechanism for SSO/CSO events—operational reality requiring documented linkage for regulatory reporting.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Water quality complaints (taste, odor, discoloration, pressure) routinely reference the specific distribution main where the issue originates. Operations teams use this for targeted flushing, leak det',
    `premise_id` BIGINT COMMENT 'Reference to the premise associated with the complaint.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Pressure-related complaints must reference the pressure zone for operational dispatch and system performance analysis. Enables zone-level complaint trending, identifies chronic low-pressure areas, and',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this complaint.',
    `order_id` BIGINT COMMENT 'Reference to the service order created to address customer-facing service actions related to the complaint, such as meter test, service reconnection, or billing adjustment.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to address the physical or operational issue underlying the complaint, such as a repair, inspection, or maintenance activity in IBM Maximo Asset Management (CMMS).',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Complaints capture reporter details that should reference the person master when the reporter is a known person. This eliminates duplication and enables proper reporter tracking. Nullable as some comp',
    `service_address_id` BIGINT COMMENT 'Reference to the service address where the complaint issue is occurring.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Complaints may relate to specific service agreements (e.g., billing disputes for a particular service type). This provides more granular complaint tracking for accounts with multiple agreements. Nulla',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Water quality complaints require facility-specific investigation and operator response. Linking complaints to serving facility enables proper routing to facility operators, coordinated sampling, and f',
    `actual_resolution_date` DATE COMMENT 'Actual date when the complaint was resolved and closed.',
    `assigned_date` DATE COMMENT 'Date when the complaint was assigned to a resolution owner.',
    `assigned_to_department` STRING COMMENT 'Department or functional area responsible for resolving the complaint, such as Customer Service, Water Quality, Distribution Operations and Maintenance (O&M), Billing, or Laboratory.',
    `billing_adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of billing adjustment or credit issued to the customer as a result of the complaint resolution, if applicable.',
    `compensation_provided_flag` BOOLEAN COMMENT 'Indicates whether any form of compensation, credit, or goodwill gesture was provided to the customer as part of the complaint resolution.',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint type. Water quality includes turbidity, discoloration, and contaminant concerns. Billing disputes cover charges, meter reads, and rate application. Service interruption includes planned and unplanned outages. Pressure issues cover low or high Pounds per Square Inch (PSI). Regulatory complaints are those escalated to state primacy agencies or Public Utilities Commission (PUC). [ENUM-REF-CANDIDATE: water_quality|billing_dispute|service_interruption|pressure_issue|odor_taste|leak|meter_accuracy|customer_service|regulatory|other — 10 candidates stripped; promote to reference product]',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the complaint as reported by the customer, including symptoms, duration, and customer concerns.',
    `complaint_number` STRING COMMENT 'Externally visible unique complaint tracking number assigned by the Customer Information System (CIS) or Customer Care and Billing (CC&B) system.',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the complaint in the resolution workflow. [ENUM-REF-CANDIDATE: open|in_progress|pending_customer|pending_investigation|resolved|closed|escalated|withdrawn — 8 candidates stripped; promote to reference product]',
    `contact_method` STRING COMMENT 'Channel through which the complaint was received by the utility. [ENUM-REF-CANDIDATE: phone|email|web_portal|mobile_app|in_person|mail|social_media — 7 candidates stripped; promote to reference product]',
    `corrective_action` STRING COMMENT 'Specific corrective action taken to address the root cause and prevent recurrence, such as infrastructure repair, meter replacement, billing adjustment, or process improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the complaint record was first created in the database.',
    `customer_satisfaction_comments` STRING COMMENT 'Free-text feedback provided by the customer regarding their satisfaction with the complaint resolution process and outcome.',
    `customer_satisfaction_rating` STRING COMMENT 'Customer satisfaction score provided by the customer after complaint resolution, typically on a scale of 1 to 5 or 1 to 10.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up action or customer contact to verify sustained resolution.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up action or monitoring is required after initial complaint resolution.',
    `internal_notes` STRING COMMENT 'Internal notes and comments for staff use, not visible to the customer, documenting investigation steps, coordination with other departments, and operational context.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the complaint record was last updated.',
    `priority_level` STRING COMMENT 'Urgency classification of the complaint based on health and safety risk, regulatory exposure, and customer impact. Critical includes Maximum Contaminant Level (MCL) exceedances and Sanitary Sewer Overflow (SSO) events.. Valid values are `critical|high|medium|low`',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency involved if the complaint was escalated, such as state Department of Environmental Quality, Public Utilities Commission (PUC), or U.S. Environmental Protection Agency (EPA).',
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
    `water_quality_test_result` STRING COMMENT 'Summary of water quality test results if testing was performed, including parameters tested such as pH, Nephelometric Turbidity Units (NTU), chlorine residual, Total Dissolved Solids (TDS), and whether results were within Maximum Contaminant Level (MCL) standards.',
    CONSTRAINT pk_customer_complaint PRIMARY KEY(`customer_complaint_id`)
) COMMENT 'Formal record of a customer complaint or grievance filed with the utility, including water quality complaints, billing disputes, service interruption complaints, pressure complaints, odor/taste complaints, and regulatory complaints escalated to the state primacy agency or PUC. Captures complaint number, complaint category, complaint description, reported date, assigned resolution owner, target resolution date, actual resolution date, resolution description, regulatory escalation flag, and customer satisfaction outcome. Distinct from customer_interaction (which captures all contacts) — a complaint has its own formal resolution workflow and regulatory reporting obligations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` (
    `account_hierarchy_id` BIGINT COMMENT 'Unique identifier for the account hierarchy relationship record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Account hierarchies (master-metered properties, consolidated billing for multi-family) require managerial approval. Financial control point and revenue protection. New FK needed; approved_by is string',
    `customer_account_id` BIGINT COMMENT 'Reference to the child account in the hierarchy. For corporate rollup structures, this is the subsidiary or division account. For master-sub meter arrangements, this is the sub-metered tenant account. For HOA structures, this is the individual unit owner account. For wholesale-retail relationships, this is the retail customer account.',
    `primary_customer_account_id` BIGINT COMMENT 'Reference to the parent account in the hierarchy. For corporate rollup structures, this is the master corporate account. For master-sub meter arrangements, this is the master meter account. For HOA structures, this is the common area account. For wholesale-retail relationships, this is the wholesale customer account.',
    `allocation_method` STRING COMMENT 'Method used to allocate shared costs or consumption from parent to child accounts. Proportional usage allocates based on relative consumption. Equal split divides costs evenly among children. Fixed percentage uses predefined allocation percentages. Custom formula applies business-specific calculation rules. Direct metered indicates child has dedicated meter with no allocation needed. Critical for master-sub meter billing and HOA common area cost allocation.. Valid values are `proportional_usage|equal_split|fixed_percentage|custom_formula|direct_metered`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Fixed percentage of parent account charges or consumption allocated to this child account when allocation method is fixed percentage. Value between 0.00 and 100.00. Sum of allocation percentages across all children under the same parent should equal 100.00 for balanced allocation. Used in HOA common area cost sharing and wholesale water distribution.',
    `approval_date` DATE COMMENT 'Date when the account hierarchy relationship was formally approved by authorized personnel. Used for audit trail and compliance verification. Must be on or before the effective start date.',
    `approval_status` STRING COMMENT 'Workflow state indicating whether the hierarchy relationship has been reviewed and approved by authorized personnel. Draft indicates initial setup. Pending approval indicates awaiting management review. Approved indicates authorized for activation. Rejected indicates denied and requires revision. Supports governance controls for corporate account structures and wholesale agreements.. Valid values are `draft|pending_approval|approved|rejected`',
    `billing_consolidation_flag` BOOLEAN COMMENT 'Indicates whether charges from the child account should be consolidated onto the parent account invoice. True means child account charges appear on parent bill. False means child account receives separate bill despite hierarchy relationship. Supports corporate consolidated billing and master meter billing arrangements.',
    `consumption_rollup_flag` BOOLEAN COMMENT 'Indicates whether child account consumption should be aggregated and reported at the parent account level for analytics and reporting. True enables corporate-level water usage tracking across multiple facilities. False keeps consumption reporting separate. Supports corporate sustainability reporting and wholesale customer usage monitoring.',
    `contract_reference_number` STRING COMMENT 'External reference to the legal contract, service agreement, or wholesale water purchase agreement that establishes this account hierarchy relationship. Links to physical contract documents stored in document management systems. Critical for wholesale-retail relationships and special contract arrangements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account hierarchy relationship record was first created in the data lakehouse. Supports audit trail and data lineage tracking. Distinct from effective start date which represents business effective date.',
    `effective_end_date` DATE COMMENT 'Date when the account hierarchy relationship ends and billing consolidation rules cease to apply. Null for open-ended relationships. Used for temporal queries, historical reporting, and automated relationship termination processing.',
    `effective_start_date` DATE COMMENT 'Date when the account hierarchy relationship becomes active and billing consolidation rules begin to apply. Used for temporal queries and historical reporting. Must be on or before the current date for active relationships.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this relationship in a multi-tier hierarchy structure. Level 1 represents the top-level parent. Level 2 represents immediate children. Level 3 and beyond represent nested sub-hierarchies. Enables recursive hierarchy traversal and reporting rollups.',
    `hierarchy_priority` STRING COMMENT 'Numeric ranking used to resolve conflicts when an account participates in multiple hierarchies. Lower numbers indicate higher priority. Used to determine which parent relationship takes precedence for billing consolidation when an account could roll up to multiple parents. Ensures deterministic processing in complex organizational structures.',
    `hierarchy_type` STRING COMMENT 'Classification of the account relationship structure. Corporate rollup supports consolidated billing for multi-location businesses. Master-sub meter supports properties with a master meter and individual tenant sub-meters. HOA common area links homeowner association common facilities to individual unit accounts. Wholesale-retail links bulk water purchasers to their retail distribution customers. Municipal department links city departments to the main municipal account. Irrigation district links agricultural water districts to individual grower accounts.. Valid values are `corporate_rollup|master_sub_meter|hoa_common_area|wholesale_retail|municipal_department|irrigation_district`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this account hierarchy relationship record was most recently updated in the data lakehouse. Supports change tracking and data quality monitoring. Updated whenever any attribute value changes.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special instructions, or business rules specific to this account hierarchy relationship. May include details about custom allocation formulas, billing exceptions, or historical context. Supports customer service representatives and billing analysts in understanding unique relationship characteristics.',
    `payment_responsibility` STRING COMMENT 'Defines which party in the hierarchy relationship is financially responsible for payment. Parent pays all means parent account is billed and responsible for all charges including children. Child pays own means each child receives and pays their own bill. Split responsibility means specific charges are assigned to parent or child based on charge type. Parent guarantees means child is billed but parent is backup guarantor. Critical for credit management and collections.. Valid values are `parent_pays_all|child_pays_own|split_responsibility|parent_guarantees`',
    `relationship_status` STRING COMMENT 'Current lifecycle state of the account hierarchy relationship. Active indicates the relationship is currently in effect and billing consolidation rules apply. Inactive indicates the relationship has been deactivated but may be reactivated. Pending indicates the relationship is awaiting approval or activation. Suspended indicates temporary hold due to billing disputes or service issues. Terminated indicates permanent closure of the relationship.. Valid values are `active|inactive|pending|suspended|terminated`',
    `source_system_code` STRING COMMENT 'Unique identifier of this account hierarchy relationship in the source operational system. Used for data integration, reconciliation, and traceability back to the system of record. Enables bidirectional synchronization between lakehouse and operational systems.',
    `termination_reason` STRING COMMENT 'Classification of why the account hierarchy relationship was ended. Customer request indicates voluntary termination. Service disconnection indicates termination due to service cutoff. Contract expiration indicates natural end of agreement term. Account closure indicates one or both accounts were closed. Organizational restructure indicates corporate changes. Billing dispute indicates termination due to payment conflicts. Supports root cause analysis and customer retention strategies.. Valid values are `customer_request|service_disconnection|contract_expiration|account_closure|organizational_restructure|billing_dispute`',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Defines parent-child relationships between customer accounts to support corporate account structures, master meter / sub-meter arrangements, HOA common-area accounts, and municipal wholesale customer hierarchies. Captures parent account, child account, hierarchy type (corporate rollup, master-sub meter, HOA, wholesale-retail), effective start date, effective end date, and billing consolidation flag. Enables consolidated billing, corporate account management, and wholesale customer reporting. Distinct from organization (which captures the legal entity) — account_hierarchy captures the billing and service relationship structure.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`deposit` (
    `deposit_id` BIGINT COMMENT 'Unique identifier for the customer_deposit data product (auto-inserted pre-linking).',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Customer deposits held in specific segregated bank accounts per state regulatory requirements and fiduciary duty. Essential for deposit reconciliation, interest calculation, and regulatory audit compl',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Deposits are collected from and held against customer accounts for credit management. This link is essential for deposit refund processing, account closure operations, credit evaluation, and customer',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Deposits recorded in specific funds per GASB requirements for restricted asset accounting. Necessary for financial statement preparation showing deposit liabilities segregated by fund type.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Security deposits may be tied to specific service agreements rather than just accounts. This allows tracking deposits at the agreement level for multi-agreement accounts. Nullable FK as some deposits',
    CONSTRAINT pk_deposit PRIMARY KEY(`deposit_id`)
) COMMENT 'Record of security deposits collected from customer accounts as a condition of service establishment or reinstatement. Captures deposit amount, deposit type (cash, surety bond, letter of credit), collection date, waiver reason (if waived), interest accrual rate, interest accrued to date, refund eligibility date, refund amount, refund date, and deposit status (held, partially refunded, fully refunded, applied to balance). Managed per state PUC tariff rules governing deposit collection and refund timelines. Distinct from billing payments — deposits are held in trust and are not revenue until forfeited.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` (
    `third_party_notification_id` BIGINT COMMENT 'Unique identifier for the third-party notification arrangement. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Third-party notification arrangements (for elderly/disabled customers) are set up by CSR staff. Regulatory requirement for vulnerable populations under state PUC rules. New FK needed; created_by_user',
    `customer_account_id` BIGINT COMMENT 'Reference to the water or wastewater service account for which this third-party notification arrangement is established.',
    `person_id` BIGINT COMMENT 'Foreign key linking to customer.person. Business justification: Third parties receiving notifications may be persons already in the system (e.g., family members, social workers). This FK links to person master when applicable. Nullable as many third parties are ex',
    `advance_notice_days` STRING COMMENT 'Number of days in advance the third party should be notified before a disconnection or service action, as required by regulation or agreement.',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the third-party notification arrangement.. Valid values are `active|inactive|suspended|expired|revoked|pending_approval`',
    `consent_date` DATE COMMENT 'Date on which the account holder provided consent for this third-party notification arrangement.',
    `consent_documentation_reference` STRING COMMENT 'Reference identifier or document number for the signed consent form or authorization from the account holder permitting third-party notification.',
    `consent_method` STRING COMMENT 'Method by which the account holder provided consent for third-party notification (e.g., written form, electronic signature, recorded verbal consent).. Valid values are `written_form|electronic_signature|verbal_recorded|online_portal|in_person`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this third-party notification arrangement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the third-party notification arrangement becomes active and notifications begin.',
    `email_address` STRING COMMENT 'Email address for electronic notification delivery to the third party.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expiration_date` DATE COMMENT 'Date on which the third-party notification arrangement expires or terminates, if applicable. Null for indefinite arrangements.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the system user or customer service representative who most recently modified this third-party notification arrangement record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this third-party notification arrangement record was most recently updated.',
    `last_notification_sent_date` TIMESTAMP COMMENT 'Timestamp of the most recent notification sent to the third party under this arrangement.',
    `last_notification_type` STRING COMMENT 'Type or category of the most recent notification sent to the third party (e.g., pre-disconnect, outage, boil-water notice).',
    `low_income_assistance_flag` BOOLEAN COMMENT 'Indicates whether this third-party notification arrangement is associated with a low-income assistance or affordability program.',
    `mailing_address_line_1` STRING COMMENT 'First line of the mailing address for postal notification delivery to the third party.',
    `mailing_address_line_2` STRING COMMENT 'Second line of the mailing address (suite, apartment, building) for postal notification delivery to the third party.',
    `mailing_city` STRING COMMENT 'City name for the third party mailing address.',
    `mailing_country_code` STRING COMMENT 'Three-letter ISO country code for the third party mailing address.',
    `mailing_postal_code` STRING COMMENT 'Postal or ZIP code for the third party mailing address.',
    `mailing_state_code` STRING COMMENT 'Two-letter state or province code for the third party mailing address.',
    `medical_baseline_program_flag` BOOLEAN COMMENT 'Indicates whether this third-party notification arrangement is associated with a medical baseline or life-support equipment program requiring special disconnection protections.',
    `notification_arrangement_number` STRING COMMENT 'Business-facing unique identifier or reference number for this third-party notification arrangement, used in customer service interactions and correspondence.',
    `notification_delivery_status` STRING COMMENT 'Status of the most recent notification delivery attempt to the third party.. Valid values are `delivered|failed|pending|bounced|undeliverable`',
    `notification_language_preference` STRING COMMENT 'Preferred language for delivering notifications to the third party (e.g., English, Spanish, Chinese).',
    `notification_method` STRING COMMENT 'Preferred method or channel for delivering notifications to the third party.. Valid values are `email|phone_call|sms|postal_mail|fax|portal_notification`',
    `notification_trigger_type` STRING COMMENT 'Type of event or condition that triggers notification to the third party (e.g., pre-disconnection notice, service outage, boil-water advisory, high consumption alert). [ENUM-REF-CANDIDATE: pre_disconnect|service_outage|boil_water_notice|water_quality_alert|high_usage_alert|payment_delinquency|all_service_alerts — 7 candidates stripped; promote to reference product]',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the third party for notifications.',
    `priority_notification_flag` BOOLEAN COMMENT 'Indicates whether this third-party notification arrangement requires priority or expedited notification due to medical, safety, or regulatory reasons.',
    `relationship_to_account_holder` STRING COMMENT 'Type of relationship the third party has to the account holder, defining their role and authority in the notification arrangement. [ENUM-REF-CANDIDATE: social_service_agency|property_manager|medical_guardian|landlord|family_member|legal_representative|caregiver|other — 8 candidates stripped; promote to reference product]',
    `revocation_date` DATE COMMENT 'Date on which the account holder or third party revoked the notification arrangement, if applicable.',
    `revocation_reason` STRING COMMENT 'Reason provided for revoking the third-party notification arrangement (e.g., account holder request, third party request, relationship ended, service terminated).',
    `secondary_contact_phone` STRING COMMENT 'Secondary or alternate telephone number for reaching the third party if primary contact fails.',
    `special_instructions` STRING COMMENT 'Free-text field for any special instructions, notes, or requirements related to notifying the third party (e.g., specific contact hours, escalation procedures, accessibility accommodations).',
    `third_party_name` STRING COMMENT 'Full legal or organizational name of the third party designated to receive notifications (e.g., social service agency, property manager, medical guardian, landlord).',
    `third_party_organization_name` STRING COMMENT 'Name of the organization the third party represents, if applicable (e.g., county social services department, property management company).',
    CONSTRAINT pk_third_party_notification PRIMARY KEY(`third_party_notification_id`)
) COMMENT 'Record of third-party notification arrangements where a designated third party (social service agency, property manager, medical guardian, landlord) is to be notified before service disconnection or in the event of a service disruption. Captures third-party name, relationship to account holder, contact information, notification trigger type (pre-disconnect, outage, boil-water notice), notification method, effective date, expiration date, and consent documentation reference. Required for compliance with state PUC consumer protection rules and ADA/medical baseline programs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`account_document` (
    `account_document_id` BIGINT COMMENT 'Unique identifier for the account document record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the document.',
    `account_employee_id` BIGINT COMMENT 'Identifier of the user or system account that uploaded the document.',
    `account_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the document record.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Easement agreements, developer agreements, connection fee receipts, construction impact waivers, or temporary service agreements tied to specific CIP projects. Essential for project legal documentatio',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account to which this document is associated. Links to the account master record.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Enforcement action documents (NOVs, consent orders, compliance schedules) are stored with affected customer accounts—regulatory document retention requirement and operational necessity for account man',
    `primary_account_employee_id` BIGINT COMMENT 'Identifier of the user or system account that uploaded or submitted the document. May be a customer portal user ID, employee ID, or system account.',
    `invoice_id` BIGINT COMMENT 'Reference to an invoice associated with this document, such as billing statements or payment receipts.',
    `order_id` BIGINT COMMENT 'Reference to a service order associated with this document, such as service application approvals or connection agreements.',
    `work_order_id` BIGINT COMMENT 'Reference to a work order associated with this document, such as meter installation reports or service connection documentation.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Documents may be specific to service agreements (e.g., signed agreement contracts, service-specific certifications). This allows proper document organization at the agreement level. Nullable as many d',
    `superseded_account_document_id` BIGINT COMMENT 'Self-referencing FK on account_document (superseded_account_document_id)',
    `tertiary_account_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system that created this document record. Audit trail field.',
    `access_restriction_notes` STRING COMMENT 'Free-text notes describing any special access restrictions, handling instructions, or confidentiality requirements for the document.',
    `accessibility_format_flag` BOOLEAN COMMENT 'Indicates whether the document is available in an accessible format such as large print, braille, or audio for customers with disabilities.',
    `approved_by_user_name` STRING COMMENT 'Full name of the user who approved the document for audit and accountability purposes.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the document was officially approved for use or distribution.',
    `ccr_delivery_flag` BOOLEAN COMMENT 'Indicates whether this document is part of the annual Consumer Confidence Report (CCR) delivery requirement under the Safe Drinking Water Act (SDWA).',
    `checksum_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the document file to ensure integrity and detect tampering or corruption.',
    `compliance_program_code` STRING COMMENT 'Code identifying the regulatory compliance program or requirement that this document supports. Examples include LCRR (Lead and Copper Rule Revisions), IUP (Industrial User Permit), NPDES (National Pollutant Discharge Elimination System), SDWA (Safe Drinking Water Act), CWA (Clean Water Act), and PUC audit requirements. [ENUM-REF-CANDIDATE: LCRR|IUP|NPDES|SDWA|CWA|PUC_AUDIT|LOW_INCOME_ASSISTANCE|OTHER — 8 candidates stripped; promote to reference product]',
    `confidentiality_level` STRING COMMENT 'Classification level indicating the sensitivity and access restrictions for the document. Aligns with organizational data classification policy.. Valid values are `PUBLIC|INTERNAL|CONFIDENTIAL|RESTRICTED`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this document record was first created in the system. Audit trail field for record creation.',
    `customer_visible_flag` BOOLEAN COMMENT 'Indicates whether the document is visible or accessible to the customer through self-service portals or upon request.',
    `digital_signature_present_flag` BOOLEAN COMMENT 'Indicates whether the document contains a digital signature for authentication and non-repudiation purposes.',
    `document_category` STRING COMMENT 'High-level categorization of the document for organizational and retrieval purposes.. Valid values are `regulatory|billing|service|compliance|legal|operational`',
    `document_date` DATE COMMENT 'The official date of the document as indicated on the document itself, such as the signature date, issuance date, or effective date. Represents the business event date of the document.',
    `document_description` STRING COMMENT 'Detailed description of the document content, purpose, or context. Provides additional information beyond the title.',
    `document_notes` STRING COMMENT 'General free-text notes or comments about the document. Used for additional context, processing instructions, or special handling requirements.',
    `document_number` STRING COMMENT 'Business-assigned unique identifier or reference number for the document, used for tracking and retrieval purposes.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document. Indicates whether the document is pending review, verified, approved, rejected, expired, superseded by a newer version, or archived. [ENUM-REF-CANDIDATE: PENDING_REVIEW|VERIFIED|APPROVED|REJECTED|EXPIRED|SUPERSEDED|ARCHIVED — 7 candidates stripped; promote to reference product]',
    `document_title` STRING COMMENT 'Human-readable title or name of the document, providing a brief description of its content or purpose.',
    `document_type` STRING COMMENT 'Classification of the document type. Examples include service agreements, rate schedules, Consumer Confidence Reports (CCR), Industrial User Permits (IUP), backflow prevention certificates, meter test reports, and compliance notices. [ENUM-REF-CANDIDATE: service_agreement|rate_schedule|tariff|deposit_receipt|payment_plan|lien_notice|ccr|iup_permit|backflow_certificate|meter_test_report|compliance_notice|correspondence|other — 13 candidates stripped; promote to reference product]',
    `document_type_code` STRING COMMENT 'Classification code indicating the type of document. Examples include service agreements, signed applications, identity verification documents, income certification forms, Lead and Copper Rule Revisions (LCRR) lead service line notification acknowledgments, Industrial User Permit (IUP) permits, and legal correspondence. [ENUM-REF-CANDIDATE: SERVICE_AGREEMENT|APPLICATION|IDENTITY_VERIFICATION|INCOME_CERTIFICATION|LCRR_NOTIFICATION|IUP_PERMIT|LEGAL_CORRESPONDENCE|PAYMENT_ARRANGEMENT|BACKFLOW_PERMIT|EASEMENT|METER_INSTALLATION|CONSTRUCTION_PERMIT|WAIVER_FORM|CONSENT_FORM|OTHER — promote to reference product]',
    `effective_date` DATE COMMENT 'Date when the document becomes effective or enforceable, particularly relevant for agreements, rate schedules, and regulatory documents.',
    `expiration_date` DATE COMMENT 'Date when the document expires or is no longer valid. Applicable to permits, certifications, and time-limited agreements. Null for documents without expiration.',
    `file_format` STRING COMMENT 'File format or MIME type of the document. Common formats include PDF, DOCX, JPEG, PNG, TIFF, and XML. [ENUM-REF-CANDIDATE: PDF|DOCX|DOC|JPEG|JPG|PNG|TIFF|TIF|XML — 9 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'Original file name of the uploaded document, including file extension. Preserves the name provided at upload time.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes. Used for storage management and validation purposes.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the document is written.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this document record was last modified. Audit trail field for record updates.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the document is subject to a legal hold and must not be destroyed or altered due to pending or active litigation, investigation, or audit.',
    `notarization_date` DATE COMMENT 'Date when the document was notarized. Null if not notarized or notarization not required.',
    `notarization_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the document requires notarization. True if notarization is required.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context related to the document.',
    `print_on_bill_flag` BOOLEAN COMMENT 'Indicates whether the document or a reference to it should be printed on the customer bill.',
    `regulatory_reference_number` STRING COMMENT 'External reference number assigned by a regulatory agency or governing body, such as permit numbers, docket numbers, or compliance case identifiers.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this document is required for regulatory compliance purposes (e.g., LCRR lead notification documentation, IUP compliance records, PUC audit requirements). True if the document is regulatory-mandated.',
    `retention_expiration_date` DATE COMMENT 'Date when the document retention period expires and the document may be eligible for deletion or archival per records retention policy. Supports compliance with Public Utilities Commission (PUC) audit requirements and regulatory retention schedules.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory or internal policy requirements before eligible for destruction.',
    `signature_captured_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a signature has been captured on the document. True if signature is present.',
    `signature_date` DATE COMMENT 'Date when the document was signed by the customer or authorized party. Null if not signed or signature not required.',
    `signature_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the document requires a customer or authorized party signature. True if signature is required.',
    `source_system_code` STRING COMMENT 'Code identifying the source system or application from which this document record originated. Examples include CC&B (Customer Care and Billing), CIS (Customer Information System), DMS (Document Management System), or web portal.',
    `storage_location_uri` STRING COMMENT 'Uniform Resource Identifier (URI) or path to the physical or cloud storage location where the document is stored.',
    `storage_reference` STRING COMMENT 'Reference path or key to the physical document storage location. May be a document management system (DMS) path, object store key (e.g., S3 bucket path), or file system path. Used for document retrieval.',
    `upload_channel` STRING COMMENT 'Channel or method through which the document was submitted or uploaded. Examples include web portal, mobile app, email, fax, mail scan, in-person submission, call center, or field service. [ENUM-REF-CANDIDATE: WEB_PORTAL|MOBILE_APP|EMAIL|FAX|MAIL_SCAN|IN_PERSON|CALL_CENTER|FIELD_SERVICE — 8 candidates stripped; promote to reference product]',
    `upload_timestamp` TIMESTAMP COMMENT 'Date and time when the document was uploaded or received into the system. Represents the business event timestamp for document receipt.',
    `uploaded_by_name` STRING COMMENT 'Name of the person or system that uploaded the document. Provides human-readable context for the uploader.',
    `uploaded_by_user_name` STRING COMMENT 'Full name of the user who uploaded the document for audit and accountability purposes.',
    `uploaded_timestamp` TIMESTAMP COMMENT 'Timestamp when the document was uploaded or ingested into the system.',
    `verification_status` STRING COMMENT 'Status indicating whether the document has been verified for authenticity, completeness, and compliance. Used for identity verification documents, income certifications, and regulatory compliance documents.. Valid values are `NOT_VERIFIED|VERIFIED|FAILED|PENDING`',
    `verified_timestamp` TIMESTAMP COMMENT 'Date and time when the document was verified. Null if the document has not yet been verified.',
    `version_number` STRING COMMENT 'Version number of the document. Increments when a new version of the same document is uploaded. Supports document version control.',
    CONSTRAINT pk_account_document PRIMARY KEY(`account_document_id`)
) COMMENT 'Master reference table for account_document. ';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` (
    `customer_program_enrollment_id` BIGINT COMMENT 'Primary key for customer_program_enrollment',
    `conservation_program_id` BIGINT COMMENT 'Foreign key linking to the conservation program in which the customer is enrolled',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer account enrolled in the conservation program',
    `service_program_enrollment_id` BIGINT COMMENT 'Unique identifier for each customer enrollment in a conservation program. Primary key for the enrollment relationship.',
    `certification_status` STRING COMMENT 'Status of certification or verification for the customers compliance with program requirements (e.g., installation verification for rebate programs). Explicitly identified in detection phase relationship data.',
    `enrollment_date` DATE COMMENT 'Date when the customer account enrolled in the conservation program. Explicitly identified in detection phase relationship data.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the customers enrollment in the program (active, pending, completed, cancelled, suspended). Explicitly identified in detection phase relationship data.',
    `incentive_amount_received` DECIMAL(18,2) COMMENT 'Actual monetary incentive amount disbursed to this customer for this specific program enrollment. Explicitly identified in detection phase relationship data.',
    `participation_end_date` DATE COMMENT 'Date when the customer completed or exited the conservation program. Null for ongoing enrollments. Explicitly identified in detection phase relationship data.',
    `participation_start_date` DATE COMMENT 'Date when the customer began active participation in the conservation program activities. Explicitly identified in detection phase relationship data.',
    `rebate_payment_date` DATE COMMENT 'Date when the rebate or incentive payment was issued to the customer for this program enrollment. Explicitly identified in detection phase relationship data.',
    `water_savings_achieved_gallons` BIGINT COMMENT 'Measured or estimated water savings in gallons achieved by this specific customer through this specific program enrollment. Used for program performance reporting and regulatory compliance. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_customer_program_enrollment PRIMARY KEY(`customer_program_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between customer accounts and conservation programs in the water utility. It captures the operational process of customers enrolling in water conservation programs (rebates, audits, incentives) and tracks participation lifecycle, incentive disbursement, and water savings achievement. Each record links one customer account to one conservation program with attributes that exist only in the context of this enrollment relationship.. Existence Justification: In water utility operations, customers routinely enroll in multiple conservation programs simultaneously (e.g., a residential customer participates in toilet rebate program, irrigation audit program, and smart controller incentive program at the same time). Each conservation program has hundreds or thousands of participating customer accounts. The utility actively manages these enrollments as operational business entities, tracking enrollment lifecycle, processing rebate payments, verifying installations, and measuring water savings per customer-program combination for regulatory reporting and program performance analysis.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` (
    `account_enforcement_impact_id` BIGINT COMMENT 'Unique identifier for this account-enforcement impact record. Primary key.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key to compliance.enforcement_action identifying the regulatory action',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the affected customer account',
    `account_restriction_type` STRING COMMENT 'Type of operational restriction imposed on this account as a result of the enforcement action. Values: SERVICE_SUSPENSION (service temporarily halted), BILLING_HOLD (billing suspended pending resolution), NEW_CONNECTION_BLOCK (no new service connections allowed), USAGE_RESTRICTION (volumetric limits imposed), DISCHARGE_LIMIT (wastewater discharge restrictions for industrial accounts), NONE (no restrictions)',
    `affected_service_count` BIGINT COMMENT 'Number of active service connections at this account affected by the enforcement action (e.g., water service, wastewater service, stormwater service)',
    `customer_response_due_date` DATE COMMENT 'Deadline by which the customer must respond or complete required actions. Null if no customer response is required.',
    `customer_response_received_date` DATE COMMENT 'Date the utility received the required response or confirmation of action completion from the customer. Null if response not yet received or not required.',
    `customer_response_required_flag` BOOLEAN COMMENT 'Indicates whether the customer account holder is required to take specific action or provide information in response to the enforcement action (e.g., industrial customer must submit discharge monitoring reports, commercial customer must install backflow prevention)',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact to this specific customer account resulting from the enforcement action, including service interruption costs, billing adjustments, or account-level penalties',
    `impact_resolution_date` DATE COMMENT 'Date when all account-level impacts from the enforcement action were fully resolved (restrictions lifted, financial impacts settled, customer actions completed). Null if impact is ongoing.',
    `impact_severity` STRING COMMENT 'Severity level of the enforcement action impact on this specific account. CRITICAL (service interruption or health/safety risk), HIGH (significant operational or financial impact), MEDIUM (moderate restrictions or costs), LOW (minor administrative impact), MINIMAL (informational only)',
    `notes` STRING COMMENT 'Free-text notes documenting account-specific details of the enforcement action impact, customer communications, special circumstances, or resolution details',
    `notification_date` DATE COMMENT 'Date the customer account holder was notified of the enforcement action impact. Null if notification has not been sent.',
    `notification_method` STRING COMMENT 'Method used to notify the customer account holder. Values: MAIL (postal mail), EMAIL (electronic mail), PHONE (telephone call), IN_PERSON (face-to-face meeting), PUBLIC_NOTICE (public posting or media), BILL_INSERT (notice included with bill)',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the customer account holder was formally notified of the enforcement action and its impact on their service. Required for regulatory compliance and customer communication tracking.',
    `restriction_end_date` DATE COMMENT 'Date when account-level restrictions were lifted or are scheduled to be lifted. Null if restrictions are ongoing or no restrictions were imposed.',
    `restriction_start_date` DATE COMMENT 'Date when account-level restrictions resulting from the enforcement action became effective. Null if no restrictions imposed.',
    CONSTRAINT pk_account_enforcement_impact PRIMARY KEY(`account_enforcement_impact_id`)
) COMMENT 'This association product represents the impact relationship between customer accounts and regulatory enforcement actions. It captures account-specific consequences when enforcement actions affect service delivery, billing, or operational restrictions at the account level. Each record links one customer_account to one enforcement_action with attributes that exist only in the context of this specific impact relationship, including service restrictions, financial impacts, and customer notification requirements.. Existence Justification: In water utility operations, a single enforcement action (e.g., consent order for NPDES permit violation at a treatment facility) can simultaneously impact multiple customer accounts served by that facility, requiring account-specific notifications, service restrictions, and impact tracking. Conversely, a single customer account (particularly large industrial or commercial accounts) can be subject to multiple concurrent enforcement actions addressing different violations (e.g., separate actions for discharge limit violations, reporting failures, and stormwater permit violations). The utility must actively manage these account-enforcement relationships to coordinate customer notifications, implement service restrictions, track financial impacts, and document customer responses.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` (
    `premise_overflow_impact_id` BIGINT COMMENT 'Unique identifier for this premise-overflow impact record. Primary key.',
    `overflow_event_id` BIGINT COMMENT 'Foreign key linking to the overflow event',
    `premise_id` BIGINT COMMENT 'Foreign key linking to the affected premise',
    `cleanup_completion_date` DATE COMMENT 'Date when cleanup or remediation was completed at this premise. Null if cleanup was not required. Explicitly identified in detection reasoning.',
    `cleanup_required_flag` BOOLEAN COMMENT 'Indicates whether cleanup or remediation was required at this specific premise as a result of the overflow event. Explicitly identified in detection reasoning.',
    `customer_compensation_amount` DECIMAL(18,2) COMMENT 'Dollar amount of compensation provided to the customer at this premise due to the overflow impact. Explicitly identified in detection reasoning.',
    `impact_severity` STRING COMMENT 'Severity level of the impact to this specific premise from this overflow event. Explicitly identified in detection reasoning.',
    `impact_type` STRING COMMENT 'Classification of the type of impact this overflow event had on this specific premise. Explicitly identified in detection reasoning.',
    `notification_date` DATE COMMENT 'Date when the customer/occupant of this premise was notified about the overflow event. Explicitly identified in detection reasoning.',
    `notification_method` STRING COMMENT 'Method used to notify the customer at this premise about the overflow event. Explicitly identified in detection reasoning.',
    CONSTRAINT pk_premise_overflow_impact PRIMARY KEY(`premise_overflow_impact_id`)
) COMMENT 'This association product represents the impact relationship between a premise and an overflow event (SSO/CSO). It captures premise-specific impact details, customer notifications, and remediation actions required for regulatory compliance and customer service. Each record links one premise to one overflow event with attributes that exist only in the context of this specific impact occurrence.. Existence Justification: In water utility operations, a single SSO/CSO overflow event can impact multiple downstream premises (contamination spreads to multiple properties, multiple addresses in affected area require notification), and a single premise can be affected by multiple overflow events over time (recurring issues, different event causes). The utility must track premise-specific impact details, customer notifications, and remediation for each premise-event combination to meet NPDES regulatory reporting requirements and manage customer service obligations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` (
    `sampling_participation_id` BIGINT COMMENT 'Unique identifier for this sampling participation record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer account participating in the sampling program',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to the sampling plan in which the customer is enrolled',
    `access_instructions` STRING COMMENT 'Site-specific instructions for laboratory staff to access the customers property for sample collection, including gate codes, contact procedures, preferred sampling times, and special access requirements. Explicitly identified in detection phase relationship data.',
    `effective_end_date` DATE COMMENT 'Date when this participation record ends or is scheduled to end. Nullable for ongoing participation.',
    `effective_start_date` DATE COMMENT 'Date when this participation record becomes active and sample collection should begin.',
    `enrollment_date` DATE COMMENT 'Date when the customer account was enrolled in this sampling plan. Explicitly identified in detection phase relationship data.',
    `last_sample_collected_date` DATE COMMENT 'Date of the most recent sample collection event at this customer location under this sampling plan. Used to calculate next scheduled sampling date and track compliance.',
    `next_scheduled_sample_date` DATE COMMENT 'Date of the next scheduled sample collection event at this customer location under this sampling plan. Calculated based on sampling frequency and last collection date.',
    `notification_preference` STRING COMMENT 'Customers preferred method for receiving notifications about upcoming sampling events, results, and program updates. Explicitly identified in detection phase relationship data.',
    `participation_notes` STRING COMMENT 'Free-text field for operational notes about this customers participation, including special circumstances, historical issues, or coordination requirements.',
    `participation_status` STRING COMMENT 'Current status of the customers participation in this sampling plan: enrolled (registered but not yet active), active (currently participating), suspended (temporarily paused), withdrawn (customer opted out), completed (sampling program concluded). Explicitly identified in detection phase relationship data.',
    `sampling_frequency_override` STRING COMMENT 'Customer-specific override of the default sampling frequency defined in the sampling plan. Used when a particular customer requires more or less frequent sampling due to site-specific conditions or regulatory requirements. Explicitly identified in detection phase relationship data.',
    `total_samples_collected` STRING COMMENT 'Cumulative count of sample collection events completed at this customer location under this sampling plan. Used for compliance reporting and program tracking.',
    `volunteer_consent_date` DATE COMMENT 'Date when the customer provided formal consent to participate in the sampling program, particularly important for voluntary programs and residential tap sampling under LCRR. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_sampling_participation PRIMARY KEY(`sampling_participation_id`)
) COMMENT 'This association product represents the enrollment and participation of customer accounts in regulatory and voluntary water quality sampling programs. It captures the operational relationship between a customer account and a sampling plan, including consent, access arrangements, notification preferences, and participation status. Each record links one customer_account to one sampling_plan with attributes that exist only in the context of this participation relationship. Critical for LCRR compliance, lead/copper monitoring, and voluntary sampling programs.. Existence Justification: In water utility operations, customer accounts participate in multiple sampling plans simultaneously (e.g., a residential customer may be enrolled in LCRR Tier 1 lead/copper monitoring, seasonal DBP monitoring, and voluntary PFAS testing), and each sampling plan involves many customer accounts across the service territory. The utility actively manages these enrollments as operational records, tracking consent, access arrangements, notification preferences, and participation status for each customer-plan combination. This is a recognized business process called Sampling Program Enrollment or Sampling Participation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` (
    `account_asset_responsibility_id` BIGINT COMMENT 'Unique surrogate primary key for each account-asset responsibility record',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer account that has responsibility for the asset',
    `registry_id` BIGINT COMMENT 'Foreign key linking to the physical infrastructure asset for which responsibility is assigned',
    `billing_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this account receives bills for asset-related charges (true) or if another account is billed (false). In master-metered scenarios, the master account may be billed while sub-accounts have usage responsibility',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate asset-related costs (maintenance, replacement, depreciation) to this account: PERCENTAGE (based on ownership_percentage), EQUAL_SPLIT (divided equally among all responsible accounts), USAGE_BASED (proportional to metered usage), FIXED_AMOUNT (predetermined fixed cost), CUSTOM (special arrangement)',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this responsibility record was created in the system',
    `effective_end_date` DATE COMMENT 'Date when this responsibility relationship ended or will end. NULL indicates current active responsibility. Used for tracking responsibility history and managing transitions during property sales or account consolidations',
    `effective_start_date` DATE COMMENT 'Date when this responsibility relationship became effective. Used for historical tracking of asset responsibility changes due to property transfers, account splits, or infrastructure ownership changes',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this responsibility record',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this responsibility record',
    `maintenance_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this account is responsible for maintenance and repair of the asset (true) or if maintenance is handled by the utility (false). Critical for determining who responds to asset failures and who bears repair costs',
    `notes` STRING COMMENT 'Free-text notes documenting special arrangements, legal agreements, or context for this responsibility relationship (e.g., Per HOA agreement dated 2019-03-15, Shared lateral serving units 101-104)',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership or cost responsibility this account holds for the asset (0.00 to 100.00). Used for shared assets where multiple accounts split costs proportionally (e.g., HOA shared infrastructure, multi-tenant buildings)',
    `responsibility_type` STRING COMMENT 'Classification of the responsibility relationship: OWNER (full ownership), SHARED_OWNER (co-ownership with other accounts), MAINTENANCE_ONLY (maintenance responsibility without ownership), COST_ALLOCATION (cost sharing arrangement), MASTER_METER (master-metered multi-unit property)',
    `created_by` STRING COMMENT 'User ID or system identifier that created this responsibility record',
    CONSTRAINT pk_account_asset_responsibility PRIMARY KEY(`account_asset_responsibility_id`)
) COMMENT 'This association product represents the shared responsibility relationship between customer accounts and physical infrastructure assets in water utilities. It captures scenarios where multiple accounts share responsibility for assets (HOA-owned private mains, shared laterals in multi-unit buildings, master-metered properties) or where large commercial/industrial accounts have responsibility for multiple assets (meters, backflow devices, private fire lines). Each record links one customer account to one asset with attributes defining the nature and extent of responsibility.. Existence Justification: In water utilities, multiple customer accounts can legitimately share responsibility for physical infrastructure assets (HOA-owned private mains serving multiple accounts, shared service laterals in multi-unit buildings, master-metered properties with sub-accounts). Conversely, large commercial/industrial accounts routinely have responsibility for multiple distinct assets (multiple meters, backflow prevention devices, private fire service lines, on-site treatment equipment). This is an operational relationship that customer service, billing, and asset management teams actively manage.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` (
    `sampling_site_id` BIGINT COMMENT 'Unique identifier for this customer-sampling point relationship record',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer account that owns or occupies the premises where sampling occurs',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to the water quality sampling location at the customer premises',
    `rotation_pool_id` BIGINT COMMENT 'Identifier for the sampling site rotation pool to which this customer-sampling point relationship belongs for LCRR compliance',
    `access_authorization_status` STRING COMMENT 'Current status of the utilitys authorization to access the customer premises for sampling purposes',
    `contact_name` STRING COMMENT 'Name of the specific contact person at this customer location for sampling coordination (may differ from account holder)',
    `contact_phone` STRING COMMENT 'Phone number for the site contact to coordinate sampling appointments',
    `customer_consent_date` DATE COMMENT 'Date when the customer provided written consent to participate in the water quality sampling program at this location',
    `last_sample_collected_date` DATE COMMENT 'Most recent date when a sample was successfully collected from this customer-sampling point combination',
    `next_scheduled_sample_date` DATE COMMENT 'Next planned sampling date for this customer-sampling point relationship based on regulatory frequency and rotation schedule',
    `notification_preference` STRING COMMENT 'Customers preferred method for receiving sampling appointment notifications and results',
    `participation_status` STRING COMMENT 'Current status of the customers participation in the sampling program at this specific location',
    `preferred_sampling_time` TIMESTAMP COMMENT 'Customers preferred time window for sampling visits (e.g., weekday mornings, weekends only) to coordinate access',
    `sampling_frequency_override` STRING COMMENT 'Site-specific sampling frequency that may differ from the standard regulatory schedule due to tier classification, previous exceedances, or voluntary monitoring',
    `site_activation_date` DATE COMMENT 'Date when this customer-sampling point relationship became active for regulatory monitoring purposes',
    `site_deactivation_date` DATE COMMENT 'Date when this customer-sampling point relationship was terminated due to customer withdrawal, property sale, or site rotation requirements',
    `special_access_instructions` STRING COMMENT 'Site-specific instructions for utility personnel to access the sampling location (gate codes, parking, entry procedures)',
    `tier_classification` STRING COMMENT 'Lead and Copper Rule Revisions tier classification for this customer tap site based on service line material and building plumbing risk factors',
    CONSTRAINT pk_sampling_site PRIMARY KEY(`sampling_site_id`)
) COMMENT 'This association product represents the regulatory compliance agreement between a customer account and a water quality sampling point. It captures customer consent, access authorization, and sampling coordination for Lead and Copper Rule (LCR) and Lead and Copper Rule Revisions (LCRR) compliance monitoring. Each record links one customer_account to one sampling_point with attributes that govern the sampling relationship, site rotation schedules, and customer participation terms.. Existence Justification: Water utilities must maintain pools of customer tap sampling sites for Lead and Copper Rule (LCR/LCRR) compliance monitoring. A single customer account can have multiple sampling points (e.g., kitchen tap, bathroom tap, outdoor spigot at different tier classifications), and a single sampling point can be associated with multiple customer accounts over time due to property transfers, tenant changes, and regulatory site rotation requirements. The utility actively manages these relationships with consent agreements, access authorizations, and sampling schedules.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` (
    `grant_enrollment_id` BIGINT COMMENT 'Unique identifier for this customer grant enrollment record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer account receiving grant assistance',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the grant program providing financial assistance',
    `benefit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of financial assistance provided to this customer account under this grant enrollment. Explicitly identified in detection phase relationship data.',
    `certification_status` STRING COMMENT 'Current status of the customers eligibility certification for this grant program (pending, certified, expired, revoked, under_review). Explicitly identified in detection phase relationship data.',
    `eligibility_period_end` DATE COMMENT 'End date of the period during which this customer account is eligible for benefits under this grant. Explicitly identified in detection phase relationship data.',
    `eligibility_period_start` DATE COMMENT 'Start date of the period during which this customer account is eligible for benefits under this grant. Explicitly identified in detection phase relationship data.',
    `enrollment_date` DATE COMMENT 'Date when the customer account was enrolled in this grant program. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_grant_enrollment PRIMARY KEY(`grant_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between customer accounts and financial assistance grants in water utility operations. It captures the participation of individual customer accounts in utility assistance programs (LIHWAP, LIHEAP, weatherization assistance) where customers receive financial aid for water/wastewater bills. Each record links one customer account to one grant program with enrollment dates, benefit amounts, eligibility periods, and certification status that exist only in the context of this specific enrollment.. Existence Justification: In water utility operations, customer accounts can be enrolled in multiple financial assistance grant programs simultaneously (e.g., LIHWAP for arrears, LIHEAP for ongoing bills, weatherization assistance), and each grant program serves multiple customer accounts. The utility actively manages these enrollments as operational records, tracking enrollment dates, benefit amounts paid to each customer, eligibility periods, and certification status for each customer-grant combination.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` (
    `project_stakeholder_id` BIGINT COMMENT 'Unique system identifier for the project stakeholder engagement record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to the CIP project for which the organization is a stakeholder',
    `organization_id` BIGINT COMMENT 'Foreign key linking to the organization serving as a stakeholder in the CIP project',
    `engagement_end_date` DATE COMMENT 'Date when stakeholder engagement concluded, typically at project closeout or when the organizations involvement ended. Null for ongoing stakeholder relationships.',
    `engagement_level` STRING COMMENT 'IAP2 spectrum classification of stakeholder engagement intensity: inform (one-way communication), consult (feedback solicited), involve (concerns directly reflected in decisions), collaborate (partnership in decision-making), empower (final decision authority delegated). Explicitly identified in detection phase.',
    `engagement_start_date` DATE COMMENT 'Date when the organization was formally identified as a stakeholder and engagement activities commenced. Used for tracking engagement timeline and compliance with notification requirements.',
    `impact_severity` STRING COMMENT 'Assessment of the projects impact on the stakeholder organization: none (no direct impact), low (minor inconvenience), moderate (temporary service disruption), high (significant operational impact), critical (major business disruption requiring mitigation). Explicitly identified in detection phase.',
    `last_engagement_date` DATE COMMENT 'Date of the most recent engagement activity with this stakeholder (meeting, notification, consultation). Used for tracking engagement frequency and compliance.',
    `mitigation_agreement_reference` STRING COMMENT 'Reference number or identifier for formal mitigation agreements, MOUs, or impact compensation arrangements between the utility and the stakeholder organization. Null if no formal agreement exists. Explicitly identified in detection phase.',
    `next_engagement_due_date` DATE COMMENT 'Scheduled date for the next required engagement activity with this stakeholder. Used for proactive stakeholder management and compliance with engagement commitments.',
    `notes` STRING COMMENT 'Free-text field for project managers to document stakeholder concerns, engagement history, special requirements, or other contextual information relevant to managing this stakeholder relationship.',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether the organization must receive formal project notifications (construction schedules, service interruptions, public meetings) per regulatory requirements or stakeholder agreements. Explicitly identified in detection phase.',
    `primary_contact_email` STRING COMMENT 'Email address for the project-specific contact within the stakeholder organization. Used for project notifications and engagement communications.',
    `primary_contact_name` STRING COMMENT 'Name of the specific individual within the stakeholder organization who serves as the primary point of contact for this project. May differ from the organizations general primary contact.',
    `primary_contact_phone` STRING COMMENT 'Phone number for the project-specific contact within the stakeholder organization. Used for urgent project communications.',
    `stakeholder_role` STRING COMMENT 'Classification of the organizations role in the project: affected_party (impacted by construction or service changes), contributor (providing resources or expertise), permitting_authority (regulatory approval required), funding_partner (co-funding the project), community_representative (HOA or business district), regulatory_oversight (compliance monitoring). Explicitly identified in detection phase.',
    `stakeholder_status` STRING COMMENT 'Current status of the stakeholder relationship: active (ongoing engagement), satisfied (no concerns), concerns_raised (issues identified), escalated (formal complaint or dispute), disengaged (non-responsive), closed (engagement concluded).',
    CONSTRAINT pk_project_stakeholder PRIMARY KEY(`project_stakeholder_id`)
) COMMENT 'This association product represents the stakeholder engagement relationship between organizations and CIP projects. It captures the formal tracking of organizational stakeholders (HOAs, business districts, municipalities, large industrial customers, permitting authorities) and their involvement in capital improvement projects. Each record links one organization to one CIP project with attributes that define the stakeholder role, engagement requirements, impact assessment, and mitigation commitments. Known in water utilities as the Project Stakeholder Registry.. Existence Justification: In water utility CIP operations, organizations serve as stakeholders in multiple capital projects (an HOA may be affected by multiple water main replacements in their service area), and each CIP project has multiple organizational stakeholders (a treatment plant expansion involves permitting authorities, affected industrial users, funding partners, and community representatives). The utility actively manages this many-to-many relationship through a Project Stakeholder Registry, tracking engagement roles, notification requirements, impact assessments, and mitigation agreements for each organization-project pairing.';

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
    `parcel_type` STRING COMMENT 'Category of the parcel based on land use and zoning.',
    `source_system` STRING COMMENT 'Originating source system that supplied the parcel data.',
    `state` STRING COMMENT 'State or province code where the parcel is located.',
    `parcel_status` STRING COMMENT 'Current lifecycle status of the parcel.',
    `tax_assessed_value` DECIMAL(18,2) COMMENT 'Assessed value of the parcel for property tax purposes.',
    `tax_assessment_year` STRING COMMENT 'Fiscal year of the tax assessment.',
    `valuation_usd` DECIMAL(18,2) COMMENT 'Assessed monetary value of the parcel in US dollars.',
    `zip_code` STRING COMMENT 'Postal code for the parcel location.',
    `zoning_code` STRING COMMENT 'Regulatory zoning classification code for the parcel.',
    CONSTRAINT pk_parcel PRIMARY KEY(`parcel_id`)
) COMMENT 'Master reference table for parcel. Referenced by parcel_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`case` (
    `case_id` BIGINT COMMENT 'Primary key for case',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who raised the case.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor assigned to resolve the case.',
    `parent_case_id` BIGINT COMMENT 'Self-referencing FK on case (parent_case_id)',
    `assigned_department` STRING COMMENT 'Internal department responsible for handling the case.',
    `case_number` STRING COMMENT 'Human‑readable case number used in customer communications and internal tracking.',
    `case_type` STRING COMMENT 'Category of the case indicating the nature of the request or issue.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Base monetary amount associated with the case before taxes, fees, or discounts.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date‑time when the case was marked as closed or resolved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the case record was first persisted in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date‑time when the case was initially created by the customer or system.',
    `priority` STRING COMMENT 'Urgency level assigned to the case for handling and SLA purposes.',
    `resolution_description` STRING COMMENT 'Narrative description of how the case was resolved.',
    `sla_met` BOOLEAN COMMENT 'True if the case was resolved within the SLA target timeframe.',
    `sla_target_hours` STRING COMMENT 'Maximum number of hours allowed to resolve the case per service level agreement.',
    `source_channel` STRING COMMENT 'Channel through which the case was submitted.',
    `case_status` STRING COMMENT 'Current lifecycle state of the case.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the charge amount.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes, fees, and discounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the case record.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Master reference table for case. Referenced by case_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` (
    `rotation_pool_id` BIGINT COMMENT 'Primary key for rotation_pool',
    `parent_rotation_pool_id` BIGINT COMMENT 'Self-referencing FK on rotation_pool (parent_rotation_pool_id)',
    `territory_id` BIGINT COMMENT 'add column territory_id (BIGINT) with FK to service.territory.territory_id - lead/copper rotation pools are organized by service territory per LCR requirements',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rotation pool record was created in the system.',
    `rotation_pool_description` STRING COMMENT 'Detailed description of the rotation pool purpose and usage.',
    `effective_from` DATE COMMENT 'Date when the rotation pool becomes effective.',
    `effective_until` DATE COMMENT 'Date when the rotation pool is retired or expires; null if indefinite.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this pool is the default selection for new accounts.',
    `rotation_pool_name` STRING COMMENT 'Descriptive name of the rotation pool.',
    `region_code` STRING COMMENT 'Three-letter country code representing the region of the rotation pool.',
    `rotation_day_of_week` STRING COMMENT 'Day of the week when rotation is scheduled. [ENUM-REF-CANDIDATE: Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday — promote to reference product]',
    `rotation_end_time` TIMESTAMP COMMENT 'Time of day when the rotation period ends.',
    `rotation_frequency` STRING COMMENT 'How often the rotation occurs (e.g., daily, weekly).',
    `rotation_start_time` TIMESTAMP COMMENT 'Time of day when the rotation period starts.',
    `rotation_pool_status` STRING COMMENT 'Current lifecycle status of the rotation pool.',
    `rotation_pool_type` STRING COMMENT 'Category of customers or services the pool applies to.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rotation pool record.',
    CONSTRAINT pk_rotation_pool PRIMARY KEY(`rotation_pool_id`)
) COMMENT 'Master reference table for rotation_pool. Referenced by rotation_pool_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`organization`(`organization_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ADD CONSTRAINT `fk_customer_person_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`organization`(`organization_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`parcel`(`parcel_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ADD CONSTRAINT `fk_customer_account_person_rel_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ADD CONSTRAINT `fk_customer_account_person_rel_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ADD CONSTRAINT `fk_customer_account_segment_assignment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ADD CONSTRAINT `fk_customer_account_segment_assignment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_customer_customer_account_id` FOREIGN KEY (`service_customer_customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_case_id` FOREIGN KEY (`case_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`case`(`case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_reversed_history_account_status_history_id` FOREIGN KEY (`reversed_history_account_status_history_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`account_status_history`(`account_status_history_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_contact_customer_customer_account_id` FOREIGN KEY (`contact_customer_customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ADD CONSTRAINT `fk_customer_communication_preference_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ADD CONSTRAINT `fk_customer_communication_preference_communication_customer_customer_account_id` FOREIGN KEY (`communication_customer_customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ADD CONSTRAINT `fk_customer_communication_preference_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_assistance_program_id` FOREIGN KEY (`assistance_program_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`assistance_program`(`assistance_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_primary_customer_account_id` FOREIGN KEY (`primary_customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ADD CONSTRAINT `fk_customer_third_party_notification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ADD CONSTRAINT `fk_customer_third_party_notification_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_superseded_account_document_id` FOREIGN KEY (`superseded_account_document_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`account_document`(`account_document_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ADD CONSTRAINT `fk_customer_account_enforcement_impact_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ADD CONSTRAINT `fk_customer_premise_overflow_impact_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ADD CONSTRAINT `fk_customer_sampling_participation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ADD CONSTRAINT `fk_customer_account_asset_responsibility_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ADD CONSTRAINT `fk_customer_sampling_site_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ADD CONSTRAINT `fk_customer_sampling_site_rotation_pool_id` FOREIGN KEY (`rotation_pool_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`rotation_pool`(`rotation_pool_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ADD CONSTRAINT `fk_customer_project_stakeholder_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`organization`(`organization_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ADD CONSTRAINT `fk_customer_parcel_parent_parcel_id` FOREIGN KEY (`parent_parcel_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`parcel`(`parcel_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_parent_case_id` FOREIGN KEY (`parent_case_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`case`(`case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ADD CONSTRAINT `fk_customer_rotation_pool_parent_rotation_pool_id` FOREIGN KEY (`parent_rotation_pool_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`rotation_pool`(`rotation_pool_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_water_utilities_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_account');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_ssot_owner' = 'billing.billing_account');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_business_glossary_term' = 'Secondary Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `secondary_phone_type` SET TAGS ('dbx_business_glossary_term' = 'Secondary Phone Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `secondary_phone_type` SET TAGS ('dbx_value_regex' = 'mobile|home|work|other');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `secondary_phone_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `secondary_phone_type` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `senior_citizen_flag` SET TAGS ('dbx_business_glossary_term' = 'Senior Citizen Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'Jr|Sr|II|III|IV|V');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`person` ALTER COLUMN `suffix` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `parent_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?1?d{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `special_billing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Billing Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Organization Website URL');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` SET TAGS ('dbx_subdomain' = 'service_premises');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` SET TAGS ('dbx_subdomain' = 'service_premises');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Connected Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `backflow_prevention_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `building_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Building Square Footage');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `connection_fee_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Paid Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `connection_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Paid Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `district_metered_area_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `district_metered_area_code` SET TAGS ('dbx_value_regex' = '^DMA-[A-Z0-9]{3,10}$');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_value_regex' = '^PZ-[A-Z0-9]{2,8}$');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` SET TAGS ('dbx_subdomain' = 'service_premises');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_service_agreement');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `account_person_rel_id` SET TAGS ('dbx_business_glossary_term' = 'Account Person Relationship ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `accessibility_requirements` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `accessibility_requirements` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `authorization_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Document Reference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `billing_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Authority Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `ccr_delivery_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Delivery Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `emergency_contact_priority` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Priority');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `emergency_contact_priority` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `financial_responsibility_percentage` SET TAGS ('dbx_business_glossary_term' = 'Financial Responsibility Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `landlord_tenant_indicator` SET TAGS ('dbx_business_glossary_term' = 'Landlord Tenant Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `landlord_tenant_indicator` SET TAGS ('dbx_value_regex' = 'landlord|tenant|owner_occupant|property_manager|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `lcrr_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail|portal|none');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `relationship_notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'primary_account_holder|co_applicant|authorized_representative|emergency_contact|third_party_notification|property_manager');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `service_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Authorization Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `third_party_payer_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Payer Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'in_person|document_upload|phone_verification|email_verification|third_party_service|notarized_form');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_person_rel` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|unverified|verification_failed|expired');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `assistance_program_eligible` SET TAGS ('dbx_business_glossary_term' = 'Assistance Program Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `average_monthly_usage_gallons` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Usage Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `ccr_distribution_required` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Distribution Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `conservation_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Conservation Target Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `demand_forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Category');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `geographic_zone` SET TAGS ('dbx_business_glossary_term' = 'Geographic Zone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `industry_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `industry_classification_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `meter_size_range` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Range');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `rate_case_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Docket Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `revenue_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contribution Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `seasonal_variation_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Variation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural|institutional');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `segmentation_basis` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Basis');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `service_class_code` SET TAGS ('dbx_business_glossary_term' = 'Service Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `service_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `usage_threshold_max_mgd` SET TAGS ('dbx_business_glossary_term' = 'Usage Threshold Maximum Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`segment` ALTER COLUMN `usage_threshold_min_mgd` SET TAGS ('dbx_business_glossary_term' = 'Usage Threshold Minimum Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `account_segment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Account Segment Assignment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^ASG-[0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_reason_code` SET TAGS ('dbx_value_regex' = 'INCOME_CERT|USAGE_THRESHOLD|MANUAL_OVERRIDE|RATE_CLASS_CHANGE|PROGRAM_ENROLLMENT|REGULATORY_MANDATE');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source Reference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source System');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `is_primary_segment` SET TAGS ('dbx_business_glossary_term' = 'Primary Segment Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `override_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Override Authorized By');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Override Justification');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority Rank');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_segment_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` SET TAGS ('dbx_subdomain' = 'service_premises');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_application_id` SET TAGS ('dbx_business_glossary_term' = 'Service Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_assigned_to_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_assigned_to_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_assigned_to_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ALTER COLUMN `service_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `account_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Account Status History ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `account_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating User ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `account_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `account_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `account_payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Case ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Case ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Read ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `primary_account_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating User ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `primary_account_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `primary_account_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `reversed_history_account_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed History Record ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `days_delinquent` SET TAGS ('dbx_business_glossary_term' = 'Days Delinquent');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `initiated_by_system_code` SET TAGS ('dbx_business_glossary_term' = 'Initiating System Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `medical_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `medical_certification_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `medical_certification_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `medical_certification_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `new_status_code` SET TAGS ('dbx_business_glossary_term' = 'New Account Status Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'MAIL|EMAIL|SMS|PHONE|DOOR_HANGER|NONE');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `previous_status_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Account Status Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `reconnection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconnection Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Status Reversal Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Transition Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'CC&B|MAXIMO|CRM|LEGACY|MIGRATION');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'engagement_records');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `contact_customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Contact Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|sms|postal|portal|fax');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|invalid|pending_verification');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'billing|service|emergency|legal_notice|technical|customer_service');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `delivery_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Failure Count');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `delivery_success_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Success Count');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `invalid_date` SET TAGS ('dbx_business_glossary_term' = 'Invalid Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `invalid_reason` SET TAGS ('dbx_business_glossary_term' = 'Invalid Reason');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `invalid_reason` SET TAGS ('dbx_value_regex' = 'bounced_email|disconnected_phone|returned_mail|customer_reported|system_validation_failed');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Contact Label');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `last_contact_type` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `opt_in_billing` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Billing Communications Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `opt_in_emergency` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Emergency Communications Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `opt_in_marketing` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Marketing Communications Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `opt_in_service` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Service Communications Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `opt_out_reason` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Reason');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Contact Quality Score');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Contact Value');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `value` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email_link|sms_code|postal_mail|phone_call|in_person|system_import');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` SET TAGS ('dbx_subdomain' = 'engagement_records');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `communication_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `communication_customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `audio_format_required` SET TAGS ('dbx_business_glossary_term' = 'Audio Format Required');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `bill_ready_channel` SET TAGS ('dbx_business_glossary_term' = 'Bill Ready Notification Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `bill_ready_channel` SET TAGS ('dbx_value_regex' = 'email|sms|mail|portal|mobile_app');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `boil_water_notice_channel` SET TAGS ('dbx_business_glossary_term' = 'Boil Water Notice Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `boil_water_notice_channel` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail|mobile_app');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `braille_required` SET TAGS ('dbx_business_glossary_term' = 'Braille Required');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `ccr_delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Delivery Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `ccr_delivery_channel` SET TAGS ('dbx_value_regex' = 'email|mail|portal');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `ccr_electronic_consent` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Electronic Consent');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `ccr_electronic_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Electronic Consent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `conservation_alert_channel` SET TAGS ('dbx_business_glossary_term' = 'Water Conservation Alert Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `conservation_alert_channel` SET TAGS ('dbx_value_regex' = 'email|sms|mail|mobile_app');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `contact_time_preference` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Preference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `contact_time_preference` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|anytime');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `delinquency_notice_channel` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Notice Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `delinquency_notice_channel` SET TAGS ('dbx_value_regex' = 'email|sms|mail|phone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `do_not_call` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `do_not_call_date` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `ebill_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Bill (E-Bill) Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `email_unsubscribe_date` SET TAGS ('dbx_business_glossary_term' = 'Email Unsubscribe Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `email_unsubscribe_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `email_unsubscribe_date` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `large_print_required` SET TAGS ('dbx_business_glossary_term' = 'Large Print Required');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `marketing_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `outage_alert_channel` SET TAGS ('dbx_business_glossary_term' = 'Outage Alert Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `outage_alert_channel` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mobile_app');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `paperless_billing_consent` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Consent');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `payment_confirmation_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `payment_confirmation_channel` SET TAGS ('dbx_value_regex' = 'email|sms|mail|portal|mobile_app');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_value_regex' = 'email|sms|mail|phone|portal|mobile_app');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|vi|other');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `robocall_consent` SET TAGS ('dbx_business_glossary_term' = 'Robocall Consent');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `robocall_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Robocall Consent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `service_appointment_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Appointment Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `service_appointment_channel` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mobile_app');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `sms_consent` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Consent');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `sms_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Consent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `sms_opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Opt-Out Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `tty_required` SET TAGS ('dbx_business_glossary_term' = 'Text Telephone (TTY) Required');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `update_source` SET TAGS ('dbx_business_glossary_term' = 'Update Source');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `update_source` SET TAGS ('dbx_value_regex' = 'customer_portal|mobile_app|call_center|mail|system');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`communication_preference` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` SET TAGS ('dbx_subdomain' = 'assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` ALTER COLUMN `assistance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_assistance_program');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` SET TAGS ('dbx_subdomain' = 'assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ALTER COLUMN `customer_assistance_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ALTER COLUMN `affordability_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Affordability Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ALTER COLUMN `assistance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Assistance Program Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ALTER COLUMN `billing_assistance_enrollment_id` SET TAGS ('dbx_ssot_owner' = 'billing.billing_assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` SET TAGS ('dbx_subdomain' = 'engagement_records');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `account_note_id` SET TAGS ('dbx_business_glossary_term' = 'Account Note Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Note Author User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `account_reviewed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `account_reviewed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `account_reviewed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Complaint Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `primary_account_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Note Author User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `primary_account_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `primary_account_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Service Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `auto_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Generated Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `character_count` SET TAGS ('dbx_business_glossary_term' = 'Character Count');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `collections_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Collections Hold Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Note Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `customer_visible_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Visible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Note Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `hazard_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Indicator Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Note Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `medical_baseline_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Baseline Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `medical_baseline_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `medical_baseline_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `medical_baseline_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_author_name` SET TAGS ('dbx_business_glossary_term' = 'Note Author Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_category` SET TAGS ('dbx_business_glossary_term' = 'Note Category');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_category` SET TAGS ('dbx_value_regex' = 'BILLING|SERVICE_DELIVERY|SAFETY|REGULATORY|CUSTOMER_PREFERENCE|PROPERTY_ACCESS');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_status` SET TAGS ('dbx_business_glossary_term' = 'Note Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|ARCHIVED|DELETED|EXPIRED');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_text` SET TAGS ('dbx_business_glossary_term' = 'Note Text');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_type_code` SET TAGS ('dbx_business_glossary_term' = 'Note Type Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `note_type_code` SET TAGS ('dbx_value_regex' = 'GENERAL|COLLECTIONS|FIELD_SERVICE|COMPLAINT|LEGAL_HOLD|MEDICAL_BASELINE');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `print_on_bill_flag` SET TAGS ('dbx_business_glossary_term' = 'Print on Bill Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Note Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `visibility_level` SET TAGS ('dbx_business_glossary_term' = 'Note Visibility Level');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `visibility_level` SET TAGS ('dbx_value_regex' = 'INTERNAL|EXTERNAL|RESTRICTED');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ALTER COLUMN `workflow_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Workflow Trigger Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'engagement_records');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Interaction Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `interaction_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `network_valve_id` SET TAGS ('dbx_business_glossary_term' = 'Network Valve Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `overflow_event_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` SET TAGS ('dbx_subdomain' = 'engagement_records');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `customer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `customer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `customer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `overflow_event_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Service Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `assigned_to_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Department');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `billing_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `compensation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Provided Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `compensation_provided_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `compensation_provided_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Contact Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `customer_satisfaction_comments` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Comments');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `regulatory_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Escalation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `regulatory_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Complaint Subcategory');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `water_quality_test_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Test Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ALTER COLUMN `water_quality_test_result` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Test Result');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `primary_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'proportional_usage|equal_split|fixed_percentage|custom_formula|direct_metered');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `billing_consolidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Consolidation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `consumption_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumption Rollup Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_priority` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Priority');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'corporate_rollup|master_sub_meter|hoa_common_area|wholesale_retail|municipal_department|irrigation_district');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `payment_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Payment Responsibility');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `payment_responsibility` SET TAGS ('dbx_value_regex' = 'parent_pays_all|child_pays_own|split_responsibility|parent_guarantees');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'customer_request|service_disconnection|contract_expiration|account_closure|organizational_restructure|billing_dispute');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` SET TAGS ('dbx_subdomain' = 'assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ALTER COLUMN `deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for customer_deposit');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` SET TAGS ('dbx_subdomain' = 'engagement_records');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `third_party_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Notification ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Person Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `advance_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Days');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|revoked|pending_approval');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `consent_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Documentation Reference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written_form|electronic_signature|verbal_recorded|online_portal|in_person');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `last_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Notification Sent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `last_notification_type` SET TAGS ('dbx_business_glossary_term' = 'Last Notification Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `low_income_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `low_income_assistance_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_state_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing State Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_state_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `mailing_state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `medical_baseline_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Baseline Program Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `medical_baseline_program_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `medical_baseline_program_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `medical_baseline_program_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `notification_arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Arrangement Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `notification_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Delivery Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `notification_delivery_status` SET TAGS ('dbx_value_regex' = 'delivered|failed|pending|bounced|undeliverable');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `notification_language_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Language Preference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|phone_call|sms|postal_mail|fax|portal_notification');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `notification_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Trigger Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `priority_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Notification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `relationship_to_account_holder` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Account Holder');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Secondary Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `third_party_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `third_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `third_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `third_party_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Organization Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ALTER COLUMN `third_party_organization_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` SET TAGS ('dbx_subdomain' = 'engagement_records');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `account_document_id` SET TAGS ('dbx_business_glossary_term' = 'Account Document Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `account_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `account_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `account_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `account_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `account_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `account_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `primary_account_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `primary_account_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `primary_account_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Related Invoice Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Service Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `superseded_account_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Account Document Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `superseded_account_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `tertiary_account_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `tertiary_account_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `tertiary_account_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `accessibility_format_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Format Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `ccr_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Delivery Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `compliance_program_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'PUBLIC|INTERNAL|CONFIDENTIAL|RESTRICTED');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `customer_visible_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Visible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `digital_signature_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Present Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `digital_signature_present_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'regulatory|billing|service|compliance|legal|operational');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_notes` SET TAGS ('dbx_business_glossary_term' = 'Document Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `document_type_code` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `file_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `notarization_date` SET TAGS ('dbx_business_glossary_term' = 'Notarization Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `notarization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notarization Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `print_on_bill_flag` SET TAGS ('dbx_business_glossary_term' = 'Print on Bill Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `signature_date` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Storage Reference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `storage_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `upload_channel` SET TAGS ('dbx_business_glossary_term' = 'Upload Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `uploaded_by_name` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `uploaded_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `uploaded_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By User Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `uploaded_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `uploaded_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `uploaded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Uploaded Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'NOT_VERIFIED|VERIFIED|FAILED|PENDING');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` SET TAGS ('dbx_subdomain' = 'assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` SET TAGS ('dbx_association_edges' = 'customer.customer_account,service.conservation_program');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `customer_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'customer_program_enrollment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Conservation Program Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Customer Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `service_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `incentive_amount_received` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount Received');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Participation End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `rebate_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Rebate Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ALTER COLUMN `water_savings_achieved_gallons` SET TAGS ('dbx_business_glossary_term' = 'Water Savings Achieved');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` SET TAGS ('dbx_subdomain' = 'compliance_participation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` SET TAGS ('dbx_association_edges' = 'customer.customer_account,compliance.enforcement_action');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `account_enforcement_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Account Enforcement Impact ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Enforcement Impact - Customer Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `account_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Account Restriction Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `affected_service_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Count');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `customer_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `customer_response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `customer_response_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `impact_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Impact Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Impact Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `restriction_end_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ALTER COLUMN `restriction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` SET TAGS ('dbx_subdomain' = 'compliance_participation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` SET TAGS ('dbx_association_edges' = 'customer.premise,compliance.overflow_event');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `premise_overflow_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Overflow Impact ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `overflow_event_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Overflow Impact - Sso Cso Event Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Overflow Impact - Premise Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `cleanup_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `cleanup_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `customer_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Customer Compensation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `customer_compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `customer_compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `impact_type` SET TAGS ('dbx_business_glossary_term' = 'Impact Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` SET TAGS ('dbx_subdomain' = 'compliance_participation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` SET TAGS ('dbx_association_edges' = 'customer.customer_account,laboratory.sampling_plan');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `sampling_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Participation Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Participation - Customer Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Participation - Sampling Plan Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `access_instructions` SET TAGS ('dbx_business_glossary_term' = 'Access Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `last_sample_collected_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Collected Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `next_scheduled_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `participation_notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `sampling_frequency_override` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency Override');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `total_samples_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Samples Collected');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ALTER COLUMN `volunteer_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Consent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` SET TAGS ('dbx_subdomain' = 'compliance_participation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` SET TAGS ('dbx_association_edges' = 'customer.customer_account,asset.asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `account_asset_responsibility_id` SET TAGS ('dbx_business_glossary_term' = 'Account Asset Responsibility ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Asset Responsibility - Customer Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Account Asset Responsibility - Asset Registry Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `billing_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Responsibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `maintenance_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `responsibility_type` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` SET TAGS ('dbx_subdomain' = 'compliance_participation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` SET TAGS ('dbx_association_edges' = 'customer.customer_account,quality.sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `sampling_site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Sampling Site ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Sampling Site - Customer Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Sampling Site - Sampling Point Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `rotation_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pool ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `access_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Access Authorization Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `customer_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Consent Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `last_sample_collected_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Collected Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `next_scheduled_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sample Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `preferred_sampling_time` SET TAGS ('dbx_business_glossary_term' = 'Preferred Sampling Time');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `sampling_frequency_override` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency Override');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `site_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Site Activation Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `site_deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Site Deactivation Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `special_access_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Access Instructions');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'LCRR Tier Classification');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` SET TAGS ('dbx_subdomain' = 'assistance_enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` SET TAGS ('dbx_association_edges' = 'customer.customer_account,finance.grant');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ALTER COLUMN `grant_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Grant Enrollment ID');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Grant Enrollment - Customer Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Grant Enrollment - Grant Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ALTER COLUMN `benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ALTER COLUMN `eligibility_period_end` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ALTER COLUMN `eligibility_period_start` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` SET TAGS ('dbx_subdomain' = 'compliance_participation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` SET TAGS ('dbx_association_edges' = 'customer.organization,project.cip_project');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `project_stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Project Stakeholder Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Stakeholder - Cip Project Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Project Stakeholder - Organization Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `engagement_level` SET TAGS ('dbx_business_glossary_term' = 'Engagement Level');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `last_engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Engagement Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `mitigation_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Agreement Reference');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `next_engagement_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Engagement Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notes');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `stakeholder_role` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Role');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ALTER COLUMN `stakeholder_status` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` SET TAGS ('dbx_subdomain' = 'service_premises');
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
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `parcel_type` SET TAGS ('dbx_business_glossary_term' = 'Parcel Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Parcel Source System');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `parcel_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `tax_assessed_value` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessed Value');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `tax_assessment_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Year');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `valuation_usd` SET TAGS ('dbx_business_glossary_term' = 'Valuation Usd');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ALTER COLUMN `zoning_code` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` SET TAGS ('dbx_subdomain' = 'compliance_participation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `parent_case_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Case Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `parent_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'Sla Met');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Sla Target Hours');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` SET TAGS ('dbx_subdomain' = 'compliance_participation');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pool Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `parent_rotation_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Rotation Pool Id');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `parent_rotation_pool_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_pool_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_pool_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_pool_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Rotation Day Of Week');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_end_time` SET TAGS ('dbx_business_glossary_term' = 'Rotation End Time');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rotation Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_start_time` SET TAGS ('dbx_business_glossary_term' = 'Rotation Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_pool_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `rotation_pool_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`rotation_pool` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
