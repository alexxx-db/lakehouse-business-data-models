-- Schema for Domain: customer | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`customer` COMMENT 'Single source of truth for all customer identity, account hierarchy, and relationship data. Manages OEM, fabless design house, ODM, distributor, and automotive customer profiles, contacts, segmentation, design-win engagement records, and customer qualification status. Integrates with Salesforce CRM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the account record.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales representative responsible for the account.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Customer account revenue is posted to a default GL account; required for General Ledger posting per account.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Customer profitability analysis tracks revenue and expense by profit center; required for the Customer Profitability Dashboard.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Normalize address data: move primary address fields from account to address table and reference via FK.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Required for Preferred Supplier selection per account, used in sourcing strategy and procurement reports.',
    `account_status` STRING COMMENT 'Current lifecycle status of the account.. Valid values are `active|inactive|suspended|pending|closed`',
    `account_type` STRING COMMENT 'Classification of the account within the semiconductor ecosystem.. Valid values are `oem|fabless|odm|distributor|automotive_tier1|other`',
    `audit_status` STRING COMMENT 'Result of the most recent compliance audit for the account.. Valid values are `passed|failed|pending`',
    `closure_date` DATE COMMENT 'Date when the account was closed or deactivated, if applicable.',
    `communication_preference` STRING COMMENT 'Preferred channel for account communications.. Valid values are `email|phone|mail`',
    `compliance_status` STRING COMMENT 'Current compliance posture of the account with internal and external regulations.. Valid values are `compliant|non_compliant|pending`',
    `credit_rating` STRING COMMENT 'External credit rating of the account. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|C|D — promote to reference product]',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code used for billing. [ENUM-REF-CANDIDATE: USD|EUR|JPY|CNY|KRW|... — promote to reference product]',
    `data_classification` STRING COMMENT 'Data classification level applied to the account record.. Valid values are `internal|confidential|restricted|public`',
    `account_description` STRING COMMENT 'Free‑form description or notes about the account.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the legal entity.',
    `export_control_classification` STRING COMMENT 'Export control regime applicable to the account.. Valid values are `ear|itar|none`',
    `geographic_region` STRING COMMENT 'Primary geographic region of the accounts operations.',
    `industry_vertical` STRING COMMENT 'Primary industry vertical the account operates in (e.g., automotive, consumer electronics). [ENUM-REF-CANDIDATE: automotive|consumer|industrial|communications|computing|... — promote to reference product]',
    `label_requirements` STRING COMMENT 'Labeling format required on products delivered to the account.. Valid values are `barcode|qr|none`',
    `last_activity_date` DATE COMMENT 'Date of the most recent interaction or transaction with the account.',
    `last_order_date` DATE COMMENT 'Date of the most recent order placed by the account.',
    `legal_name` STRING COMMENT 'Full legal name of the corporate entity as registered.',
    `account_name` STRING COMMENT 'Primary display name of the account (legal or trade name).',
    `notes` STRING COMMENT 'Additional free‑form notes captured by sales or support teams.',
    `packaging_requirements` STRING COMMENT 'Special packaging or labeling requirements for shipments to the account.. Valid values are `lead_free|rohs_compliant|custom`',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the account.. Valid values are `net30|net45|net60|cash|custom`',
    `preferred_language` STRING COMMENT 'Preferred language for communications with the account.. Valid values are `en|es|zh|de|fr|ja`',
    `primary_email` STRING COMMENT 'Main email address used for account communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `primary_phone` STRING COMMENT 'Main telephone number for the account point of contact.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the account record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the account record.',
    `revenue_tier` STRING COMMENT 'Revenue bracket of the account based on annual sales.. Valid values are `small|mid|large|enterprise`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) based on credit, compliance, and transaction history.',
    `sales_region` STRING COMMENT 'Geographic sales region assigned to the account.. Valid values are `americas|emea|apac`',
    `strategic_classification` STRING COMMENT 'Strategic importance of the account to the company.. Valid values are `strategic|core|non_core|partner`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the account is tax‑exempt.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier for the account.',
    `creation_date` DATE COMMENT 'Date when the account was first created in the system.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master record for all customer accounts in the semiconductor ecosystem, including OEMs, fabless design houses, ODMs, distributors, and automotive Tier-1 suppliers. SSOT for customer identity, legal entity name, DUNS number, account type, industry vertical, revenue tier, strategic classification, credit rating, payment terms, export control classification (EAR/ITAR), account status, preferred communication settings, packaging/labeling requirements, and Salesforce CRM account ID. Integrates with SAP S/4HANA SD module and Salesforce CRM Account object.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique system-generated identifier for the contact.',
    `account_id` BIGINT COMMENT 'FK to customer.account.account_id — Every contact must be associated with exactly one customer account. This is the most fundamental FK in the domain — contacts cannot exist without an account parent.',
    `address_id` BIGINT COMMENT 'FK to customer.address',
    `primary_contact_account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Connect contact to its parent customer account for hierarchy and reporting.',
    `birth_date` DATE COMMENT 'Birth date of the contact, used for age verification where required.',
    `contact_role` STRING COMMENT 'The role of the contact record in the customer domain.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|suspended|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the contact record in the customer domain.',
    `data_classification` STRING COMMENT 'Classification level of the contact data.. Valid values are `restricted|confidential|internal|public`',
    `department` STRING COMMENT 'Department within the organization where the contact works.',
    `email` STRING COMMENT 'Primary email address for the contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `external_reference_code` STRING COMMENT 'Identifier of the contact in external systems (e.g., Salesforce ID).',
    `first_name` STRING COMMENT 'Given name of the contact.',
    `full_name` STRING COMMENT 'Legal full name of the contact person.',
    `gdpr_consent_status` STRING COMMENT 'Current GDPR consent status for personal data processing.. Valid values are `granted|revoked|pending`',
    `is_employee` BOOLEAN COMMENT 'True if the contact is an employee of Semiconductors.',
    `is_key_contact` BOOLEAN COMMENT 'Indicates whether the contact is a primary point of contact for the customer account.',
    `is_primary_contact` BOOLEAN COMMENT 'The is primary contact of the contact record in the customer domain.',
    `job_title` STRING COMMENT 'The job title of the contact record in the customer domain.',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|zh|de|fr|other`',
    `last_consent_update` TIMESTAMP COMMENT 'Timestamp of the most recent GDPR consent status change.',
    `last_interaction_date` DATE COMMENT 'Date of the most recent interaction with the contact.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the contact record in the customer domain.',
    `last_name` STRING COMMENT 'Family name of the contact.',
    `linkedin_profile` STRING COMMENT 'URL to the contacts LinkedIn professional profile.. Valid values are `^https?://(www.)?linkedin.com/in/[A-Za-z0-9_-]+$`',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates if the contact has opted in to receive marketing communications.',
    `nationality` STRING COMMENT 'Contacts nationality.',
    `notes` STRING COMMENT 'Free-text notes about the contact.',
    `phone` STRING COMMENT 'The phone of the contact record in the customer domain.',
    `phone_number` STRING COMMENT 'Primary telephone number for the contact, in international format.. Valid values are `^+?[0-9]{7,15}$`',
    `preferred_communication_channel` STRING COMMENT 'Preferred method for contacting the individual.. Valid values are `email|phone|linkedin|sms|other`',
    `preferred_language` STRING COMMENT 'The preferred language of the contact record in the customer domain.',
    `profile_picture_url` STRING COMMENT 'URL to the contacts profile picture.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the contact record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contact record.',
    `role_type` STRING COMMENT 'Categorization of the contacts functional role.. Valid values are `technical|commercial|executive|support|management`',
    `time_zone` STRING COMMENT 'Time zone of the contact for scheduling communications.',
    `title` STRING COMMENT 'Professional title or position of the contact within their organization.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual contact persons associated with customer accounts, including design engineers, procurement managers, FAE (Field Application Engineers) counterparts, and executive sponsors. Captures full name, title, department, role type (technical, commercial, executive), email, phone, preferred communication channel, LinkedIn profile, GDPR consent status, and active/inactive status. Maps to Salesforce CRM Contact object.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` (
    `account_hierarchy_id` BIGINT COMMENT 'System‑generated unique identifier for each account hierarchy relationship record.',
    `account_id` BIGINT COMMENT 'Identifier of the child corporate account linked to the parent.',
    `parent_account_id` BIGINT COMMENT 'Identifier of the parent corporate account in the hierarchy.',
    `primary_account_id` BIGINT COMMENT 'FK to customer.account.account_id — The parent_account_id in account_hierarchy must reference the account product. Without this FK, hierarchy records are orphaned.',
    `account_hierarchy_status` STRING COMMENT 'Current operational status of the hierarchy link.. Valid values are `active|inactive|pending|terminated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hierarchy record was first created in the source system.',
    `account_hierarchy_description` STRING COMMENT 'Free‑text notes providing additional context about the parent‑child relationship.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the account hierarchy customer record.',
    `effective_from` DATE COMMENT 'Date on which the hierarchical relationship became effective.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the account hierarchy customer record.',
    `effective_until` DATE COMMENT 'Date on which the hierarchical relationship ended; null if still active.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the child account within the corporate hierarchy (1 = top‑level).',
    `hierarchy_type` STRING COMMENT 'The hierarchy type of the account hierarchy record in the customer domain.',
    `is_active` BOOLEAN COMMENT 'The is active of the account hierarchy record in the customer domain.',
    `is_primary` BOOLEAN COMMENT 'True if the child account is the primary entity under the parent; otherwise false.',
    `is_ultimate_parent` BOOLEAN COMMENT 'The is ultimate parent of the account hierarchy record in the customer domain.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last updated the hierarchy record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the account hierarchy record in the customer domain.',
    `relationship_type` STRING COMMENT 'Classification of the hierarchical relationship between parent and child accounts.. Valid values are `subsidiary|division|affiliate|distributor_branch|joint_venture|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hierarchy record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the hierarchy record.',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Defines parent-child corporate hierarchy relationships between customer accounts, enabling roll-up of revenue, design-wins, and engagement metrics across global enterprise accounts. Captures parent account, child account, hierarchy level, relationship type (subsidiary, division, affiliate, distributor branch), effective date, and end date. Critical for global OEM and distributor account management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique surrogate key for the customer segment record. _canonical_skip_reason: Inferred role REFERENCE_LOOKUP; no mandatory minimum categories required.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id',
    `segment_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the market segment within the organization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was first created.',
    `segment_description` STRING COMMENT 'Free‑form description of the segment purpose and characteristics.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Default discount percentage offered to the segment.',
    `effective_from` DATE COMMENT 'Date when the segment definition becomes active.',
    `effective_until` DATE COMMENT 'Date when the segment definition expires or is retired (null if open‑ended).',
    `is_active` BOOLEAN COMMENT 'The is active of the segment record in the customer domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the segment record in the customer domain.',
    `market_share_target_percent` DECIMAL(18,2) COMMENT 'Desired market share percentage for the segment.',
    `market_vertical` STRING COMMENT 'The market vertical of the segment record in the customer domain.',
    `segment_name` STRING COMMENT 'Human‑readable name of the market segment (e.g., Hyperscaler, Automotive Tier‑1).',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the segment.',
    `pricing_strategy` STRING COMMENT 'Pricing model applied to the segment.. Valid values are `standard|premium|discounted`',
    `region` STRING COMMENT 'Primary geographic region associated with the segment. [ENUM-REF-CANDIDATE: USA|CAN|MEX|CHN|JPN|KOR|DEU|FRA|GBR|IND|BRA|AUS — 12 candidates stripped; promote to reference product]',
    `revenue_target_usd` DECIMAL(18,2) COMMENT 'Annual revenue target for the segment expressed in US dollars.',
    `sales_motion` STRING COMMENT 'Primary sales approach used for the segment.. Valid values are `direct|indirect|partner|online`',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment.. Valid values are `active|inactive|deprecated`',
    `segment_type` STRING COMMENT 'The type of the segment record in the customer domain.',
    `strategic_priority_tier` STRING COMMENT 'Internal priority ranking used for resource allocation and go‑to‑market planning.. Valid values are `high|medium|low`',
    `sub_vertical` STRING COMMENT 'More granular market sub‑category within the vertical (e.g., AI Chipmakers, Power Management). [ENUM-REF-CANDIDATE: ai_chipmakers|power_management|networking|mobile_devices|automotive_sensors|industrial_automation|defense_systems|smart_home|wearables|edge_computing] ',
    `tam_band` STRING COMMENT 'Size band of the total addressable market for the segment.. Valid values are `large|mid|small`',
    `target_customer_type` STRING COMMENT 'Primary type of customers targeted by the segment.. Valid values are `oem|fabless|odm|distributor|automotive|government`',
    `target_market` STRING COMMENT 'The target market of the segment record in the customer domain.',
    `target_revenue_usd` DECIMAL(18,2) COMMENT 'The target revenue usd of the segment record in the customer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the segment record.',
    `vertical_market` STRING COMMENT 'High‑level industry vertical to which the segment belongs (e.g., Semiconductor, Automotive, Consumer Electronics). [ENUM-REF-CANDIDATE: semiconductor|automotive|consumer_electronics|industrial_iot|government_defense|healthcare|telecom|energy|finance|retail|education|media] ',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the segment record.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Reference data defining market segmentation classifications for customer accounts. Each segment represents a strategic grouping used for go-to-market planning, pricing strategy, and resource allocation. Attributes include segment code, segment name (e.g., Hyperscaler, Automotive Tier-1, Consumer Electronics OEM, Industrial IoT, Government/Defense), vertical market, sub-vertical, strategic priority tier, TAM band, and assigned sales motion. Managed by sales strategy and marketing teams as controlled vocabulary.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`address` (
    `address_id` BIGINT COMMENT 'System-generated unique identifier for the address record.',
    `account_id` BIGINT COMMENT 'Surrogate FK to customer account (single canonical reference, replaces denormalized address_account_id)',
    `address_status` STRING COMMENT 'Current status of the address record (active/inactive/archived - replaces denormalized is_active boolean). Valid values are `active|inactive|pending|closed`',
    `address_type` STRING COMMENT 'Category of the address indicating its business purpose.. Valid values are `headquarters|ship_to|bill_to|design_center|office|warehouse`',
    `change_reason` STRING COMMENT 'Reason code or description for the most recent address change.',
    `change_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent address change was recorded.',
    `city` STRING COMMENT 'City component of the address.',
    `classification` STRING COMMENT 'Classification indicating whether the address belongs to internal organization, external customer, or partner.. Valid values are `internal|external|partner`',
    `address_code` STRING COMMENT 'Internal code used to reference the address within ERP and PLM systems.',
    `contact_email` STRING COMMENT 'Email address of the primary contact at the address.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the address.',
    `contact_phone` STRING COMMENT 'Phone number of the primary contact at the address.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code (normalized; replaces denormalized country name). Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the address becomes valid for business use.',
    `effective_until` DATE COMMENT 'Date when the address ceases to be valid (null if open‑ended).',
    `export_control_screened` BOOLEAN COMMENT 'True if the address has been screened against export control lists.',
    `export_control_status` STRING COMMENT 'Result of export‑control screening for the address.. Valid values are `cleared|restricted|blocked`',
    `geolocation_accuracy` STRING COMMENT 'Indicates the precision level of the latitude/longitude values.. Valid values are `high|medium|low`',
    `is_billing` BOOLEAN COMMENT 'The is billing of the address record in the customer domain.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this address is the primary location for the associated account.',
    `is_shipping` BOOLEAN COMMENT 'The is shipping of the address record in the customer domain.',
    `label` STRING COMMENT 'Human‑readable label identifying the address (e.g., “HQ San Jose”).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the address record in the customer domain.',
    `last_verified` DATE COMMENT 'Date when the address information was last validated.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate in decimal degrees.',
    `line_1` STRING COMMENT 'The line 1 of the address record in the customer domain.',
    `line_2` STRING COMMENT 'The line 2 of the address record in the customer domain.',
    `lineage_code` BIGINT COMMENT 'Identifier linking this address to its predecessor in case of address merges or splits.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate in decimal degrees.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the address.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.. Valid values are `^[A-Z0-9 -]{3,10}$`',
    `purpose` STRING COMMENT 'Business purpose for which the address is used.. Valid values are `logistics|billing|design_support|customer_service|sales`',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created of the address record in the customer domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated of the address record in the customer domain.',
    `region` STRING COMMENT 'Broad geographic region (e.g., APAC, EMEA, AMER) used for reporting.',
    `state_province` STRING COMMENT 'State or province component of the address.',
    `street_line1` STRING COMMENT 'Primary street address line (normalized canonical field)',
    `street_line2` STRING COMMENT 'Secondary street address line (normalized canonical field)',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction applicable to the address.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the address location.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last modification timestamp (canonical; replaces denormalized last_modified_timestamp)',
    `validation_status` STRING COMMENT 'The validation status of the address record in the customer domain.',
    `verification_status` STRING COMMENT 'Current status of address verification.. Valid values are `verified|unverified|pending`',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing addresses associated with customer accounts and contacts, including headquarters, ship-to, bill-to, and design center locations. Captures address type, street lines, city, state/province, postal code, country (ISO 3166), region, time zone, and geolocation coordinates. Supports multi-site global accounts with multiple address records per account. Used for logistics, tax jurisdiction, and export control screening.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` (
    `customer_design_win_id` BIGINT COMMENT 'Surrogate primary key for the customer design win record.',
    `account_id` BIGINT COMMENT 'FK to customer.account.account_id — Every design-win is attributed to a specific customer account. This FK is critical for revenue forecasting and account-level reporting.',
    `assembly_process_flow_id` BIGINT COMMENT 'Foreign key linking to packaging.assembly_process_flow. Business justification: Each design win selects a packaging process flow; linking enables process planning and yield forecasting in the Process Flow Assignment workflow.',
    `channel_partner_id` BIGINT COMMENT 'Reference to the distributor channel partner, if the win originated via a distributor.',
    `contact_id` BIGINT COMMENT 'FK to customer.contact.contact_id — Design-wins reference the FAE owner and customer engineering contact. Contact FK enables relationship tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the FAE responsible for the design‑win engagement.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Each design win part must have an ECCN classification for export control; used in export license generation and customs documentation.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - design wins target specific technology nodes',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Design‑win forecasts and revenue reports must reference the exact catalog entry; part_number is a denormalized duplicate and is removed.',
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the opportunity record within the customer design win customer entity.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the customer design win customer entity.',
    `primary_customer_account_id` BIGINT COMMENT 'Reference to the customer organization that owns the design win.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Design win financial tracking attributes revenue to a profit center for margin analysis; appears in Design Win Profitability report.',
    `reach_svhc_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.reach_svhc_declaration. Business justification: Design win parts require REACH SVHC declarations for EU chemical compliance; needed for regulatory filing and product safety reporting.',
    `research_program_id` BIGINT COMMENT 'Foreign key linking to research.program. Business justification: Design Win Forecast Report links each customer design win to the internal R&D program delivering the technology, enabling revenue attribution and program performance tracking.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Design win must identify the supplier manufacturing the part, essential for supply chain planning and production ramp scheduling.',
    `authoritative_sales_design_win_id` BIGINT COMMENT 'Authoritative single-source-of-truth reference to owning entity sales.sales_design_win resolving the cross-domain SSOT duplicate with sales.customer_design_win.',
    `sales_design_win_id` BIGINT COMMENT 'Cross-domain FK to authoritative SSOT owner sales.sales_design_win (resolves MVM SSOT duplicate).',
    `application` STRING COMMENT 'The application of the customer design win record in the customer domain.',
    `application_segment` STRING COMMENT 'The application segment of the customer design win record in the customer domain.',
    `competitive_displacement_flag` BOOLEAN COMMENT 'Indicates whether the win displaces a competitors product (true) or not (false).',
    `competitor_displaced` STRING COMMENT 'The competitor displaced of the customer design win record in the customer domain.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when the design win was officially confirmed (won).',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the customer design win record in the customer domain.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `[A-Z]{3}`',
    `design_phase` STRING COMMENT 'The design phase of the customer design win record in the customer domain.',
    `design_project_name` STRING COMMENT 'Name of the internal design project associated with the win.',
    `design_win_name` STRING COMMENT 'The design win name of the customer design win record in the customer domain.',
    `design_win_number` STRING COMMENT 'External business identifier assigned to the design win record.',
    `design_win_source` STRING COMMENT 'Origin of the design win (internal development, channel‑sourced, or partner‑sourced).. Valid values are `internal|channel|partner`',
    `design_win_status` STRING COMMENT 'The design win status of the customer design win record in the customer domain.',
    `end_application` STRING COMMENT 'The end application of the customer design win record in the customer domain.',
    `end_product` STRING COMMENT 'The end product of the customer design win record in the customer domain.',
    `estimated_annual_revenue_usd` DECIMAL(18,2) COMMENT 'Projected annual revenue from the design win, expressed in US dollars.',
    `estimated_annual_unit_volume` BIGINT COMMENT 'Projected number of units the customer will purchase per year.',
    `estimated_annual_volume` BIGINT COMMENT 'The estimated annual volume of the customer design win record in the customer domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the customer design win record in the customer domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the customer design win record in the customer domain.',
    `notes` STRING COMMENT 'Free‑form notes captured by the FAE or sales team.',
    `nre_amount_usd` DECIMAL(18,2) COMMENT 'Estimated NRE cost associated with the design win, expressed in US dollars.',
    `nre_required_flag` BOOLEAN COMMENT 'True if the project includes a non‑recurring engineering (NRE) component.',
    `package_type` STRING COMMENT 'Package format chosen for the part (e.g., BGA, WLCSP).',
    `platform_generation` STRING COMMENT 'Generation of the platform family for which the design win is targeted.',
    `probability_percent` DECIMAL(18,2) COMMENT 'The probability percent of the customer design win record in the customer domain.',
    `process_node` STRING COMMENT 'Technology node (e.g., 7nm, 5nm) selected for the design.',
    `production_ramp_date` DATE COMMENT 'Target date when volume production is expected to ramp.',
    `production_start_date` DATE COMMENT 'The production start date associated with the customer design win customer record.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `registration_timestamp` TIMESTAMP COMMENT 'Timestamp when the design win was first registered in the system.',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the design_win concept (sales.sales_design_win)',
    `stage` STRING COMMENT 'Current stage of the design‑win lifecycle.. Valid values are `registered|evaluating|sampling|won|lost|on_hold`',
    `tapeout_target_date` DATE COMMENT 'Planned date for tape‑out of the design.',
    `target_application` STRING COMMENT 'Intended end‑product or market application (e.g., smartphone SoC, ADAS ECU, AI accelerator).',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the customer design win record in the customer domain.',
    `win_date` DATE COMMENT 'The win date associated with the customer design win customer record.',
    `win_probability_percent` DECIMAL(18,2) COMMENT 'The win probability percent of the customer design win record in the customer domain.',
    CONSTRAINT pk_customer_design_win PRIMARY KEY(`customer_design_win_id`)
) COMMENT 'Unified record tracking the full design-in lifecycle from initial registration through confirmed design-win for semiconductor products selected by customers. SSOT for the complete design-in pipeline from early registration through revenue forecasting — distinct from sales-domain opportunity records which track revenue probability and sales stage. Captures design project name, target end product/application (e.g., smartphone SoC, ADAS ECU, AI accelerator), platform generation, process node, package type, device/part number selected, design-win stage (registered, evaluating, sampling, won, lost, on-hold), registration date, design-win confirmation date, tapeout target date, production ramp date, estimated annual unit volume (AUV), estimated annual revenue, competitive displacement flag, associated distributor (if channel-sourced), FAE owner, and NRE requirements. Integrates with Salesforce CRM Opportunity.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` (
    `customer_design_registration_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each customer design registration record.',
    `authoritative_sales_design_registration_id` BIGINT COMMENT 'Authoritative single-source-of-truth reference to owning entity sales.sales_design_registration resolving the cross-domain SSOT duplicate with sales.customer_design_registration.',
    `channel_partner_id` BIGINT COMMENT 'Identifier of the distributor (if any) associated with the registration.',
    `account_id` BIGINT COMMENT 'Identifier of the customer owning the design project.',
    `customer_distributor_account_id` BIGINT COMMENT 'Unique identifier for the customer distributor account record within the customer design registration customer entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: DESIGN REGISTRATION: Captures the sales engineer responsible for registering a design win, required for revenue attribution and performance dashboards.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Design registration validation uses the catalog to verify process node, package, and qualification; part_number is redundant and removed.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the customer design registration customer entity.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Design registration specifies the intended package type; linking ensures downstream packaging aligns with the registered specifications, used in the Design Registration Review process.',
    `sales_design_registration_id` BIGINT COMMENT 'Cross-domain FK to authoritative SSOT owner sales.sales_design_registration (resolves MVM SSOT duplicate).',
    `application` STRING COMMENT 'The application of the customer design registration record in the customer domain.',
    `approval_date` DATE COMMENT 'The approval date associated with the customer design registration customer record.',
    `approved_by` STRING COMMENT 'The approved by of the customer design registration record in the customer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the registration record was first created.',
    `design_complexity` STRING COMMENT 'Qualitative assessment of design difficulty.. Valid values are `low|medium|high`',
    `design_project_description` STRING COMMENT 'Free‑form description of the design objectives, features, and scope.',
    `design_project_name` STRING COMMENT 'Human‑readable name of the customer’s design project.',
    `design_start_date` DATE COMMENT 'Date when the customer officially started the design effort.',
    `end_application` STRING COMMENT 'The end application of the customer design registration record in the customer domain.',
    `end_customer_name` STRING COMMENT 'The end customer name of the customer design registration record in the customer domain.',
    `end_product` STRING COMMENT 'The end product of the customer design registration record in the customer domain.',
    `estimated_annual_volume` BIGINT COMMENT 'The estimated annual volume of the customer design registration record in the customer domain.',
    `estimated_volume` BIGINT COMMENT 'The estimated volume of the customer design registration record in the customer domain.',
    `expected_volume` STRING COMMENT 'The expected volume of the customer design registration record in the customer domain.',
    `expected_yield_percent` DECIMAL(18,2) COMMENT 'Projected percentage of good dies per wafer for the design.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the customer design registration customer record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the customer design registration record in the customer domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the customer design registration record in the customer domain.',
    `nre_budget_amount` DECIMAL(18,2) COMMENT 'Non‑Recurring Engineering budget allocated for the design project.',
    `nre_budget_currency` STRING COMMENT 'Currency of the NRE budget amount.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `package_type` STRING COMMENT 'Physical package style for the final silicon die.. Valid values are `BGA|QFN|WLCSP|COB|FOUP`',
    `platform_generation` STRING COMMENT 'Generation of the semiconductor platform (e.g., next‑gen, legacy) targeted by the design.. Valid values are `gen1|gen2|gen3|gen4|gen5`',
    `process_node_nm` STRING COMMENT 'Technology node (in nanometers) selected for the design.. Valid values are `7nm|5nm|3nm|2nm|1nm`',
    `production_target_date` DATE COMMENT 'Target date for first silicon production run.',
    `project_name` STRING COMMENT 'The project name of the customer design registration record in the customer domain.',
    `qualification_date` DATE COMMENT 'Date when the qualification status was determined.',
    `qualification_status` STRING COMMENT 'Result of the customer design qualification review.. Valid values are `pending|qualified|disqualified`',
    `registration_date` DATE COMMENT 'The registration date associated with the customer design registration customer record.',
    `registration_number` STRING COMMENT 'Business identifier assigned to the design registration, used for tracking and external communication.',
    `registration_status` STRING COMMENT 'Current lifecycle state of the design registration.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `special_pricing_flag` BOOLEAN COMMENT 'The special pricing flag of the customer design registration record in the customer domain.',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the design_registration concept (sales.sales_design_registration)',
    `tapeout_target_date` DATE COMMENT 'Planned date for the final mask set release (tape‑out).',
    `target_application` STRING COMMENT 'Primary market or end‑use application for which the design is intended.. Valid values are `mobile|automotive|ai|iot|datacenter|consumer`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the registration record.',
    CONSTRAINT pk_customer_design_registration PRIMARY KEY(`customer_design_registration_id`)
) COMMENT 'Formal registration of a customer design project that uses a specific semiconductor product, capturing the design project name, target application, platform generation, process node, package type, design start date, tapeout target date, production target date, design registration status, and associated distributor (if applicable). Enables early pipeline visibility and NRE planning. Precedes and feeds into design_win records.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` (
    `qualification_status_id` BIGINT COMMENT 'Unique surrogate key for each qualification status record.',
    `account_id` BIGINT COMMENT 'Unique identifier for the secondary account record within the qualification status customer entity.',
    `fabrication_technology_node_id` BIGINT COMMENT 'add column fabrication_technology_node_id (BIGINT) with FK to fabrication.fabrication_technology_node.fabrication_technology_node_id - customer qualification is technology node specific',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the qualification status customer entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the qualification status customer entity.',
    `primary_account_id` BIGINT COMMENT 'FK to customer.account.account_id — Qualification status is per-account (or per-site). Must reference the account being qualified.',
    `primary_qualification_owner_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: QUALIFICATION OWNERSHIP: Tracks which employee owns each qualification record for audit and compliance reporting, essential for product qualification governance.',
    `site_id` BIGINT COMMENT 'Identifier of the specific customer site or location being qualified.',
    `aec_q_status` STRING COMMENT 'Status of the AEC-Q100/Q101 compliance qualification.. Valid values are `not_applicable|compliant|non_compliant|pending`',
    `approved_by` STRING COMMENT 'The approved by of the qualification status record in the customer domain.',
    `completion_date` DATE COMMENT 'The completion date associated with the qualification status customer record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was created.',
    `document_reference` STRING COMMENT 'Reference code for attached qualification documentation.',
    `effective_from` DATE COMMENT 'Date when the qualification becomes effective.',
    `effective_until` DATE COMMENT 'Date when the qualification expires or is no longer effective.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the qualification status customer record.',
    `iatf_16949_status` STRING COMMENT 'Status of the IATF 16949 automotive quality certification.. Valid values are `not_certified|certified|pending|revoked`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the qualification status record in the customer domain.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the qualification record.. Valid values are `draft|active|suspended|expired|revoked`',
    `notes` STRING COMMENT 'The notes of the qualification status record in the customer domain.',
    `overall_qualification_status` STRING COMMENT 'Aggregated qualification outcome for the customer.. Valid values are `qualified|conditionally_qualified|not_qualified|pending`',
    `ppap_status` STRING COMMENT 'Status of the Production Part Approval Process qualification.. Valid values are `not_started|in_progress|completed|failed`',
    `qualification_completion_date` DATE COMMENT 'Date when qualification was completed.',
    `qualification_date` DATE COMMENT 'The qualification date associated with the qualification status customer record.',
    `qualification_level` STRING COMMENT 'The qualification level of the qualification status record in the customer domain.',
    `qualification_notes` STRING COMMENT 'Free-text notes regarding the qualification process.',
    `qualification_number` STRING COMMENT 'External reference number assigned to the qualification record.',
    `qualification_requirements` STRING COMMENT 'Specific qualification requirements applicable to the customer.',
    `qualification_review_date` DATE COMMENT 'Date of the most recent qualification review.',
    `qualification_score` DECIMAL(18,2) COMMENT 'Numeric score (0-100) representing overall qualification assessment.',
    `qualification_standard` STRING COMMENT 'The qualification standard of the qualification status record in the customer domain.',
    `qualification_start_date` DATE COMMENT 'Date when qualification activities commenced.',
    `qualification_state` STRING COMMENT 'The qualification state of the qualification status record in the customer domain.',
    `qualification_status_status` STRING COMMENT 'The status of the qualification status record in the customer domain.',
    `qualification_type` STRING COMMENT 'Category of qualification based on industry segment.. Valid values are `automotive|industrial|consumer|aerospace`',
    `qualified_date` DATE COMMENT 'The qualified date associated with the qualification status customer record.',
    `qualified_product_families` STRING COMMENT 'Comma-separated list of product families the customer is qualified to receive.',
    `requalification_required_flag` BOOLEAN COMMENT 'The requalification required flag of the qualification status record in the customer domain.',
    `result` STRING COMMENT 'The result of the qualification status record in the customer domain.',
    `start_date` DATE COMMENT 'The start date associated with the qualification status customer record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the qualification record.',
    CONSTRAINT pk_qualification_status PRIMARY KEY(`qualification_status_id`)
) COMMENT 'Tracks the qualification and approval status of a customer account or specific customer site for purchasing and receiving semiconductor products, including automotive PPAP (Production Part Approval Process) qualification, AEC-Q100/Q101 compliance acknowledgment, IATF 16949 certification status, customer-specific qualification requirements, qualification start date, qualification completion date, qualified product families, and qualification expiry date. Critical for automotive and industrial customer management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` (
    `engagement_activity_id` BIGINT COMMENT 'Unique identifier for the engagement activity record.',
    `account_id` BIGINT COMMENT 'Unique identifier for the primary account record within the engagement activity customer entity.',
    `contact_id` BIGINT COMMENT 'FK to customer.contact.contact_id — Engagement activities involve specific contacts (meeting participants, email recipients).',
    `employee_id` BIGINT COMMENT 'Unique identifier for the engagement employee record within the engagement activity customer entity.',
    `opportunity_id` BIGINT COMMENT 'Identifier of the sales opportunity linked to the activity.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the engagement activity customer entity.',
    `primary_engagement_account_id` BIGINT COMMENT 'Identifier of the customer account associated with the activity.',
    `ic_design_project_id` BIGINT COMMENT 'Identifier of the design project referenced in the activity.',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product discussed or demonstrated.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Engagement Activity logs include activities tied to a specific research project, needed for project status dashboards and resource planning.',
    `activity_category` STRING COMMENT 'High‑level classification of the activity purpose.. Valid values are `technical|commercial|legal|support`',
    `activity_channel` STRING COMMENT 'The activity channel of the engagement activity record in the customer domain.',
    `activity_date` DATE COMMENT 'The activity date associated with the engagement activity customer record.',
    `activity_description` STRING COMMENT 'The activity description of the engagement activity record in the customer domain.',
    `activity_duration_minutes` STRING COMMENT 'Length of the activity measured in minutes.',
    `activity_outcome` STRING COMMENT 'The activity outcome of the engagement activity record in the customer domain.',
    `activity_status` STRING COMMENT 'The activity status of the engagement activity record in the customer domain.',
    `activity_subject` STRING COMMENT 'The activity subject of the engagement activity record in the customer domain.',
    `activity_timestamp` TIMESTAMP COMMENT 'Date and time when the engagement activity occurred.',
    `activity_type` STRING COMMENT 'Category of the engagement activity (e.g., technical visit, design review, product demo, sample request, NDA signing, executive briefing, strategic account designation, tier upgrade, account escalation, at‑risk flag). [ENUM-REF-CANDIDATE: technical_visit|design_review|product_demo|sample_request|nda_signing|executive_briefing|strategic_account_designation|tier_upgrade|account_escalation|at_risk_flag — promote to reference product]',
    `attachment_count` STRING COMMENT 'Number of files attached to the activity record.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budgeted monetary amount allocated for the activity.',
    `business_impact` STRING COMMENT 'Qualitative impact of the activity on the business relationship.. Valid values are `positive|neutral|negative`',
    `channel` STRING COMMENT 'Medium through which the activity was conducted.. Valid values are `in_person|virtual|phone|email|field_service`',
    `compliance_status` STRING COMMENT 'Compliance status of the activity with internal and external regulations.. Valid values are `compliant|non_compliant|exempt`',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the activity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the activity record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter currency code for the budget amount.. Valid values are `^[A-Z]{3}$`',
    `engagement_score` STRING COMMENT 'Numeric rating (1‑10) of the overall engagement quality.',
    `follow_up_date` DATE COMMENT 'The follow up date associated with the engagement activity customer record.',
    `follow_up_due_date` DATE COMMENT 'Planned date for the next follow‑up action.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the activity is billable to the customer.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the activity contains confidential information.',
    `is_escalated` BOOLEAN COMMENT 'Indicates whether the activity was escalated to higher management.',
    `language` STRING COMMENT 'Language used during the activity.. Valid values are `EN|JP|KR|CN|DE|FR`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the engagement activity record in the customer domain.',
    `location` STRING COMMENT 'Physical location where the activity took place.',
    `new_status` STRING COMMENT 'Engagement status after the activity.. Valid values are `prospect|qualified|design_win|implementation|support`',
    `next_action` STRING COMMENT 'Planned follow‑up action after the activity.',
    `notes` STRING COMMENT 'Additional free‑form notes captured during the activity.',
    `outcome` STRING COMMENT 'Free‑text description of the result of the activity.',
    `participant_email` STRING COMMENT 'Email address of the participant.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `participant_name` STRING COMMENT 'Full legal name of the participant.',
    `participant_role` STRING COMMENT 'Role of the participant representing the company in the activity.. Valid values are `FAE|Sales|Account_Manager|Customer_Engineer|Executive`',
    `prior_status` STRING COMMENT 'Engagement status before the activity.. Valid values are `prospect|qualified|design_win|implementation|support`',
    `priority` STRING COMMENT 'The priority of the engagement activity record in the customer domain.',
    `region` STRING COMMENT 'Three‑letter country code representing the region of the activity.. Valid values are `^[A-Z]{3}$`',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates if the activity must be reported to a regulatory body.',
    `risk_flag` STRING COMMENT 'Risk level associated with the engagement.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the activity record.',
    CONSTRAINT pk_engagement_activity PRIMARY KEY(`engagement_activity_id`)
) COMMENT 'Comprehensive log of all customer engagement activities, touchpoints, and relationship milestone events. Covers FAE technical visits, design review meetings, product demonstrations, sample requests follow-ups, NDA signings, executive briefings, as well as significant relationship milestones (strategic account designation, tier upgrades, account escalations, at-risk flags). Captures activity type, date, participants, account, opportunity reference, outcome, next action, channel, prior/new state for milestone events, and business impact. Integrates with Salesforce CRM Activity/Task/Event objects. Supports customer relationship health scoring and lifecycle tracking.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` (
    `nda_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the NDA agreement record.',
    `account_id` BIGINT COMMENT 'Unique identifier for the secondary account record within the nda agreement customer entity.',
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact record within the nda agreement customer entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the nda agreement customer entity.',
    `primary_account_id` BIGINT COMMENT 'FK to customer.account.account_id — NDAs are executed with customer accounts. Must reference the account for access control and roadmap sharing decisions.',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the NDA by the legal or sales organization.',
    `agreement_status` STRING COMMENT 'The agreement status of the nda agreement record in the customer domain.',
    `agreement_type` STRING COMMENT 'The agreement type of the nda agreement record in the customer domain.',
    `auto_renew_flag` BOOLEAN COMMENT 'The auto renew flag of the nda agreement record in the customer domain.',
    `compliance_requirements` STRING COMMENT 'List of regulatory or contractual compliance obligations referenced in the NDA (e.g., ITAR, EAR, GDPR).',
    `confidentiality_level` STRING COMMENT 'Classification of the NDAs sensitivity as defined by corporate data governance.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the NDA record was first created in the system.',
    `disclosure_scope` STRING COMMENT 'The disclosure scope of the nda agreement record in the customer domain.',
    `document_reference_code` STRING COMMENT 'Identifier linking to the stored NDA document in the document management system.',
    `document_url` STRING COMMENT 'The document url of the nda agreement record in the customer domain.',
    `effective_date` DATE COMMENT 'Date on which the NDA becomes legally binding.',
    `execution_date` DATE COMMENT 'Date the NDA was signed by the authorized signatory.',
    `expiry_date` DATE COMMENT 'Date on which the NDA expires unless renewed.',
    `governing_law` STRING COMMENT 'The governing law of the nda agreement record in the customer domain.',
    `jurisdiction` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code representing the legal jurisdiction governing the NDA.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the nda agreement record in the customer domain.',
    `legal_entity_name` STRING COMMENT 'Official legal name of the customer organization bound by the NDA.',
    `mutual_flag` BOOLEAN COMMENT 'The mutual flag of the nda agreement record in the customer domain.',
    `nda_agreement_status` STRING COMMENT 'Current lifecycle state of the NDA agreement.. Valid values are `active|expired|pending|under_renewal`',
    `nda_number` STRING COMMENT 'The nda number of the nda agreement record in the customer domain.',
    `nda_status` STRING COMMENT 'The nda status of the nda agreement record in the customer domain.',
    `nda_type` STRING COMMENT 'Indicates whether the NDA is mutual (both parties exchange confidential information) or one‑way (only the semiconductor company shares information).. Valid values are `mutual|one-way`',
    `renewal_notice_date` DATE COMMENT 'Date on which a renewal notice must be sent to the customer before expiry.',
    `scope_description` STRING COMMENT 'Free‑text description of the technology, roadmap, pricing, or other information covered by the NDA.',
    `signatory_email` STRING COMMENT 'Email address of the signatory used for correspondence and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `signatory_name` STRING COMMENT 'Legal name of the individual who signed the NDA on behalf of the customer.',
    `signatory_phone` STRING COMMENT 'Primary telephone number of the signatory.',
    `signed_by` STRING COMMENT 'The signed by of the nda agreement record in the customer domain.',
    `signed_by_company` STRING COMMENT 'The signed by company of the nda agreement record in the customer domain.',
    `signed_by_counterparty` STRING COMMENT 'The signed by counterparty of the nda agreement record in the customer domain.',
    `signed_date` DATE COMMENT 'The signed date associated with the nda agreement customer record.',
    `term_months` STRING COMMENT 'The term months of the nda agreement record in the customer domain.',
    `termination_reason` STRING COMMENT 'Reason provided for early termination of the NDA, if applicable.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the NDA record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the NDA record.',
    `version_number` STRING COMMENT 'Incremental version of the NDA when amendments are made.',
    `created_by` STRING COMMENT 'User identifier of the person who created the NDA record.',
    CONSTRAINT pk_nda_agreement PRIMARY KEY(`nda_agreement_id`)
) COMMENT 'Non-Disclosure Agreement records between the semiconductor company and customer accounts, capturing NDA type (mutual, one-way), execution date, expiry date, covered scope (product roadmap, process technology, pricing), signatory contacts, legal entity names, NDA status (active, expired, under renewal), and document reference ID. Required before sharing roadmap, PDK, or pre-production device information with customers.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`account_team` (
    `account_team_id` BIGINT COMMENT 'Unique surrogate key for each account team assignment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal employee (sales, FAE, support) assigned to the account.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account to which the team member is assigned.',
    `allocation_percent` DECIMAL(18,2) COMMENT 'The allocation percent of the account team record in the customer domain.',
    `assigned_from` DATE COMMENT 'The assigned from of the account team record in the customer domain.',
    `assigned_until` DATE COMMENT 'The assigned until of the account team record in the customer domain.',
    `assignment_end_date` DATE COMMENT 'The assignment end date associated with the account team customer record.',
    `assignment_start_date` DATE COMMENT 'The assignment start date associated with the account team customer record.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment (e.g., active, inactive, pending, terminated).. Valid values are `active|inactive|pending|terminated`',
    `coverage_region` STRING COMMENT 'Broader geographic region covered by the team member for this account.. Valid values are `North America|Europe|Asia`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created in the system.',
    `end_date` DATE COMMENT 'Date when the employees assignment to the account ends or is scheduled to end (null if ongoing).',
    `is_active` BOOLEAN COMMENT 'The is active of the account team record in the customer domain.',
    `is_primary` BOOLEAN COMMENT 'The is primary of the account team record in the customer domain.',
    `is_primary_owner` BOOLEAN COMMENT 'The is primary owner of the account team record in the customer domain.',
    `is_primary_team` BOOLEAN COMMENT 'True if this assignment belongs to the accounts primary coverage team (as opposed to secondary support).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the account team record in the customer domain.',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information about the assignment.',
    `primary_contact_flag` BOOLEAN COMMENT 'True if this team member is the primary point of contact for the account.',
    `responsibility` STRING COMMENT 'The responsibility of the account team record in the customer domain.',
    `responsibility_area` STRING COMMENT 'The responsibility area of the account team record in the customer domain.',
    `role` STRING COMMENT 'Functional role of the employee within the account coverage team.. Valid values are `Account Manager|FAE|Regional Sales Manager|Application Engineer|Customer Success Manager`',
    `start_date` DATE COMMENT 'Date when the employees assignment to the account becomes effective.',
    `team_role` STRING COMMENT 'The team role of the account team record in the customer domain.',
    `territory` STRING COMMENT 'Geographic sales territory associated with the assignment (e.g., NA, EMEA, APAC).. Valid values are `NA|EMEA|APAC`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    `workload_percentage` DECIMAL(18,2) COMMENT 'Portion of the employees total workload allocated to this account (percentage).',
    CONSTRAINT pk_account_team PRIMARY KEY(`account_team_id`)
) COMMENT 'Assignment of internal sales, FAE, and support personnel to customer accounts, defining the account coverage team structure. Captures team member employee ID, account ID, role (Account Manager, FAE, Regional Sales Manager, Application Engineer, Customer Success Manager), territory, assignment start date, assignment end date, primary contact flag, and coverage region. Enables account ownership tracking and workload management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` (
    `distributor_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the distributor agreement record.',
    `account_id` BIGINT COMMENT 'Unique identifier for the secondary account record within the distributor agreement customer entity.',
    `channel_partner_id` BIGINT COMMENT 'Unique identifier of the distributor party associated with this agreement.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the distributor agreement customer entity.',
    `primary_account_id` BIGINT COMMENT 'FK to customer.account.account_id — Distributor agreements reference the distributors account record. The distributor is a type of account.',
    `agreement_number` STRING COMMENT 'External contract number assigned by the company to identify the agreement.',
    `agreement_status` STRING COMMENT 'The agreement status of the distributor agreement record in the customer domain.',
    `agreement_type` STRING COMMENT 'Classification of the agreement such as distribution, exclusive, or co-marketing.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement received final approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the agreement.',
    `auto_renew_flag` BOOLEAN COMMENT 'The auto renew flag of the distributor agreement record in the customer domain.',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'The commission rate pct of the distributor agreement record in the customer domain.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'The commission rate percent of the distributor agreement record in the customer domain.',
    `compliance_requirements` STRING COMMENT 'List of regulatory or industry compliance obligations attached to the agreement.',
    `contract_document_url` STRING COMMENT 'Link to the stored electronic copy of the signed agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the distributor agreement record in the customer domain.',
    `credit_limit_usd` DECIMAL(18,2) COMMENT 'The credit limit usd of the distributor agreement record in the customer domain.',
    `currency_code` STRING COMMENT 'Currency used for all monetary amounts in the agreement.. Valid values are `^[A-Z]{3}$`',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'Standard discount percentage applied to the distributors purchases.',
    `distributor_agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.. Valid values are `active|inactive|terminated|pending|draft`',
    `distributor_tier` STRING COMMENT 'The distributor tier of the distributor agreement record in the customer domain.',
    `effective_date` DATE COMMENT 'The effective date associated with the distributor agreement customer record.',
    `effective_end_date` DATE COMMENT 'Date when the agreement expires or is terminated; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the agreement becomes legally binding.',
    `exclusive_distribution` BOOLEAN COMMENT 'True if the distributor has exclusive rights for the territory/product line.',
    `exclusivity_flag` BOOLEAN COMMENT 'The exclusivity flag of the distributor agreement record in the customer domain.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the distributor agreement customer record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the distributor agreement record in the customer domain.',
    `mdf_currency` STRING COMMENT 'Currency code for the MDF entitlement.. Valid values are `^[A-Z]{3}$`',
    `mdf_entitlement_amount` DECIMAL(18,2) COMMENT 'Monetary amount of Marketing Development Fund allocated to the distributor.',
    `mdf_expiry_date` DATE COMMENT 'Date when the MDF entitlement expires if not used.',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of units the distributor must order per transaction.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or remarks.',
    `price_protection_flag` BOOLEAN COMMENT 'The price protection flag of the distributor agreement record in the customer domain.',
    `price_protection_terms` STRING COMMENT 'Textual description of price protection clauses (e.g., minimum advertised price).',
    `product_line_codes` STRING COMMENT 'Comma‑separated list of product line identifiers the distributor is authorized to sell.',
    `product_scope` STRING COMMENT 'The product scope of the distributor agreement record in the customer domain.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `regulatory_approval_status` STRING COMMENT 'Current status of required regulatory approvals for the agreement.. Valid values are `approved|pending|rejected`',
    `renewal_notice_period_days` STRING COMMENT 'Number of days the distributor must be notified before automatic renewal.',
    `renewal_option` STRING COMMENT 'Specifies whether the agreement renews automatically, manually, or not at all.. Valid values are `auto|manual|none`',
    `stock_rotation_allowed_flag` BOOLEAN COMMENT 'The stock rotation allowed flag of the distributor agreement record in the customer domain.',
    `stock_rotation_rights` BOOLEAN COMMENT 'Indicates whether the distributor has rights to rotate stock to maintain freshness.',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to give notice before terminating the agreement.',
    `termination_reason` STRING COMMENT 'Reason provided for agreement termination, if applicable.',
    `territory` STRING COMMENT 'The territory of the distributor agreement record in the customer domain.',
    `territory_country_code` STRING COMMENT 'Three‑letter ISO country code representing the geographic territory covered.. Valid values are `^[A-Z]{3}$`',
    `territory_scope` STRING COMMENT 'The territory scope of the distributor agreement record in the customer domain.',
    `tier` STRING COMMENT 'Level of the distributor based on company‑defined criteria.. Valid values are `authorized|preferred|elite`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the distributor agreement record in the customer domain.',
    CONSTRAINT pk_distributor_agreement PRIMARY KEY(`distributor_agreement_id`)
) COMMENT 'Master records of distribution agreements between the semiconductor company and authorized distributor accounts, capturing distributor tier (authorized, preferred, elite), geographic territory coverage, product line authorizations, stock rotation rights, price protection terms, marketing development fund (MDF) entitlements, agreement effective date, expiry date, and agreement status. Distinct from direct customer accounts — distributors resell to end customers.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` (
    `credit_profile_id` BIGINT COMMENT 'Unique identifier for the credit profile record.',
    `account_id` BIGINT COMMENT 'Unique identifier for the secondary account record within the credit profile customer entity.',
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the gl account record within the credit profile customer entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the credit profile customer entity.',
    `primary_account_id` BIGINT COMMENT 'FK to customer.account.account_id — Credit profiles are per-account. Must reference the account for order-to-cash credit checks.',
    `available_credit_usd` DECIMAL(18,2) COMMENT 'The available credit usd of the credit profile record in the customer domain.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the credit profile is subject to any regulatory hold or review.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the credit profile record in the customer domain.',
    `credit_analyst_notes` STRING COMMENT 'Free‑form notes entered by the credit analyst.',
    `credit_hold` BOOLEAN COMMENT 'Indicates whether the customers credit is currently on hold.',
    `credit_hold_flag` BOOLEAN COMMENT 'The credit hold flag of the credit profile record in the customer domain.',
    `credit_hold_reason` STRING COMMENT 'Reason for placing the customers credit on hold.',
    `credit_limit_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount by which the credit limit was adjusted.',
    `credit_limit_adjustment_date` DATE COMMENT 'Date when the credit limit adjustment took effect.',
    `credit_limit_adjustment_reason` STRING COMMENT 'Reason for the most recent credit limit change.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the customer.',
    `credit_limit_currency` STRING COMMENT 'Currency of the credit limit (ISO 4217 three‑letter code).',
    `credit_limit_effective_from` DATE COMMENT 'Date when the current credit limit became effective.',
    `credit_limit_effective_until` DATE COMMENT 'Date when the current credit limit expires (null if open‑ended).',
    `credit_limit_usd` DECIMAL(18,2) COMMENT 'The credit limit usd of the credit profile record in the customer domain.',
    `credit_profile_status` STRING COMMENT 'Current lifecycle status of the credit profile.. Valid values are `active|inactive|on_hold|closed|pending`',
    `credit_profile_type` STRING COMMENT 'Category of the credit profile based on internal risk segmentation.. Valid values are `standard|high_risk|low_risk|custom`',
    `credit_rating` STRING COMMENT 'The credit rating of the credit profile record in the customer domain.',
    `credit_rating_external` STRING COMMENT 'External credit rating from a third‑party agency.. Valid values are `A|B|C|D|E`',
    `credit_rating_internal` STRING COMMENT 'Internal credit rating assigned by the company.. Valid values are `Excellent|Good|Fair|Poor|Bad`',
    `credit_review_date` DATE COMMENT 'Date of the most recent credit review.',
    `credit_review_notes` STRING COMMENT 'Analyst comments from the latest credit review.',
    `credit_review_outcome` STRING COMMENT 'Result of the most recent credit review.. Valid values are `increase|decrease|maintain|hold`',
    `credit_score` STRING COMMENT 'Numerical credit score from an external scoring model.',
    `credit_score_date` DATE COMMENT 'Date when the credit score was obtained.',
    `credit_score_source` STRING COMMENT 'Source of the credit score (e.g., Equifax, Experian).',
    `credit_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the credit limit currently utilized.',
    `currency_code` STRING COMMENT 'Currency used for all monetary fields (ISO 4217).',
    `days_sales_outstanding` STRING COMMENT 'The days sales outstanding of the credit profile record in the customer domain.',
    `dso_days` STRING COMMENT 'The dso days of the credit profile record in the customer domain.',
    `external_rating_agency` STRING COMMENT 'Name of the external agency providing the credit rating.',
    `is_preferred_customer` BOOLEAN COMMENT 'Indicates whether the customer is marked as a preferred partner.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the credit profile record in the customer domain.',
    `last_review_date` DATE COMMENT 'The last review date associated with the credit profile customer record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credit profile.',
    `next_review_date` DATE COMMENT 'The next review date associated with the credit profile customer record.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid balance owed by the customer.',
    `outstanding_balance_usd` DECIMAL(18,2) COMMENT 'The outstanding balance usd of the credit profile record in the customer domain.',
    `overdue_amount` DECIMAL(18,2) COMMENT 'Amount past due beyond the agreed payment terms.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the customer.. Valid values are `Net 30|Net 45|Net 60|Prepay|Cash`',
    `preferred_customer_reason` STRING COMMENT 'Business justification for preferred customer status.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for credit communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `profile_name` STRING COMMENT 'Human‑readable name for the credit profile (e.g., "Standard Credit Profile").',
    `rating_date` DATE COMMENT 'Date when the external credit rating was issued.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the credit profile record was first created.',
    `risk_category` STRING COMMENT 'Overall risk classification derived from credit metrics.. Valid values are `low|medium|high`',
    `status_date` DATE COMMENT 'Date when the credit profile status last changed.',
    `updated_by` STRING COMMENT 'User identifier who last updated the credit profile record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the credit profile record in the customer domain.',
    `created_by` STRING COMMENT 'User identifier who created the credit profile record.',
    CONSTRAINT pk_credit_profile PRIMARY KEY(`credit_profile_id`)
) COMMENT 'Customer-facing credit and financial risk profile maintained by the customer domain as SSOT for customer creditworthiness assessment. Captures credit limit, credit rating (internal and external Dun & Bradstreet), payment terms (Net 30, Net 60, prepay), credit hold status, credit review date, outstanding balance, overdue amount, credit utilization percentage, currency, and credit analyst notes. Distinct from finance-domain AR aging and collections records — this product owns the customers credit posture used for real-time order-to-cash credit checks. Integrates with SAP S/4HANA FI-AR (Accounts Receivable).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` (
    `customer_sample_request_id` BIGINT COMMENT 'Unique identifier for the sample request record.',
    `account_id` BIGINT COMMENT 'FK to customer.account.account_id — Sample requests originate from a customer account. Required for funnel tracking and account-level engagement metrics.',
    `contact_id` BIGINT COMMENT 'FK to customer.contact.contact_id — Sample requests are submitted by a specific contact (design engineer). FK enables follow-up and design-in tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sample request costs are charged to an internal cost center; required for Sample Cost Allocation reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the FAE who approved the sample request.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the customer sample request customer entity.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Sample fulfillment may be executed via an internal order to capture labor/material spend; needed for Internal Order Cost Tracking.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the customer sample request customer entity.',
    `primary_customer_account_id` BIGINT COMMENT 'Identifier of the customer who submitted the sample request.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Normalize shipping address details into address table, reducing redundancy.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Sample request is sent to a specific supplier; linking enables tracking of sample fulfillment and supplier performance.',
    `authoritative_product_sample_request_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `product_sample_request_id` BIGINT COMMENT 'Cross-domain FK to authoritative SSOT owner product.product_sample_request (resolves MVM SSOT duplicate).',
    `application_description` STRING COMMENT 'Free‑form description of the customer’s intended application for the sample.',
    `approval_status` STRING COMMENT 'The approval status of the customer sample request record in the customer domain.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was approved.',
    `cost_adjustment` DECIMAL(18,2) COMMENT 'Any additional charge or discount applied to the gross cost (e.g., tax, handling fee).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Base cost of the sample before any adjustments.',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the sample cost.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `cost_net` DECIMAL(18,2) COMMENT 'Final cost after adjustments; amount to be billed to the customer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the system.',
    `customer_sample_request_status` STRING COMMENT 'Current processing state of the sample request.. Valid values are `pending|approved|rejected|fulfilled|cancelled`',
    `delivery_requested_date` DATE COMMENT 'Date by which the customer expects the sample to be delivered.',
    `evaluation_outcome` STRING COMMENT 'The evaluation outcome of the customer sample request record in the customer domain.',
    `feedback_due_date` DATE COMMENT 'The feedback due date associated with the customer sample request customer record.',
    `fulfillment_status` STRING COMMENT 'Current status of sample fulfillment and delivery.. Valid values are `not_fulfilled|shipped|delivered|returned`',
    `fulfillment_timestamp` TIMESTAMP COMMENT 'Date‑time when the fulfillment status last changed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the customer sample request record in the customer domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the customer sample request record in the customer domain.',
    `notes` STRING COMMENT 'Free‑form notes entered by the requestor or processing team.',
    `part_number` STRING COMMENT 'Part number (e.g., SKU or device ID) of the sample being requested.',
    `priority` STRING COMMENT 'The priority of the customer sample request record in the customer domain.',
    `quantity` STRING COMMENT 'Number of units requested for the sample.',
    `request_date` DATE COMMENT 'The request date associated with the customer sample request customer record.',
    `request_number` STRING COMMENT 'Human‑readable request number assigned by the system.',
    `request_status` STRING COMMENT 'The request status of the customer sample request record in the customer domain.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was submitted by the customer.',
    `sample_purpose` STRING COMMENT 'Intended use of the sample (e.g., evaluation, design‑in, qualification, testing).. Valid values are `evaluation|design_in|qualification|testing`',
    `sample_type` STRING COMMENT 'The sample type of the customer sample request record in the customer domain.',
    `ship_date` DATE COMMENT 'The ship date associated with the customer sample request customer record.',
    `target_application` STRING COMMENT 'The target application of the customer sample request record in the customer domain.',
    `tracking_number` STRING COMMENT 'The tracking number of the customer sample request record in the customer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the request record.',
    CONSTRAINT pk_customer_sample_request PRIMARY KEY(`customer_sample_request_id`)
) COMMENT 'Customer requests for engineering samples, evaluation kits, and pre-production devices prior to volume purchase. Captures requesting contact, account, part number requested, quantity, application description, sample purpose (evaluation, design-in, qualification), requested delivery date, shipping address, approval status, approving FAE, sample cost (if charged), and fulfillment status. Tracks the early-stage design-in funnel from sample to design registration to design-win.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` (
    `price_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the price agreement record.',
    `account_id` BIGINT COMMENT 'FK to customer.account.account_id — Customer-specific pricing is negotiated per account. FK to account is mandatory for pricing lookups during order entry.',
    `customer_design_win_id` BIGINT COMMENT 'Identifier of the associated design‑win record, if the price agreement is tied to a winning design.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue posting for each price agreement requires a GL account; used in the Revenue Recognition report.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Price agreements are contractually bound to a catalog item to ensure correct pricing and compliance; part_number is a denormalized duplicate.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the price agreement customer entity.',
    `price_approved_by_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PRICE APPROVAL: Links the employee who approves a price agreement, needed for audit trails, compliance with pricing governance, and sign‑off reports.',
    `primary_price_account_id` BIGINT COMMENT 'Unique identifier of the customer to which the price agreement applies.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the price agreement, used in contracts and communications.',
    `agreement_status` STRING COMMENT 'The agreement status of the price agreement record in the customer domain.',
    `agreement_type` STRING COMMENT 'Category of the price agreement indicating its purpose or pricing model.. Valid values are `standard|special|volume|promotional`',
    `approval_date` DATE COMMENT 'Date on which the price agreement was approved.',
    `approval_status` STRING COMMENT 'Result of the internal approval workflow for the price agreement.. Valid values are `approved|rejected|pending`',
    `approved_by` STRING COMMENT 'Name or employee identifier of the person who approved the agreement.',
    `contract_reference` STRING COMMENT 'Reference number of the Special Price Authorization or contract linked to this agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the agreed price.',
    `price_agreement_description` STRING COMMENT 'Free‑form text describing the purpose, scope, or special conditions of the agreement.',
    `discount_pct` DECIMAL(18,2) COMMENT 'The discount pct of the price agreement record in the customer domain.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied on top of the base unit price.',
    `effective_date` DATE COMMENT 'The effective date associated with the price agreement customer record.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the price agreement customer record.',
    `effective_from` DATE COMMENT 'Date on which the price agreement becomes binding.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the price agreement customer record.',
    `effective_until` DATE COMMENT 'Date on which the price agreement expires; null for open‑ended agreements.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the price agreement customer record.',
    `incoterms` STRING COMMENT 'The incoterms of the price agreement record in the customer domain.',
    `is_price_locked` BOOLEAN COMMENT 'Indicates whether the price agreement is locked from further changes.',
    `last_modified_by` STRING COMMENT 'User identifier that performed the latest update.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the price agreement record in the customer domain.',
    `min_quantity` STRING COMMENT 'The min quantity of the price agreement record in the customer domain.',
    `minimum_order_quantity` BIGINT COMMENT 'Minimum quantity that must be ordered to qualify for the agreed price.',
    `minimum_quantity` STRING COMMENT 'The minimum quantity of the price agreement record in the customer domain.',
    `notes` STRING COMMENT 'Additional remarks or internal comments related to the agreement.',
    `part_revision` STRING COMMENT 'Specific revision or mask set of the part covered by the agreement.',
    `payment_terms` STRING COMMENT 'The payment terms of the price agreement record in the customer domain.',
    `price_agreement_status` STRING COMMENT 'Current lifecycle state of the price agreement.. Valid values are `active|inactive|suspended|pending|draft|terminated`',
    `price_change_approval_reference` BIGINT COMMENT 'Reference to the approval workflow instance for a price change.',
    `price_change_effective_date` DATE COMMENT 'Date on which a price amendment becomes effective.',
    `price_change_reason` STRING COMMENT 'Narrative reason for a price amendment or re‑negotiation.',
    `price_source` STRING COMMENT 'Origin of the price data (e.g., SAP SD pricing condition, manual entry, external feed).. Valid values are `sap|manual|external`',
    `price_type` STRING COMMENT 'The price type of the price agreement record in the customer domain.',
    `price_uom` STRING COMMENT 'Unit of measure for the price (e.g., per die, per wafer, per lot).',
    `pricing_channel` STRING COMMENT 'Sales channel through which the price is offered.. Valid values are `direct|distributor|online|partner`',
    `pricing_region` STRING COMMENT 'Geographic region to which the pricing terms apply.. Valid values are `NA|EMEA|APAC|LATAM`',
    `pricing_type` STRING COMMENT 'The pricing type of the price agreement record in the customer domain.',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether taxes are already included in the unit price.',
    `tier_end_quantity` BIGINT COMMENT 'Inclusive upper bound of quantity for this volume tier; null if no upper limit.',
    `tier_price` DECIMAL(18,2) COMMENT 'Agreed unit price applicable for the defined volume tier.',
    `tier_start_quantity` BIGINT COMMENT 'Inclusive lower bound of quantity for this volume tier.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of the part, expressed in the specified currency.',
    `unit_price_usd` DECIMAL(18,2) COMMENT 'The unit price usd of the price agreement record in the customer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the price agreement record.',
    `volume_tier` STRING COMMENT 'Label for the volume‑based pricing tier.. Valid values are `tier1|tier2|tier3|tier4`',
    `created_by` STRING COMMENT 'User identifier that created the price agreement record.',
    CONSTRAINT pk_price_agreement PRIMARY KEY(`price_agreement_id`)
) COMMENT 'Customer-specific pricing agreements and special price authorizations (SPAs) negotiated for specific part numbers. SSOT for customer-negotiated prices distinct from sales-domain standard list pricing and discount schedules. Captures agreed unit price, currency, minimum order quantity (MOQ), volume tiers, effective date, expiry date, approval chain, SPA reference number, and associated design-win or contract. These are customer-committed prices that flow into order entry — not sales pipeline pricing assumptions. Integrates with SAP S/4HANA SD pricing conditions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` (
    `customer_ltb_notification_id` BIGINT COMMENT 'System-generated unique identifier for each LTB/EOL notification record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer receiving the LTB/EOL notification.',
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact record within the customer ltb notification customer entity.',
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the ic catalog record within the customer ltb notification customer entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the customer ltb notification customer entity.',
    `authoritative_product_ltb_notification_id` BIGINT COMMENT 'Authoritative single-source-of-truth reference to owning entity product.product_ltb_notification resolving the cross-domain SSOT duplicate with product.customer_ltb_notification.',
    `product_ltb_notification_id` BIGINT COMMENT 'Cross-domain FK to authoritative SSOT owner product.product_ltb_notification (resolves MVM SSOT duplicate).',
    `acknowledged_by_contact` STRING COMMENT 'Name of the customer contact who acknowledged the notification.',
    `acknowledged_flag` BOOLEAN COMMENT 'The acknowledged flag of the customer ltb notification record in the customer domain.',
    `acknowledgment_date` DATE COMMENT 'The acknowledgment date associated with the customer ltb notification customer record.',
    `acknowledgment_deadline` DATE COMMENT 'The acknowledgment deadline of the customer ltb notification record in the customer domain.',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'The acknowledgment required flag of the customer ltb notification record in the customer domain.',
    `acknowledgment_status` STRING COMMENT 'Current response state from the customer.. Valid values are `pending|acknowledged|rejected`',
    `compliance_required` BOOLEAN COMMENT 'Indicates whether the notification is subject to mandatory regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification record was first created in the system.',
    `cross_reference_notes` STRING COMMENT 'Notes on compatibility between the discontinued part and the replacement.',
    `customer_ltb_notification_status` STRING COMMENT 'Lifecycle status of the notification record.. Valid values are `draft|sent|acknowledged|closed|cancelled`',
    `discontinuance_reason_code` STRING COMMENT 'Coded value representing the discontinuance reason code of the customer ltb notification customer record.',
    `eol_announcement_date` DATE COMMENT 'Date the products End‑of‑Life was officially announced to customers.',
    `estimated_ltb_revenue` DECIMAL(18,2) COMMENT 'The estimated ltb revenue of the customer ltb notification record in the customer domain.',
    `estimated_ltb_revenue_usd` DECIMAL(18,2) COMMENT 'The estimated ltb revenue usd of the customer ltb notification record in the customer domain.',
    `estimated_ltb_units` STRING COMMENT 'The estimated ltb units of the customer ltb notification record in the customer domain.',
    `final_order_date` DATE COMMENT 'The final order date associated with the customer ltb notification customer record.',
    `final_shipment_date` DATE COMMENT 'The final shipment date associated with the customer ltb notification customer record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the customer ltb notification record in the customer domain.',
    `last_shipment_date` DATE COMMENT 'Date of the final shipment of the discontinued product.',
    `ltb_order_deadline` DATE COMMENT 'Final date by which customers must place a Last‑Time‑Buy order.',
    `ltb_order_reference` STRING COMMENT 'Customers internal order number for the LTB purchase.',
    `ltb_quantity_committed` STRING COMMENT 'Number of units the customer committed to purchase in the Last‑Time‑Buy.',
    `migration_support_fae` STRING COMMENT 'FAE assigned to assist the customer with migration.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the customer ltb notification record in the customer domain.',
    `notes` STRING COMMENT 'Free‑form field for any extra information relevant to the notification.',
    `notification_channel` STRING COMMENT 'Medium used to deliver the notification.. Valid values are `email|portal|fax|phone|mail`',
    `notification_date` DATE COMMENT 'Date the LTB/EOL notification was sent to the customer.',
    `notification_issue_date` DATE COMMENT 'The notification issue date associated with the customer ltb notification customer record.',
    `notification_number` STRING COMMENT 'Business-visible unique code for the notification, used in communications and tracking.',
    `notification_status` STRING COMMENT 'The notification status of the customer ltb notification record in the customer domain.',
    `notification_type` STRING COMMENT 'The notification type of the customer ltb notification record in the customer domain.',
    `priority` STRING COMMENT 'Business priority assigned to the notification for handling.. Valid values are `low|medium|high`',
    `product_part_number` STRING COMMENT 'Manufacturer part number of the product being discontinued.',
    `recommended_replacement_part` STRING COMMENT 'Part number of the suggested replacement product.',
    `regulatory_obligation` STRING COMMENT 'Regulatory domain that drives the LTB/EOL requirement (e.g., automotive long‑term supply).. Valid values are `automotive|aerospace|consumer|industrial`',
    `replacement_product` STRING COMMENT 'The replacement product of the customer ltb notification record in the customer domain.',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the ltb_notification concept (product.product_ltb_notification)',
    `transition_plan_status` STRING COMMENT 'Current state of the customers transition plan.. Valid values are `not_started|in_progress|completed|blocked`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the notification record.',
    CONSTRAINT pk_customer_ltb_notification PRIMARY KEY(`customer_ltb_notification_id`)
) COMMENT 'Last Time Buy (LTB) and End-of-Life (EOL) customer notification records tracking communication of product discontinuation to affected customer accounts. Captures product part number, EOL announcement date, LTB order deadline, last shipment date, customer account, customer notification date, notification channel, customer acknowledgment status, acknowledged-by contact, LTB quantity committed by customer, LTB order reference, recommended replacement part, cross-reference compatibility notes, migration support FAE assignment, and customer transition plan status. SSOT for customer-facing EOL communication lifecycle. Supports regulatory traceability for automotive long-term supply obligations and customer transition planning.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` (
    `tool_allocation_id` BIGINT COMMENT 'Primary key',
    `account_id` BIGINT COMMENT 'FK to customer account',
    `fab_tool_id` BIGINT COMMENT 'FK to fab tool',
    `ic_catalog_id` BIGINT COMMENT 'FK to IC catalog',
    `employee_id` BIGINT COMMENT 'FK to owner employee',
    `tool_approved_by_employee_id` BIGINT COMMENT 'FK to approving employee',
    `tool_qualification_id` BIGINT COMMENT 'FK to tool qualification',
    `allocated_capacity_pct` DECIMAL(18,2) COMMENT 'Allocated capacity percentage',
    `allocated_capacity_percent` DECIMAL(18,2) COMMENT 'The allocated capacity percent of the tool allocation record in the customer domain.',
    `allocated_capacity_wpw` STRING COMMENT 'Allocated capacity wafers per week',
    `allocated_date` DATE COMMENT 'The allocated date associated with the tool allocation customer record.',
    `allocated_qty` DECIMAL(18,2) COMMENT 'Allocated quantity',
    `allocated_quantity` STRING COMMENT 'Allocated quantity integer',
    `allocated_wafer_starts` STRING COMMENT 'The allocated wafer starts of the tool allocation record in the customer domain.',
    `allocated_wafer_starts_per_week` STRING COMMENT 'The allocated wafer starts per week of the tool allocation record in the customer domain.',
    `allocation_basis` STRING COMMENT 'The allocation basis of the tool allocation record in the customer domain.',
    `allocation_end_date` DATE COMMENT 'The allocation end date associated with the tool allocation customer record.',
    `allocation_notes` STRING COMMENT 'The allocation notes of the tool allocation record in the customer domain.',
    `allocation_number` STRING COMMENT 'The allocation number of the tool allocation record in the customer domain.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage of the tool allocation record in the customer domain.',
    `allocation_period` STRING COMMENT 'The allocation period of the tool allocation record in the customer domain.',
    `allocation_period_end` DATE COMMENT 'The allocation period end of the tool allocation record in the customer domain.',
    `allocation_period_start` DATE COMMENT 'The allocation period start of the tool allocation record in the customer domain.',
    `allocation_priority` STRING COMMENT 'The allocation priority of the tool allocation record in the customer domain.',
    `allocation_qty` STRING COMMENT 'Allocation quantity',
    `allocation_quantity` STRING COMMENT 'The allocation quantity of the tool allocation record in the customer domain.',
    `allocation_start_date` DATE COMMENT 'The allocation start date associated with the tool allocation customer record.',
    `allocation_status` STRING COMMENT 'The allocation status of the tool allocation record in the customer domain.',
    `allocation_type` STRING COMMENT 'The allocation type of the tool allocation record in the customer domain.',
    `approved_by` STRING COMMENT 'The approved by of the tool allocation record in the customer domain.',
    `committed_date` DATE COMMENT 'The committed date associated with the tool allocation customer record.',
    `committed_volume` BIGINT COMMENT 'The committed volume of the tool allocation record in the customer domain.',
    `committed_volume_wafers` STRING COMMENT 'Committed volume in wafers',
    `consumed_capacity_wpw` STRING COMMENT 'Consumed capacity wafers per week',
    `consumed_quantity` STRING COMMENT 'The consumed quantity of the tool allocation record in the customer domain.',
    `contract_reference` STRING COMMENT 'The contract reference of the tool allocation record in the customer domain.',
    `created_at` TIMESTAMP COMMENT 'Created at timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the tool allocation record in the customer domain.',
    `cycle_time_commitment_days` STRING COMMENT 'The cycle time commitment days of the tool allocation record in the customer domain.',
    `effective_date` DATE COMMENT 'The effective date associated with the tool allocation customer record.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the tool allocation customer record.',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the tool allocation customer record.',
    `effective_until` DATE COMMENT 'Effective until date',
    `expiration_date` DATE COMMENT 'The expiration date associated with the tool allocation customer record.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the tool allocation customer record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the tool allocation record in the customer domain.',
    `notes` STRING COMMENT 'The notes of the tool allocation record in the customer domain.',
    `notification_lead_days` STRING COMMENT 'The notification lead days of the tool allocation record in the customer domain.',
    `overflow_allowed_flag` BOOLEAN COMMENT 'The overflow allowed flag of the tool allocation record in the customer domain.',
    `priority` STRING COMMENT 'The priority of the tool allocation record in the customer domain.',
    `priority_class` STRING COMMENT 'The priority class of the tool allocation record in the customer domain.',
    `priority_level` STRING COMMENT 'The priority level of the tool allocation record in the customer domain.',
    `priority_tier` STRING COMMENT 'The priority tier of the tool allocation record in the customer domain.',
    `remaining_capacity_wpw` STRING COMMENT 'Remaining capacity wafers per week',
    `reservation_fee_usd` DECIMAL(18,2) COMMENT 'The reservation fee usd of the tool allocation record in the customer domain.',
    `reserved_capacity_pct` DECIMAL(18,2) COMMENT 'Reserved capacity percentage',
    `reserved_capacity_wph` DECIMAL(18,2) COMMENT 'Reserved capacity wafers per hour',
    `reserved_hours_per_week` DECIMAL(18,2) COMMENT 'The reserved hours per week of the tool allocation record in the customer domain.',
    `reserved_quantity` BIGINT COMMENT 'The reserved quantity of the tool allocation record in the customer domain.',
    `tool_allocation_status` STRING COMMENT 'The status of the tool allocation record in the customer domain.',
    `tool_type` STRING COMMENT 'The tool type of the tool allocation record in the customer domain.',
    `updated_at` TIMESTAMP COMMENT 'Updated at timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the tool allocation record in the customer domain.',
    `utilization_pct` DECIMAL(18,2) COMMENT 'Utilization percentage',
    `utilization_target_pct` DECIMAL(18,2) COMMENT 'The utilization target pct of the tool allocation record in the customer domain.',
    `utilization_target_percent` DECIMAL(18,2) COMMENT 'The utilization target percent of the tool allocation record in the customer domain.',
    `wafer_starts_per_week` BIGINT COMMENT 'The wafer starts per week of the tool allocation record in the customer domain.',
    CONSTRAINT pk_tool_allocation PRIMARY KEY(`tool_allocation_id`)
) COMMENT 'Represents the allocation of fab tools to customer accounts for capacity planning, capturing the percentage of tool capacity assigned and the allocation period.. Existence Justification: Capacity planning teams actively allocate fab tools to customer accounts, recording the percentage of tool capacity assigned and the allocation period. A single account can be allocated multiple fab tools, and a single fab tool can serve multiple accounts simultaneously. The allocation records are managed as a distinct business entity.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_primary_contact_account_id` FOREIGN KEY (`primary_contact_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_primary_account_id` FOREIGN KEY (`primary_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ADD CONSTRAINT `fk_customer_customer_design_win_primary_customer_account_id` FOREIGN KEY (`primary_customer_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ADD CONSTRAINT `fk_customer_customer_design_registration_customer_distributor_account_id` FOREIGN KEY (`customer_distributor_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ADD CONSTRAINT `fk_customer_qualification_status_primary_account_id` FOREIGN KEY (`primary_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ADD CONSTRAINT `fk_customer_engagement_activity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ADD CONSTRAINT `fk_customer_engagement_activity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ADD CONSTRAINT `fk_customer_engagement_activity_primary_engagement_account_id` FOREIGN KEY (`primary_engagement_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_primary_account_id` FOREIGN KEY (`primary_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ADD CONSTRAINT `fk_customer_account_team_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ADD CONSTRAINT `fk_customer_distributor_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ADD CONSTRAINT `fk_customer_distributor_agreement_primary_account_id` FOREIGN KEY (`primary_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_primary_account_id` FOREIGN KEY (`primary_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_primary_customer_account_id` FOREIGN KEY (`primary_customer_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ADD CONSTRAINT `fk_customer_customer_sample_request_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_customer_design_win_id` FOREIGN KEY (`customer_design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`customer_design_win`(`customer_design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_primary_price_account_id` FOREIGN KEY (`primary_price_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ADD CONSTRAINT `fk_customer_customer_ltb_notification_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ADD CONSTRAINT `fk_customer_customer_ltb_notification_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ADD CONSTRAINT `fk_customer_tool_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'oem|fabless|odm|distributor|automotive_tier1|other');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|mail');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'internal|confidential|restricted|public');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'ear|itar|none');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `label_requirements` SET TAGS ('dbx_business_glossary_term' = 'Label Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `label_requirements` SET TAGS ('dbx_value_regex' = 'barcode|qr|none');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Account Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `packaging_requirements` SET TAGS ('dbx_business_glossary_term' = 'Packaging Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `packaging_requirements` SET TAGS ('dbx_value_regex' = 'lead_free|rohs_compliant|custom');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash|custom');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = 'en|es|zh|de|fr|ja');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `revenue_tier` SET TAGS ('dbx_business_glossary_term' = 'Revenue Tier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `revenue_tier` SET TAGS ('dbx_value_regex' = 'small|mid|large|enterprise');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'americas|emea|apac');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `strategic_classification` SET TAGS ('dbx_business_glossary_term' = 'Strategic Classification');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `strategic_classification` SET TAGS ('dbx_value_regex' = 'strategic|core|non_core|partner');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Creation Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `primary_contact_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `primary_contact_account_id` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `primary_contact_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `primary_contact_account_id` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification (DATA_CLASS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department (DEPT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address (EMAIL)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External System Identifier (EXT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name (FN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name (CN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Status (GDPR_CONSENT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_value_regex' = 'granted|revoked|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_employee` SET TAGS ('dbx_business_glossary_term' = 'Employee Flag (IS_EMP)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_key_contact` SET TAGS ('dbx_business_glossary_term' = 'Key Contact Flag (KEY_CONTACT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_key_contact` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_key_contact` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_key_contact` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG_PREF)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|zh|de|fr|other');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `last_consent_update` SET TAGS ('dbx_business_glossary_term' = 'Last Consent Update Timestamp (CONSENT_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date (LAST_INT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name (LN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `linkedin_profile` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile URL (LINKEDIN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `linkedin_profile` SET TAGS ('dbx_value_regex' = '^https?://(www.)?linkedin.com/in/[A-Za-z0-9_-]+$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `linkedin_profile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `linkedin_profile` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag (MKT_OPT_IN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality (NAT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `nationality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Phone');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number (PHONE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel (PREF_COMM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|linkedin|sms|other');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `profile_picture_url` SET TAGS ('dbx_business_glossary_term' = 'Profile Picture URL (PHOTO_URL)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type (ROLE_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'technical|commercial|executive|support|management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone (TZ)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Title (TITLE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy ID (AH_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Account ID (CHILD_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID (PARENT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `primary_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `account_hierarchy_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Description (DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (LEVEL)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Relationship Flag (IS_PRIMARY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `is_ultimate_parent` SET TAGS ('dbx_business_glossary_term' = 'Is Ultimate Parent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User (MODIFIED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type (REL_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'subsidiary|division|affiliate|distributor_branch|joint_venture|other');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `market_share_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Market Share Target (PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `market_vertical` SET TAGS ('dbx_business_glossary_term' = 'Market Vertical');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'standard|premium|discounted');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `revenue_target_usd` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `sales_motion` SET TAGS ('dbx_business_glossary_term' = 'Sales Motion');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `sales_motion` SET TAGS ('dbx_value_regex' = 'direct|indirect|partner|online');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Tier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `sub_vertical` SET TAGS ('dbx_business_glossary_term' = 'Sub‑Vertical Market');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `tam_band` SET TAGS ('dbx_business_glossary_term' = 'TAM Band');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `tam_band` SET TAGS ('dbx_value_regex' = 'large|mid|small');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `target_customer_type` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `target_customer_type` SET TAGS ('dbx_value_regex' = 'oem|fabless|odm|distributor|automotive|government');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `target_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue Usd');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `vertical_market` SET TAGS ('dbx_business_glossary_term' = 'Vertical Market');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`segment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` SET TAGS ('dbx_nat_key_normalized' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_surrogate_key' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_authoritative' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'headquarters|ship_to|bill_to|design_center|office|warehouse');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Address Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Change Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Address Classification');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'internal|external|partner');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_business_glossary_term' = 'Address Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_natural_key' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'country_code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `export_control_screened` SET TAGS ('dbx_business_glossary_term' = 'Export Control Screened Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `export_control_status` SET TAGS ('dbx_business_glossary_term' = 'Export Control Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `export_control_status` SET TAGS ('dbx_value_regex' = 'cleared|restricted|blocked');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `geolocation_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Accuracy');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `geolocation_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `geolocation_accuracy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `geolocation_accuracy` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `is_billing` SET TAGS ('dbx_business_glossary_term' = 'Is Billing');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `is_shipping` SET TAGS ('dbx_business_glossary_term' = 'Is Shipping');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Address Label');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `last_verified` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Line 1');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Line 2');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `lineage_code` SET TAGS ('dbx_business_glossary_term' = 'Address Lineage ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9 -]{3,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Address Purpose');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'logistics|billing|design_support|customer_service|sales');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `street_line1` SET TAGS ('dbx_business_glossary_term' = 'Street Line 1');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `street_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `street_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `street_line2` SET TAGS ('dbx_business_glossary_term' = 'Street Line 2');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `street_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `street_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` SET TAGS ('dbx_subdomain' = 'design_engagement');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` SET TAGS ('dbx_ssot_role' = 'dependent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` SET TAGS ('dbx_ssot_counterpart' = 'sales.sales_design_win');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` SET TAGS ('dbx_ssot_owner' = 'sales.sales_design_win');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Identifier (CDW_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Identifier (DIST_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Field Application Engineer Owner Identifier (FAE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `primary_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `reach_svhc_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Svhc Declaration Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `research_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `authoritative_sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Sales Design Win Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `authoritative_sales_design_win_id` SET TAGS ('dbx_ssot' = 'owner_reference');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Design Win Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_ssot_owner_ref' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `application` SET TAGS ('dbx_business_glossary_term' = 'Application');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `application_segment` SET TAGS ('dbx_business_glossary_term' = 'Application Segment');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `competitive_displacement_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Displacement Flag (COMP_DISP_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `competitor_displaced` SET TAGS ('dbx_business_glossary_term' = 'Competitor Displaced');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Design Win Confirmation Timestamp (DW_CONF_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `design_phase` SET TAGS ('dbx_business_glossary_term' = 'Design Phase');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `design_project_name` SET TAGS ('dbx_business_glossary_term' = 'Design Project Name (DP_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `design_win_name` SET TAGS ('dbx_business_glossary_term' = 'Design Win Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `design_win_number` SET TAGS ('dbx_business_glossary_term' = 'Design Win Number (DW_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `design_win_source` SET TAGS ('dbx_business_glossary_term' = 'Design Win Source (DW_SOURCE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `design_win_source` SET TAGS ('dbx_value_regex' = 'internal|channel|partner');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `design_win_status` SET TAGS ('dbx_business_glossary_term' = 'Design Win Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `end_application` SET TAGS ('dbx_business_glossary_term' = 'End Application');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `end_product` SET TAGS ('dbx_business_glossary_term' = 'End Product');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `estimated_annual_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Revenue (USD) (EST_REV_USD)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `estimated_annual_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Unit Volume (AUV)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `estimated_annual_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Volume');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Design Win Notes (DW_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `nre_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Non‑Recurring Engineering Amount (USD) (NRE_AMT_USD)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `nre_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Non‑Recurring Engineering Required Flag (NRE_REQ_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type (PKG_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `platform_generation` SET TAGS ('dbx_business_glossary_term' = 'Platform Generation (PLAT_GEN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Probability Percent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node (PROC_NODE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `production_ramp_date` SET TAGS ('dbx_business_glossary_term' = 'Production Ramp Date (PROD_RAMP_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Design Win Registration Timestamp (DW_REG_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Design Win Stage (DW_STAGE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'registered|evaluating|sampling|won|lost|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `tapeout_target_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Target Date (TAPEOUT_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application (TARGET_APP)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `win_date` SET TAGS ('dbx_business_glossary_term' = 'Win Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_win` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` SET TAGS ('dbx_subdomain' = 'design_engagement');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` SET TAGS ('dbx_ssot_role' = 'dependent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` SET TAGS ('dbx_ssot_counterpart' = 'sales.sales_design_registration');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` SET TAGS ('dbx_ssot_owner' = 'sales.sales_design_registration');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `customer_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Registration ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `authoritative_sales_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Sales Design Registration Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `authoritative_sales_design_registration_id` SET TAGS ('dbx_ssot' = 'owner_reference');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `customer_distributor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `sales_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Design Registration Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `sales_design_registration_id` SET TAGS ('dbx_ssot_owner_ref' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `application` SET TAGS ('dbx_business_glossary_term' = 'Application');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `design_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Complexity (COMPLEXITY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `design_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `design_project_description` SET TAGS ('dbx_business_glossary_term' = 'Design Project Description (DP_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `design_project_name` SET TAGS ('dbx_business_glossary_term' = 'Design Project Name (DP_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `design_start_date` SET TAGS ('dbx_business_glossary_term' = 'Design Start Date (DS_START)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `end_application` SET TAGS ('dbx_business_glossary_term' = 'End Application');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `end_customer_name` SET TAGS ('dbx_business_glossary_term' = 'End Customer Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `end_customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `end_customer_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `end_product` SET TAGS ('dbx_business_glossary_term' = 'End Product');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `estimated_annual_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Volume');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `estimated_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `expected_volume` SET TAGS ('dbx_business_glossary_term' = 'Expected Volume');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `expected_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percent (YIELD_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `nre_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'NRE Budget Amount (NRE_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `nre_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'NRE Budget Currency (NRE_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `nre_budget_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type (PKG)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'BGA|QFN|WLCSP|COB|FOUP');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `platform_generation` SET TAGS ('dbx_business_glossary_term' = 'Platform Generation (PLAT_GEN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `platform_generation` SET TAGS ('dbx_value_regex' = 'gen1|gen2|gen3|gen4|gen5');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node (NM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_value_regex' = '7nm|5nm|3nm|2nm|1nm');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `production_target_date` SET TAGS ('dbx_business_glossary_term' = 'Production Target Date (PROD_TGT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date (QUAL_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|qualified|disqualified');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number (REG_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status (REG_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `special_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Pricing Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `tapeout_target_date` SET TAGS ('dbx_business_glossary_term' = 'Tape‑out Target Date (TAP_OUT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application (APP)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `target_application` SET TAGS ('dbx_value_regex' = 'mobile|automotive|ai|iot|datacenter|consumer');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_design_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` SET TAGS ('dbx_subdomain' = 'design_engagement');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_status_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `primary_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `primary_qualification_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `primary_qualification_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `primary_qualification_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `aec_q_status` SET TAGS ('dbx_business_glossary_term' = 'AEC-Q Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `aec_q_status` SET TAGS ('dbx_value_regex' = 'not_applicable|compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `iatf_16949_status` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `iatf_16949_status` SET TAGS ('dbx_value_regex' = 'not_certified|certified|pending|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `overall_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `overall_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditionally_qualified|not_qualified|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `ppap_status` SET TAGS ('dbx_business_glossary_term' = 'PPAP Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `ppap_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Qualification Level');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number (QUAL_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Qualification Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_review_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_score` SET TAGS ('dbx_business_glossary_term' = 'Qualification Score');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_state` SET TAGS ('dbx_business_glossary_term' = 'Qualification State');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_status_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'automotive|industrial|consumer|aerospace');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualified_date` SET TAGS ('dbx_business_glossary_term' = 'Qualified Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `qualified_product_families` SET TAGS ('dbx_business_glossary_term' = 'Qualified Product Families');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `requalification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Requalification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Result');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`qualification_status` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` SET TAGS ('dbx_subdomain' = 'design_engagement');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `engagement_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Activity ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `primary_engagement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Design ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Related Product ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_category` SET TAGS ('dbx_business_glossary_term' = 'Activity Category');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_category` SET TAGS ('dbx_value_regex' = 'technical|commercial|legal|support');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_channel` SET TAGS ('dbx_business_glossary_term' = 'Activity Channel');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Activity Duration (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_subject` SET TAGS ('dbx_business_glossary_term' = 'Activity Subject');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Activity Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `business_impact` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Engagement Channel');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_person|virtual|phone|email|field_service');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Activity Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'EN|JP|KR|CN|DE|FR');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Activity Location');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Engagement Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'prospect|qualified|design_win|implementation|support');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next Action');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `participant_email` SET TAGS ('dbx_business_glossary_term' = 'Participant Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `participant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `participant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `participant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `participant_name` SET TAGS ('dbx_business_glossary_term' = 'Participant Full Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `participant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `participant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `participant_role` SET TAGS ('dbx_business_glossary_term' = 'Participant Role');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `participant_role` SET TAGS ('dbx_value_regex' = 'FAE|Sales|Account_Manager|Customer_Engineer|Executive');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Engagement Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `prior_status` SET TAGS ('dbx_value_regex' = 'prospect|qualified|design_win|implementation|support');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `risk_flag` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`engagement_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'NDA Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `primary_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `disclosure_scope` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Scope');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `document_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Url');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `mutual_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutual Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'NDA Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_agreement_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|under_renewal');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_number` SET TAGS ('dbx_business_glossary_term' = 'Nda Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_status` SET TAGS ('dbx_business_glossary_term' = 'Nda Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_type` SET TAGS ('dbx_business_glossary_term' = 'NDA Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_type` SET TAGS ('dbx_value_regex' = 'mutual|one-way');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `renewal_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Signatory Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Full Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_business_glossary_term' = 'Signatory Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signed_by` SET TAGS ('dbx_business_glossary_term' = 'Signed By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signed_by_company` SET TAGS ('dbx_business_glossary_term' = 'Signed By Company');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signed_by_counterparty` SET TAGS ('dbx_business_glossary_term' = 'Signed By Counterparty');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Term Months');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `account_team_id` SET TAGS ('dbx_business_glossary_term' = 'Account Team ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `assigned_from` SET TAGS ('dbx_business_glossary_term' = 'Assigned From');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `assigned_until` SET TAGS ('dbx_business_glossary_term' = 'Assigned Until');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `coverage_region` SET TAGS ('dbx_business_glossary_term' = 'Coverage Geographic Region');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `coverage_region` SET TAGS ('dbx_value_regex' = 'North America|Europe|Asia');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `is_primary_owner` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Owner');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `is_primary_team` SET TAGS ('dbx_business_glossary_term' = 'Primary Team Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Assignment Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `responsibility` SET TAGS ('dbx_business_glossary_term' = 'Responsibility');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `responsibility_area` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Area');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Team Member Role (e.g., Account Manager, FAE, Regional Sales Manager, Application Engineer, Customer Success Manager)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `role` SET TAGS ('dbx_value_regex' = 'Account Manager|FAE|Regional Sales Manager|Application Engineer|Customer Success Manager');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `team_role` SET TAGS ('dbx_business_glossary_term' = 'Team Role');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `territory` SET TAGS ('dbx_value_regex' = 'NA|EMEA|APAC');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_team` ALTER COLUMN `workload_percentage` SET TAGS ('dbx_business_glossary_term' = 'Workload Allocation Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `distributor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Identifier (DIST_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `primary_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number (AGMT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type (AGMT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Pct');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMPLIANCE_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL (CONTRACT_DOC_URL)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Usd');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Currency Code (CURR_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percent (DISC_RATE_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `distributor_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Lifecycle Status (AGMT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `distributor_agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending|draft');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `distributor_tier` SET TAGS ('dbx_business_glossary_term' = 'Distributor Tier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `exclusive_distribution` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Distribution Right (EXCL_DIST_RIGHT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `mdf_currency` SET TAGS ('dbx_business_glossary_term' = 'Marketing Development Fund Currency (MDF_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `mdf_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `mdf_entitlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Development Fund Entitlement Amount (MDF_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `mdf_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Development Fund Expiry Date (MDF_EXP_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MIN_ORDER_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `price_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `price_protection_terms` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Terms (PRICE_PROT_TERMS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `product_line_codes` SET TAGS ('dbx_business_glossary_term' = 'Authorized Product Line Codes (PROD_LINE_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (AUDIT_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (AUDIT_UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days) (RENEW_NOTICE_DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RENEW_OPT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `stock_rotation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Stock Rotation Allowed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `stock_rotation_rights` SET TAGS ('dbx_business_glossary_term' = 'Stock Rotation Rights (STOCK_ROT_RIGHTS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days) (TERM_NOTICE_DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `territory_country_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `territory_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Distributor Tier (DIST_TIER)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'authorized|preferred|elite');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`distributor_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `primary_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `available_credit_usd` SET TAGS ('dbx_business_glossary_term' = 'Available Credit Usd');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Adjustment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Adjustment Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Adjustment Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Usd');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_hold|closed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_type` SET TAGS ('dbx_value_regex' = 'standard|high_risk|low_risk|custom');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_rating_external` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_rating_external` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_rating_internal` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_rating_internal` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Poor|Bad');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_review_outcome` SET TAGS ('dbx_value_regex' = 'increase|decrease|maintain|hold');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_score_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Score Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_score_source` SET TAGS ('dbx_business_glossary_term' = 'Credit Score Source');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `dso_days` SET TAGS ('dbx_business_glossary_term' = 'Dso Days');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `external_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'External Rating Agency');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `is_preferred_customer` SET TAGS ('dbx_business_glossary_term' = 'Preferred Customer Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `outstanding_balance_usd` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Usd');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Amount');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'Net 30|Net 45|Net 60|Prepay|Cash');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `preferred_customer_reason` SET TAGS ('dbx_business_glossary_term' = 'Preferred Customer Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `status_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status Change Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` SET TAGS ('dbx_subdomain' = 'design_engagement');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` SET TAGS ('dbx_ssot_role' = 'dependent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` SET TAGS ('dbx_ssot_counterpart' = 'product.product_sample_request');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` SET TAGS ('dbx_ssot_owner' = 'product.product_sample_request');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `customer_sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Sample Request Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Field Application Engineer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `primary_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `authoritative_product_sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Product Sample Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `product_sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Product Sample Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `product_sample_request_id` SET TAGS ('dbx_ssot_owner_ref' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `application_description` SET TAGS ('dbx_business_glossary_term' = 'Application Description');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost Adjustment');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Sample Gross Cost');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost Currency');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_net` SET TAGS ('dbx_business_glossary_term' = 'Sample Net Cost');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `cost_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `customer_sample_request_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `customer_sample_request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|fulfilled|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `delivery_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `evaluation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Outcome');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `feedback_due_date` SET TAGS ('dbx_business_glossary_term' = 'Feedback Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Fulfillment Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_fulfilled|shipped|delivered|returned');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Fulfillment Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Requested Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Sample Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `sample_purpose` SET TAGS ('dbx_business_glossary_term' = 'Sample Purpose');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `sample_purpose` SET TAGS ('dbx_value_regex' = 'evaluation|design_in|qualification|testing');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_sample_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `primary_price_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'standard|special|volume|promotional');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference (SPA)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Pct');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `discount_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_business_glossary_term' = 'Price Locked Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `min_quantity` SET TAGS ('dbx_business_glossary_term' = 'Min Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `part_revision` SET TAGS ('dbx_business_glossary_term' = 'Part Revision');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|draft|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_change_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'sap|manual|external');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `pricing_channel` SET TAGS ('dbx_business_glossary_term' = 'Pricing Channel');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `pricing_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|online|partner');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `pricing_region` SET TAGS ('dbx_business_glossary_term' = 'Pricing Region');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `pricing_region` SET TAGS ('dbx_value_regex' = 'NA|EMEA|APAC|LATAM');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `pricing_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tier_end_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier End Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tier_price` SET TAGS ('dbx_business_glossary_term' = 'Tier Price');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tier_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tier_start_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier Start Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Usd');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `volume_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` SET TAGS ('dbx_ssot_owner' = 'product.product_ltb_notification');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `customer_ltb_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Customer LTB Notification ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `authoritative_product_ltb_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Product Ltb Notification Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `authoritative_product_ltb_notification_id` SET TAGS ('dbx_ssot' = 'owner_reference');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `product_ltb_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Ltb Notification Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `product_ltb_notification_id` SET TAGS ('dbx_ssot_owner_ref' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `acknowledged_by_contact` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By Contact (ACK_CONTACT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `acknowledged_by_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `acknowledged_by_contact` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `acknowledged_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `acknowledgment_deadline` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status (ACK_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required Flag (COMPLIANCE_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `cross_reference_notes` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Reference Compatibility Notes (COMP_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `customer_ltb_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status (NOTIF_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `customer_ltb_notification_status` SET TAGS ('dbx_value_regex' = 'draft|sent|acknowledged|closed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `discontinuance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discontinuance Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End-of-Life Announcement Date (EOL_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `estimated_ltb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ltb Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `estimated_ltb_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ltb Revenue Usd');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `estimated_ltb_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ltb Units');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `final_order_date` SET TAGS ('dbx_business_glossary_term' = 'Final Order Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `final_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Shipment Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `last_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Shipment Date (LAST_SHIP_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `ltb_order_deadline` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Order Deadline (LTB_DEADLINE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `ltb_order_reference` SET TAGS ('dbx_business_glossary_term' = 'LTB Order Reference (LTB_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `ltb_quantity_committed` SET TAGS ('dbx_business_glossary_term' = 'LTB Quantity Committed (LTB_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `migration_support_fae` SET TAGS ('dbx_business_glossary_term' = 'Migration Support Field Application Engineer (FAE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel (NOTIF_CHAN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|portal|fax|phone|mail');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date (NOTIF_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `notification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Number (NOTIF_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Notification Priority (PRIORITY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `product_part_number` SET TAGS ('dbx_business_glossary_term' = 'Product Part Number (PN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `recommended_replacement_part` SET TAGS ('dbx_business_glossary_term' = 'Recommended Replacement Part (REPL_PART)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `regulatory_obligation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation (REG_OBL)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `regulatory_obligation` SET TAGS ('dbx_value_regex' = 'automotive|aerospace|consumer|industrial');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `replacement_product` SET TAGS ('dbx_business_glossary_term' = 'Replacement Product');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `transition_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Transition Plan Status (TRANS_PLAN_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `transition_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|blocked');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`customer_ltb_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` SET TAGS ('dbx_association_edges' = 'customer.account,equipment.fab_tool');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `tool_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Allocation Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `tool_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `tool_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `tool_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocated_capacity_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity Pct');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocated_capacity_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity Percent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocated_capacity_wpw` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity Wpw');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocated_date` SET TAGS ('dbx_business_glossary_term' = 'Allocated Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocated_qty` SET TAGS ('dbx_business_glossary_term' = 'Allocated Qty');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocated_wafer_starts` SET TAGS ('dbx_business_glossary_term' = 'Allocated Wafer Starts');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocated_wafer_starts_per_week` SET TAGS ('dbx_business_glossary_term' = 'Allocated Wafer Starts Per Week');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_period` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_qty` SET TAGS ('dbx_business_glossary_term' = 'Allocation Qty');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocation Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `committed_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `committed_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `committed_volume_wafers` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume Wafers');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `consumed_capacity_wpw` SET TAGS ('dbx_business_glossary_term' = 'Consumed Capacity Wpw');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumed Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `remaining_capacity_wpw` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity Wpw');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `reserved_capacity_pct` SET TAGS ('dbx_business_glossary_term' = 'Reserved Capacity Pct');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `reserved_capacity_wph` SET TAGS ('dbx_business_glossary_term' = 'Reserved Capacity Wph');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `reserved_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Reserved Hours Per Week');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `tool_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Tool Allocation Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `tool_type` SET TAGS ('dbx_business_glossary_term' = 'Tool Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Utilization Pct');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `utilization_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`tool_allocation` ALTER COLUMN `wafer_starts_per_week` SET TAGS ('dbx_business_glossary_term' = 'Wafer Starts Per Week');
