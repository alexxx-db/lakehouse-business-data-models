-- Schema for Domain: customer | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-07-10 14:04:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`customer` COMMENT 'Single source of truth for all customer identity, account hierarchy, and relationship data. Manages OEM, fabless design house, ODM, distributor, and automotive customer profiles, contacts, segmentation, design-win engagement records, and customer qualification status. Integrates with Salesforce CRM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the account record.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Normalize primary address fields by referencing address table.',
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
    `address_id` BIGINT COMMENT 'FK to customer.address',
    `account_id` BIGINT COMMENT 'FK to customer.account.account_id — Every contact must be associated with exactly one customer account. This is the most fundamental FK in the domain — contacts cannot exist without an account parent.',
    `primary_contact_account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Connect contact to its parent customer account for hierarchy and reporting.',
    `birth_date` DATE COMMENT 'Birth date of the contact, used for age verification where required.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|suspended|pending`',
    `data_classification` STRING COMMENT 'Classification level of the contact data.. Valid values are `restricted|confidential|internal|public`',
    `department` STRING COMMENT 'Department within the organization where the contact works.',
    `email` STRING COMMENT 'Primary email address for the contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `external_reference_code` STRING COMMENT 'Identifier of the contact in external systems (e.g., Salesforce ID).',
    `first_name` STRING COMMENT 'Given name of the contact.',
    `full_name` STRING COMMENT 'Legal full name of the contact person.',
    `gdpr_consent_status` STRING COMMENT 'Current GDPR consent status for personal data processing.. Valid values are `granted|revoked|pending`',
    `is_employee` BOOLEAN COMMENT 'True if the contact is an employee of Semiconductors.',
    `is_key_contact` BOOLEAN COMMENT 'Indicates whether the contact is a primary point of contact for the customer account.',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|zh|de|fr|other`',
    `last_consent_update` TIMESTAMP COMMENT 'Timestamp of the most recent GDPR consent status change.',
    `last_interaction_date` DATE COMMENT 'Date of the most recent interaction with the contact.',
    `last_name` STRING COMMENT 'Family name of the contact.',
    `linkedin_profile` STRING COMMENT 'URL to the contacts LinkedIn professional profile.. Valid values are `^https?://(www.)?linkedin.com/in/[A-Za-z0-9_-]+$`',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates if the contact has opted in to receive marketing communications.',
    `nationality` STRING COMMENT 'Contacts nationality.',
    `notes` STRING COMMENT 'Free-text notes about the contact.',
    `phone_number` STRING COMMENT 'Primary telephone number for the contact, in international format.. Valid values are `^+?[0-9]{7,15}$`',
    `preferred_communication_channel` STRING COMMENT 'Preferred method for contacting the individual.. Valid values are `email|phone|linkedin|sms|other`',
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
    `effective_from` DATE COMMENT 'Date on which the hierarchical relationship became effective.',
    `effective_until` DATE COMMENT 'Date on which the hierarchical relationship ended; null if still active.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the child account within the corporate hierarchy (1 = top‑level).',
    `is_primary` BOOLEAN COMMENT 'True if the child account is the primary entity under the parent; otherwise false.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last updated the hierarchy record.',
    `relationship_type` STRING COMMENT 'Classification of the hierarchical relationship between parent and child accounts.. Valid values are `subsidiary|division|affiliate|distributor_branch|joint_venture|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hierarchy record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the hierarchy record.',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Defines parent-child corporate hierarchy relationships between customer accounts, enabling roll-up of revenue, design-wins, and engagement metrics across global enterprise accounts. Captures parent account, child account, hierarchy level, relationship type (subsidiary, division, affiliate, distributor branch), effective date, and end date. Critical for global OEM and distributor account management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`address` (
    `address_id` BIGINT COMMENT 'System-generated unique identifier for the address record.',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record.. Valid values are `active|inactive|pending|closed`',
    `address_type` STRING COMMENT 'Category of the address indicating its business purpose.. Valid values are `headquarters|ship_to|bill_to|design_center|office|warehouse`',
    `billing_account_code` BIGINT COMMENT 'FK to customer.account.account_id — Addresses are associated with customer accounts (ship-to, bill-to, HQ). This FK is required for order fulfillment, logistics, and export control screening.',
    `change_reason` STRING COMMENT 'Reason code or description for the most recent address change.',
    `change_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent address change was recorded.',
    `city` STRING COMMENT 'City component of the address.',
    `classification` STRING COMMENT 'Classification indicating whether the address belongs to internal organization, external customer, or partner.. Valid values are `internal|external|partner`',
    `address_code` STRING COMMENT 'Internal code used to reference the address within ERP and PLM systems.',
    `contact_email` STRING COMMENT 'Email address of the primary contact at the address.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the address.',
    `contact_phone` STRING COMMENT 'Phone number of the primary contact at the address.',
    `country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 country code.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the address becomes valid for business use.',
    `effective_until` DATE COMMENT 'Date when the address ceases to be valid (null if open‑ended).',
    `export_control_screened` BOOLEAN COMMENT 'True if the address has been screened against export control lists.',
    `export_control_status` STRING COMMENT 'Result of export‑control screening for the address.. Valid values are `cleared|restricted|blocked`',
    `geolocation_accuracy` STRING COMMENT 'Indicates the precision level of the latitude/longitude values.. Valid values are `high|medium|low`',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this address is the primary location for the associated account.',
    `label` STRING COMMENT 'Human‑readable label identifying the address (e.g., “HQ San Jose”).',
    `last_verified` DATE COMMENT 'Date when the address information was last validated.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate in decimal degrees.',
    `lineage_code` BIGINT COMMENT 'Identifier linking this address to its predecessor in case of address merges or splits.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate in decimal degrees.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the address.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.. Valid values are `^[A-Z0-9 -]{3,10}$`',
    `primary_address_account_code` BIGINT COMMENT 'FK to customer.account.account_id — Addresses are associated with customer accounts (ship-to, bill-to, HQ). This is a core master data relationship.',
    `purpose` STRING COMMENT 'Business purpose for which the address is used.. Valid values are `logistics|billing|design_support|customer_service|sales`',
    `region` STRING COMMENT 'Broad geographic region (e.g., APAC, EMEA, AMER) used for reporting.',
    `state_province` STRING COMMENT 'State or province component of the address.',
    `street_line1` STRING COMMENT 'First line of the street address.',
    `street_line2` STRING COMMENT 'Second line of the street address (optional).',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction applicable to the address.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the address location.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the address record.',
    `verification_status` STRING COMMENT 'Current status of address verification.. Valid values are `verified|unverified|pending`',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing addresses associated with customer accounts and contacts, including headquarters, ship-to, bill-to, and design center locations. Captures address type, street lines, city, state/province, postal code, country (ISO 3166), region, time zone, and geolocation coordinates. Supports multi-site global accounts with multiple address records per account. Used for logistics, tax jurisdiction, and export control screening.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`design_win` (
    `design_win_id` BIGINT COMMENT 'Surrogate primary key for the customer design win record.',
    `contact_id` BIGINT COMMENT 'FK to customer.contact.contact_id — Design-wins reference the FAE owner and customer engineering contact. Contact FK enables relationship tracking.',
    `account_id` BIGINT COMMENT 'FK to customer.account.account_id — Every design-win is attributed to a specific customer account. This FK is critical for revenue forecasting and account-level reporting.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Design Win Forecast Report links each customer design win to the internal R&D program delivering the technology, enabling revenue attribution and program performance tracking.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Design‑win forecasts and revenue reports must reference the exact catalog entry; part_number is a denormalized duplicate and is removed.',
    `primary_customer_account_id` BIGINT COMMENT 'Reference to the customer organization that owns the design win.',
    `product_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_spec. Business justification: Design wins must reference the specific product spec version the customer designed to — critical for PCN (product change notification) management, qualification support, and warranty claims. When a sp',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Design win must identify the supplier manufacturing the part, essential for supply chain planning and production ramp scheduling.',
    `competitive_displacement_flag` BOOLEAN COMMENT 'Indicates whether the win displaces a competitors product (true) or not (false).',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when the design win was officially confirmed (won).',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `[A-Z]{3}`',
    `design_project_name` STRING COMMENT 'Name of the internal design project associated with the win.',
    `design_win_number` STRING COMMENT 'External business identifier assigned to the design win record.',
    `estimated_annual_revenue_usd` DECIMAL(18,2) COMMENT 'Projected annual revenue from the design win, expressed in US dollars.',
    `estimated_annual_unit_volume` BIGINT COMMENT 'Projected number of units the customer will purchase per year.',
    `notes` STRING COMMENT 'Free‑form notes captured by the FAE or sales team.',
    `nre_amount_usd` DECIMAL(18,2) COMMENT 'Estimated NRE cost associated with the design win, expressed in US dollars.',
    `nre_required_flag` BOOLEAN COMMENT 'True if the project includes a non‑recurring engineering (NRE) component.',
    `package_type` STRING COMMENT 'Package format chosen for the part (e.g., BGA, WLCSP).',
    `platform_generation` STRING COMMENT 'Generation of the platform family for which the design win is targeted.',
    `process_node` STRING COMMENT 'Technology node (e.g., 7nm, 5nm) selected for the design.',
    `production_ramp_date` DATE COMMENT 'Target date when volume production is expected to ramp.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `registration_timestamp` TIMESTAMP COMMENT 'Timestamp when the design win was first registered in the system.',
    `source` STRING COMMENT 'Origin of the design win (internal development, channel‑sourced, or partner‑sourced).. Valid values are `internal|channel|partner`',
    `stage` STRING COMMENT 'Current stage of the design‑win lifecycle.. Valid values are `registered|evaluating|sampling|won|lost|on_hold`',
    `tapeout_target_date` DATE COMMENT 'Planned date for tape‑out of the design.',
    `target_application` STRING COMMENT 'Intended end‑product or market application (e.g., smartphone SoC, ADAS ECU, AI accelerator).',
    CONSTRAINT pk_design_win PRIMARY KEY(`design_win_id`)
) COMMENT 'Unified record tracking the full design-in lifecycle from initial registration through confirmed design-win for semiconductor products selected by customers. SSOT for the complete design-in pipeline from early registration through revenue forecasting — distinct from sales-domain opportunity records which track revenue probability and sales stage. Captures design project name, target end product/application (e.g., smartphone SoC, ADAS ECU, AI accelerator), platform generation, process node, package type, device/part number selected, design-win stage (registered, evaluating, sampling, won, lost, on-hold), registration date, design-win confirmation date, tapeout target date, production ramp date, estimated annual unit volume (AUV), estimated annual revenue, competitive displacement flag, associated distributor (if channel-sourced), FAE owner, and NRE requirements. Integrates with Salesforce CRM Opportunity.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` (
    `design_registration_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each customer design registration record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer owning the design project.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Design registrations in the semiconductor industry are initiated by specific contacts — typically design engineers or technical leads at the customer account. Adding contact_id to customer_design_regi',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: A customer design registration is the formal precursor to a design win in the semiconductor design-in lifecycle. Linking customer_design_registration.customer_design_win_id -> customer_design_win.cust',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Design registration process records the fab tool that will be qualified for the project; needed for the Design Qualification Tool Allocation workflow.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: A design registration commits a customer to a specific process flow/technology node. process_node_nm is a denormalized plain-text field; a proper FK to process_flow enables foundry design registration',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Design registration validation uses the catalog to verify process node, package, and qualification; part_number is redundant and removed.',
    `supplier_id` BIGINT COMMENT 'Identifier of the distributor (if any) associated with the registration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the registration record was first created.',
    `design_complexity` STRING COMMENT 'Qualitative assessment of design difficulty.. Valid values are `low|medium|high`',
    `design_project_description` STRING COMMENT 'Free‑form description of the design objectives, features, and scope.',
    `design_project_name` STRING COMMENT 'Human‑readable name of the customer’s design project.',
    `design_start_date` DATE COMMENT 'Date when the customer officially started the design effort.',
    `expected_yield_percent` DECIMAL(18,2) COMMENT 'Projected percentage of good dies per wafer for the design.',
    `nre_budget_amount` DECIMAL(18,2) COMMENT 'Non‑Recurring Engineering budget allocated for the design project.',
    `nre_budget_currency` STRING COMMENT 'Currency of the NRE budget amount.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `package_type` STRING COMMENT 'Physical package style for the final silicon die.. Valid values are `BGA|QFN|WLCSP|COB|FOUP`',
    `platform_generation` STRING COMMENT 'Generation of the semiconductor platform (e.g., next‑gen, legacy) targeted by the design.. Valid values are `gen1|gen2|gen3|gen4|gen5`',
    `production_target_date` DATE COMMENT 'Target date for first silicon production run.',
    `qualification_date` DATE COMMENT 'Date when the qualification status was determined.',
    `qualification_status` STRING COMMENT 'Result of the customer design qualification review.. Valid values are `pending|qualified|disqualified`',
    `registration_number` STRING COMMENT 'Business identifier assigned to the design registration, used for tracking and external communication.',
    `registration_status` STRING COMMENT 'Current lifecycle state of the design registration.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `tapeout_target_date` DATE COMMENT 'Planned date for the final mask set release (tape‑out).',
    `target_application` STRING COMMENT 'Primary market or end‑use application for which the design is intended.. Valid values are `mobile|automotive|ai|iot|datacenter|consumer`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the registration record.',
    CONSTRAINT pk_design_registration PRIMARY KEY(`design_registration_id`)
) COMMENT 'Formal registration of a customer design project that uses a specific semiconductor product, capturing the design project name, target application, platform generation, process node, package type, design start date, tapeout target date, production target date, design registration status, and associated distributor (if applicable). Enables early pipeline visibility and NRE planning. Precedes and feeds into design_win records.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` (
    `nda_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the NDA agreement record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Semiconductor NDAs are routinely scoped to specific product families to protect pre-release roadmap data, design files, and confidential specs. Legal and IP teams track which families are covered per ',
    `account_id` BIGINT COMMENT 'FK to customer.account.account_id — NDAs are executed with customer accounts. Must reference the account for access control and roadmap sharing decisions.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: NDA agreements are executed by specific named contacts (signatories). The nda_agreement table currently stores signatory_name, signatory_email, and signatory_phone as denormalized string columns — the',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: NDAs are executed with suppliers to protect IP; linking supports compliance monitoring and legal audit.',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the NDA by the legal or sales organization.',
    `compliance_requirements` STRING COMMENT 'List of regulatory or contractual compliance obligations referenced in the NDA (e.g., ITAR, EAR, GDPR).',
    `confidentiality_level` STRING COMMENT 'Classification of the NDAs sensitivity as defined by corporate data governance.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the NDA record was first created in the system.',
    `document_reference_code` STRING COMMENT 'Identifier linking to the stored NDA document in the document management system.',
    `effective_date` DATE COMMENT 'Date on which the NDA becomes legally binding.',
    `execution_date` DATE COMMENT 'Date the NDA was signed by the authorized signatory.',
    `expiry_date` DATE COMMENT 'Date on which the NDA expires unless renewed.',
    `jurisdiction` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code representing the legal jurisdiction governing the NDA.. Valid values are `^[A-Z]{3}$`',
    `legal_entity_name` STRING COMMENT 'Official legal name of the customer organization bound by the NDA.',
    `nda_agreement_status` STRING COMMENT 'Current lifecycle state of the NDA agreement.. Valid values are `active|expired|pending|under_renewal`',
    `nda_type` STRING COMMENT 'Indicates whether the NDA is mutual (both parties exchange confidential information) or one‑way (only the semiconductor company shares information).. Valid values are `mutual|one-way`',
    `renewal_notice_date` DATE COMMENT 'Date on which a renewal notice must be sent to the customer before expiry.',
    `scope_description` STRING COMMENT 'Free‑text description of the technology, roadmap, pricing, or other information covered by the NDA.',
    `termination_reason` STRING COMMENT 'Reason provided for early termination of the NDA, if applicable.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the NDA record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the NDA record.',
    `version_number` STRING COMMENT 'Incremental version of the NDA when amendments are made.',
    `created_by` STRING COMMENT 'User identifier of the person who created the NDA record.',
    CONSTRAINT pk_nda_agreement PRIMARY KEY(`nda_agreement_id`)
) COMMENT 'Non-Disclosure Agreement records between the semiconductor company and customer accounts, capturing NDA type (mutual, one-way), execution date, expiry date, covered scope (product roadmap, process technology, pricing), signatory contacts, legal entity names, NDA status (active, expired, under renewal), and document reference ID. Required before sharing roadmap, PDK, or pre-production device information with customers.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` (
    `credit_profile_id` BIGINT COMMENT 'Unique identifier for the credit profile record.',
    `account_id` BIGINT COMMENT 'FK to customer.account.account_id — Credit profiles are per-account. Must reference the account for order-to-cash credit checks.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Credit profiles have a designated primary contact (typically the customers finance or procurement contact responsible for credit matters). The credit_profile table currently stores primary_contact_em',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the credit profile is subject to any regulatory hold or review.',
    `credit_analyst_notes` STRING COMMENT 'Free‑form notes entered by the credit analyst.',
    `credit_hold` BOOLEAN COMMENT 'Indicates whether the customers credit is currently on hold.',
    `credit_hold_reason` STRING COMMENT 'Reason for placing the customers credit on hold.',
    `credit_limit_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount by which the credit limit was adjusted.',
    `credit_limit_adjustment_date` DATE COMMENT 'Date when the credit limit adjustment took effect.',
    `credit_limit_adjustment_reason` STRING COMMENT 'Reason for the most recent credit limit change.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the customer.',
    `credit_limit_currency` STRING COMMENT 'Currency of the credit limit (ISO 4217 three‑letter code).',
    `credit_limit_effective_from` DATE COMMENT 'Date when the current credit limit became effective.',
    `credit_limit_effective_until` DATE COMMENT 'Date when the current credit limit expires (null if open‑ended).',
    `credit_profile_status` STRING COMMENT 'Current lifecycle status of the credit profile.. Valid values are `active|inactive|on_hold|closed|pending`',
    `credit_profile_type` STRING COMMENT 'Category of the credit profile based on internal risk segmentation.. Valid values are `standard|high_risk|low_risk|custom`',
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
    `external_rating_agency` STRING COMMENT 'Name of the external agency providing the credit rating.',
    `is_preferred_customer` BOOLEAN COMMENT 'Indicates whether the customer is marked as a preferred partner.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credit profile.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid balance owed by the customer.',
    `overdue_amount` DECIMAL(18,2) COMMENT 'Amount past due beyond the agreed payment terms.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the customer.. Valid values are `Net 30|Net 45|Net 60|Prepay|Cash`',
    `preferred_customer_reason` STRING COMMENT 'Business justification for preferred customer status.',
    `profile_name` STRING COMMENT 'Human‑readable name for the credit profile (e.g., "Standard Credit Profile").',
    `rating_date` DATE COMMENT 'Date when the external credit rating was issued.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the credit profile record was first created.',
    `risk_category` STRING COMMENT 'Overall risk classification derived from credit metrics.. Valid values are `low|medium|high`',
    `status_date` DATE COMMENT 'Date when the credit profile status last changed.',
    `updated_by` STRING COMMENT 'User identifier who last updated the credit profile record.',
    `created_by` STRING COMMENT 'User identifier who created the credit profile record.',
    CONSTRAINT pk_credit_profile PRIMARY KEY(`credit_profile_id`)
) COMMENT 'Customer-facing credit and financial risk profile maintained by the customer domain as SSOT for customer creditworthiness assessment. Captures credit limit, credit rating (internal and external Dun & Bradstreet), payment terms (Net 30, Net 60, prepay), credit hold status, credit review date, outstanding balance, overdue amount, credit utilization percentage, currency, and credit analyst notes. Distinct from finance-domain AR aging and collections records — this product owns the customers credit posture used for real-time order-to-cash credit checks. Integrates with SAP S/4HANA FI-AR (Accounts Receivable).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` (
    `price_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the price agreement record.',
    `design_win_id` BIGINT COMMENT 'Identifier of the associated design‑win record, if the price agreement is tied to a winning design.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Price agreements are contractually bound to a catalog item to ensure correct pricing and compliance; part_number is a denormalized duplicate.',
    `account_id` BIGINT COMMENT 'FK to customer.account.account_id — Customer-specific pricing is negotiated per account. FK to account is mandatory for pricing lookups during order entry.',
    `primary_price_account_id` BIGINT COMMENT 'Unique identifier of the customer to which the price agreement applies.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Semiconductor price agreements are negotiated at the SKU level — specific package, speed grade, and temperature variant determine the contracted unit price. Sales operations, quote generation, and ord',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Price agreements in semiconductors are negotiated directly with a named supplier (distributor or direct). The supplier price contract management process requires knowing which supplier the agreed pr',
    `agreement_number` STRING COMMENT 'External reference number assigned to the price agreement, used in contracts and communications.',
    `agreement_type` STRING COMMENT 'Category of the price agreement indicating its purpose or pricing model.. Valid values are `standard|special|volume|promotional`',
    `approval_date` DATE COMMENT 'Date on which the price agreement was approved.',
    `approval_status` STRING COMMENT 'Result of the internal approval workflow for the price agreement.. Valid values are `approved|rejected|pending`',
    `approved_by` STRING COMMENT 'Name or employee identifier of the person who approved the agreement.',
    `contract_reference` STRING COMMENT 'Reference number of the Special Price Authorization or contract linked to this agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the agreed price.',
    `price_agreement_description` STRING COMMENT 'Free‑form text describing the purpose, scope, or special conditions of the agreement.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied on top of the base unit price.',
    `effective_from` DATE COMMENT 'Date on which the price agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the price agreement expires; null for open‑ended agreements.',
    `is_price_locked` BOOLEAN COMMENT 'Indicates whether the price agreement is locked from further changes.',
    `last_modified_by` STRING COMMENT 'User identifier that performed the latest update.',
    `minimum_order_quantity` BIGINT COMMENT 'Minimum quantity that must be ordered to qualify for the agreed price.',
    `notes` STRING COMMENT 'Additional remarks or internal comments related to the agreement.',
    `part_revision` STRING COMMENT 'Specific revision or mask set of the part covered by the agreement.',
    `price_agreement_status` STRING COMMENT 'Current lifecycle state of the price agreement.. Valid values are `active|inactive|suspended|pending|draft|terminated`',
    `price_change_approval_reference` BIGINT COMMENT 'Reference to the approval workflow instance for a price change.',
    `price_change_effective_date` DATE COMMENT 'Date on which a price amendment becomes effective.',
    `price_change_reason` STRING COMMENT 'Narrative reason for a price amendment or re‑negotiation.',
    `price_source` STRING COMMENT 'Origin of the price data (e.g., SAP SD pricing condition, manual entry, external feed).. Valid values are `sap|manual|external`',
    `price_uom` STRING COMMENT 'Unit of measure for the price (e.g., per die, per wafer, per lot).',
    `pricing_channel` STRING COMMENT 'Sales channel through which the price is offered.. Valid values are `direct|distributor|online|partner`',
    `pricing_region` STRING COMMENT 'Geographic region to which the pricing terms apply.. Valid values are `NA|EMEA|APAC|LATAM`',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether taxes are already included in the unit price.',
    `tier_end_quantity` BIGINT COMMENT 'Inclusive upper bound of quantity for this volume tier; null if no upper limit.',
    `tier_price` DECIMAL(18,2) COMMENT 'Agreed unit price applicable for the defined volume tier.',
    `tier_start_quantity` BIGINT COMMENT 'Inclusive lower bound of quantity for this volume tier.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of the part, expressed in the specified currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the price agreement record.',
    `volume_tier` STRING COMMENT 'Label for the volume‑based pricing tier.. Valid values are `tier1|tier2|tier3|tier4`',
    `created_by` STRING COMMENT 'User identifier that created the price agreement record.',
    CONSTRAINT pk_price_agreement PRIMARY KEY(`price_agreement_id`)
) COMMENT 'Customer-specific pricing agreements and special price authorizations (SPAs) negotiated for specific part numbers. SSOT for customer-negotiated prices distinct from sales-domain standard list pricing and discount schedules. Captures agreed unit price, currency, minimum order quantity (MOQ), volume tiers, effective date, expiry date, approval chain, SPA reference number, and associated design-win or contract. These are customer-committed prices that flow into order entry — not sales pipeline pricing assumptions. Integrates with SAP S/4HANA SD pricing conditions.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`address`(`address_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_primary_contact_account_id` FOREIGN KEY (`primary_contact_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_primary_account_id` FOREIGN KEY (`primary_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ADD CONSTRAINT `fk_customer_design_win_primary_customer_account_id` FOREIGN KEY (`primary_customer_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ADD CONSTRAINT `fk_customer_design_registration_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ADD CONSTRAINT `fk_customer_design_registration_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ADD CONSTRAINT `fk_customer_design_registration_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ADD CONSTRAINT `fk_customer_nda_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`contact`(`contact_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_design_win_id` FOREIGN KEY (`design_win_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`design_win`(`design_win_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ADD CONSTRAINT `fk_customer_price_agreement_primary_price_account_id` FOREIGN KEY (`primary_price_account_id`) REFERENCES `vibe_semiconductors_v1`.`customer`.`account`(`account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_pii_detected' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `primary_contact_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `primary_contact_account_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_pii_detected' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `is_key_contact` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG_PREF)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|zh|de|fr|other');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `last_consent_update` SET TAGS ('dbx_business_glossary_term' = 'Last Consent Update Timestamp (CONSENT_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date (LAST_INT)');
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
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number (PHONE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel (PREF_COMM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|linkedin|sms|other');
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
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (LEVEL)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Relationship Flag (IS_PRIMARY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User (MODIFIED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type (REL_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'subsidiary|division|affiliate|distributor_branch|joint_venture|other');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`account_hierarchy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'headquarters|ship_to|bill_to|design_center|office|warehouse');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `billing_account_code` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Address Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Change Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Address Classification');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'internal|external|partner');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_business_glossary_term' = 'Address Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
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
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Address Label');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `last_verified` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `lineage_code` SET TAGS ('dbx_business_glossary_term' = 'Address Lineage ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (degrees)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9 -]{3,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `primary_address_account_code` SET TAGS ('dbx_business_glossary_term' = 'Address Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `primary_address_account_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `primary_address_account_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Address Purpose');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'logistics|billing|design_support|customer_service|sales');
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
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`address` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` SET TAGS ('dbx_subdomain' = 'design_engagement');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Identifier (CDW_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `contact_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `primary_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `competitive_displacement_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Displacement Flag (COMP_DISP_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Design Win Confirmation Timestamp (DW_CONF_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `design_project_name` SET TAGS ('dbx_business_glossary_term' = 'Design Project Name (DP_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `design_project_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `design_win_number` SET TAGS ('dbx_business_glossary_term' = 'Design Win Number (DW_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `estimated_annual_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Revenue (USD) (EST_REV_USD)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `estimated_annual_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Unit Volume (AUV)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Design Win Notes (DW_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `nre_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Non‑Recurring Engineering Amount (USD) (NRE_AMT_USD)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `nre_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Non‑Recurring Engineering Required Flag (NRE_REQ_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type (PKG_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `platform_generation` SET TAGS ('dbx_business_glossary_term' = 'Platform Generation (PLAT_GEN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node (PROC_NODE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `production_ramp_date` SET TAGS ('dbx_business_glossary_term' = 'Production Ramp Date (PROD_RAMP_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Design Win Registration Timestamp (DW_REG_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Design Win Source (DW_SOURCE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'internal|channel|partner');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Design Win Stage (DW_STAGE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'registered|evaluating|sampling|won|lost|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `tapeout_target_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Target Date (TAPEOUT_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_win` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application (TARGET_APP)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` SET TAGS ('dbx_subdomain' = 'design_engagement');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Registration ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `design_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Complexity (COMPLEXITY)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `design_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `design_project_description` SET TAGS ('dbx_business_glossary_term' = 'Design Project Description (DP_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `design_project_name` SET TAGS ('dbx_business_glossary_term' = 'Design Project Name (DP_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `design_project_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `design_start_date` SET TAGS ('dbx_business_glossary_term' = 'Design Start Date (DS_START)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `expected_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percent (YIELD_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `nre_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'NRE Budget Amount (NRE_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `nre_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'NRE Budget Currency (NRE_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `nre_budget_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type (PKG)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'BGA|QFN|WLCSP|COB|FOUP');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `platform_generation` SET TAGS ('dbx_business_glossary_term' = 'Platform Generation (PLAT_GEN)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `platform_generation` SET TAGS ('dbx_value_regex' = 'gen1|gen2|gen3|gen4|gen5');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `production_target_date` SET TAGS ('dbx_business_glossary_term' = 'Production Target Date (PROD_TGT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date (QUAL_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|qualified|disqualified');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number (REG_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status (REG_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `tapeout_target_date` SET TAGS ('dbx_business_glossary_term' = 'Tape‑out Target Date (TAP_OUT)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application (APP)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `target_application` SET TAGS ('dbx_value_regex' = 'mobile|automotive|ai|iot|datacenter|consumer');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`design_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'NDA Agreement ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `document_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'NDA Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_agreement_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|under_renewal');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_type` SET TAGS ('dbx_business_glossary_term' = 'NDA Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `nda_type` SET TAGS ('dbx_value_regex' = 'mutual|one-way');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `renewal_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`nda_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` SET TAGS ('dbx_subdomain' = 'financial_risk');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile ID');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Adjustment Amount');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Adjustment Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Adjustment Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_hold|closed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Type');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_type` SET TAGS ('dbx_value_regex' = 'standard|high_risk|low_risk|custom');
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
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `external_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'External Rating Agency');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `is_preferred_customer` SET TAGS ('dbx_business_glossary_term' = 'Preferred Customer Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Amount');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'Net 30|Net 45|Net 60|Prepay|Cash');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `preferred_customer_reason` SET TAGS ('dbx_business_glossary_term' = 'Preferred Customer Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Name');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `status_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status Change Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`credit_profile` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` SET TAGS ('dbx_subdomain' = 'financial_risk');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `primary_price_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
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
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `discount_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_business_glossary_term' = 'Price Locked Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `part_revision` SET TAGS ('dbx_business_glossary_term' = 'Part Revision');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|draft|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_change_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Change Approval Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'sap|manual|external');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `pricing_channel` SET TAGS ('dbx_business_glossary_term' = 'Pricing Channel');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `pricing_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|online|partner');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `pricing_region` SET TAGS ('dbx_business_glossary_term' = 'Pricing Region');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `pricing_region` SET TAGS ('dbx_value_regex' = 'NA|EMEA|APAC|LATAM');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tier_end_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier End Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tier_price` SET TAGS ('dbx_business_glossary_term' = 'Tier Price');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tier_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `tier_start_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier Start Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `volume_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_semiconductors_v1`.`customer`.`price_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
