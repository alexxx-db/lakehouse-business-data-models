-- Schema for Domain: sales | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`sales` COMMENT 'Owns commercial sales execution, order management, and revenue transactions across all channels (retail, wholesale, DTC, e-commerce). Manages sales orders, pricing agreements, sales force automation (SFA), retail account call records, POG compliance, RSP/MSRP price management, ACV/TDP/SOM metrics, and field sales KPIs. Integrates with Salesforce Consumer Goods Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` (
    `trade_account_id` BIGINT COMMENT 'Unique identifier for the B2B trade account. Primary key for the trade account master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation report requires each customer linked to a cost center for internal expense tracking and profitability analysis.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Logistics planning assigns each trade account a primary distribution center for order fulfillment and inventory allocation.',
    `parent_trade_account_id` BIGINT COMMENT 'The parent trade account id of the trade account record',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis assigns each customer to a profit center to aggregate revenue and margin in financial reporting.',
    `region_id` BIGINT COMMENT 'The region id of the trade account record',
    `channel_classification_id` BIGINT COMMENT 'The channel classification id of the trade account record',
    `account_close_date` DATE COMMENT 'The date when this trade account was permanently closed or terminated, if applicable.',
    `account_name` STRING COMMENT 'The account name of the trade account record',
    `account_number` STRING COMMENT 'The account number of the trade account record',
    `account_open_date` DATE COMMENT 'The date when this trade account was first established and approved for business transactions.',
    `account_status` STRING COMMENT 'The current lifecycle status of the trade account: active (operational), inactive (dormant), suspended (temporarily blocked), pending approval (new account under review), credit hold (payment issues), or closed (permanently terminated).. Valid values are `active|inactive|suspended|pending_approval|credit_hold|closed`',
    `account_tier` STRING COMMENT 'Strategic tier classification based on account size, coverage, and business importance: Tier 1 (national key accounts), Tier 2 (regional chains), Tier 3 (local/metro accounts), Tier 4 (independent operators).. Valid values are `tier_1_national|tier_2_regional|tier_3_local|tier_4_independent`',
    `account_type` STRING COMMENT 'The business model classification of the trade partner: retailer (sells to end consumers), distributor (logistics and fulfillment), wholesaler (bulk reseller), foodservice operator (restaurants/catering), or broker (sales intermediary).. Valid values are `retailer|distributor|wholesaler|foodservice_operator|broker`',
    `acv_total` DECIMAL(18,2) COMMENT 'The total All Commodity Volume representing the annual dollar sales volume across all product categories for this retail account, used for market coverage analysis.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the trade account record',
    `trade_account_code` STRING COMMENT 'The trade account code of the trade account record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the trade account record',
    `credit_limit` DECIMAL(18,2) COMMENT 'The credit limit of the trade account record',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding accounts receivable balance allowed for this trade account before credit hold is applied.',
    `credit_rating` STRING COMMENT 'The credit risk rating assigned to this trade account by internal credit management or external credit bureau (e.g., AAA, AA, A, BBB, BB, B, CCC, D).',
    `currency_code` STRING COMMENT 'The 3-letter ISO 4217 currency code for all financial transactions with this trade account (e.g., USD, CAD, EUR, MXN).. Valid values are `^[A-Z]{3}$`',
    `dba_name` STRING COMMENT 'The trade name or DBA name under which the account operates in the market, if different from legal entity name.',
    `trade_account_description` STRING COMMENT 'The trade account description of the trade account record',
    `dsd_delivery_flag` BOOLEAN COMMENT 'Indicates whether this trade account receives direct store delivery (DSD) shipments bypassing the retailers distribution center.',
    `dun_number` STRING COMMENT 'The dun number of the trade account record',
    `duns_number` STRING COMMENT 'The 9-digit DUNS number assigned by Dun & Bradstreet for unique identification of the business entity.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether this trade account has EDI connectivity enabled for electronic exchange of purchase orders, invoices, and advance ship notices.',
    `effective_from` DATE COMMENT 'The effective from of the trade account record',
    `effective_until` DATE COMMENT 'The effective until of the trade account record',
    `gln` STRING COMMENT 'The 13-digit GS1 Global Location Number uniquely identifying the legal entity and physical location of the trade partner.. Valid values are `^[0-9]{13}$`',
    `headquarters_address_line1` STRING COMMENT 'The first line of the street address for the trade account headquarters or primary business location.',
    `headquarters_address_line2` STRING COMMENT 'The second line of the street address (suite, floor, building) for the trade account headquarters.',
    `headquarters_city` STRING COMMENT 'The city name of the trade account headquarters location.',
    `headquarters_country_code` STRING COMMENT 'The 3-letter ISO 3166-1 alpha-3 country code for the trade account headquarters location (e.g., USA, CAN, MEX, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'The postal code or ZIP code of the trade account headquarters location.',
    `headquarters_state_province` STRING COMMENT 'The state, province, or administrative region of the trade account headquarters location.',
    `last_order_date` DATE COMMENT 'The date of the most recent purchase order received from this trade account.',
    `legal_entity_name` STRING COMMENT 'The official registered legal name of the trade partner organization as it appears on legal documents and contracts.',
    `minimum_order_quantity` STRING COMMENT 'The minimum order quantity (in units or cases) required for orders placed by this trade account.',
    `trade_account_name` STRING COMMENT 'The trade account name of the trade account record',
    `notes` STRING COMMENT 'The notes of the trade account record',
    `otif_sla_target_percent` DECIMAL(18,2) COMMENT 'The contractual OTIF service level agreement target percentage for order fulfillment performance (e.g., 95.00 represents 95% of orders delivered on time and in full).',
    `payment_method` STRING COMMENT 'The primary payment instrument used by this account: ACH (automated clearing house), wire transfer, check, EDI payment (electronic funds transfer via EDI 820), or credit card.. Valid values are `ach|wire_transfer|check|edi_payment|credit_card`',
    `payment_terms` STRING COMMENT 'The payment terms of the trade account record',
    `payment_terms_code` STRING COMMENT 'The standard payment terms code governing invoice payment due dates and early payment discounts (e.g., Net 30, Net 60, 2/10 Net 30).',
    `previous_status` STRING COMMENT 'The account status immediately prior to the most recent status change, maintained for audit trail and lifecycle analysis.',
    `primary_contact_email` STRING COMMENT 'The business email address of the primary contact for order management, invoicing, and account communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact or account manager at the trade partner organization.',
    `primary_contact_phone` STRING COMMENT 'The business phone number of the primary contact, including country code and extension if applicable.',
    `primary_language_code` STRING COMMENT 'The 2-letter ISO 639-1 language code for the preferred communication language with this trade account (e.g., en, es, fr, de).. Valid values are `^[a-z]{2}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the trade account record',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this trade account master record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this trade account master record was most recently modified.',
    `source_system_code` STRING COMMENT 'The source system code of the trade account record',
    `status_change_reason` STRING COMMENT 'The business reason or justification for the most recent account status change (e.g., payment default, business closure, credit improvement, contract renewal).',
    `status_change_timestamp` TIMESTAMP COMMENT 'The date and time when the most recent account status change occurred.',
    `status_changed_by_user` STRING COMMENT 'The user ID or name of the person who executed the most recent account status change, for audit and accountability purposes.',
    `tax_exemption_flag` BOOLEAN COMMENT 'Indicates whether this trade account holds a valid tax exemption certificate for sales tax or VAT purposes.',
    `tax_number` STRING COMMENT 'The government-issued tax identification number for this legal entity (e.g., EIN in USA, VAT number in EU, GST number in other jurisdictions).',
    `tdp_count` STRING COMMENT 'The total number of distribution points (store locations or outlets) operated by this trade account where products can be sold.',
    `trade_account_status` STRING COMMENT 'The trade account status of the trade account record',
    `trade_channel` STRING COMMENT 'The primary retail or distribution channel through which this trade account operates: grocery (supermarkets), mass (mass merchandisers), club (warehouse clubs), drug (pharmacy chains), convenience stores, foodservice (restaurants/institutions), or e-commerce (online retailers). [ENUM-REF-CANDIDATE: grocery|mass|club|drug|convenience|foodservice|e-commerce — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the trade account record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the trade account record',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this trade account participates in a VMI program where the supplier manages inventory replenishment based on POS or warehouse data.',
    CONSTRAINT pk_trade_account PRIMARY KEY(`trade_account_id`)
) COMMENT 'SSOT master record for all B2B trade customers including retailers, distributors, wholesalers, and foodservice operators. Captures authoritative account identity: legal entity name, trade channel classification (grocery, mass, club, drug, foodservice, e-commerce), account tier, credit rating, payment terms, currency, tax identifiers, DUNS number, GLN (GS1 Global Location Number), primary language, account status, lifecycle dates, and full status change audit history (previous status, new status, change reason, change timestamp, changed-by user). This is the golden record for all trade partner identity — every other customer domain entity references this product via FK.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` (
    `account_contact_id` BIGINT COMMENT 'Reference to another account contact record representing this contacts direct manager or supervisor within the trade account organization. Enables organizational hierarchy mapping.',
    `trade_account_id` BIGINT COMMENT 'Reference to the parent trade account (retailer, distributor, wholesaler, or foodservice operator) to which this contact belongs.',
    `account_contact_status` STRING COMMENT 'The account contact status of the account contact record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account contact record',
    `assistant_name` STRING COMMENT 'The name of the contacts administrative assistant or executive assistant, if applicable. Used for scheduling and communication routing.',
    `assistant_phone` STRING COMMENT 'The phone number of the contacts administrative assistant. Used for scheduling and communication routing.',
    `account_contact_code` STRING COMMENT 'The account contact code of the account contact record',
    `contact_notes` STRING COMMENT 'Free-form text field for capturing additional notes, preferences, or context about the contact. Used by sales representatives to document relationship insights.',
    `contact_role` STRING COMMENT 'The contacts role in the buying decision process. Distinguishes between primary decision-makers, influencers, and administrative contacts. Critical for sales force automation and account planning.. Valid values are `primary_buyer|secondary_buyer|decision_maker|influencer|gatekeeper|end_user`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record. Active contacts are currently employed and engaged with the account. Inactive or terminated contacts are retained for historical reference.. Valid values are `active|inactive|on_leave|terminated|transferred`',
    `contact_type` STRING COMMENT 'Classification of the contacts primary functional role at the trade account. Determines which business processes and communications this contact participates in.. Valid values are `buyer|category_manager|logistics_coordinator|finance_contact|marketing_contact|operations_manager`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The currency code of the account contact record',
    `department` STRING COMMENT 'The organizational department or functional area within the trade account where this contact works. Examples include Procurement, Logistics, Finance, Marketing.',
    `account_contact_description` STRING COMMENT 'The account contact description of the account contact record',
    `effective_end_date` DATE COMMENT 'The date when this contacts role at the trade account ended, if applicable. Null for currently active contacts. Used for historical tracking and relationship continuity.',
    `effective_from` DATE COMMENT 'The effective from of the account contact record',
    `effective_start_date` DATE COMMENT 'The date when this contact became active in their current role at the trade account. Used for tracking tenure and relationship history.',
    `effective_until` DATE COMMENT 'The effective until of the account contact record',
    `email` STRING COMMENT 'The email of the account contact record',
    `email_address` STRING COMMENT 'Primary business email address for the contact. Used for commercial communications, order confirmations, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the contact, if applicable. Still used in some trade channels for purchase orders and formal documentation.',
    `first_name` STRING COMMENT 'The given name of the individual contact at the trade account.',
    `full_name` STRING COMMENT 'The complete formatted name of the contact, typically concatenated as first name and last name. Used for display and reporting purposes.',
    `is_decision_maker` BOOLEAN COMMENT 'Boolean flag indicating whether this contact has purchasing authority and decision-making power for the account. True if decision maker, False otherwise.',
    `is_primary` BOOLEAN COMMENT 'The is primary of the account contact record',
    `is_primary_contact` BOOLEAN COMMENT 'Boolean flag indicating whether this contact is the primary point of contact for the trade account. True if primary, False otherwise.',
    `job_title` STRING COMMENT 'The official job title or position held by the contact at the trade account organization. Examples include Senior Buyer, Category Manager, Supply Chain Director.',
    `language_preference` STRING COMMENT 'The contacts preferred language for business communications, represented as a 3-letter ISO 639-2 language code. Examples: ENG (English), SPA (Spanish), FRA (French).. Valid values are `^[A-Z]{3}$`',
    `last_contact_date` DATE COMMENT 'The date of the most recent interaction or communication with this contact. Used to track engagement frequency and identify dormant relationships.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact record was most recently updated. Used for audit trail and change tracking.',
    `last_name` STRING COMMENT 'The family name or surname of the individual contact at the trade account.',
    `linkedin_profile_url` STRING COMMENT 'The URL of the contacts LinkedIn professional profile. Used for social selling and relationship intelligence.',
    `mobile_number` STRING COMMENT 'Mobile or cellular phone number for the contact. Used for urgent communications and field-based retail execution activities.',
    `account_contact_name` STRING COMMENT 'The account contact name of the account contact record',
    `next_follow_up_date` DATE COMMENT 'The scheduled date for the next planned follow-up or interaction with this contact. Supports proactive account management and sales cadence planning.',
    `notes` STRING COMMENT 'The notes of the account contact record',
    `opt_in_email` BOOLEAN COMMENT 'Boolean flag indicating whether the contact has opted in to receive commercial email communications. True if opted in, False if opted out. Required for GDPR and CCPA compliance.',
    `opt_in_phone` BOOLEAN COMMENT 'Boolean flag indicating whether the contact has opted in to receive commercial phone communications. True if opted in, False if opted out. Required for telemarketing compliance.',
    `opt_in_sms` BOOLEAN COMMENT 'Boolean flag indicating whether the contact has opted in to receive commercial SMS or text message communications. True if opted in, False if opted out.',
    `phone` STRING COMMENT 'The phone of the account contact record',
    `phone_number` STRING COMMENT 'Primary business telephone number for the contact. Includes country code, area code, and local number.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method for receiving business communications. Supports personalized engagement strategies in SFA and retail execution workflows.. Valid values are `email|phone|mobile|fax|portal|in_person`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account contact record',
    `role_title` STRING COMMENT 'The role title of the account contact record',
    `salesforce_user_code` STRING COMMENT 'The Salesforce user ID of the sales representative or account manager responsible for this contact. Links to the internal sales team member managing the relationship.',
    `source_system_code` STRING COMMENT 'The unique identifier for this contact in the source operational system. Used for data reconciliation and integration traceability.',
    `territory_code` STRING COMMENT 'The sales territory or region code to which this contact and their account are assigned. Used for sales force automation and territory management.',
    `uom` STRING COMMENT 'The uom of the account contact record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account contact record',
    CONSTRAINT pk_account_contact PRIMARY KEY(`account_contact_id`)
) COMMENT 'Individual contacts associated with a trade account, including buyers, category managers, logistics coordinators, and finance contacts at the retailer or distributor. Captures full name, job title, department, contact role (primary buyer, logistics, finance, marketing), phone, email, preferred communication channel, active status, and opt-in/opt-out flags for commercial communications. Supports SFA and retail execution workflows in Salesforce Consumer Goods Cloud.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` (
    `account_address_id` BIGINT COMMENT 'Unique identifier for the account address record. Primary key.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account (retailer, distributor, wholesaler, or foodservice customer) that this address belongs to.',
    `account_address_status` STRING COMMENT 'Current lifecycle status of the address record. Active addresses are available for transactions; inactive addresses are retained for historical reporting; pending addresses await validation; closed addresses are permanently retired.. Valid values are `active|inactive|pending|closed`',
    `address_line_1` STRING COMMENT 'Primary street address line including street number, street name, and building identifier. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, apartment, or unit number. Organizational contact data classified as confidential.',
    `address_line_3` STRING COMMENT 'Additional address line for complex addresses, building names, or delivery instructions. Organizational contact data classified as confidential.',
    `address_name` STRING COMMENT 'Business name or label for this address location (e.g., Main Distribution Center, Regional Office - Northeast, Store #1234).',
    `address_type` STRING COMMENT 'Classification of the address purpose: headquarters (HQ), billing address, ship-to location, sold-to location, returns processing center, or warehouse/distribution center. Supports Electronic Data Interchange (EDI) ship-to/bill-to mapping and Direct Store Delivery (DSD) route planning.. Valid values are `headquarters|billing|ship_to|sold_to|returns|warehouse`',
    `address_validation_date` DATE COMMENT 'Date when the address was last validated against postal authority databases. Format: yyyy-MM-dd.',
    `address_validation_status` STRING COMMENT 'Status of address verification against postal authority databases. Validated addresses improve delivery success rates and reduce logistics costs.. Valid values are `validated|unvalidated|invalid|pending`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account address record',
    `city` STRING COMMENT 'City or municipality name for the address location. Organizational contact data classified as confidential.',
    `account_address_code` STRING COMMENT 'The account address code of the account address record',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code (e.g., USA, CAN, MEX, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field for data governance and compliance.',
    `currency_code` STRING COMMENT 'The currency code of the account address record',
    `delivery_instructions` STRING COMMENT 'Special instructions for delivery personnel including receiving hours, dock locations, access codes, contact requirements, and handling instructions. Critical for On Time In Full (OTIF) performance.',
    `account_address_description` STRING COMMENT 'The account address description of the account address record',
    `dock_door_number` STRING COMMENT 'Specific dock door or bay number for deliveries at warehouse or distribution center locations. Used by carriers and Direct Store Delivery (DSD) drivers.',
    `dsd_route_eligible_flag` BOOLEAN COMMENT 'Indicates whether this location is eligible for Direct Store Delivery (DSD) routing (True) or requires warehouse distribution (False). Critical for route planning and logistics optimization.',
    `edi_location_qualifier` STRING COMMENT 'EDI X12 location qualifier code used in Electronic Data Interchange (EDI) transactions to identify the address role (e.g., ST for ship-to, BT for bill-to, SF for ship-from). Supports automated order processing and Advanced Shipping Notice (ASN) generation.',
    `effective_end_date` DATE COMMENT 'Date when this address was deactivated or replaced. Null indicates the address is currently active. Format: yyyy-MM-dd. Supports address history tracking and audit compliance.',
    `effective_from` DATE COMMENT 'The effective from of the account address record',
    `effective_start_date` DATE COMMENT 'Date when this address became active and valid for use in transactions. Format: yyyy-MM-dd. Supports address history tracking and audit compliance.',
    `effective_until` DATE COMMENT 'The effective until of the account address record',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying this physical location in the global supply chain. 13-digit numeric identifier used for EDI transactions and supply chain visibility.. Valid values are `^[0-9]{13}$`',
    `inactivation_reason` STRING COMMENT 'Business reason for address inactivation (e.g., location closed, address changed, account terminated, consolidation). Used for audit trails and business intelligence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field for data governance and compliance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for geospatial analysis, route optimization, and Direct Store Delivery (DSD) planning. Range: -90.0000000 to +90.0000000.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for geospatial analysis, route optimization, and Direct Store Delivery (DSD) planning. Range: -180.0000000 to +180.0000000.',
    `account_address_name` STRING COMMENT 'The account address name of the account address record',
    `notes` STRING COMMENT 'The notes of the account address record',
    `postal_code` STRING COMMENT 'Postal code, ZIP code, or postcode for mail delivery routing. Format varies by country (e.g., 5-digit ZIP in USA, alphanumeric in Canada/UK). Organizational contact data classified as confidential.',
    `primary_address_flag` BOOLEAN COMMENT 'Indicates whether this is the primary address for the account (True) or a secondary/alternate address (False). Used for default shipping and billing operations.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account address record',
    `receiving_hours_end` STRING COMMENT 'End time for receiving deliveries at this location in 24-hour format (HH:mm). Used for delivery scheduling and On Time In Full (OTIF) compliance.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]$`',
    `receiving_hours_start` STRING COMMENT 'Start time for receiving deliveries at this location in 24-hour format (HH:mm). Used for delivery scheduling and On Time In Full (OTIF) compliance.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]$`',
    `source_system_code` STRING COMMENT 'Unique identifier for this address in the source system of record. Used for data reconciliation and bidirectional synchronization.',
    `standardized_address_flag` BOOLEAN COMMENT 'Indicates whether the address has been standardized to postal authority format (True) or remains in original input format (False).',
    `state_province` STRING COMMENT 'State, province, or administrative region code or name. Uses standard postal abbreviations (e.g., CA, NY, ON, QC). Organizational contact data classified as confidential.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction identifier for sales tax, value-added tax (VAT), or goods and services tax (GST) calculation. Used in invoice generation and financial reporting.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for this location (e.g., America/New_York, America/Chicago, Europe/London). Used for delivery scheduling, service level agreement (SLA) tracking, and On Time In Full (OTIF) calculations.',
    `uom` STRING COMMENT 'The uom of the account address record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account address record',
    CONSTRAINT pk_account_address PRIMARY KEY(`account_address_id`)
) COMMENT 'Physical and mailing addresses associated with a trade account, including headquarters, billing address, ship-to locations, and sold-to locations. Captures address type (HQ, billing, ship-to, sold-to, returns), street, city, state/province, postal code, country, GS1 GLN for the location, geo-coordinates, time zone, and address validation status. Supports EDI ship-to/bill-to mapping and DSD route planning.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` (
    `account_hierarchy_id` BIGINT COMMENT 'Unique identifier for the account hierarchy relationship record. Primary key.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the child account in the hierarchy. References the lower-level organizational entity (e.g., store, banner, chain).',
    `child_trade_account_id` BIGINT COMMENT 'add column child_trade_account_id (BIGINT) with FK to sales.trade_account.trade_account_id - hierarchy needs explicit child linkage',
    `parent_trade_account_id` BIGINT COMMENT 'Parent trade account in the hierarchy.',
    `primary_trade_account_id` BIGINT COMMENT 'Identifier of the parent account in the hierarchy. References the higher-level organizational entity (e.g., banner, chain, parent corporation).',
    `account_hierarchy_status` STRING COMMENT 'The account hierarchy status of the account hierarchy record',
    `acv_rollup_flag` BOOLEAN COMMENT 'Indicates whether All Commodity Volume (ACV) metrics should be rolled up from child to parent account. True means include in ACV aggregation; false means exclude. Critical for market coverage and distribution analysis.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account hierarchy record',
    `approval_status` STRING COMMENT 'Approval status of the hierarchical relationship change. Draft indicates the relationship is being defined; pending approval indicates the relationship is awaiting management review; approved indicates the relationship has been validated; rejected indicates the relationship was not approved.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the business user who approved the hierarchical relationship. Used for audit trail and governance purposes.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the hierarchical relationship was approved. Used for audit trail and compliance reporting.',
    `account_hierarchy_code` STRING COMMENT 'The account hierarchy code of the account hierarchy record',
    `consolidation_flag` BOOLEAN COMMENT 'Indicates whether financial and operational metrics from the child account should be consolidated into the parent account for reporting purposes. True means consolidate; false means report separately. Critical for All Commodity Volume (ACV), Total Distribution Points (TDP), trade spend, and sales performance roll-ups.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the account hierarchy record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The currency code of the account hierarchy record',
    `account_hierarchy_description` STRING COMMENT 'The account hierarchy description of the account hierarchy record',
    `effective_end_date` DATE COMMENT 'Date when the hierarchical relationship ends or is no longer valid. Null indicates an open-ended relationship. Critical for historical analysis and point-in-time reporting.',
    `effective_from` DATE COMMENT 'The effective from of the account hierarchy record',
    `effective_start_date` DATE COMMENT 'Date when the hierarchical relationship becomes effective. Used for temporal tracking of organizational changes, mergers, acquisitions, and restructuring events.',
    `effective_until` DATE COMMENT 'The effective until of the account hierarchy record',
    `hierarchy_depth` STRING COMMENT 'Numeric depth of the child account within the hierarchy tree, with 1 representing the top level (parent corporation) and increasing numbers representing deeper levels (chain, banner, store). Used for recursive queries and hierarchy traversal.',
    `hierarchy_level` STRING COMMENT 'Level of the child account within the organizational hierarchy. Store represents individual retail locations; banner represents a retail brand or fascia; chain represents a retail chain or group; parent corporation represents the ultimate parent entity; division represents a business division; region represents a geographic region.. Valid values are `store|banner|chain|parent_corporation|division|region`',
    `hierarchy_path` STRING COMMENT 'Materialized path representing the full lineage from root to child account, typically formatted as slash-separated account identifiers (e.g., /1/23/456/7890). Enables efficient ancestor and descendant queries for Sales and Operations Planning (S&OP) and Trade Promotion Management (TPM) reporting.',
    `hierarchy_type` STRING COMMENT 'Type of organizational hierarchy relationship. Commercial hierarchies support sales and trade promotion roll-ups; logistics hierarchies support distribution and delivery planning; financial hierarchies support invoicing and payment consolidation; reporting hierarchies support management reporting structures; legal hierarchies represent corporate ownership; operational hierarchies support day-to-day execution.. Valid values are `commercial|logistics|financial|reporting|legal|operational`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the account hierarchy record was last updated. Used for change tracking and audit purposes.',
    `account_hierarchy_name` STRING COMMENT 'The account hierarchy name of the account hierarchy record',
    `notes` STRING COMMENT 'Free-text notes or comments about the hierarchical relationship. May include business context, special handling instructions, or historical information about organizational changes.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership or control the parent account has over the child account. Used for proportional consolidation in financial and operational reporting. Range 0.00 to 100.00.',
    `primary_hierarchy_flag` BOOLEAN COMMENT 'Indicates whether this is the primary hierarchical relationship for the child account when multiple hierarchy types exist. True means this is the default hierarchy for reporting and analytics; false means this is a secondary or alternate hierarchy.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account hierarchy record',
    `relationship_code` STRING COMMENT 'Business code or identifier representing the nature of the parent-child relationship. May include codes for wholly-owned subsidiary, franchise, joint venture, affiliate, or other relationship types specific to the consumer goods trade channel.',
    `relationship_name` STRING COMMENT 'Human-readable name or description of the hierarchical relationship. Provides business context for the parent-child linkage (e.g., Regional Banner Group, Corporate Ownership, Distribution Network).',
    `relationship_status` STRING COMMENT 'Current status of the hierarchical relationship. Active indicates the relationship is currently in effect; inactive indicates the relationship has ended; pending indicates the relationship is awaiting activation; suspended indicates the relationship is temporarily paused; terminated indicates the relationship has been permanently ended.. Valid values are `active|inactive|pending|suspended|terminated`',
    `rollup_weight` DECIMAL(18,2) COMMENT 'Weighting factor applied when rolling up metrics from child to parent account. Used for proportional allocation of All Commodity Volume (ACV), Total Distribution Points (TDP), trade spend, and sales performance when a child account participates in multiple hierarchies or has split ownership.',
    `sales_rollup_flag` BOOLEAN COMMENT 'Indicates whether sales performance metrics should be rolled up from child to parent account. True means include in sales aggregation; false means exclude. Essential for Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP).',
    `source_system_code` STRING COMMENT 'Unique identifier of the hierarchical relationship record in the source system. Used for data lineage, reconciliation, and bidirectional synchronization.',
    `tdp_rollup_flag` BOOLEAN COMMENT 'Indicates whether Total Distribution Points (TDP) metrics should be rolled up from child to parent account. True means include in TDP aggregation; false means exclude. Essential for numeric distribution and weighted distribution reporting.',
    `trade_spend_rollup_flag` BOOLEAN COMMENT 'Indicates whether trade promotion spending should be rolled up from child to parent account. True means include in trade spend aggregation; false means exclude. Critical for Trade Promotion Management (TPM) and Trade Promotion Optimization (TPO) reporting.',
    `uom` STRING COMMENT 'The uom of the account hierarchy record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account hierarchy record',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Defines the parent-child organizational hierarchy of trade accounts, enabling roll-up of ACV, TDP, trade spend, and sales performance from store level to banner, banner to chain, and chain to parent corporation. Captures parent account, child account, hierarchy level (store, banner, chain, parent corporation), effective date range, hierarchy type (commercial, logistics, financial), and consolidation flag. Critical for S&OP and TPM reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` (
    `retail_store_id` BIGINT COMMENT 'Unique identifier for the retail store location. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Store‑level budgeting and expense tracking use a cost center per retail store for internal cost accounting.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Store replenishment process requires an assigned distribution center to schedule deliveries and calculate OTIF performance.',
    `edi_trading_partner_id` BIGINT COMMENT 'EDI trading partner identifier used for electronic order transmission, invoicing, and Advanced Shipping Notices (ASN).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Store profitability reporting aggregates sales and costs by profit center, requiring a link from store to profit_center.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Store Manager Assignment report linking each store to the responsible employee manager.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Store‑level VMI or direct replenishment ties a retail store to the exact supplier site that ships inventory, needed for logistics and OTIF tracking.',
    `trade_account_id` BIGINT COMMENT 'Reference to the parent trade account, banner, or retail chain that owns or operates this store.',
    `acv_weight` DECIMAL(18,2) COMMENT 'All Commodity Volume (ACV) weighting factor representing this stores share of total market volume, used for distribution and market share calculations.',
    `address_line_1` STRING COMMENT 'Primary street address of the retail store location.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the retail store record',
    `banner_name` STRING COMMENT 'The retail banner or brand under which this store operates (e.g., Walmart Supercenter, Target, Kroger).',
    `city` STRING COMMENT 'City or municipality where the retail store is located.',
    `close_date` DATE COMMENT 'Date when the store permanently closed or is scheduled to close. Null if store is active.',
    `retail_store_code` STRING COMMENT 'The retail store code of the retail store record',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the store is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail store record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the retail store record',
    `retail_store_description` STRING COMMENT 'The retail store description of the retail store record',
    `dsd_route_code` STRING COMMENT 'Route code or identifier for Direct Store Delivery (DSD) logistics and delivery scheduling.',
    `effective_from` DATE COMMENT 'The effective from of the retail store record',
    `effective_until` DATE COMMENT 'The effective until of the retail store record',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying this physical store location for Electronic Data Interchange (EDI) and supply chain transactions.. Valid values are `^[0-9]{13}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail store record was last updated or modified.',
    `last_visit_date` DATE COMMENT 'Date of the most recent retail execution visit or sales call to this store location.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the store location for mapping and route optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the store location for mapping and route optimization.',
    `retail_store_name` STRING COMMENT 'The retail store name of the retail store record',
    `next_scheduled_visit_date` DATE COMMENT 'Date of the next planned retail execution visit or sales call to this store location.',
    `notes` STRING COMMENT 'The notes of the retail store record',
    `open_date` DATE COMMENT 'Date when the store first opened for business operations.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the store (e.g., Mon-Fri 8am-10pm, Sat-Sun 9am-9pm) used for retail execution visit planning.',
    `osa_target_pct` DECIMAL(18,2) COMMENT 'Target On Shelf Availability (OSA) percentage for this store indicating expected in-stock performance for key Stock Keeping Units (SKUs).',
    `otif_sla_target_pct` DECIMAL(18,2) COMMENT 'Target On Time In Full (OTIF) service level percentage agreed with this store for delivery performance measurement.',
    `planogram_zone` STRING COMMENT 'Planogram zone or cluster assignment indicating which shelf layout and assortment plan applies to this store.',
    `pos_system_type` STRING COMMENT 'Type or vendor of the Point of Sale (POS) system used at this store for transaction processing and sales data capture.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the store location used for logistics and Direct Store Delivery (DSD) routing.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the retail store record',
    `retail_store_status` STRING COMMENT 'The retail store status of the retail store record',
    `source_system_code` STRING COMMENT 'The source system code of the retail store record',
    `state_province` STRING COMMENT 'State, province, or administrative region where the store is located.',
    `store_format` STRING COMMENT 'The retail format classification of the store indicating size, assortment, and operational model. [ENUM-REF-CANDIDATE: hypermarket|supermarket|convenience|club|drug|dollar|specialty|e-commerce_fulfillment_center — 8 candidates stripped; promote to reference product]',
    `store_name` STRING COMMENT 'The official name or designation of the retail store location.',
    `store_number` STRING COMMENT 'The retailer-assigned unique store number or code used for operational identification and Direct Store Delivery (DSD) routing.',
    `store_phone` STRING COMMENT 'Primary contact phone number for the retail store location.',
    `store_size_sq_ft` STRING COMMENT 'Total retail selling space of the store measured in square feet, used for All Commodity Volume (ACV) and Total Distribution Points (TDP) calculations.',
    `store_status` STRING COMMENT 'Current operational status of the retail store location.. Valid values are `active|inactive|pending_opening|temporarily_closed|permanently_closed|under_renovation`',
    `store_tier` STRING COMMENT 'Strategic tier classification (e.g., Tier 1, Tier 2) indicating store importance based on volume, profitability, or strategic value for prioritized retail execution.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `tdp_weight` DECIMAL(18,2) COMMENT 'Total Distribution Points (TDP) weighting factor representing this stores contribution to numeric distribution metrics.',
    `trading_area` STRING COMMENT 'Geographic trading area or market designation (e.g., metro area, region) used for sales territory and distribution planning.',
    `uom` STRING COMMENT 'The uom of the retail store record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the retail store record',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this store participates in a Vendor Managed Inventory (VMI) program where the manufacturer manages replenishment.',
    CONSTRAINT pk_retail_store PRIMARY KEY(`retail_store_id`)
) COMMENT 'Individual physical retail store or outlet location associated with a trade account banner or chain. Captures store number, store name, banner, format (hypermarket, supermarket, convenience, club, drug, dollar, e-commerce fulfillment center), store size (sq ft), trading area, store open/close dates, store manager, operating hours, and planogram zone assignment. Used for retail execution, OSA tracking, and DSD route management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` (
    `edi_trading_partner_id` BIGINT COMMENT 'Unique identifier for the EDI trading partner configuration record. Primary key.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade customer account (retailer, distributor, wholesaler, or foodservice operator) that this EDI configuration serves.',
    `acknowledgment_sla_hours` STRING COMMENT 'The contractual turnaround time (in hours) for Consumer Goods to send functional acknowledgments (997) or business acknowledgments (855) back to the trading partner after receiving an EDI transaction.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the edi trading partner record',
    `as2_identifier` STRING COMMENT 'The AS2 identifier (AS2-From or AS2-To) used in AS2 message headers when AS2 protocol is in use.',
    `edi_trading_partner_code` STRING COMMENT 'The edi trading partner code of the edi trading partner record',
    `communication_protocol` STRING COMMENT 'The communication protocol used to transmit EDI documents between Consumer Goods and the trading partner (e.g., AS2 for secure internet-based exchange, SFTP for file transfer, VAN for value-added network).. Valid values are `AS2|SFTP|FTPS|VAN|HTTP/S|Direct Connect`',
    `contact_email` STRING COMMENT 'The email address of the primary EDI contact at the trading partner for operational communication and issue escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'The name of the primary EDI coordinator or technical contact at the trading partner organization responsible for EDI operations and issue resolution.',
    `contact_phone` STRING COMMENT 'The phone number of the primary EDI contact at the trading partner for urgent operational issues.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this EDI trading partner configuration record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the edi trading partner record',
    `edi_trading_partner_description` STRING COMMENT 'The edi trading partner description of the edi trading partner record',
    `digital_signature_required` BOOLEAN COMMENT 'Indicates whether EDI transmissions must include digital signatures for non-repudiation (common in AS2 protocol).',
    `edi_go_live_date` DATE COMMENT 'The date when EDI transactions with this trading partner went live in production.',
    `edi_partner_code` STRING COMMENT 'The unique EDI partner identifier assigned to the trading partner, used in EDI envelope headers (ISA/GS segments) to route transactions.',
    `edi_standard` STRING COMMENT 'The EDI messaging standard used for communication with this trading partner (e.g., ANSI X12 for North America, UN/EDIFACT for international).. Valid values are `ANSI X12|UN/EDIFACT|TRADACOMS|VDA|ODETTE`',
    `edi_trading_partner_status` STRING COMMENT 'Current operational status of the EDI trading partner configuration (active for live production, testing for certification phase, inactive for discontinued partners, suspended for temporary holds).. Valid values are `active|inactive|suspended|testing`',
    `edi_version` STRING COMMENT 'The specific version of the EDI standard in use (e.g., 004010, 005010 for ANSI X12; D96A, D01B for EDIFACT).',
    `effective_from` DATE COMMENT 'The effective from of the edi trading partner record',
    `effective_until` DATE COMMENT 'The effective until of the edi trading partner record',
    `encryption_required` BOOLEAN COMMENT 'Indicates whether EDI transmissions with this trading partner must be encrypted (e.g., AS2 with encryption, SFTP with SSH).',
    `environment_type` STRING COMMENT 'Indicates whether this EDI configuration is for production transactions, testing/certification, or development purposes.. Valid values are `production|test|development`',
    `gs_qualifier` STRING COMMENT 'GS application sender/receiver code qualifier that identifies the type of identification being used in the GS segment.. Valid values are `01|14|ZZ`',
    `gs_receiver_code` STRING COMMENT 'The application receiver code used in the GS03 segment, identifying the trading partner as the receiver at the functional group level.',
    `gs_sender_code` STRING COMMENT 'The application sender code used in the GS02 segment, identifying Consumer Goods as the sender at the functional group level.',
    `isa_qualifier` STRING COMMENT 'ISA interchange ID qualifier code that identifies the type of identification being used in the ISA segment (e.g., 01=DUNS, 14=DUNS+4, ZZ=Mutually Defined). [ENUM-REF-CANDIDATE: 01|14|20|27|28|29|30|33|ZZ — 9 candidates stripped; promote to reference product]',
    `isa_receiver_code` STRING COMMENT 'The receiver identification code used in the ISA08 segment of outbound EDI transactions, representing the trading partner receiving the data.',
    `isa_sender_code` STRING COMMENT 'The sender identification code used in the ISA06 segment of outbound EDI transactions from Consumer Goods to the trading partner.',
    `mdn_requested` BOOLEAN COMMENT 'Indicates whether Consumer Goods requests a Message Disposition Notification (MDN) receipt from the trading partner when using AS2 protocol.',
    `edi_trading_partner_name` STRING COMMENT 'The edi trading partner name of the edi trading partner record',
    `notes` STRING COMMENT 'Free-text notes capturing special configuration requirements, partner-specific business rules, or operational considerations for this EDI relationship.',
    `partner_id_value` DECIMAL(18,2) COMMENT 'The partner id value of the edi trading partner record',
    `partner_qualifier` STRING COMMENT 'The partner qualifier of the edi trading partner record',
    `processing_sla_hours` STRING COMMENT 'The contractual turnaround time (in hours) for Consumer Goods to process inbound EDI transactions (e.g., convert 850 PO into sales order) after receipt.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the edi trading partner record',
    `sftp_directory_inbound` STRING COMMENT 'The directory path on the SFTP server where Consumer Goods retrieves inbound EDI files from the trading partner.',
    `sftp_directory_outbound` STRING COMMENT 'The directory path on the SFTP server where Consumer Goods deposits outbound EDI files for the trading partner to retrieve.',
    `sftp_host` STRING COMMENT 'The SFTP server hostname or IP address used for file-based EDI exchange when SFTP protocol is in use.',
    `sftp_port` STRING COMMENT 'The TCP port number used for SFTP connections (typically 22).',
    `sftp_username` STRING COMMENT 'The username credential used to authenticate to the trading partner SFTP server.',
    `source_system_code` STRING COMMENT 'The source system code of the edi trading partner record',
    `transaction_set_810_enabled` BOOLEAN COMMENT 'Indicates whether Consumer Goods sends 810 Invoice transaction sets to the trading partner for billing.',
    `transaction_set_846_enabled` BOOLEAN COMMENT 'Indicates whether inventory position data is exchanged via 846 Inventory Inquiry/Advice transaction sets for Vendor Managed Inventory (VMI) programs.',
    `transaction_set_850_enabled` BOOLEAN COMMENT 'Indicates whether the trading partner sends 850 Purchase Order transaction sets to Consumer Goods.',
    `transaction_set_852_enabled` BOOLEAN COMMENT 'Indicates whether the trading partner sends 852 Product Activity Data (POS sales data) to Consumer Goods for demand sensing and replenishment.',
    `transaction_set_855_enabled` BOOLEAN COMMENT 'Indicates whether Consumer Goods sends 855 Purchase Order Acknowledgment transaction sets back to the trading partner.',
    `transaction_set_856_enabled` BOOLEAN COMMENT 'Indicates whether Consumer Goods sends 856 Advanced Ship Notice transaction sets to notify the trading partner of shipments.',
    `transaction_set_867_enabled` BOOLEAN COMMENT 'Indicates whether the trading partner sends 867 Product Transfer and Resale Report transaction sets for secondary sales visibility (distributor to retailer).',
    `transaction_set_997_enabled` BOOLEAN COMMENT 'Indicates whether 997 Functional Acknowledgment transaction sets are exchanged to confirm receipt and syntactic validation of EDI documents.',
    `uom` STRING COMMENT 'The uom of the edi trading partner record',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this EDI trading partner configuration record was last modified.',
    `van_mailbox_code` STRING COMMENT 'The mailbox identifier assigned by the VAN provider for routing EDI documents to and from the trading partner.',
    `van_provider` STRING COMMENT 'The name of the Value-Added Network provider facilitating EDI exchange (e.g., SPS Commerce, TrueCommerce, Cleo) when VAN protocol is in use.',
    CONSTRAINT pk_edi_trading_partner PRIMARY KEY(`edi_trading_partner_id`)
) COMMENT 'EDI (Electronic Data Interchange) configuration and trading partner profile for a trade account. Captures EDI partner ID, ISA/GS qualifiers, EDI standard (ANSI X12, EDIFACT), supported transaction sets (850 PO, 855 PO Ack, 856 ASN, 810 Invoice, 852 POS Data, 867 Product Transfer), communication protocol (AS2, SFTP, VAN), test vs. production flag, EDI go-live date, and SLA for acknowledgment turnaround. Owned by the customer domain as part of trade account configuration.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` (
    `customer_vmi_agreement_id` BIGINT COMMENT 'Unique identifier for the VMI agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the manufacturer employee (demand planner or supply planner) responsible for managing this VMI agreement and executing replenishment decisions.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: VMI program execution requires linking each customer VMI agreement to the supplying vendor for inventory replenishment planning.',
    `tertiary_customer_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who last modified this VMI agreement record. Supports audit and accountability.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account (retailer, distributor, wholesaler, or foodservice operator) participating in this VMI agreement.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the VMI agreement, used in communications with the trade partner and in SAP IBP or APS systems.. Valid values are `^VMI-[A-Z0-9]{8,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the VMI agreement: draft (being negotiated), pending approval (awaiting sign-off), active (in force), suspended (temporarily paused), terminated (ended early), or expired (reached end date).. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the customer vmi agreement record',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the VMI agreement automatically renews at the end of the term (True) or requires explicit renegotiation (False).',
    `customer_vmi_agreement_code` STRING COMMENT 'The customer vmi agreement code of the customer vmi agreement record',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the signed legal contract document stored in the document management system (e.g., Veeva Vault, SharePoint).',
    `covered_sku_count` STRING COMMENT 'Total number of distinct SKUs included in the VMI agreement scope. Used for agreement complexity assessment and system configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VMI agreement record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this VMI agreement (penalties, inventory valuation, etc.).. Valid values are `^[A-Z]{3}$`',
    `customer_vmi_agreement_status` STRING COMMENT 'The customer vmi agreement status of the customer vmi agreement record',
    `customer_vmi_agreement_description` STRING COMMENT 'The customer vmi agreement description of the customer vmi agreement record',
    `effective_end_date` DATE COMMENT 'Date when the VMI agreement expires or terminates. Nullable for open-ended agreements with auto-renewal clauses.',
    `effective_from` DATE COMMENT 'The effective from of the customer vmi agreement record',
    `effective_start_date` DATE COMMENT 'Date when the VMI agreement becomes binding and replenishment responsibilities transfer to the manufacturer.',
    `effective_until` DATE COMMENT 'The effective until of the customer vmi agreement record',
    `forecast_sharing_cadence` STRING COMMENT 'Frequency at which the trade account shares demand forecasts, POS data, or promotional plans with the manufacturer to support VMI planning.. Valid values are `daily|weekly|bi_weekly|monthly|quarterly|none`',
    `inventory_ownership_model` STRING COMMENT 'Defines who owns the inventory at the trade account location: customer-owned (traditional), supplier-owned consignment (ownership transfers at sale), shared risk, or pay-on-scan (ownership transfers at POS scan).. Valid values are `customer_owned|supplier_owned_consignment|shared_risk|pay_on_scan`',
    `inventory_valuation_method` STRING COMMENT 'Accounting method used to value inventory under this VMI agreement: FIFO (First In First Out), LIFO (Last In First Out), weighted average, or standard cost.. Valid values are `fifo|lifo|weighted_average|standard_cost`',
    `inventory_visibility_method` STRING COMMENT 'Technical method by which the manufacturer receives inventory position data from the trade account: EDI 846 (inventory inquiry/advice), API integration, web portal access, manual reports, WMS integration, or none.. Valid values are `edi_846|api_integration|portal_access|manual_report|wms_integration|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this VMI agreement record was last updated. Tracks changes to terms, status, or configuration.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review meeting or report for this VMI agreement. Used to track review compliance.',
    `max_inventory_weeks_of_supply` DECIMAL(18,2) COMMENT 'Maximum inventory target expressed as weeks of supply. Replenishment orders are sized to bring inventory to this level without exceeding it.',
    `max_stock_level` DECIMAL(18,2) COMMENT 'The max stock level of the customer vmi agreement record',
    `min_inventory_weeks_of_supply` DECIMAL(18,2) COMMENT 'Minimum inventory target expressed as weeks of supply (demand coverage). Triggers replenishment when inventory falls below this threshold.',
    `min_stock_level` DECIMAL(18,2) COMMENT 'The min stock level of the customer vmi agreement record',
    `customer_vmi_agreement_name` STRING COMMENT 'The customer vmi agreement name of the customer vmi agreement record',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next formal performance review meeting or report. Drives calendar reminders and preparation workflows.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, exceptions, or operational instructions specific to this VMI agreement.',
    `order_transmission_method` STRING COMMENT 'Method by which replenishment orders are transmitted to the trade account or their systems: EDI 850 (purchase order), API, web portal, email, fax, or manual entry.. Valid values are `edi_850|api|portal|email|fax|manual`',
    `penalty_amount_per_incident` DECIMAL(18,2) COMMENT 'Fixed financial penalty amount charged per SLA violation incident (e.g., per OOS event, per late delivery). Expressed in the agreement currency.',
    `penalty_clause_enabled` BOOLEAN COMMENT 'Indicates whether the VMI agreement includes financial penalties or chargebacks for SLA violations (e.g., missed OTIF targets, excess OOS incidents).',
    `performance_review_frequency` STRING COMMENT 'Cadence at which the manufacturer and trade account conduct formal performance reviews of VMI metrics (fill rate, OTIF, inventory turns, OOS incidents).. Valid values are `monthly|quarterly|semi_annually|annually`',
    `pos_data_sharing_enabled` BOOLEAN COMMENT 'Indicates whether the trade account shares real-time or near-real-time POS (point of sale) data with the manufacturer to improve demand sensing accuracy.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the customer vmi agreement record',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required before the end date to trigger renewal or termination discussions. Typically 30, 60, or 90 days.',
    `replenishment_frequency` STRING COMMENT 'Cadence at which the manufacturer reviews inventory levels and triggers replenishment orders: daily, twice weekly, weekly, bi-weekly, monthly, on-demand (event-driven), or continuous (real-time). [ENUM-REF-CANDIDATE: daily|twice_weekly|weekly|bi_weekly|monthly|on_demand|continuous — 7 candidates stripped; promote to reference product]',
    `replenishment_lead_time_days` STRING COMMENT 'Committed lead time in days from replenishment order creation to delivery at the trade account location. Used for min/max inventory calculations.',
    `review_frequency_days` STRING COMMENT 'The review frequency days of the customer vmi agreement record',
    `safety_stock_weeks` DECIMAL(18,2) COMMENT 'Buffer inventory expressed as weeks of supply to protect against demand variability and supply disruptions. Included in min inventory calculations.',
    `sku_scope_type` STRING COMMENT 'Defines the breadth of SKU coverage in the VMI agreement: all SKUs, specific product category, specific brand, explicit SKU list, or custom selection criteria.. Valid values are `all_skus|product_category|brand|specific_sku_list|custom`',
    `sla_target_fill_rate_percent` DECIMAL(18,2) COMMENT 'Contractual target for order fill rate (percentage of ordered quantity delivered) that the manufacturer commits to achieve under this VMI agreement. Typically 95-99%.',
    `sla_target_oos_incidents_per_month` STRING COMMENT 'Maximum allowable number of out-of-stock incidents per month at the trade account location under this VMI agreement. Exceeding this triggers penalty or review clauses.',
    `sla_target_otif_percent` DECIMAL(18,2) COMMENT 'Contractual target for OTIF (On Time In Full) delivery performance that the manufacturer commits to achieve. Measures both timeliness and completeness of deliveries.',
    `source_system_code` STRING COMMENT 'The source system code of the customer vmi agreement record',
    `trade_partner_contact_email` STRING COMMENT 'Email address of the primary trade account contact for VMI communications, forecast sharing, and issue escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `trade_partner_contact_name` STRING COMMENT 'Name of the primary contact person at the trade account responsible for VMI coordination and issue resolution.',
    `trade_partner_contact_phone` STRING COMMENT 'Phone number of the primary trade account contact for urgent VMI issues and escalations.',
    `uom` STRING COMMENT 'The uom of the customer vmi agreement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the customer vmi agreement record',
    `vmi_program_type` STRING COMMENT 'Classification of the VMI program model: full VMI (supplier owns inventory decisions), CMI/Co-Managed Inventory (collaborative), consignment (supplier owns inventory until sale), supplier-managed replenishment, continuous replenishment, or vendor-owned inventory.. Valid values are `full_vmi|co_managed_inventory|consignment|supplier_managed_replenishment|continuous_replenishment|vendor_owned_inventory`',
    CONSTRAINT pk_customer_vmi_agreement PRIMARY KEY(`customer_vmi_agreement_id`)
) COMMENT 'Vendor Managed Inventory (VMI) agreement between the CPG manufacturer and a trade account. Captures VMI program type (full VMI, CMI/Co-Managed Inventory, consignment), covered SKU scope, min/max inventory targets by location, replenishment frequency, lead time commitments, forecast sharing cadence, VMI start/end dates, responsible demand planner, and performance SLA thresholds (fill rate %, OTIF %, weeks of supply targets). Links to trade_account and drives automated replenishment triggers in SAP IBP or similar APS systems.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` (
    `account_sla_id` BIGINT COMMENT 'Unique identifier for the account service level agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for SLA ownership tracking; SLA records must reference the employee managing the account.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account (retailer, distributor, wholesaler, or foodservice customer) to which this SLA applies.',
    `account_sla_status` STRING COMMENT 'Current lifecycle state of the SLA. Draft indicates pending approval; active indicates in force; suspended indicates temporarily paused; expired indicates end date reached; terminated indicates early cancellation; under review indicates renegotiation in progress.. Valid values are `draft|active|suspended|expired|terminated|under_review`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account sla record',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this SLA. Typically a commercial director or senior account executive. Nullable for draft or unapproved SLAs.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA was formally approved and moved to active status. Nullable for draft or unapproved SLAs.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the SLA automatically renews at the end of the effective period (True) or requires explicit renegotiation (False).',
    `account_sla_code` STRING COMMENT 'The account sla code of the account sla record',
    `contract_reference` STRING COMMENT 'Reference to the master commercial contract or trading agreement under which this SLA is governed. Links SLA to broader contractual framework.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA record was first created in the system. Audit trail for record inception.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for penalty and incentive amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `account_sla_description` STRING COMMENT 'The account sla description of the account sla record',
    `effective_from` DATE COMMENT 'The effective from of the account sla record',
    `effective_from_date` DATE COMMENT 'Date when the SLA terms become binding and performance measurement begins.',
    `effective_to_date` DATE COMMENT 'Date when the SLA terms expire or are scheduled to end. Nullable for open-ended agreements subject to termination notice.',
    `effective_until` DATE COMMENT 'The effective until of the account sla record',
    `escalation_procedure` STRING COMMENT 'Description of the process and contacts for escalating SLA breaches or disputes. Includes escalation levels, response times, and resolution authority.',
    `exclusion_conditions` STRING COMMENT 'Description of circumstances under which SLA performance measurement is suspended or penalties waived (e.g., force majeure, natural disasters, customer-caused delays, system outages).',
    `fill_rate_target_pct` DECIMAL(18,2) COMMENT 'The fill rate target pct of the account sla record',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary value of incentive per occurrence or per measurement period when SLA target is exceeded. Nullable if incentive is non-monetary or variable.',
    `incentive_terms` STRING COMMENT 'Description of rewards or bonuses provided when performance exceeds the target. May include volume bonuses, preferred status, or co-investment in joint initiatives.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this SLA record. Audit trail for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA record was last updated. Audit trail for change tracking.',
    `measurement_period` STRING COMMENT 'Time window over which SLA performance is calculated and reported. Rolling periods provide continuous assessment; fixed periods align with calendar or fiscal cycles. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annual|rolling_30_days|rolling_90_days — 7 candidates stripped; promote to reference product]',
    `minimum_performance_threshold` DECIMAL(18,2) COMMENT 'Lowest acceptable performance level before penalties or escalation are triggered. Typically set below the target to allow for minor variance.',
    `account_sla_name` STRING COMMENT 'The account sla name of the account sla record',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal SLA review meeting or renegotiation session.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, historical amendments, or operational guidance related to this SLA.',
    `otif_target_pct` DECIMAL(18,2) COMMENT 'The otif target pct of the account sla record',
    `owning_team` STRING COMMENT 'Name or identifier of the internal commercial, sales, or customer service team responsible for managing this SLA and the account relationship.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary value of penalty per occurrence or per measurement period when SLA is breached. Nullable if penalty is non-monetary or variable.',
    `penalty_terms` STRING COMMENT 'Description of financial or commercial penalties applied when performance falls below the minimum threshold. May include rebates, credits, discounts, or service recovery actions.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account sla record',
    `reporting_frequency` STRING COMMENT 'Cadence at which SLA performance reports are generated and shared with the account. On-demand indicates ad-hoc reporting upon request. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annual|on_demand — 7 candidates stripped; promote to reference product]',
    `review_frequency` STRING COMMENT 'Cadence at which the SLA terms are formally reviewed and potentially renegotiated with the account. As-needed indicates event-driven reviews.. Valid values are `monthly|quarterly|semi_annual|annual|biennial|as_needed`',
    `sla_number` STRING COMMENT 'Business identifier for the SLA. Externally-known unique code used in contracts and commercial communications.. Valid values are `^SLA-[A-Z0-9]{6,12}$`',
    `sla_tier` STRING COMMENT 'Service tier classification indicating the level of commitment and priority. Higher tiers typically receive more favorable terms, faster response, and stricter performance guarantees.. Valid values are `platinum|gold|silver|bronze|standard`',
    `sla_type` STRING COMMENT 'Category of service level commitment. OTIF (On Time In Full) measures delivery timeliness and completeness; fill rate measures order fulfillment percentage; lead time measures order-to-delivery duration; invoice accuracy measures billing correctness; claims resolution measures dispute handling speed; order accuracy measures picking/shipping correctness.. Valid values are `otif|fill_rate|lead_time|invoice_accuracy|claims_resolution|order_accuracy`',
    `source_system_code` STRING COMMENT 'Unique identifier of this SLA record in the source operational system. Used for traceability and reconciliation.',
    `target_metric_unit` STRING COMMENT 'Unit of measure for the target metric value. Percentage for rate-based metrics (OTIF, fill rate, accuracy); days or hours for time-based metrics (lead time, resolution time); count for volume-based metrics; ratio for comparative metrics.. Valid values are `percentage|days|hours|count|ratio`',
    `target_metric_value` DECIMAL(18,2) COMMENT 'Quantitative performance target that must be achieved. For OTIF this is percentage (e.g., 95.00 for 95%); for lead time this is days; for fill rate this is percentage; for invoice accuracy this is percentage; for claims resolution this is days.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the SLA before the effective end date.',
    `uom` STRING COMMENT 'The uom of the account sla record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account sla record',
    `created_by` STRING COMMENT 'User ID or name of the person who created this SLA record. Audit trail for accountability.',
    CONSTRAINT pk_account_sla PRIMARY KEY(`account_sla_id`)
) COMMENT 'Service Level Agreement terms defined for a trade account, covering order fulfillment, delivery, and service commitments. Captures SLA type (OTIF, fill rate, lead time, invoice accuracy, claims resolution), target metric value, measurement period, penalty/incentive terms, effective date range, SLA tier (gold, silver, bronze), and owning commercial team. Distinct from VMI agreements — covers the full commercial service commitment beyond inventory replenishment.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` (
    `account_segment_id` BIGINT COMMENT 'Unique identifier for the account segment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that assigned this segment classification.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account (retailer, distributor, wholesaler, or foodservice customer) to which this segmentation applies.',
    `account_segment_status` STRING COMMENT 'The account segment status of the account segment record',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this account segment assignment is currently active and in use for commercial operations.',
    `acv_tier` STRING COMMENT 'Tier classification based on All Commodity Volume, representing the total retail sales volume of the account across all product categories.. Valid values are `high|medium|low|not_measured`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account segment record',
    `applicable_region` STRING COMMENT 'Geographic region where this segmentation applies (e.g., North America, EMEA, APAC, LATAM).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this segment assignment was formally approved.',
    `assigned_sales_region` STRING COMMENT 'Sales region or territory to which this account segment is assigned for field sales coverage and quota allocation.',
    `channel_tier` STRING COMMENT 'Hierarchical tier assignment within the channel, indicating relative importance or volume contribution (tier_1 = highest, tier_4 = lowest).. Valid values are `tier_1|tier_2|tier_3|tier_4|unassigned`',
    `account_segment_code` STRING COMMENT 'The account segment code of the account segment record',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this account segment record was first created in the system.',
    `credit_limit_tier` STRING COMMENT 'Credit limit tier classification for accounts in this segment, determining maximum outstanding receivables allowed.. Valid values are `unlimited|high|medium|low|restricted`',
    `currency_code` STRING COMMENT 'The currency code of the account segment record',
    `customer_tier` STRING COMMENT 'Customer value tier assignment based on revenue, volume, or strategic importance (platinum = highest value, standard = baseline).. Valid values are `platinum|gold|silver|bronze|standard`',
    `account_segment_description` STRING COMMENT 'The account segment description of the account segment record',
    `dsd_eligible_flag` BOOLEAN COMMENT 'Indicates whether the account is eligible for Direct Store Delivery, bypassing distribution centers for direct product delivery to retail locations.',
    `edi_trading_partner_flag` BOOLEAN COMMENT 'Indicates whether the account is configured as an EDI trading partner for automated order and invoice exchange.',
    `effective_end_date` DATE COMMENT 'Date when this account segment assignment expires or is superseded by a new assignment. Null indicates open-ended assignment.',
    `effective_from` DATE COMMENT 'The effective from of the account segment record',
    `effective_start_date` DATE COMMENT 'Date when this account segment assignment becomes effective and applicable for business operations.',
    `effective_until` DATE COMMENT 'The effective until of the account segment record',
    `field_sales_call_frequency` STRING COMMENT 'Recommended frequency of field sales representative visits based on account segment and strategic priority.. Valid values are `weekly|biweekly|monthly|quarterly|annual|as_needed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this account segment record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this account segment assignment was last reviewed and validated by commercial leadership.',
    `account_segment_name` STRING COMMENT 'The account segment name of the account segment record',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this account segment assignment.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this account segment assignment, capturing additional context or special considerations.',
    `otif_sla_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for On Time In Full delivery performance as defined in the service level agreement for this account segment.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code applicable to this account segment (e.g., NET30, NET60, COD).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `pricing_strategy` STRING COMMENT 'Pricing strategy applicable to this account segment (EDLP = Everyday Low Price, Hi-Lo = High-Low promotional pricing).. Valid values are `edlp|hi_lo|hybrid|custom|standard`',
    `primary_channel_code` STRING COMMENT 'Code representing the primary channel classification (e.g., RETAIL, FOODSERVICE, WHOLESALE, DTC).. Valid values are `^[A-Z0-9_]{2,15}$`',
    `primary_channel_name` STRING COMMENT 'Full name of the primary channel (e.g., Retail, Foodservice, Wholesale, Direct to Consumer).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account segment record',
    `secondary_channel_code` STRING COMMENT 'Code representing the secondary channel sub-classification (e.g., GROCERY, MASS, CLUB, DRUG, CONVENIENCE, ECOMMERCE, QSR, INSTITUTIONAL).. Valid values are `^[A-Z0-9_]{2,15}$`',
    `secondary_channel_name` STRING COMMENT 'Full name of the secondary channel sub-classification (e.g., Grocery, Mass Merchandiser, Club, Drug, Convenience Store, E-Commerce, Quick Service Restaurant, Institutional).',
    `segment_assignment_reason` STRING COMMENT 'Business rationale or trigger for this segment assignment (e.g., annual review, volume threshold met, strategic partnership established).',
    `segment_code` STRING COMMENT 'Short alphanumeric code representing the commercial segment assignment (e.g., STRATEGIC, KEY_ACCT, REGIONAL, EMERGING, TAIL).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `segment_name` STRING COMMENT 'Full descriptive name of the commercial segment (e.g., Strategic Account, Key Account, Regional Account, Emerging Account, Tail Account).',
    `segment_tier` STRING COMMENT 'The segment tier of the account segment record',
    `segmentation_model_version` STRING COMMENT 'Version identifier of the segmentation model or algorithm used to assign this segment (e.g., 2024.Q1, V3.2).. Valid values are `^[A-Z0-9._-]{1,20}$`',
    `source_system_code` STRING COMMENT 'The source system code of the account segment record',
    `strategic_priority_flag` BOOLEAN COMMENT 'Indicates whether this account is designated as a strategic priority for executive engagement and resource allocation.',
    `tdp_tier` STRING COMMENT 'Tier classification based on Total Distribution Points, representing the weighted distribution reach of the account.. Valid values are `high|medium|low|not_measured`',
    `trade_promotion_eligibility` STRING COMMENT 'Eligibility status for trade promotion programs and funding allocation based on segment classification.. Valid values are `full|limited|excluded|pending_review`',
    `uom` STRING COMMENT 'The uom of the account segment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account segment record',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether the account is eligible for Vendor Managed Inventory programs where the supplier manages inventory replenishment.',
    CONSTRAINT pk_account_segment PRIMARY KEY(`account_segment_id`)
) COMMENT 'Commercial segmentation, channel classification taxonomy, and go-to-market tier assignment for trade accounts. Owns the complete channel reference hierarchy (primary: retail, foodservice, wholesale, DTC; secondary: grocery, mass, club, drug, convenience, e-commerce, QSR, institutional) as well as the commercial segment assignment (strategic, key account, regional, emerging, tail). Captures channel code, channel name, channel tier, segmentation model version, customer tier, strategic priority flag, assigned sales region, applicable region, active status, and effective date range. Drives trade promotion allocation, field sales call frequency, and standardized channel reporting across all downstream domains.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` (
    `account_assortment_id` BIGINT COMMENT 'Unique identifier for the account assortment record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Assortment Authorization audit requires linking the approving employee to each assortment entry.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Packaging decisions for each assortment reference packaging_profile to ensure recyclability, material compliance, and regulatory packaging standards.',
    `product_lca_id` BIGINT COMMENT 'Foreign key linking to sustainability.product_lca. Business justification: Assortment planning uses product LCA data to select SKUs that meet carbon‑footprint and water‑footprint targets.',
    `sku_id` BIGINT COMMENT 'Reference to the product (SKU) included in this assortment agreement.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account (retailer, distributor, wholesaler, or foodservice operator) for which this assortment is defined.',
    `account_assortment_status` STRING COMMENT 'The account assortment status of the account assortment record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account assortment record',
    `assortment_type` STRING COMMENT 'Classification of the assortment item. Core range items are permanent listings; seasonal items are time-bound; promotional items support trade promotions; new items are recent launches; limited edition items are short-run offerings; test market items are regional trials.. Valid values are `core_range|seasonal|promotional|new_item|limited_edition|test_market`',
    `authorization_date` DATE COMMENT 'The date when this assortment listing was formally authorized or approved. Used for compliance and audit purposes.',
    `authorized_distribution_points` STRING COMMENT 'The number of store locations or distribution points within the account where this SKU is authorized for sale. Used for TDP and ACV calculations.',
    `category_role` STRING COMMENT 'The strategic role this SKU plays in the category assortment. Destination items drive traffic; routine items are everyday purchases; occasional items are infrequent buys; convenience items are impulse purchases.. Valid values are `destination|routine|occasional|convenience`',
    `account_assortment_code` STRING COMMENT 'The account assortment code of the account assortment record',
    `contract_reference` STRING COMMENT 'The reference number or identifier of the trade agreement or contract that governs this assortment. Links to master trade agreement documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the account assortment record',
    `currency_code` STRING COMMENT 'The currency code of the account assortment record',
    `delist_date` DATE COMMENT 'The date when the product was or will be removed from the authorized assortment. Null for active listings. Used for OSA monitoring and distribution gap analysis.',
    `account_assortment_description` STRING COMMENT 'The account assortment description of the account assortment record',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this SKU is delivered via direct store delivery to this account. True if DSD; false if warehouse delivery.',
    `effective_end_date` DATE COMMENT 'The date on which this assortment record expires. Null for open-ended core range items. Used for seasonal and promotional assortments.',
    `effective_from` DATE COMMENT 'The effective from of the account assortment record',
    `effective_start_date` DATE COMMENT 'The date from which this assortment record becomes effective. Used for seasonal and promotional assortments with defined start dates.',
    `effective_until` DATE COMMENT 'The effective until of the account assortment record',
    `exclusive_flag` BOOLEAN COMMENT 'Indicates whether this SKU is exclusive to this account (not available to other retailers). True if exclusive; false if non-exclusive.',
    `gtin` STRING COMMENT 'The GS1 Global Trade Item Number for the product in this assortment. May be GTIN-8, GTIN-12 (UPC), GTIN-13 (EAN), or GTIN-14.. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `is_mandatory` BOOLEAN COMMENT 'The is mandatory of the account assortment record',
    `last_order_date` DATE COMMENT 'The most recent date when an order was placed for this SKU by this account. Used for distribution gap analysis and OSA monitoring.',
    `last_shipment_date` DATE COMMENT 'The most recent date when this SKU was shipped to this account. Used for on-time in-full (OTIF) tracking and distribution monitoring.',
    `launch_wave` STRING COMMENT 'The launch wave or phase identifier for new item introductions. Used to track rollout progress and coordinate new item launch activities.',
    `listing_date` DATE COMMENT 'The date when the product was first authorized for sale to this account. Marks the start of the assortment agreement for this SKU.',
    `listing_status` STRING COMMENT 'Current status of the product listing with the account. Listed indicates active authorization; delisted indicates removal from assortment; pending indicates approval in progress; suspended indicates temporary hold; discontinued indicates permanent removal.. Valid values are `listed|delisted|pending|suspended|discontinued`',
    `moq` DECIMAL(18,2) COMMENT 'The minimum order quantity agreed between the manufacturer and the account for this SKU. Expressed in the base unit of measure.',
    `moq_unit` STRING COMMENT 'The unit of measure for the minimum order quantity. Defines whether MOQ is expressed in eaches, cases, pallets, layers, or inner packs.. Valid values are `each|case|pallet|layer|inner_pack`',
    `account_assortment_name` STRING COMMENT 'The account assortment name of the account assortment record',
    `notes` STRING COMMENT 'Free-text notes or comments about this assortment listing. May include special handling instructions, promotional details, or account-specific requirements.',
    `planogram_slot_count` STRING COMMENT 'The number of shelf facings or slots allocated to this SKU in the retailers planogram. Used for on-shelf availability (OSA) monitoring and space management analysis.',
    `priority_rank` STRING COMMENT 'The priority ranking of this SKU within the accounts assortment. Lower numbers indicate higher priority. Used for allocation and supply planning decisions.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this assortment item is part of a trade promotion or promotional event. True if promotional; false if regular assortment.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account assortment record',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this assortment record was first created in the lakehouse. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this assortment record was last updated in the lakehouse. Used for change tracking and audit purposes.',
    `source_system_code` STRING COMMENT 'The unique identifier of this assortment record in the source operational system. Used for data lineage and reconciliation.',
    `uom` STRING COMMENT 'The uom of the account assortment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account assortment record',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU is eligible for vendor managed inventory replenishment with this account. True if VMI-eligible; false otherwise.',
    CONSTRAINT pk_account_assortment PRIMARY KEY(`account_assortment_id`)
) COMMENT 'Authorized product assortment (range) agreed between the CPG manufacturer and a trade account or retail banner. Captures the list of authorized SKUs/GTINs, assortment type (core range, seasonal, promotional, new item), listing status (listed, delisted, pending), listing date, delist date, minimum order quantity (MOQ), and planogram slot count. Supports OSA monitoring, new item launch tracking, and distribution gap analysis via TradeEdge.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` (
    `account_credit_profile_id` BIGINT COMMENT 'Unique identifier for the account credit profile record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the credit analyst responsible for managing this accounts credit profile and conducting credit reviews.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account (retailer, distributor, wholesaler, or foodservice customer) to which this credit profile applies.',
    `account_credit_profile_status` STRING COMMENT 'The account credit profile status of the account credit profile record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account credit profile record',
    `available_credit_amount` DECIMAL(18,2) COMMENT 'Remaining credit capacity available for new orders, calculated as credit limit minus current exposure. Used for order release decisions.',
    `bankruptcy_filing_date` DATE COMMENT 'Date when the account filed for bankruptcy. Null if no bankruptcy filing exists.',
    `bankruptcy_flag` BOOLEAN COMMENT 'Indicates whether this account has filed for bankruptcy or is in bankruptcy proceedings. True = bankruptcy status, False = no bankruptcy.',
    `account_credit_profile_code` STRING COMMENT 'The account credit profile code of the account credit profile record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was first created in the system.',
    `credit_analyst_notes` STRING COMMENT 'Free-text notes from the credit analyst documenting credit decisions, risk factors, payment behavior, disputes, and other relevant credit management information.',
    `credit_hold_date` DATE COMMENT 'Date when the credit hold was placed on this account. Null if no hold is currently active.',
    `credit_hold_reason_code` STRING COMMENT 'Code indicating the reason for credit hold (e.g., OVERLIMIT = exceeded credit limit, PASTDUE = overdue invoices, DISPUTE = payment dispute, BANKRUPTCY = customer bankruptcy filing).. Valid values are `^[A-Z0-9]{2,10}$`',
    `credit_hold_status` STRING COMMENT 'Current credit hold status for this account. Active = credit hold in effect, orders blocked; Released = no hold, orders allowed; Manual Review = requires credit analyst approval; Blocked = permanently blocked.. Valid values are `active|released|manual_review|blocked`',
    `credit_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum insured amount under the trade credit insurance policy for this account. Null if no insurance coverage exists.',
    `credit_insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether this account is covered by trade credit insurance. True = covered, False = not covered.',
    `credit_insurance_policy_number` STRING COMMENT 'Policy number for the trade credit insurance covering this account. Null if no insurance coverage exists.',
    `credit_insurance_provider` STRING COMMENT 'Name of the trade credit insurance provider (e.g., Euler Hermes, Atradius, Coface). Null if no insurance coverage exists.',
    `credit_limit` DECIMAL(18,2) COMMENT 'The credit limit of the account credit profile record',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure authorized for this trade account, expressed in the accounts functional currency. Approved by credit management and reviewed periodically.',
    `credit_limit_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the credit limit amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `credit_limit_override_expiry_date` DATE COMMENT 'Expiration date for a temporary credit limit override. After this date, the credit limit reverts to the standard amount. Null if no override is active.',
    `credit_limit_override_flag` BOOLEAN COMMENT 'Indicates whether the credit limit has been manually overridden by credit management (e.g., temporary increase for seasonal demand). True = override active, False = standard limit.',
    `credit_limit_override_reason` STRING COMMENT 'Business justification for the credit limit override (e.g., Seasonal demand increase for Q4 holiday period, Strategic account expansion).',
    `credit_rating` STRING COMMENT 'The credit rating of the account credit profile record',
    `credit_review_date` DATE COMMENT 'Date of the most recent credit review for this account. Credit reviews are typically conducted annually or triggered by significant events (payment default, financial distress).',
    `credit_used` DECIMAL(18,2) COMMENT 'The credit used of the account credit profile record',
    `currency_code` STRING COMMENT 'The currency code of the account credit profile record',
    `current_exposure_amount` DECIMAL(18,2) COMMENT 'Current outstanding receivables balance for this account, including open invoices, unbilled deliveries, and pending orders. Updated in real-time from SAP FI-AR.',
    `account_credit_profile_description` STRING COMMENT 'The account credit profile description of the account credit profile record',
    `dso_actual_days` STRING COMMENT 'Actual DSO (Days Sales Outstanding) for this account over the trailing 90-day period, calculated as (Average Accounts Receivable / Revenue) × Number of Days.',
    `dso_target_days` STRING COMMENT 'Target DSO (Days Sales Outstanding) for this account, representing the expected number of days to collect payment. Used for performance monitoring and credit risk assessment.',
    `dunning_level` STRING COMMENT 'Current dunning level (collection escalation stage) for this account. 0 = no dunning, 1-9 = escalating collection actions. Higher levels indicate more aggressive collection efforts.',
    `effective_date` DATE COMMENT 'Date when this credit profile became effective. Used for historical tracking and audit purposes.',
    `effective_from` DATE COMMENT 'The effective from of the account credit profile record',
    `effective_until` DATE COMMENT 'The effective until of the account credit profile record',
    `expiry_date` DATE COMMENT 'Date when this credit profile expires or was superseded by a new profile. Null for the current active profile.',
    `external_credit_rating` STRING COMMENT 'Credit rating from external credit bureau or rating agency (e.g., Dun & Bradstreet PAYDEX score, Experian rating). Format varies by provider.',
    `external_credit_score` STRING COMMENT 'Numeric credit score from external credit bureau (e.g., PAYDEX score 0-100, FICO commercial score). Higher scores indicate lower risk.',
    `internal_credit_rating` STRING COMMENT 'Internal credit rating assigned by the companys credit analysts based on payment history, financial strength, and business relationship. Scale: AAA (highest) to D (default). [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `last_dunning_date` DATE COMMENT 'Date of the most recent dunning notice (collection letter) sent to this account. Null if no dunning has occurred.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this credit profile record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was last updated. Used for audit trail and change tracking.',
    `account_credit_profile_name` STRING COMMENT 'The account credit profile name of the account credit profile record',
    `next_credit_review_date` DATE COMMENT 'Scheduled date for the next periodic credit review. Used for credit management workflow and compliance with internal credit policy.',
    `notes` STRING COMMENT 'The notes of the account credit profile record',
    `payment_method_preference` STRING COMMENT 'Preferred payment method for this account. ACH = Automated Clearing House, Wire = wire transfer, Check = paper check, EDI = Electronic Data Interchange payment, Credit Card = corporate credit card.. Valid values are `ach|wire|check|edi|credit_card`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining the due date calculation and discount conditions (e.g., NET30, NET60, 2/10NET30, COD). Maps to SAP payment terms master.. Valid values are `^[A-Z0-9]{2,10}$`',
    `payment_terms_description` STRING COMMENT 'Human-readable description of payment terms (e.g., Net 30 days, Net 60 days, 2% discount if paid within 10 days, net 30, Cash on Delivery).',
    `profile_status` STRING COMMENT 'Current status of this credit profile record. Active = currently in use, Inactive = historical/superseded, Suspended = temporarily disabled, Under Review = pending credit analyst review.. Valid values are `active|inactive|suspended|under_review`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account credit profile record',
    `risk_category` STRING COMMENT 'Overall financial risk classification for this account based on credit rating, payment history, exposure, and external factors. Low = minimal risk, Medium = moderate risk, High = elevated risk, Critical = severe risk.. Valid values are `low|medium|high|critical`',
    `risk_class` STRING COMMENT 'The risk class of the account credit profile record',
    `source_system_code` STRING COMMENT 'Unique identifier for this credit profile record in the source system. Used for data lineage and reconciliation.',
    `uom` STRING COMMENT 'The uom of the account credit profile record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account credit profile record',
    CONSTRAINT pk_account_credit_profile PRIMARY KEY(`account_credit_profile_id`)
) COMMENT 'Credit and financial risk profile for a trade account, capturing credit limit, current credit exposure, credit rating (internal and external), payment terms (net 30, net 60, COD), DSO (Days Sales Outstanding) target, credit hold status, credit review date, credit insurance coverage, and credit analyst notes. Managed in SAP S/4HANA FI-AR and used for order release decisions and financial risk management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` (
    `account_pricing_agreement_id` BIGINT COMMENT 'Unique identifier for the account pricing agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'The user ID of the person who most recently modified this pricing agreement record, establishing accountability for changes.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Sustainability‑linked pricing agreements tie discount tiers to the achievement of ESG commitment targets.',
    `price_list_id` BIGINT COMMENT 'Reference to the master price list that serves as the base for this agreement. The price list contains SKU-level pricing that may be further adjusted by discounts and rebates defined in this agreement.',
    `primary_account_manager_employee_id` BIGINT COMMENT 'The employee ID of the account manager or key account manager responsible for this trade relationship and pricing agreement.',
    `trade_account_id` BIGINT COMMENT 'Reference to the B2B trade customer (retailer, distributor, wholesaler, or foodservice account) that this pricing agreement applies to.',
    `account_pricing_agreement_status` STRING COMMENT 'The account pricing agreement status of the account pricing agreement record',
    `agreement_name` STRING COMMENT 'Descriptive name for the pricing agreement, typically including the account name and agreement period for easy identification.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for this pricing agreement, used in contracts and communications with the trade partner.',
    `agreement_status` STRING COMMENT 'The current lifecycle status of the pricing agreement. Draft agreements are being negotiated, pending approval agreements await internal authorization, active agreements are in force, suspended agreements are temporarily inactive, expired agreements have passed their end date, and terminated agreements have been cancelled before expiration.. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `agreement_type` STRING COMMENT 'Classification of the pricing agreement structure. Standard agreements use fixed pricing, promotional agreements support temporary campaigns, volume-based agreements offer discounts based on purchase volume, tiered agreements have multiple pricing levels, custom agreements are negotiated individually, national account agreements cover terms, and regional agreements apply to specific geographic areas. [ENUM-REF-CANDIDATE: standard|promotional|volume_based|tiered|custom|national_account|regional — 7 candidates stripped; promote to reference product]',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account pricing agreement record',
    `approval_status` STRING COMMENT 'The approval workflow status for this pricing agreement. Tracks whether the negotiated terms have been reviewed and authorized by the appropriate internal stakeholders (pricing manager, sales director, finance).. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing agreement received final approval and was authorized for activation.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether this agreement automatically renews at the end of the effective period. When true, the agreement extends for another term unless either party provides termination notice.',
    `base_discount_percent` DECIMAL(18,2) COMMENT 'The negotiated base discount percentage applied to list prices for this account. This is the foundational discount before any volume rebates or promotional allowances.',
    `account_pricing_agreement_code` STRING COMMENT 'The account pricing agreement code of the account pricing agreement record',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which all pricing, discounts, and rebates in this agreement are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `account_pricing_agreement_description` STRING COMMENT 'The account pricing agreement description of the account pricing agreement record',
    `discount_pct` DECIMAL(18,2) COMMENT 'The discount pct of the account pricing agreement record',
    `distribution_channel_code` STRING COMMENT 'The distribution channel through which products are sold under this agreement (e.g., retail, foodservice, wholesale, DTC). Different channels may have different pricing structures.',
    `division_code` STRING COMMENT 'The product division or business unit to which this pricing agreement applies (e.g., personal care, household products, health and wellness). Allows different divisions to maintain separate pricing agreements with the same account.',
    `early_payment_discount_percent` DECIMAL(18,2) COMMENT 'The discount percentage offered if the account pays invoices before the standard payment due date, incentivizing faster payment.',
    `effective_end_date` DATE COMMENT 'The date when this pricing agreement expires and the negotiated terms are no longer valid. Nullable for open-ended agreements that remain active until explicitly terminated.',
    `effective_from` DATE COMMENT 'The effective from of the account pricing agreement record',
    `effective_start_date` DATE COMMENT 'The date when this pricing agreement becomes active and the negotiated terms take effect. Orders placed on or after this date are subject to these pricing conditions.',
    `effective_until` DATE COMMENT 'The effective until of the account pricing agreement record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing agreement record was most recently updated, tracking the latest change to any field.',
    `minimum_order_quantity` STRING COMMENT 'The minimum order quantity required per order or per SKU to qualify for the negotiated pricing terms. Ensures economical order sizes for manufacturing and logistics.',
    `msrp_guidance_amount` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price for products covered by this agreement. Similar to RSP but typically used for durable goods and higher-value items.',
    `account_pricing_agreement_name` STRING COMMENT 'The account pricing agreement name of the account pricing agreement record',
    `notes` STRING COMMENT 'Free-text notes capturing special terms, negotiation context, exceptions, or other relevant information about this pricing agreement that does not fit structured fields.',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the invoice payment schedule and early payment discount terms for this agreement (e.g., Net 30, 2/10 Net 30).',
    `pricing_strategy` STRING COMMENT 'The pricing strategy model applied to this agreement. EDLP (Everyday Low Price) maintains consistent low prices, Hi-Lo (High-Low) uses regular price with frequent promotions, hybrid combines both approaches, cost-plus adds margin to cost, and market-based aligns with competitive market rates.. Valid values are `edlp|hi_lo|hybrid|cost_plus|market_based`',
    `pricing_tier` STRING COMMENT 'The tier level assigned to this account within the pricing hierarchy, determining the base discount level. Higher tiers typically receive better pricing based on volume commitments, strategic importance, or relationship strength.',
    `promotional_allowance_cap_amount` DECIMAL(18,2) COMMENT 'The maximum dollar amount available for promotional allowances during the agreement period. Caps the total promotional funding regardless of purchase volume.',
    `promotional_allowance_percent` DECIMAL(18,2) COMMENT 'The negotiated promotional allowance percentage that the account can apply toward trade promotions, displays, and marketing activities. This is a fund allocation for cooperative marketing efforts.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account pricing agreement record',
    `renewal_notice_days` STRING COMMENT 'The number of days before the effective end date that either party must provide notice if they wish to terminate rather than renew the agreement.',
    `rsp_guidance_amount` DECIMAL(18,2) COMMENT 'The manufacturers recommended selling price guidance provided to the trade account for consumer-facing pricing. This is advisory and not binding, but helps maintain brand positioning and margin expectations.',
    `sales_organization_code` STRING COMMENT 'The sales organization responsible for managing this pricing agreement. In SAP S/4HANA, this determines the organizational unit that owns the customer relationship and pricing terms.',
    `source_system_code` STRING COMMENT 'The source system code of the account pricing agreement record',
    `uom` STRING COMMENT 'The uom of the account pricing agreement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account pricing agreement record',
    `volume_rebate_enabled` BOOLEAN COMMENT 'Indicates whether volume-based rebates are active for this agreement. When true, the account qualifies for additional discounts based on purchase volume thresholds.',
    `volume_rebate_percent_1` DECIMAL(18,2) COMMENT 'The additional rebate percentage applied when volume rebate threshold 1 is met or exceeded.',
    `volume_rebate_percent_2` DECIMAL(18,2) COMMENT 'The additional rebate percentage applied when volume rebate threshold 2 is met or exceeded.',
    `volume_rebate_percent_3` DECIMAL(18,2) COMMENT 'The additional rebate percentage applied when volume rebate threshold 3 is met or exceeded.',
    `volume_rebate_threshold_1` DECIMAL(18,2) COMMENT 'The first volume threshold (in currency or units) that triggers an additional rebate percentage. Represents the minimum purchase volume required to qualify for the first tier of volume-based discounts.',
    `volume_rebate_threshold_2` DECIMAL(18,2) COMMENT 'The second volume threshold that triggers a higher rebate percentage. Represents the purchase volume required to qualify for the second tier of volume-based discounts.',
    `volume_rebate_threshold_3` DECIMAL(18,2) COMMENT 'The third volume threshold that triggers the highest rebate percentage. Represents the purchase volume required to qualify for the third tier of volume-based discounts.',
    CONSTRAINT pk_account_pricing_agreement PRIMARY KEY(`account_pricing_agreement_id`)
) COMMENT 'Negotiated pricing agreement between the CPG manufacturer and a trade account, defining the contracted price list, discount structure, and rebate terms for a defined period. Captures price list ID, pricing tier, base price, negotiated discount %, volume rebate thresholds, promotional allowance terms, EDLP vs. Hi-Lo pricing strategy, RSP/MSRP guidance, effective date range, and approval status. Managed in SAP S/4HANA SD condition records.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` (
    `account_status_history_id` BIGINT COMMENT 'Unique identifier for each account status change event record. Primary key for the account status history audit trail.',
    `employee_id` BIGINT COMMENT 'System user identifier of the person or automated process that initiated the status change. Critical for audit trail and accountability.',
    `reversed_history_account_status_history_id` BIGINT COMMENT 'Foreign key reference to the original account_status_history record that this entry reverses or corrects. Null if this is not a reversal entry.',
    `trade_account_id` BIGINT COMMENT 'Foreign key reference to the trade account master record that this status change event applies to. Links the status history to the B2B customer account.',
    `account_number` STRING COMMENT 'The business identifier of the trade account at the time of status change. Denormalized for audit trail completeness and historical reporting.',
    `account_status_history_status` STRING COMMENT 'The account status history status of the account status history record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account status history record',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this status change required managerial or compliance approval before execution. True if approval workflow was triggered, false if change was auto-approved or did not require approval.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the status change was approved. Null if no approval was required or if change is pending approval.',
    `approved_by_user_name` STRING COMMENT 'Full name of the approver who authorized the status change. Denormalized for audit readability.',
    `change_method` STRING COMMENT 'The method by which the status change was executed: manual user action, automated workflow, batch process, API call, or EDI transaction. Distinguishes human-initiated vs system-initiated changes.. Valid values are `manual|automated|batch|api|edi`',
    `change_reason` STRING COMMENT 'The change reason of the account status history record',
    `change_source_system` STRING COMMENT 'The operational system or application that originated the status change event (e.g., SAP_SD, SALESFORCE_CG_CLOUD, CREDIT_MANAGEMENT_SYSTEM, EDI_GATEWAY). Used for traceability and system integration audit.',
    `changed_by_user_name` STRING COMMENT 'Full name of the user who initiated the status change. Denormalized for audit readability and historical reporting when user records may be archived.',
    `account_status_history_code` STRING COMMENT 'The account status history code of the account status history record',
    `compliance_violation_code` STRING COMMENT 'Standardized code identifying the specific compliance violation that triggered a compliance hold or suspension. Null if status change is not compliance-related.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the account status history record',
    `credit_limit_at_change` DECIMAL(18,2) COMMENT 'The credit limit assigned to the trade account at the time of this status change. Captured for historical credit risk analysis and compliance audit. Expressed in the accounts base currency.',
    `currency_code` STRING COMMENT 'The currency code of the account status history record',
    `days_sales_outstanding_at_change` STRING COMMENT 'The DSO metric for the trade account at the time of status change. Measures average collection period and provides context for payment-related status transitions.',
    `account_status_history_description` STRING COMMENT 'The account status history description of the account status history record',
    `edi_control_number` STRING COMMENT 'The unique control number of the EDI transaction that triggered or communicated this status change. Used for EDI audit trail and reconciliation. Null for non-EDI status changes.',
    `edi_transaction_set` STRING COMMENT 'The EDI transaction set code (e.g., 846 Inventory Inquiry, 997 Functional Acknowledgment) associated with this status change if the change was triggered by or communicated via EDI. Null for non-EDI status changes.',
    `effective_date` DATE COMMENT 'The business-effective date when the new status became active. May differ from the system change timestamp for backdated or scheduled status changes.',
    `effective_from` DATE COMMENT 'The effective from of the account status history record',
    `effective_until` DATE COMMENT 'The effective until of the account status history record',
    `hold_release_date` DATE COMMENT 'The scheduled or actual date when a hold status was or will be released. Used for temporary holds with defined resolution timelines. Null for permanent status changes or non-hold statuses.',
    `hold_type` STRING COMMENT 'Specific classification of hold when the new status is a hold state. Distinguishes between credit holds, compliance holds, quality holds, legal holds, and payment holds. Null if status is not a hold state.. Valid values are `credit_hold|compliance_hold|quality_hold|legal_hold|payment_hold|general_hold`',
    `account_status_history_name` STRING COMMENT 'The account status history name of the account status history record',
    `new_status` STRING COMMENT 'The status of the trade account after this change event. Captures the to-state in the account lifecycle transition. [ENUM-REF-CANDIDATE: new|active|on_hold|credit_hold|compliance_hold|suspended|closed|inactive — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-form text field for additional context, comments, or instructions related to the status change. Used by account managers and credit analysts to document special circumstances or follow-up actions.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an automated notification (email, EDI message, or system alert) was sent to the trade account contact or internal stakeholders about this status change. True if notification was successfully dispatched.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when the status change notification was sent. Null if no notification was sent or if notification failed.',
    `outstanding_balance_at_change` DECIMAL(18,2) COMMENT 'The total outstanding receivables balance for the trade account at the time of this status change. Provides financial context for credit-related status transitions. Expressed in the accounts base currency.',
    `previous_status` STRING COMMENT 'The status of the trade account immediately before this change event. Captures the from-state in the account lifecycle transition. [ENUM-REF-CANDIDATE: new|active|on_hold|credit_hold|compliance_hold|suspended|closed|inactive — 8 candidates stripped; promote to reference product]',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account status history record',
    `record_created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this audit record was first inserted into the account status history table. Distinct from status_change_timestamp which represents the business event time.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this status change event must be included in regulatory reporting submissions (e.g., SOX compliance, FDA audit trails, anti-money laundering reports). True if regulatory disclosure is required.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this status change record represents a reversal or correction of a previous status change. True if this is a corrective entry, false for normal status transitions.',
    `sla_impact_flag` BOOLEAN COMMENT 'Indicates whether this status change affects the accounts SLA terms or service level commitments. True if SLA metrics or obligations are modified by this status transition.',
    `source_system_code` STRING COMMENT 'The source system code of the account status history record',
    `status_change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the status change (e.g., CREDIT_LIMIT_EXCEEDED, COMPLIANCE_VIOLATION, CUSTOMER_REQUEST, ACCOUNT_CLOSURE, REACTIVATION_APPROVED). Used for categorization and root cause analysis.',
    `status_change_reason_description` STRING COMMENT 'Detailed free-text explanation of why the account status was changed. Provides context beyond the reason code for audit and compliance purposes.',
    `status_change_timestamp` TIMESTAMP COMMENT 'The precise date and time when the account status change was executed in the system. Primary business event timestamp for this audit record.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to supporting documentation for this status change (e.g., approval memo, compliance report, customer correspondence, legal notice). Used to link audit trail to source documents.',
    `uom` STRING COMMENT 'The uom of the account status history record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account status history record',
    `change_date` DATE COMMENT 'The change date of the account status history record',
    CONSTRAINT pk_account_status_history PRIMARY KEY(`account_status_history_id`)
) COMMENT 'Audit history of status changes for a trade account lifecycle, capturing each transition event: new, active, on-hold (credit hold, compliance hold), suspended, closed, reactivated. Records previous status, new status, change reason code, change date/time, changed by user, and supporting notes. Enables compliance audit trails and account lifecycle analytics without polluting the master trade_account record.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` (
    `account_compliance_record_id` BIGINT COMMENT 'Unique identifier for the account compliance record. Primary key for this entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Each compliance record must reference the specific regulatory obligation it satisfies, supporting the Compliance Obligation Tracking report used by legal and risk teams.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_permit. Business justification: Compliance records reference the specific environmental permit governing the accounts operations for regulatory reporting.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Regulatory reporting requires each account compliance record to be linked to the jurisdiction governing the obligation, enabling jurisdiction‑specific reporting and audits.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account (retailer, distributor, wholesaler, or foodservice operator) to which this compliance record applies.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance verification reports must capture which employee performed the verification for each record.',
    `account_compliance_record_status` STRING COMMENT 'The account compliance record status of the account compliance record record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account compliance record record',
    `assessment_date` DATE COMMENT 'The assessment date of the account compliance record record',
    `account_compliance_record_code` STRING COMMENT 'The account compliance record code of the account compliance record record',
    `compliance_scope` STRING COMMENT 'Describes the scope or coverage of the compliance record, such as specific product categories, geographic regions, or business activities covered by this license or certification.',
    `compliance_status` STRING COMMENT 'Current lifecycle status of the compliance record. Indicates whether the license or certification is currently valid, expired, pending approval, suspended, or revoked.. Valid values are `active|expired|pending|suspended|revoked|renewed`',
    `compliance_type` STRING COMMENT 'The category of compliance or regulatory requirement. Defines the nature of the license, certification, or regulatory registration required to conduct business with this trade partner.. Valid values are `business_license|food_handler_permit|alcohol_license|import_export_license|gdpr_dpa|ccpa_opt_out`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'The currency code of the account compliance record record',
    `account_compliance_record_description` STRING COMMENT 'The account compliance record description of the account compliance record record',
    `document_reference` STRING COMMENT 'Reference identifier or URI pointing to the scanned or digital copy of the compliance document stored in the document management system (e.g., Veeva Vault). Enables audit trail and verification.',
    `effective_date` DATE COMMENT 'The date from which the compliance record becomes legally valid and enforceable. May differ from issue_date if there is a grace period or delayed activation. Format: yyyy-MM-dd.',
    `effective_from` DATE COMMENT 'The effective from of the account compliance record record',
    `effective_until` DATE COMMENT 'The effective until of the account compliance record record',
    `expiry_date` DATE COMMENT 'The date on which the license, permit, or certification expires and is no longer valid unless renewed. Nullable for perpetual licenses. Format: yyyy-MM-dd.',
    `issue_date` DATE COMMENT 'The date on which the license, permit, or certification was originally issued by the regulatory authority. Format: yyyy-MM-dd.',
    `issuing_authority` STRING COMMENT 'The name of the governmental body, regulatory agency, or certification organization that issued the license or certification (e.g., FDA, EPA, State Department of Health, EU REACH).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country in which the issuing authority operates (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `issuing_state_province` STRING COMMENT 'The state, province, or regional subdivision within the issuing country where the license or certification was granted. Relevant for jurisdictions with state-level regulatory requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_renewal_date` DATE COMMENT 'The most recent date on which this compliance record was successfully renewed. Nullable if never renewed. Format: yyyy-MM-dd.',
    `license_number` STRING COMMENT 'The unique alphanumeric identifier assigned by the issuing authority for this license, permit, or certification. Used for verification and audit purposes.',
    `account_compliance_record_name` STRING COMMENT 'The account compliance record name of the account compliance record record',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, exceptions, or remarks related to this compliance record. Used for audit trail and internal communication.',
    `notification_sent_date` DATE COMMENT 'The date on which the most recent compliance notification (renewal reminder, expiry alert) was sent. Format: yyyy-MM-dd.',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a renewal or expiry notification has been sent to the account or internal stakeholders. True if notification sent, False otherwise.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account compliance record record',
    `regulatory_framework` STRING COMMENT 'The overarching regulatory framework or legal standard under which this compliance record is governed (e.g., FDA CFR Title 21, EU REACH, GDPR, CCPA, ISO 22716).',
    `renewal_due_date` DATE COMMENT 'The date by which the license or certification must be renewed to avoid lapse. Used for proactive compliance monitoring and alerts. Format: yyyy-MM-dd.',
    `renewal_status` STRING COMMENT 'Indicates the current state of the renewal process for this compliance record. Tracks whether renewal is pending, submitted, approved, rejected, or overdue.. Valid values are `not_required|pending|submitted|approved|rejected|overdue`',
    `risk_level` STRING COMMENT 'Assessment of the business risk associated with non-compliance or lapse of this record. Critical risk indicates that business cannot be conducted without this compliance in place.. Valid values are `low|medium|high|critical`',
    `source_system_code` STRING COMMENT 'The source system code of the account compliance record record',
    `uom` STRING COMMENT 'The uom of the account compliance record record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account compliance record record',
    `verification_date` DATE COMMENT 'The date on which the compliance record was last verified by internal compliance or legal teams. Used to track due diligence and audit readiness. Format: yyyy-MM-dd.',
    CONSTRAINT pk_account_compliance_record PRIMARY KEY(`account_compliance_record_id`)
) COMMENT 'Regulatory and trade compliance records associated with a trade account, including licenses, certifications, and regulatory registrations required to conduct business. Captures compliance type (business license, food handler permit, alcohol license, import/export license, GDPR data processing agreement, CCPA opt-out record), issuing authority, license number, issue date, expiry date, renewal status, and document reference. Ensures the CPG manufacturer only transacts with compliant trade partners.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`order` (
    `order_id` BIGINT COMMENT 'Unique system identifier for the sales order record. Primary key for the order entity.',
    `account_address_id` BIGINT COMMENT 'Reference to the customer location that receives the invoice and is responsible for payment. May differ from ship-to location.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost Center Allocation report requires each sales order to be charged to a cost center for internal expense tracking.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center assigned to fulfill this order. Determines inventory allocation and shipping origin.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this order. Used for authorization audit trail and approval workflow tracking.',
    `rep_id` BIGINT COMMENT 'The order owning rep id of the order record',
    `order_sales_rep_id` BIGINT COMMENT 'Reference to the sales representative or account manager who created or owns this order. Used for commission calculation and SFA reporting.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.pricing_agreement. Business justification: Orders are governed by a pricing agreement; linking captures contract context.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Order‑level Promotion Event Attribution report requires linking each order to the specific promotion event that generated the sale.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Required for linking each sales order to the R&D project that created the product, enabling ROI and product launch performance reporting.',
    `retail_store_id` BIGINT COMMENT 'Reference to the customer location where goods should be delivered. May differ from bill-to location for multi-site customers.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Order Fulfillment Allocation report requires linking each order to the supply network node that will source inventory for accurate ATP/CTP calculations.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Directly assigning a territory to an order simplifies reporting and analytics.',
    `trade_account_id` BIGINT COMMENT 'Reference to the customer or retail account that placed this order. Links to the customer master record.',
    `actual_delivery_date` DATE COMMENT 'The actual date when the order was delivered to the customer. Used to calculate OTIF performance and delivery variance.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the order record',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was approved for fulfillment. Marks transition from draft/pending to confirmed status in the order lifecycle.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason for order cancellation if status is cancelled. Used for root cause analysis and process improvement.',
    `channel_type` STRING COMMENT 'The commercial channel through which the order was received. Critical for channel-specific analytics and revenue attribution.. Valid values are `retail|wholesale|dtc|ecommerce|distributor`',
    `order_code` STRING COMMENT 'The order code of the order record',
    `cogs_amount` DECIMAL(18,2) COMMENT 'Total cost of goods sold for all items on this order. Used for gross margin calculation and profitability analysis.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by supply chain and logistics based on ATP/CTP availability. Committed date for OTIF tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was first created in the database. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this order. Determines currency for pricing, tax, and totals.. Valid values are `^[A-Z]{3}$`',
    `order_description` STRING COMMENT 'The order description of the order record',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the order including trade promotions, volume discounts, and negotiated price reductions.',
    `distribution_channel` STRING COMMENT 'The distribution channel through which products are sold. Defines the route-to-market and channel-specific pricing rules.. Valid values are `^[A-Z0-9]{2,10}$`',
    `division` STRING COMMENT 'The product division or business unit for this order. Used for divisional P&L reporting and product line segmentation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `effective_from` DATE COMMENT 'The effective from of the order record',
    `effective_until` DATE COMMENT 'The effective until of the order record',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight and shipping charges applied to the order. May be customer-paid or supplier-absorbed depending on terms.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Gross profit on the order calculated as total revenue less COGS. Key profitability metric for order-level margin analysis.',
    `incoterm` STRING COMMENT 'Three-letter Incoterm code defining the transfer of risk and cost responsibility between buyer and seller. Examples: FOB, CIF, DDP.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was last updated. Used for change tracking and data synchronization across systems.',
    `order_name` STRING COMMENT 'The order name of the order record',
    `notes` STRING COMMENT 'The notes of the order record',
    `order_date` DATE COMMENT 'The date when the sales order was placed or created by the customer. Primary business event timestamp for order lifecycle.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the sales order. Used for customer communication and order tracking across systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the sales order indicating its position in the order-to-cash workflow. [ENUM-REF-CANDIDATE: draft|open|confirmed|in_fulfillment|shipped|delivered|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the order based on fulfillment method and business process. Determines routing, pricing, and delivery rules.. Valid values are `standard|rush|drop_ship|direct_store_delivery|promotional|sample`',
    `otif_status` STRING COMMENT 'Indicates whether the order was delivered on time and in full per customer commitment. Key supply chain KPI for customer service measurement.. Valid values are `on_time_in_full|late|partial|not_applicable`',
    `payment_terms` STRING COMMENT 'The payment terms code defining the credit period and discount conditions for this order. Examples: NET30, 2/10NET30.. Valid values are `^[A-Z0-9]{2,10}$`',
    `priority` STRING COMMENT 'Priority classification for order fulfillment. Determines sequencing in warehouse picking and expedited shipping eligibility.. Valid values are `standard|high|urgent|critical`',
    `purchase_order_number` STRING COMMENT 'The customers purchase order number provided at order placement. Required for EDI transactions and invoice matching.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the order record',
    `requested_delivery_date` DATE COMMENT 'The delivery date requested by the customer at the time of order placement. Used for OTIF performance measurement.',
    `sales_office` STRING COMMENT 'The sales office or branch that originated this order. Used for territory management and sales force performance tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sales_organization` STRING COMMENT 'The sales organization responsible for this order. Defines the selling entity and organizational hierarchy for reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sap_sd_document_number` STRING COMMENT 'The native SAP SD sales order document number. Used for system-to-system integration and ERP traceability.. Valid values are `^[0-9]{10}$`',
    `shipping_method` STRING COMMENT 'The transportation mode selected for order delivery. Impacts delivery time, cost, and carrier selection.. Valid values are `ground|air|ocean|rail|courier|dsd`',
    `source` STRING COMMENT 'The system or channel through which the order was originally captured. Used for channel attribution and system integration tracking.. Valid values are `web_portal|edi|sales_rep|call_center|mobile_app|marketplace`',
    `source_system_code` STRING COMMENT 'The source system code of the order record',
    `special_instructions` STRING COMMENT 'Free-text field for customer-specific delivery instructions, packaging requirements, or handling notes for warehouse and logistics teams.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before taxes, discounts, and freight charges. Base revenue amount for the order.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the order including sales tax, VAT, GST, and other applicable taxes per jurisdiction.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount for the order including subtotal, taxes, freight, less discounts. The invoiced amount for revenue recognition.',
    `uom` STRING COMMENT 'The uom of the order record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the order record',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Core sales order record capturing all commercial sales transactions across retail, wholesale, DTC, and e-commerce channels. Contains order header details (order number, date, channel type, status, delivery dates, OTIF status, payment terms, currency, totals, SAP SD document number) and line-level detail (SKU/GTIN, quantities ordered/confirmed/shipped, unit pricing, discounts, trade promotion references, line status, COGS, gross margin, delivery schedule). Serves as the primary transactional backbone of the sales domain enabling both order-level and SKU-level revenue and margin analysis.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system identifier for the invoice record. Primary key.',
    `account_address_id` BIGINT COMMENT 'Reference to the billing address location for this invoice. The address where invoice is sent and payment is remitted from.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial consolidation needs each invoice posted to the responsible cost center for accurate profit analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Invoice generation audit needs the employee responsible for creating the invoice to satisfy financial controls.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order that this invoice fulfills. Links invoice to order for order-to-cash reconciliation.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.pricing_agreement. Business justification: Invoice billing often follows a pricing agreement; linking provides traceability.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Financial reconciliation links each invoice to the specific production order that produced the sold goods, supporting cost of goods sold analysis.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Invoice‑level trade spend reconciliation needs to reference the promotion event responsible for the invoiced sales.',
    `retail_store_id` BIGINT COMMENT 'Reference to the physical delivery location where goods were shipped. May differ from bill-to account for multi-site customers.',
    `source_order_id` BIGINT COMMENT 'The source order id of the invoice record',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distributor, or DTC consumer who is billed on this invoice. The sold-to party in the order-to-cash process.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the invoice record',
    `billing_period_end_date` DATE COMMENT 'End date of the period covered by this invoice. Used for period-based billing and revenue allocation.',
    `billing_period_start_date` DATE COMMENT 'Start date of the period covered by this invoice. Relevant for subscription, service, or recurring billing scenarios.',
    `billing_type` STRING COMMENT 'Classification of the invoice document type: standard invoice for goods/services, credit memo for returns/adjustments, debit memo for additional charges, proforma for advance notice, intercompany for internal transfers, or consignment for stock-based billing.. Valid values are `standard|credit_memo|debit_memo|proforma|intercompany|consignment`',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was cancelled or voided. Null for active invoices. Used for cancelled invoice reporting and audit.',
    `invoice_code` STRING COMMENT 'The invoice code of the invoice record',
    `cost_of_goods_sold_amount` DECIMAL(18,2) COMMENT 'Total standard cost of all products billed on this invoice. Used for gross margin calculation and profitability analysis at invoice level.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was first created in the billing system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). All monetary amounts on this invoice are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `days_sales_outstanding` STRING COMMENT 'Number of days between invoice date and payment date (or current date if unpaid). Key metric for working capital management and customer payment behavior analysis.',
    `invoice_description` STRING COMMENT 'The invoice description of the invoice record',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator that the customer has raised a dispute or deduction claim against this invoice. Triggers collections hold and dispute resolution workflow.',
    `dispute_reason_code` STRING COMMENT 'Standardized code categorizing the reason for invoice dispute. Enables root cause analysis of deductions and customer dissatisfaction. [ENUM-REF-CANDIDATE: pricing|quantity|quality|delivery|promotion|damaged_goods|not_received — 7 candidates stripped; promote to reference product]',
    `distribution_channel_code` STRING COMMENT 'Code representing the distribution channel through which the sale was made (e.g., retail, wholesale, DTC, e-commerce). Enables channel-specific revenue analysis.. Valid values are `^[A-Z0-9]{2,4}$`',
    `division_code` STRING COMMENT 'Code identifying the product division or business unit to which invoice revenue is attributed. Supports divisional P&L reporting.. Valid values are `^[A-Z0-9]{2,4}$`',
    `due_date` DATE COMMENT 'The date by which payment is expected per the agreed payment terms. Used for DSO tracking and collections management.',
    `edi_document_number` STRING COMMENT 'Unique EDI transaction control number assigned when invoice is transmitted via EDI 810. Used for EDI audit trail and error resolution.',
    `edi_transmission_status` STRING COMMENT 'Status of EDI 810 invoice transmission to customers system. Tracks electronic invoice delivery for large retail and distributor accounts.. Valid values are `not_applicable|pending|transmitted|acknowledged|rejected|failed`',
    `effective_from` DATE COMMENT 'The effective from of the invoice record',
    `effective_until` DATE COMMENT 'The effective until of the invoice record',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight, shipping, and logistics charges added to the invoice. May be separately itemized for customer transparency.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice value before any deductions, including all line items, charges, and fees but before trade discounts and taxes.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Gross profit on this invoice, calculated as net_amount minus cost_of_goods_sold_amount. Key profitability metric for customer and product analysis.',
    `incoterm_code` STRING COMMENT 'Three-letter Incoterm code defining the division of costs and risks between buyer and seller (e.g., FOB, CIF, DDP). Critical for international trade invoicing.. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'The date the invoice was officially issued to the customer. This is the accounting date used for revenue recognition and aging calculations.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice document number used for customer communication, payment reconciliation, and accounts receivable tracking. Typically follows company-specific numbering scheme.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current state of the invoice in the accounts receivable lifecycle. Tracks progression from draft through payment completion or dispute resolution. [ENUM-REF-CANDIDATE: draft|issued|sent|partially_paid|paid|overdue|cancelled|disputed — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this invoice record. Tracks changes for audit and data quality monitoring.',
    `invoice_name` STRING COMMENT 'The invoice name of the invoice record',
    `net_amount` DECIMAL(18,2) COMMENT 'Final invoice total after all discounts, charges, and taxes. This is the amount due from the customer and recorded in accounts receivable.',
    `notes` STRING COMMENT 'Free-text field for special instructions, billing notes, dispute comments, or customer-specific messaging that appears on the invoice document.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Calculated as net_amount minus paid_amount. Used for aging analysis and collections prioritization.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Cumulative amount received against this invoice across all payment transactions. Used to calculate outstanding balance.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used (or expected) for settling this invoice. Influences payment processing and reconciliation workflows. [ENUM-REF-CANDIDATE: wire_transfer|ach|check|credit_card|edi_payment|cash|direct_debit — 7 candidates stripped; promote to reference product]',
    `payment_reference_number` STRING COMMENT 'External payment reference number provided by the customer or payment processor for reconciliation. Links invoice to bank statement or remittance advice.',
    `payment_status` STRING COMMENT 'Current payment settlement status indicating whether the invoice has been paid in full, partially, or remains outstanding.. Valid values are `unpaid|partially_paid|paid|overpaid|written_off`',
    `payment_terms_code` STRING COMMENT 'Standard code representing the payment terms agreement (e.g., Net 30, Net 60, 2/10 Net 30). Determines due date calculation and early payment discount eligibility.. Valid values are `^[A-Z0-9]{2,10}$`',
    `purchase_order_number` STRING COMMENT 'Customers purchase order number that authorized this invoice. Required for PO-based invoicing and three-way match reconciliation.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the invoice record',
    `revenue_recognition_category` STRING COMMENT 'Classification determining how revenue from this invoice is recognized per accounting standards (ASC 606 / IFRS 15). Drives financial reporting and revenue allocation logic.. Valid values are `point_in_time|over_time|deferred|subscription|service`',
    `sales_organization_code` STRING COMMENT 'Code identifying the sales organization unit responsible for this invoice. Used for revenue attribution and sales performance reporting.. Valid values are `^[A-Z0-9]{2,6}$`',
    `source_system_code` STRING COMMENT 'The source system code of the invoice record',
    `tax_amount` DECIMAL(18,2) COMMENT 'Sum of all tax amounts (sales tax, VAT, GST, excise) applied to the invoice. Calculated based on tax jurisdiction and product tax classification.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the invoice record',
    `trade_discount_amount` DECIMAL(18,2) COMMENT 'Total trade promotion discounts, volume rebates, and negotiated price reductions applied at invoice level. Reduces gross amount to arrive at net taxable amount.',
    `uom` STRING COMMENT 'The uom of the invoice record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the invoice record',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Commercial billing document issued to retail accounts, distributors, or DTC consumers upon order fulfillment. Contains invoice header (invoice number, date, billing type, payment terms, gross/net values, tax, currency, payment status, DSO tracking, EDI status) and line-level detail (SKU/GTIN, billed quantities, unit prices, trade discounts, net line values, tax codes, revenue recognition categories, COGS allocation). Links to the originating sales order and serves as the accounts receivable source record enabling SKU-level revenue and profitability reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` (
    `pricing_agreement_id` BIGINT COMMENT 'Unique identifier for the pricing agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Pricing agreement approvals must be signed off by a specific employee for regulatory and pricing governance.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.product_hierarchy. Business justification: Pricing agreements are defined per product hierarchy to set prices for all SKUs within that hierarchy; essential for price‑setting reports.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Pricing agreements are negotiated per brand for trade accounts; brand-level pricing is required for contract management.',
    `price_list_id` BIGINT COMMENT 'The price list id of the pricing agreement record',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distributor, or wholesale customer with whom this pricing agreement is established.',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the pricing agreement for business reference and reporting.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the pricing agreement, used in contracts and SAP SD condition records.. Valid values are `^[A-Z0-9]{8,20}$`',
    `agreement_type` STRING COMMENT 'Classification of the pricing agreement structure: standard pricing, volume-based tiered discounts, promotional allowances, rebate structures, long-term contract, or spot pricing.. Valid values are `standard|volume_tiered|promotional|rebate|contract|spot`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the pricing agreement record',
    `approval_status` STRING COMMENT 'Current approval workflow status indicating whether the pricing agreement has been reviewed and authorized by management.. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or executive who approved the pricing agreement.',
    `approved_date` DATE COMMENT 'Date when the pricing agreement was formally approved by authorized personnel.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the pricing agreement automatically renews upon expiration unless terminated by either party.',
    `base_list_price` DECIMAL(18,2) COMMENT 'Standard manufacturer list price before any discounts, allowances, or negotiated reductions are applied.',
    `pricing_agreement_code` STRING COMMENT 'The pricing agreement code of the pricing agreement record',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the legal contract document or master agreement associated with this pricing agreement.',
    `contracted_net_price` DECIMAL(18,2) COMMENT 'Agreed net price per unit after applying all negotiated discounts and allowances as defined in the pricing agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all pricing amounts in this agreement are denominated.. Valid values are `^[A-Z]{3}$`',
    `pricing_agreement_description` STRING COMMENT 'The pricing agreement description of the pricing agreement record',
    `discount_pct` DECIMAL(18,2) COMMENT 'The discount pct of the pricing agreement record',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount off the base list price granted to the customer under this pricing agreement.',
    `distribution_channel` STRING COMMENT 'Distribution channel through which products under this pricing agreement are sold (e.g., retail, wholesale, DTC, e-commerce).',
    `division` STRING COMMENT 'Product division or business unit to which this pricing agreement applies.',
    `effective_end_date` DATE COMMENT 'Date when the pricing agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_from` DATE COMMENT 'The effective from of the pricing agreement record',
    `effective_start_date` DATE COMMENT 'Date when the pricing agreement becomes active and enforceable for order pricing.',
    `effective_until` DATE COMMENT 'The effective until of the pricing agreement record',
    `geographic_scope` STRING COMMENT 'Geographic region or territory where this pricing agreement is valid and enforceable.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required per transaction to qualify for the contracted pricing under this agreement.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum monetary value required per order to qualify for the contracted pricing terms.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the pricing agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing agreement record was last modified or updated.',
    `msrp_price` DECIMAL(18,2) COMMENT 'Manufacturer suggested retail price for consumer-facing pricing, used for price positioning and margin calculation.',
    `pricing_agreement_name` STRING COMMENT 'The pricing agreement name of the pricing agreement record',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or clarifications related to the pricing agreement.',
    `payment_terms` STRING COMMENT 'Agreed payment terms defining the due date and discount conditions (e.g., Net 30, 2/10 Net 30).',
    `price_protection_flag` BOOLEAN COMMENT 'Indicates whether the customer is protected from price increases during the agreement period.',
    `pricing_agreement_status` STRING COMMENT 'Current lifecycle status of the pricing agreement indicating its operational state and enforceability.. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `pricing_tier` STRING COMMENT 'Tiered pricing level assigned to the customer based on volume commitments, strategic importance, or negotiated terms.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|custom`',
    `product_scope` STRING COMMENT 'Defines the breadth of product coverage: all products, specific product category, individual SKUs, or brand-level pricing.. Valid values are `all_products|product_category|specific_skus|brand`',
    `promotional_allowance` DECIMAL(18,2) COMMENT 'Additional allowance or discount provided to support trade promotions, in-store displays, or marketing activities.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the pricing agreement record',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Fixed monetary rebate amount granted per unit or per transaction under the pricing agreement terms.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Percentage rebate granted to the customer upon achieving volume thresholds or other performance criteria defined in the agreement.',
    `rsp_price` DECIMAL(18,2) COMMENT 'Manufacturer recommended selling price to be used by the retailer or distributor at point of sale.',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for managing and executing this pricing agreement.',
    `source_system_code` STRING COMMENT 'The source system code of the pricing agreement record',
    `uom` STRING COMMENT 'The uom of the pricing agreement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the pricing agreement record',
    `volume_threshold_quantity` DECIMAL(18,2) COMMENT 'Minimum order or cumulative purchase quantity required to qualify for the contracted pricing tier or volume-based discount.',
    `volume_threshold_uom` STRING COMMENT 'Unit of measure for the volume threshold quantity (e.g., EA for each, CS for case, PAL for pallet).. Valid values are `^[A-Z]{2,3}$`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the pricing agreement record.',
    CONSTRAINT pk_pricing_agreement PRIMARY KEY(`pricing_agreement_id`)
) COMMENT 'Contractual pricing arrangement established with a retail account, distributor, or wholesale customer defining agreed RSP/MSRP, net pricing, volume-based tiered discounts, promotional allowances, and rebate structures. Captures agreement number, effective start/end dates, pricing tier, base list price, contracted net price, volume thresholds, rebate percentage, payment terms, currency, and approval status. Source of truth for customer-specific pricing in SAP SD condition records.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the sales opportunity record. Primary key.',
    `account_contact_id` BIGINT COMMENT 'Reference to the primary buyer or decision-maker contact at the retail account or distributor for this opportunity.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated or influenced this opportunity, if applicable. Used for campaign ROI (Return on Investment) analysis.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Opportunities are tied to a specific brands product line for forecasting and pipeline reporting.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative (field sales, key account manager, or territory manager) responsible for managing this opportunity.',
    `opportunity_owning_rep_id` BIGINT COMMENT 'The opportunity owning rep id of the opportunity record',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Tracks which R&D project an opportunity targets, supporting pipeline forecasting for new product introductions.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Sales pipeline tracks regulatory submission status; linking opportunity to submission enables monitoring approval impact on forecast.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory (geographic or account-based) to which this opportunity is assigned. Used for territory performance tracking and quota allocation.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account or distributor associated with this opportunity (e.g., Walmart, Target, regional distributor).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the opportunity record',
    `channel_type` STRING COMMENT 'Primary sales channel targeted by this opportunity: retail (brick-and-mortar stores), wholesale (distributor/wholesaler), DTC (Direct to Consumer), e-commerce (online retail), DSD (Direct Store Delivery), or foodservice (restaurants, institutions).. Valid values are `retail|wholesale|dtc|ecommerce|dsd|foodservice`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity was marked as closed-won or closed-lost. Null if opportunity is still open. Used for sales cycle duration analysis.',
    `opportunity_code` STRING COMMENT 'The opportunity code of the opportunity record',
    `competitive_displacement_context` STRING COMMENT 'Description of competitive dynamics: which competitors product(s) this opportunity aims to displace, or whether this is a net-new distribution gain without displacement. Used for competitive intelligence and win/loss analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity record was first created in the system. Used for opportunity age calculation and pipeline velocity analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated revenue (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `opportunity_description` STRING COMMENT 'The opportunity description of the opportunity record',
    `effective_from` DATE COMMENT 'The effective from of the opportunity record',
    `effective_until` DATE COMMENT 'The effective until of the opportunity record',
    `estimated_acv_gain` DECIMAL(18,2) COMMENT 'Projected gain in ACV (All Commodity Volume) if this opportunity closes successfully. ACV measures the total retail sales volume of stores carrying the product.',
    `estimated_annual_revenue` DECIMAL(18,2) COMMENT 'Projected incremental annual revenue from this opportunity if closed-won, in the base currency. Used for pipeline value calculation and sales forecasting.',
    `estimated_sku_count` STRING COMMENT 'Number of SKUs (Stock Keeping Units) expected to be authorized or listed if this opportunity closes successfully. Used for distribution point forecasting.',
    `estimated_tdp_gain` STRING COMMENT 'Projected gain in TDP (Total Distribution Points) if this opportunity closes successfully. TDP measures the number of stores carrying the product weighted by store importance.',
    `estimated_value` DECIMAL(18,2) COMMENT 'The estimated value of the opportunity record',
    `expected_close_date` DATE COMMENT 'Anticipated date when the opportunity will reach closed-won or closed-lost stage. Used for sales pipeline forecasting and quota planning.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter in which the opportunity is expected to close, formatted as Q1 2024, Q2 2024, etc. Used for quarterly sales forecasting and quota tracking.. Valid values are `^Q[1-4]sd{4}$`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the opportunity is expected to close (e.g., 2024, 2025). Used for annual sales planning and year-over-year pipeline comparison.',
    `forecast_category` STRING COMMENT 'Sales forecast category for pipeline management: pipeline (early stage, low confidence), best_case (possible upside), commit (high confidence, included in quota forecast), or closed (deal finalized).. Valid values are `pipeline|best_case|commit|closed`',
    `is_deleted` BOOLEAN COMMENT 'Soft-delete flag indicating whether this opportunity record has been logically deleted. True if deleted, False if active. Used for audit trail and data retention compliance.',
    `jbp_alignment_flag` BOOLEAN COMMENT 'Indicates whether this opportunity is aligned with a formal JBP (Joint Business Planning) agreement with the retailer or distributor. True if aligned, False otherwise.',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, meeting, email, task) logged against this opportunity. Used for identifying stale opportunities requiring follow-up.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity record was last updated. Used for tracking recent activity and stale opportunity identification.',
    `lead_source` STRING COMMENT 'Origin of the opportunity: inbound inquiry from retailer, field sales prospecting, trade show contact, referral, marketing campaign, or expansion within existing account.. Valid values are `inbound_inquiry|field_sales_prospecting|trade_show|referral|marketing_campaign|existing_account_expansion`',
    `loss_reason` STRING COMMENT 'Primary reason for opportunity closure as closed-lost: price (not competitive), product fit (product did not meet needs), competitive loss (lost to competitor), timing (wrong time for buyer), budget constraints, no decision made, or other. Null if not closed-lost. [ENUM-REF-CANDIDATE: price|product_fit|competitive_loss|timing|budget_constraints|no_decision|other — 7 candidates stripped; promote to reference product]',
    `opportunity_name` STRING COMMENT 'Business-friendly name describing the opportunity (e.g., Q2 2024 SKU Authorization - Retailer X, New DTC Channel Launch - Product Line Y).',
    `next_step_description` STRING COMMENT 'Description of the next action or milestone required to advance this opportunity (e.g., Schedule buyer meeting, Submit pricing proposal, Finalize contract terms).',
    `notes` STRING COMMENT 'The notes of the opportunity record',
    `opportunity_status` STRING COMMENT 'The opportunity status of the opportunity record',
    `opportunity_type` STRING COMMENT 'Classification of the opportunity by business objective: new retail account acquisition, SKU (Stock Keeping Unit) authorization/listing expansion, new channel entry (e.g., e-commerce, DSD), distribution gain with retailer/distributor, shelf space expansion, or promotional program. [ENUM-REF-CANDIDATE: new_account_acquisition|sku_authorization|sku_listing_expansion|channel_entry|distribution_gain|shelf_space_expansion|promotional_program — 7 candidates stripped; promote to reference product]',
    `probability_pct` DECIMAL(18,2) COMMENT 'The probability pct of the opportunity record',
    `probability_percentage` DECIMAL(18,2) COMMENT 'Estimated probability of closing this opportunity successfully, expressed as a percentage (0.00 to 100.00). Used for weighted pipeline forecasting.',
    `product_category_focus` STRING COMMENT 'Primary product category or brand family targeted by this opportunity (e.g., Personal Care - Skincare, Household Cleaning, Health & Wellness). Free-text field for flexibility.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the opportunity record',
    `source_system_code` STRING COMMENT 'The source system code of the opportunity record',
    `stage` STRING COMMENT 'Current stage in the sales opportunity lifecycle: prospecting (initial contact), qualification (fit assessment), needs analysis (requirements gathering), proposal (offer submitted), negotiation (terms discussion), closed-won (deal secured), or closed-lost (deal not secured). [ENUM-REF-CANDIDATE: prospecting|qualification|needs_analysis|proposal|negotiation|closed_won|closed_lost — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the opportunity record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the opportunity record',
    `win_reason` STRING COMMENT 'Primary reason for opportunity closure as closed-won: price advantage, product quality, brand strength, relationship with buyer, innovation/differentiation, service level, or other. Null if not closed-won. [ENUM-REF-CANDIDATE: price|product_quality|brand_strength|relationship|innovation|service_level|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Sales opportunity record managed within Salesforce Consumer Goods Cloud representing potential new business: new retail account acquisition, SKU authorization/listing expansion, new channel entry, or distribution gain with a retailer or distributor. Captures opportunity name, stage (prospecting/qualification/proposal/negotiation/closed-won/closed-lost), estimated incremental annual revenue, probability percentage, expected close date, channel type, product category focus, assigned sales rep, buyer contact, and competitive displacement context. Drives SFA pipeline management, new distribution forecasting, and JBP (Joint Business Planning) alignment.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` (
    `account_call_id` BIGINT COMMENT 'Unique identifier for the field sales representative store visit record. Primary key for the account call entity.',
    `rep_id` BIGINT COMMENT 'The account owning rep id of the account call record',
    `account_sales_rep_id` BIGINT COMMENT 'Reference to the field sales representative who conducted the store visit. Links to workforce employee data.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Field calls are scheduled to support a particular marketing campaign; call performance is measured against campaign goals.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Captures the R&D project discussed during store visits, aligning field activities with upcoming product launches.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Linking account call to the order it generated removes need for separate flag and amount fields.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail store or account visited during this call. Links to the trade account master data.',
    `account_call_status` STRING COMMENT 'The account call status of the account call record',
    `activities_completed` STRING COMMENT 'Summary of activities performed during the store visit, such as shelf audits, order placement, merchandising, training, or promotional setup. Free-text field capturing execution details.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account call record',
    `call_date` DATE COMMENT 'The calendar date on which the store visit occurred. Used for daily sales activity tracking and field sales Key Performance Indicator (KPI) reporting.',
    `call_duration_minutes` STRING COMMENT 'Total time spent at the store location in minutes. Key metric for field sales productivity analysis and route optimization.',
    `call_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sales representative completed the store visit. Used to calculate call duration and productivity metrics.',
    `call_notes` STRING COMMENT 'Additional free-text notes and observations captured by the sales representative during the store visit. Provides qualitative context for the call record.',
    `call_number` STRING COMMENT 'Business identifier for the account call, typically generated by the Sales Force Automation (SFA) system. Used for external reference and tracking.',
    `call_objective` STRING COMMENT 'Primary business objective or goal for the store visit. Free-text description of what the sales representative intended to accomplish during the call.',
    `call_outcome` STRING COMMENT 'Overall outcome assessment of the store visit. Indicates whether call objectives were achieved and execution was successful.. Valid values are `successful|partially_successful|unsuccessful|rescheduled`',
    `call_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sales representative began the store visit. Captured via mobile Sales Force Automation (SFA) application for time-in-store analytics.',
    `call_status` STRING COMMENT 'Current lifecycle status of the account call. Tracks progression from scheduled visit through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    `call_type` STRING COMMENT 'Classification of the account call purpose. Distinguishes between routine visits, promotional activities, merchandising support, compliance audits, New Product Development (NPD) launches, and issue resolution.. Valid values are `routine|promotional|merchandising|compliance_audit|new_product_introduction|problem_resolution`',
    `account_call_code` STRING COMMENT 'The account call code of the account call record',
    `competitor_activity_observed` STRING COMMENT 'Free-text notes on competitor promotional activities, new product launches, pricing changes, or merchandising observed during the store visit. Competitive intelligence capture.',
    `competitor_pricing_flag` BOOLEAN COMMENT 'Indicates whether competitor pricing information was collected during the store visit. Used to trigger pricing analysis and response.',
    `corrective_actions_completed_flag` BOOLEAN COMMENT 'Indicates whether identified corrective actions were completed during the same store visit. Tracks immediate issue resolution effectiveness.',
    `corrective_actions_required` STRING COMMENT 'Description of corrective actions identified during the visit, such as restocking Out of Stock (OOS) items, fixing Planogram (POG) violations, or addressing pricing discrepancies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the account call record was first created in the Sales Force Automation (SFA) system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'The currency code of the account call record',
    `account_call_description` STRING COMMENT 'The account call description of the account call record',
    `display_compliance_flag` BOOLEAN COMMENT 'Indicates whether promotional displays and secondary placements are set up according to trade promotion agreements and merchandising standards.',
    `display_type` STRING COMMENT 'Type of promotional display observed or set up during the store visit. Captures secondary placement strategy execution.. Valid values are `end_cap|floor_stand|pallet|shelf_talker|cooler|none`',
    `effective_from` DATE COMMENT 'The effective from of the account call record',
    `effective_until` DATE COMMENT 'The effective until of the account call record',
    `facings_actual` STRING COMMENT 'Actual number of product facings observed during the store visit. Used to calculate facing compliance and identify shelf space gaps.',
    `facings_required` STRING COMMENT 'Total number of product facings specified in the Planogram (POG) for this store. Represents the target shelf presence.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate captured when the call was logged via mobile Sales Force Automation (SFA) application. Used to verify store visit location and route compliance.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate captured when the call was logged via mobile Sales Force Automation (SFA) application. Used to verify store visit location and route compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the account call record was last updated. Audit trail for record changes and data quality monitoring.',
    `mobile_device_code` STRING COMMENT 'Identifier of the mobile device used to capture the account call record. Used for Sales Force Automation (SFA) system audit and device management.',
    `account_call_name` STRING COMMENT 'The account call name of the account call record',
    `next_call_date` DATE COMMENT 'Scheduled date for the next store visit. Used for call frequency planning and route optimization.',
    `notes` STRING COMMENT 'The notes of the account call record',
    `oos_items_count` STRING COMMENT 'Number of Stock Keeping Units (SKUs) found to be Out of Stock (OOS) during the store visit. Key metric for On Shelf Availability (OSA) tracking.',
    `oos_items_list` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) codes or product names that were Out of Stock (OOS) during the visit. Used for replenishment prioritization.',
    `photo_evidence_count` STRING COMMENT 'Number of photos captured during the store visit via mobile Sales Force Automation (SFA) application. Used for visual compliance verification and audit trails.',
    `photo_storage_reference` STRING COMMENT 'Reference identifier or Uniform Resource Locator (URL) to the location where call photos are stored. Links to external document management or cloud storage system.',
    `pog_compliance_score` DECIMAL(18,2) COMMENT 'Overall compliance score for Planogram (POG) execution at the store, typically expressed as a percentage. Measures how well the actual shelf layout matches the planned POG.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account call record',
    `scheduled_date` DATE COMMENT 'Originally planned date for the store visit. Used to track adherence to call plans and route schedules.',
    `shelf_position_compliant_flag` BOOLEAN COMMENT 'Indicates whether products are placed in the correct shelf position as specified in the Planogram (POG). Critical for optimal product visibility and sales.',
    `signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a digital signature was captured from the store contact to confirm the visit and any agreements made. Used for audit and compliance purposes.',
    `signature_reference` STRING COMMENT 'Reference identifier to the stored digital signature image. Links to external document storage system.',
    `source_system_code` STRING COMMENT 'The source system code of the account call record',
    `store_contact_name` STRING COMMENT 'Name of the store manager or key contact person met during the visit. Used for relationship tracking and follow-up coordination.',
    `sync_status` STRING COMMENT 'Synchronization status of the call record between the mobile Sales Force Automation (SFA) application and the central system. Tracks data integration completeness.. Valid values are `synced|pending|failed`',
    `uom` STRING COMMENT 'The uom of the account call record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account call record',
    CONSTRAINT pk_account_call PRIMARY KEY(`account_call_id`)
) COMMENT 'Field sales representative store visit record captured via Salesforce Consumer Goods Cloud SFA, including planogram compliance audit observations. Records call date/time, store/account visited, sales rep, call type, objectives, activities completed, orders placed, shelf compliance observations, OSA findings, competitor activity, POG compliance scores (facings required vs actual, shelf position, OOS items, display compliance), photo evidence references, corrective actions, and call outcome. Core operational record for retail execution, field sales KPI tracking, and shelf compliance reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` (
    `planogram_compliance_id` BIGINT COMMENT 'Primary key for planogram_compliance',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or merchandiser who conducted the planogram compliance audit.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Planogram compliance audits are performed per brands shelf layout; brand‑specific compliance reporting is required.',
    `retail_store_id` BIGINT COMMENT 'The retail store id of the planogram compliance record',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account or store where the planogram compliance audit was conducted.',
    `actual_facings_count` STRING COMMENT 'The actual number of product facings observed during the audit for the audited category or SKU (Stock Keeping Unit).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the planogram compliance record',
    `audit_date` DATE COMMENT 'The date when the planogram compliance audit was performed.',
    `audit_duration_minutes` STRING COMMENT 'The total time spent conducting the planogram compliance audit, measured in minutes.',
    `audit_timestamp` TIMESTAMP COMMENT 'The precise date and time when the planogram compliance audit was conducted, including time zone information.',
    `audit_type` STRING COMMENT 'The type of planogram compliance audit conducted (scheduled routine audit, ad hoc spot check, follow-up audit, promotional display audit).. Valid values are `scheduled|ad_hoc|follow_up|promotional`',
    `planogram_compliance_code` STRING COMMENT 'The planogram compliance code of the planogram compliance record',
    `compliance_pct` DECIMAL(18,2) COMMENT 'The compliance pct of the planogram compliance record',
    `compliance_trend` STRING COMMENT 'Indicates the trend in planogram compliance for this account compared to previous audits (improving, stable, declining).. Valid values are `improving|stable|declining`',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions needed to achieve planogram compliance, including specific merchandising tasks.',
    `corrective_action_priority` STRING COMMENT 'The priority level assigned to the corrective action based on business impact and urgency (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required to bring the shelf display into planogram compliance (True = action required, False = no action required).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this planogram compliance audit record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the planogram compliance record',
    `planogram_compliance_description` STRING COMMENT 'The planogram compliance description of the planogram compliance record',
    `display_compliance_score` DECIMAL(18,2) COMMENT 'Overall compliance score for the planogram audit, typically expressed as a percentage (0.00 to 100.00) indicating adherence to the planogram specifications.',
    `effective_from` DATE COMMENT 'The effective from of the planogram compliance record',
    `effective_until` DATE COMMENT 'The effective until of the planogram compliance record',
    `facings_variance` STRING COMMENT 'The difference between required and actual facings count (actual minus required), indicating over- or under-representation on shelf.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this planogram compliance audit record was last updated or modified.',
    `planogram_compliance_name` STRING COMMENT 'The planogram compliance name of the planogram compliance record',
    `notes` STRING COMMENT 'The notes of the planogram compliance record',
    `oos_items_count` STRING COMMENT 'The number of SKUs (Stock Keeping Units) identified as out of stock during the planogram compliance audit.',
    `oos_sku_list` STRING COMMENT 'Comma-separated list of SKU (Stock Keeping Unit) codes that were identified as out of stock during the audit.',
    `osa_compliance_flag` BOOLEAN COMMENT 'Indicates whether the audit met the minimum On Shelf Availability (OSA) threshold for the category (True = compliant, False = non-compliant).',
    `photo_count` STRING COMMENT 'The number of photos captured during the planogram compliance audit for documentation and evidence purposes.',
    `photo_evidence_reference` STRING COMMENT 'Reference identifier or URI to photographic evidence captured during the audit, stored in the document management system.',
    `planogram_compliance_status` STRING COMMENT 'The planogram compliance status of the planogram compliance record',
    `pog_effective_date` DATE COMMENT 'The date from which the audited planogram version became effective at the retail location.',
    `pog_version_code` STRING COMMENT 'The version identifier of the planogram being audited against, indicating the specific layout and merchandising plan.',
    `previous_audit_score` DECIMAL(18,2) COMMENT 'The display compliance score from the most recent previous audit for comparison and trend analysis.',
    `product_category_code` STRING COMMENT 'The product category or subcategory being audited for planogram compliance.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the planogram compliance record',
    `required_facings_count` STRING COMMENT 'The number of product facings (shelf positions) required by the planogram for the audited category or SKU (Stock Keeping Unit).',
    `resolution_date` DATE COMMENT 'The date when the corrective action was completed and the planogram compliance issue was resolved.',
    `resolution_notes` STRING COMMENT 'Additional notes or comments documenting the resolution of the planogram compliance issue and actions taken.',
    `resolution_status` STRING COMMENT 'Current status of the corrective action resolution workflow (open, in progress, resolved, closed, escalated, deferred).. Valid values are `open|in_progress|resolved|closed|escalated|deferred`',
    `shelf_level` STRING COMMENT 'The vertical shelf position where the product is placed (eye level, top shelf, middle shelf, bottom shelf, end cap).. Valid values are `eye_level|top_shelf|middle_shelf|bottom_shelf|end_cap`',
    `shelf_position_compliant_flag` BOOLEAN COMMENT 'Indicates whether the products are placed in the correct shelf position as specified by the planogram (True = compliant, False = non-compliant).',
    `source_system_code` STRING COMMENT 'The source system code of the planogram compliance record',
    `store_manager_notified_flag` BOOLEAN COMMENT 'Indicates whether the store manager was notified of the planogram compliance findings during or after the audit (True = notified, False = not notified).',
    `unauthorized_sku_list` STRING COMMENT 'Comma-separated list of unauthorized SKU (Stock Keeping Unit) codes found on the shelf that are not part of the approved planogram.',
    `unauthorized_substitution_flag` BOOLEAN COMMENT 'Indicates whether unauthorized product substitutions were found in place of the planogram-specified SKUs (Stock Keeping Units) (True = substitutions found, False = no substitutions).',
    `uom` STRING COMMENT 'The uom of the planogram compliance record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the planogram compliance record',
    CONSTRAINT pk_planogram_compliance PRIMARY KEY(`planogram_compliance_id`)
) COMMENT 'POG (Planogram) compliance audit record captured during field sales account calls or dedicated retail execution audits. Tracks store/account, audit date, product category, planogram version, number of facings required vs. actual, shelf position compliance flag, out-of-stock (OOS) items identified, unauthorized substitutions, display compliance score, photo evidence reference, corrective action required flag, and resolution status. Enables OSA and shelf execution KPI reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` (
    `pos_transaction_id` BIGINT COMMENT 'Unique identifier for the point-of-sale transaction record. Primary key for the POS transaction entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: POS transactions record the cashier employee for labor tracking, shift reporting, and audit of sales.',
    `retail_store_id` BIGINT COMMENT 'Identifier of the specific retail store or outlet where the consumer purchase occurred.',
    `sku_id` BIGINT COMMENT 'Identifier of the product sold in this transaction. Links to the product master.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retail account or customer where the transaction occurred. Links to the trade account master.',
    `acv_flag` BOOLEAN COMMENT 'Indicates whether this store is included in the All Commodity Volume (ACV) universe for weighted distribution calculations. Used for Total Distribution Points (TDP) and ACV metrics.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the pos transaction record',
    `baseline_sales_flag` BOOLEAN COMMENT 'Indicates whether the transaction represents baseline (non-promotional) sales. Used to separate baseline from incremental promotional volume in Trade Promotion Management (TPM) analysis.',
    `channel_type` STRING COMMENT 'The retail channel classification where the transaction occurred (e.g., Grocery, Mass Merchandiser, Drug, Convenience, Club, Dollar, Online, Specialty). Used for channel performance analysis. [ENUM-REF-CANDIDATE: grocery|mass_merchandiser|drug|convenience|club|dollar|online|specialty — 8 candidates stripped; promote to reference product]',
    `pos_transaction_code` STRING COMMENT 'The pos transaction code of the pos transaction record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the pos transaction record',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the transaction monetary values.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A quality score (0-100) assigned to the transaction record based on completeness, accuracy, and timeliness of the source data. Used for data reliability assessment.',
    `data_source` STRING COMMENT 'The source system or provider from which the POS transaction data was obtained (e.g., Nielsen IQ, IRI/Circana, Retailer EDI, Retailer Portal, TradeEdge, Internal).. Valid values are `nielsen_iq|iri_circana|retailer_edi|retailer_portal|tradeedge|internal`',
    `data_source_file_code` STRING COMMENT 'The identifier of the source data file or feed from which this transaction record was extracted. Used for data lineage and reconciliation.',
    `pos_transaction_description` STRING COMMENT 'The pos transaction description of the pos transaction record',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to this transaction due to promotional activity. Used for promotional effectiveness analysis.',
    `ean` STRING COMMENT 'The 13-digit European Article Number identifying the product. International standard barcode identifier.. Valid values are `^d{13}$`',
    `effective_from` DATE COMMENT 'The effective from of the pos transaction record',
    `effective_until` DATE COMMENT 'The effective until of the pos transaction record',
    `extended_retail_value` DECIMAL(18,2) COMMENT 'The total retail sales value for this transaction line (units sold multiplied by retail selling price). Core metric for revenue and market share analysis.',
    `gtin` STRING COMMENT 'The Global Trade Item Number (GTIN-8, GTIN-12, GTIN-13, or GTIN-14) identifying the product sold. Standardized product identifier for cross-retailer analysis.. Valid values are `^d{8}$|^d{12}$|^d{13}$|^d{14}$`',
    `market_name` STRING COMMENT 'The designated market area or geographic market classification for the store location. Used for market-level Share of Market (SOM) analysis.',
    `pos_transaction_name` STRING COMMENT 'The pos transaction name of the pos transaction record',
    `notes` STRING COMMENT 'Free-form text field for additional comments, annotations, or data quality observations related to the transaction record.',
    `out_of_stock_flag` BOOLEAN COMMENT 'Indicates whether an out-of-stock condition was detected at the store during the transaction period. Used for On-Shelf Availability (OSA) monitoring.',
    `pos_transaction_status` STRING COMMENT 'The pos transaction status of the pos transaction record',
    `processed_timestamp` TIMESTAMP COMMENT 'The timestamp when the POS transaction record was processed and loaded into the lakehouse silver layer. Used for data pipeline monitoring.',
    `product_description` STRING COMMENT 'Textual description of the product as provided by the data source. May include brand, variant, and size information.',
    `promotion_type` STRING COMMENT 'The type of promotional activity applied to this transaction (e.g., Temporary Price Reduction, Multi-Buy, Coupon, Loyalty Discount, Clearance).. Valid values are `temporary_price_reduction|multi_buy|coupon|loyalty_discount|clearance|none`',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether the product was sold under a promotional offer or trade promotion at the time of transaction. Used for Trade Promotion Optimization (TPO) analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the pos transaction record',
    `received_timestamp` TIMESTAMP COMMENT 'The timestamp when the POS transaction data was received from the source system or data provider. Used for data latency monitoring.',
    `reporting_period` STRING COMMENT 'The granularity or aggregation period of the POS data as provided by the source (e.g., Daily, Weekly, Monthly). Varies by syndicated data provider.. Valid values are `daily|weekly|monthly`',
    `retail_selling_price` DECIMAL(18,2) COMMENT 'The per-unit retail price at which the product was sold to the consumer. Used for price compliance monitoring against Recommended Selling Price (RSP) and Manufacturer Suggested Retail Price (MSRP).',
    `retailer_name` STRING COMMENT 'The name of the retail chain or banner where the transaction occurred. Used for retailer scorecard reporting.',
    `sales_amount` DECIMAL(18,2) COMMENT 'The sales amount of the pos transaction record',
    `source_system_code` STRING COMMENT 'The source system code of the pos transaction record',
    `store_city` STRING COMMENT 'The city where the retail store is located. Used for geographic sales analysis.',
    `store_country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code where the retail store is located.. Valid values are `^[A-Z]{3}$`',
    `store_format` STRING COMMENT 'The format or size classification of the retail store (e.g., Superstore, Supermarket, Small Format, Express). Used for format-level performance analysis.',
    `store_name` STRING COMMENT 'The name or identifier of the specific retail store location where the transaction occurred.',
    `store_postal_code` STRING COMMENT 'The postal or ZIP code of the retail store location. Used for micro-market analysis.',
    `store_state_province` STRING COMMENT 'The state or province where the retail store is located. Used for regional sales analysis.',
    `transaction_date` DATE COMMENT 'The calendar date when the consumer purchase transaction occurred at the retail outlet. Primary business event date for demand sensing and On-Shelf Availability (OSA) monitoring.',
    `transaction_number` STRING COMMENT 'Business identifier or receipt number for the point-of-sale transaction as provided by the data source.',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consumer purchase transaction was recorded at the point of sale.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity sold (e.g., Each, Case, Pack, Box, Dozen, Pound, Kilogram). [ENUM-REF-CANDIDATE: EA|CS|PK|BX|DZ|LB|KG|OZ|ML|LT|GL — 11 candidates stripped; promote to reference product]',
    `units_sold` DECIMAL(18,2) COMMENT 'The quantity of product units sold in this transaction. Core metric for demand sensing and sell-through analysis.',
    `uom` STRING COMMENT 'The uom of the pos transaction record',
    `upc` STRING COMMENT 'The 12-digit Universal Product Code scanned at the point of sale. North American standard barcode identifier.. Valid values are `^d{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the pos transaction record',
    `week_ending_date` DATE COMMENT 'The Saturday date marking the end of the reporting week for weekly aggregated POS data. Standard for Nielsen IQ and IRI/Circana weekly reporting.',
    CONSTRAINT pk_pos_transaction PRIMARY KEY(`pos_transaction_id`)
) COMMENT 'Point-of-sale sell-through transaction representing consumer purchases at retail outlets, capturing secondary sales (offtake) data sourced from syndicated data providers (Nielsen IQ, IRI/Circana), retailer EDI/portal feeds, or TradeEdge. Records transaction date, store/retailer, SKU/GTIN, units sold, retail selling price, extended retail value, promotional flag, channel type, and data source. Enables demand sensing, on-shelf availability (OSA) monitoring, ACV/TDP/SOM metric computation, and retailer scorecard reporting. Granularity varies by source from store-day-SKU to week-account-SKU.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` (
    `return_order_id` BIGINT COMMENT 'Unique identifier for the return order record. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Return processing requires identifying the original batch for quality assessment and potential recall actions.',
    `order_id` BIGINT COMMENT 'Reference to the original sales order that this return is associated with.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Return processing must capture the employee handling the return for accountability and quality control.',
    `product_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.product_complaint. Business justification: Return processing links to product complaints for root‑cause analysis and corrective action tracking.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Required for recall processing: return orders must reference active product recall to manage returned items per compliance.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Return orders must reference the exact SKU being returned for warranty, credit, and compliance processing; used in return analytics.',
    `source_order_id` BIGINT COMMENT 'The source order id of the return order record',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distributor, or DTC consumer initiating the return.',
    `waste_generation_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_generation. Business justification: Returned goods generate waste; linking return orders to waste generation records enables accurate waste reporting and cost recovery.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Additional adjustments applied to the return value (e.g., damage deductions, handling fees, promotional credits).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the return order record',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier used for reverse shipment of the returned goods.',
    `return_order_code` STRING COMMENT 'The return order code of the return order record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return order record was first created in the system.',
    `credit_memo_issued_date` DATE COMMENT 'Date when the credit memo was officially issued to the customer.',
    `credit_memo_number` STRING COMMENT 'Unique credit memo document number issued for this return in the financial system.. Valid values are `^CM-[A-Z0-9]{8,12}$`',
    `credit_memo_posted_date` DATE COMMENT 'Date when the credit memo was posted to the general ledger for financial settlement.',
    `credit_memo_status` STRING COMMENT 'Current status of the credit memo in the accounts receivable settlement process. [ENUM-REF-CANDIDATE: not_requested|requested|approved|issued|posted|rejected|cancelled — 7 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this return order.. Valid values are `^[A-Z]{3}$`',
    `customer_responsible_flag` BOOLEAN COMMENT 'Indicates whether the customer is financially responsible for the return (True) or the business absorbs the cost (False).',
    `return_order_description` STRING COMMENT 'The return order description of the return order record',
    `disposition_instruction` STRING COMMENT 'Instruction for handling the returned goods based on inspection results and business rules. [ENUM-REF-CANDIDATE: return_to_stock|destroy|rework|donate|quarantine|return_to_vendor|scrap — 7 candidates stripped; promote to reference product]',
    `distribution_channel` STRING COMMENT 'SAP distribution channel code through which the original sale and return are processed.. Valid values are `^[A-Z0-9]{2}$`',
    `division` STRING COMMENT 'SAP division code representing the product line or business unit.. Valid values are `^[A-Z0-9]{2}$`',
    `effective_from` DATE COMMENT 'The effective from of the return order record',
    `effective_until` DATE COMMENT 'The effective until of the return order record',
    `goods_received_date` DATE COMMENT 'Date when the returned goods were physically received at the return processing facility or warehouse.',
    `inspection_completed_date` DATE COMMENT 'Date when quality inspection of the returned goods was completed.',
    `inspector_name` STRING COMMENT 'Name of the quality inspector who performed the inspection of returned goods.',
    `lot_batch_number` STRING COMMENT 'Manufacturing lot or batch number of the returned product for traceability.. Valid values are `^[A-Z0-9]{6,20}$`',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this return order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this return order record was last modified.',
    `return_order_name` STRING COMMENT 'The return order name of the return order record',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the return.',
    `original_unit_price` DECIMAL(18,2) COMMENT 'Original unit price at which the product was sold in the originating sales order.',
    `quality_inspection_result` STRING COMMENT 'Result of the quality inspection performed on the returned goods.. Valid values are `passed|failed|partial|not_inspected`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the return order record',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing and restocking the returned goods, if applicable.',
    `return_amount` DECIMAL(18,2) COMMENT 'The return amount of the return order record',
    `return_authorization_date` DATE COMMENT 'Date when the return was officially authorized by the business for processing.',
    `return_authorization_number` STRING COMMENT 'Externally-known unique authorization number issued for this return request. Format: RMA-XXXXXXXX.. Valid values are `^RMA-[A-Z0-9]{8,12}$`',
    `return_date` DATE COMMENT 'The return date of the return order record',
    `return_order_status` STRING COMMENT 'The return order status of the return order record',
    `return_order_type` STRING COMMENT 'Classification of the return based on the originating channel: retail account, distributor, direct-to-consumer, or wholesale.. Valid values are `retail_account_return|distributor_return|dtc_consumer_return|wholesale_return`',
    `return_reason` STRING COMMENT 'The return reason of the return order record',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the product return. [ENUM-REF-CANDIDATE: damaged_in_transit|expired|shelf_life_rejection|overstock|quality_defect|wrong_item_shipped|recall|customer_dissatisfaction|packaging_defect|promotional_return — 10 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Detailed free-text description providing additional context about the return reason.',
    `return_request_date` DATE COMMENT 'Date when the return request was initiated by the customer or account.',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost incurred for shipping the returned goods back to the warehouse.',
    `return_status` STRING COMMENT 'Current lifecycle status of the return order in the reverse logistics and credit processing workflow. [ENUM-REF-CANDIDATE: requested|authorized|in_transit|received|inspected|approved|rejected|credit_issued|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `return_value_gross` DECIMAL(18,2) COMMENT 'Gross monetary value of the returned goods before any deductions (returned quantity × original unit price).',
    `return_value_net` DECIMAL(18,2) COMMENT 'Net monetary value to be credited to the customer after restocking fees and adjustments (gross - restocking fee - adjustments).',
    `returned_quantity` DECIMAL(18,2) COMMENT 'Quantity of units being returned.',
    `returned_quantity_uom` STRING COMMENT 'Unit of measure for the returned quantity (EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for processing this return.. Valid values are `^[A-Z0-9]{4}$`',
    `source_system_code` STRING COMMENT 'The source system code of the return order record',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by the carrier for the return shipment.. Valid values are `^[A-Z0-9]{10,30}$`',
    `uom` STRING COMMENT 'The uom of the return order record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the return order record',
    `warehouse_location_code` STRING COMMENT 'Code identifying the warehouse or distribution center where the returned goods were received.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this return order record.',
    CONSTRAINT pk_return_order PRIMARY KEY(`return_order_id`)
) COMMENT 'Sales return authorization and credit memo request capturing product returns from retail accounts, distributors, or DTC consumers. Records return authorization number, return reason code (damaged in transit/expired/shelf-life rejection/overstock/quality defect/wrong item shipped/recall), return date, originating order reference, returned SKU/GTIN, returned quantity, return value, restocking fee if applicable, credit memo status (requested/approved/issued/posted), and disposition instruction (return to stock/destroy/rework/donate). Tracks reverse logistics triggers and financial credit processing for AR settlement.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Primary key for territory',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Territory performance reports require linking each territory to its manager employee.',
    `region_id` BIGINT COMMENT 'The region id of the territory record',
    `account_count` STRING COMMENT 'Total number of retail trade accounts assigned to this territory. Used for workload balancing and territory design.',
    `acv_coverage` DECIMAL(18,2) COMMENT 'Estimated All Commodity Volume (ACV) represented by the retail accounts in this territory, expressed in currency. ACV measures the total sales volume of all products sold through the retail outlets in the territory, used for market potential assessment.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the territory record',
    `annual_quota_amount` DECIMAL(18,2) COMMENT 'Annual sales quota or revenue target assigned to this territory, expressed in the companys reporting currency. Used for sales performance management and incentive compensation.',
    `call_frequency_days` STRING COMMENT 'Standard call frequency in days for sales representative visits to accounts in this territory (e.g., 7 for weekly, 14 for bi-weekly, 30 for monthly). Used for SFA route planning.',
    `channel_assignment` STRING COMMENT 'Primary retail channel or trade class that this territory covers. Aligns with consumer goods distribution channels including grocery, drug, mass merchandiser, club, convenience, e-commerce, and Direct-to-Consumer (DTC). [ENUM-REF-CANDIDATE: grocery|drug|mass|club|convenience|e_commerce|foodservice|wholesale|dtc|multi_channel — 10 candidates stripped; promote to reference product]',
    `territory_code` STRING COMMENT 'Business identifier code for the territory used in sales force automation and reporting systems. Typically alphanumeric and unique across the organization.. Valid values are `^[A-Z0-9]{3,12}$`',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the primary country of the territory (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The currency code of the territory record',
    `territory_description` STRING COMMENT 'The territory description of the territory record',
    `distribution_channel` STRING COMMENT 'Distribution channel code from the ERP system representing the route-to-market for this territory (e.g., Retail, Wholesale, E-Commerce). Aligns with SAP distribution channel master data.',
    `district` STRING COMMENT 'Mid-level geographic or organizational district within a region. Represents a grouping of territories managed by a district sales manager.',
    `division` STRING COMMENT 'Business division or product line that this territory supports (e.g., Personal Care, Home Care, Beauty). Used for division-level sales reporting and product scope definition.',
    `dsd_eligible_flag` BOOLEAN COMMENT 'Indicates whether the territory includes accounts eligible for Direct Store Delivery (DSD) distribution model, where products are delivered directly to retail stores bypassing distribution centers.',
    `edi_capability_flag` BOOLEAN COMMENT 'Indicates whether the majority of accounts in this territory support Electronic Data Interchange (EDI) for automated order processing, invoicing, and inventory management.',
    `effective_end_date` DATE COMMENT 'Date when the territory definition expires or is deactivated. Null for open-ended territories.',
    `effective_from` DATE COMMENT 'The effective from of the territory record',
    `effective_start_date` DATE COMMENT 'Date when the territory definition becomes active and operational for sales assignment and quota allocation.',
    `effective_until` DATE COMMENT 'The effective until of the territory record',
    `geographic_scope` STRING COMMENT 'Textual description of the geographic boundaries or coverage area of the territory (e.g., New York, New Jersey, Connecticut, California North, National - Walmart).',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the territory record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was last modified. Used for audit trail and change tracking.',
    `territory_name` STRING COMMENT 'Human-readable name of the sales territory, typically reflecting geographic region or account grouping (e.g., Northeast Metro, California Key Accounts).',
    `notes` STRING COMMENT 'Free-text notes or comments about the territory, including special handling instructions, account nuances, or historical context.',
    `pog_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether field sales representatives in this territory are required to monitor and enforce Planogram (POG) compliance for product placement and shelf merchandising.',
    `postal_code_list` STRING COMMENT 'Comma-separated or structured list of postal codes included in this territory. Used for precise geographic assignment and routing optimization.',
    `priority_tier` STRING COMMENT 'Strategic priority classification of the territory based on revenue potential, account importance, or growth opportunity. Tier 1 or Strategic territories receive higher resource allocation and management attention.. Valid values are `tier_1|tier_2|tier_3|strategic|standard`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the territory record',
    `quota_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `sales_organization` STRING COMMENT 'Sales organization code or identifier from the ERP system (e.g., SAP Sales Organization) that owns this territory. Used for financial and organizational reporting.',
    `source_system_code` STRING COMMENT 'The source system code of the territory record',
    `state_province_list` STRING COMMENT 'Comma-separated list of states or provinces covered by this territory (e.g., NY,NJ,CT or CA,NV,AZ). Used for state-level sales reporting and compliance.',
    `store_count` STRING COMMENT 'Total number of retail store locations (points of distribution) within this territory. Key metric for coverage planning and Sales Force Automation (SFA) routing.',
    `tdp_coverage` STRING COMMENT 'Total Distribution Points (TDP) covered by this territory, representing the number of stores where the companys products are authorized for distribution. Critical metric for distribution reach and On-Shelf Availability (OSA).',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory. Active territories are operational and assigned to sales representatives; inactive territories are no longer in use; pending territories are being set up.. Valid values are `active|inactive|pending|suspended|archived`',
    `territory_type` STRING COMMENT 'Classification of the territory based on sales coverage model. Field territories cover geographic regions with multiple accounts; key account territories focus on strategic retail partners; national account territories manage relationships.. Valid values are `field|key_account|national_account|regional|district|channel`',
    `trade_class` STRING COMMENT 'Detailed trade classification or sub-channel segmentation within the primary channel (e.g., Supermarket, Drug Chain, Dollar Store, Online Pure Play). Used for granular channel analytics.',
    `uom` STRING COMMENT 'The uom of the territory record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the territory record',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether accounts in this territory participate in Vendor Managed Inventory (VMI) programs where the manufacturer manages inventory replenishment at retail locations.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the territory record. Used for audit trail and accountability.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Geographic and account-based sales territory definition used to assign field sales representatives and key account managers to specific retail accounts, geographic regions, or channel segments. Captures territory code, name, region, district, channel assignment (grocery/drug/mass/club/convenience/e-commerce), territory type (field/key account/national account), channel characteristics (trade class, EDI capability, DSD eligibility), active status, effective dates, and assigned quota. Master reference for SFA routing, field sales KPI attribution, and channel-level segmentation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key for rep',
    `employee_id` BIGINT COMMENT 'Reference to the employee master record in the workforce domain. Links the sales-domain operational view to the HR system of record (Workday HCM).',
    `manager_rep_id` BIGINT COMMENT 'Reference to the sales representative record of this reps direct manager. Supports hierarchical reporting and approval workflows in the sales organization.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: HR reporting aligns each sales rep with an org unit for headcount, budgeting, and compensation.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Sales reps position defines role, grade, and compensation; needed for payroll and career path tracking.',
    `territory_id` BIGINT COMMENT 'Reference to the assigned sales territory. Defines the geographic or account-based scope of responsibility for this sales representative.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the rep record',
    `badge_number` STRING COMMENT 'Physical security badge or identification number issued to the sales representative. Used for facility access and field audit verification.',
    `certification_status` STRING COMMENT 'Status of required sales certifications or training completions (e.g., product knowledge, compliance training, safety certifications). Certified indicates all requirements met; pending indicates training in progress; expired indicates recertification needed; not_required for roles without certification mandates.. Valid values are `certified|pending|expired|not_required`',
    `channel_specialization` STRING COMMENT 'Primary sales channel focus for this representative. Retail covers traditional grocery and drug stores; wholesale covers distributors; DTC (Direct to Consumer) covers company-owned stores and online; e-commerce covers digital marketplaces; foodservice covers restaurants and institutions; convenience covers c-stores and gas stations; mass merchandise covers big-box retailers. [ENUM-REF-CANDIDATE: retail|wholesale|dtc|ecommerce|foodservice|convenience|mass_merchandise — 7 candidates stripped; promote to reference product]',
    `rep_code` STRING COMMENT 'The rep code of the rep record',
    `commission_plan_code` STRING COMMENT 'Identifier for the commission or incentive compensation plan assigned to this sales representative. Links to the compensation management system for payout calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The currency code of the rep record',
    `current_quota_amount` DECIMAL(18,2) COMMENT 'Current sales quota target amount for the active quota period. Measured in the sales organizations reporting currency. Used for performance tracking and commission calculation.',
    `rep_description` STRING COMMENT 'The rep description of the rep record',
    `effective_from` DATE COMMENT 'The effective from of the rep record',
    `effective_until` DATE COMMENT 'The effective until of the rep record',
    `email_address` STRING COMMENT 'Corporate email address of the sales representative. Used for system notifications, commission statements, and internal communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'First name of the sales representative. Used for personalization in SFA applications and customer-facing communications.',
    `full_name` STRING COMMENT 'Full display name of the sales representative (typically first name + last name). Used in reports, dashboards, and customer-facing materials.',
    `hire_date` DATE COMMENT 'Date the sales representative was hired into the sales organization. Used for tenure calculations, commission eligibility, and performance benchmarking.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code representing the primary language of the sales representative. Used for SFA application localization and communication preferences.. Valid values are `^[a-z]{2}$`',
    `last_certification_date` DATE COMMENT 'Date the sales representative last completed required certifications or training. Used to track recertification schedules and compliance status.',
    `last_name` STRING COMMENT 'Last name of the sales representative. Used for personalization in SFA applications and customer-facing communications.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review for this sales representative. Used to track review cycles and ensure timely evaluations.',
    `mobile_device_code` STRING COMMENT 'Identifier for the company-issued mobile device (smartphone or tablet) used by the sales representative for SFA application access. Used for device management and security compliance.',
    `mobile_phone` STRING COMMENT 'Mobile phone number of the sales representative. Used for SFA mobile app authentication, emergency contact, and field communication.',
    `modified_by` STRING COMMENT 'User identifier of the person or system that last modified this sales representative record. Used for audit trail and data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was last modified. Used for audit trail and change tracking.',
    `rep_name` STRING COMMENT 'The rep name of the rep record',
    `notes` STRING COMMENT 'Free-text field for additional information about the sales representative, such as special skills, territory transition notes, or temporary assignments.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the sales representative. Exceeds indicates above-quota performance; meets indicates on-target; below indicates under-performing; new_hire indicates insufficient tenure for rating.. Valid values are `exceeds|meets|below|new_hire`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the rep record',
    `quota_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the quota amount. Typically matches the sales organizations reporting currency.. Valid values are `^[A-Z]{3}$`',
    `quota_period` STRING COMMENT 'Frequency at which sales quotas are assigned and measured for this representative. Monthly quotas are typical for field sales; quarterly for key accounts; annual for national accounts.. Valid values are `monthly|quarterly|annual`',
    `rep_number` STRING COMMENT 'Business identifier for the sales representative, typically assigned by the sales organization. Used in Salesforce Consumer Goods Cloud and SAP S/4HANA SD module for sales force automation and order capture.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rep_status` STRING COMMENT 'Current lifecycle status of the sales representative. Active reps are assigned territories and quotas; inactive reps are temporarily not selling; on_leave indicates approved absence; suspended indicates disciplinary hold; terminated indicates employment ended.. Valid values are `active|inactive|on_leave|suspended|terminated`',
    `rep_type` STRING COMMENT 'Classification of the sales representative role. Field sales covers territory-based retail execution; key account manager handles strategic retail accounts; national account manager manages top-tier national chains; inside sales supports telesales and e-commerce; DSD (Direct Store Delivery) driver combines delivery and merchandising; regional manager oversees field teams.. Valid values are `field_sales|key_account_manager|national_account_manager|inside_sales|dsd_driver|regional_manager`',
    `sales_group` STRING COMMENT 'SAP S/4HANA SD sales group code. Represents the functional team or product line focus within the sales organization (e.g., health and beauty, household care, personal care).',
    `sales_office` STRING COMMENT 'SAP S/4HANA SD sales office code. Represents the physical office or regional hub to which this sales representative is assigned.',
    `sales_organization` STRING COMMENT 'SAP S/4HANA SD sales organization code. Represents the legal entity or business unit responsible for sales transactions executed by this representative.',
    `sfa_user_code` STRING COMMENT 'User identifier in the Sales Force Automation system (Salesforce Consumer Goods Cloud). Used to link mobile app activity, retail execution records, and call reports to this sales representative.',
    `source_system_code` STRING COMMENT 'The source system code of the rep record',
    `termination_date` DATE COMMENT 'Date the sales representative left the organization or was terminated. Null for active employees. Used for historical sales attribution and territory transition analysis.',
    `uom` STRING COMMENT 'The uom of the rep record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the rep record',
    `vehicle_assigned` BOOLEAN COMMENT 'Indicates whether a company vehicle has been assigned to this sales representative. True for DSD drivers and field sales reps with company cars; false for inside sales and office-based roles.',
    `created_by` STRING COMMENT 'User identifier of the person or system that created this sales representative record. Used for audit trail and data governance.',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'Sales representative master record for field sales, key account management, and inside sales personnel operating within the sales domain. Captures employee ID reference, rep name, rep type (field sales/key account manager/national account manager/inside sales/DSD driver), assigned territory, channel specialization, hire date, active status, SFA user ID, and current quota period. Distinct from the workforce domain employee record — this is the sales-domain operational view of the selling resource.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`quota` (
    `quota_id` BIGINT COMMENT 'Unique identifier for the sales quota assignment record.',
    `account_team_id` BIGINT COMMENT 'Identifier of the account team to which this quota is assigned.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Quota setting must capture the employee who created the quota for governance and audit trails.',
    `hierarchy_id` BIGINT COMMENT 'Identifier of the product category to which this quota applies.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand to which this quota applies.',
    `rep_id` BIGINT COMMENT 'The quota owning rep id of the quota record',
    `quota_sales_rep_id` BIGINT COMMENT 'Identifier of the sales representative to whom this quota is assigned.',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory to which this quota is assigned.',
    `accelerator_rate` DECIMAL(18,2) COMMENT 'Enhanced commission rate applied when stretch target is exceeded.',
    `allocation_method` STRING COMMENT 'Methodology used to allocate quota across territories or reps (e.g., historical performance, market potential, equal distribution).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the quota record',
    `approval_status` STRING COMMENT 'Approval workflow status for the quota assignment.. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or executive who approved the quota.',
    `approved_date` DATE COMMENT 'Date on which the quota was approved.',
    `channel_type` STRING COMMENT 'Sales channel to which this quota applies. DSD = Direct Store Delivery, DTC = Direct to Consumer.. Valid values are `retail|wholesale|dtc|ecommerce|dsd`',
    `quota_code` STRING COMMENT 'The quota code of the quota record',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission percentage rate applied when quota is achieved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quota record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary quota values.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Customer segment or account classification to which this quota applies (e.g., national accounts, regional chains, independent retailers).',
    `quota_description` STRING COMMENT 'The quota description of the quota record',
    `distribution_channel` STRING COMMENT 'Distribution channel code for this quota assignment.',
    `division` STRING COMMENT 'Business division or product line code for this quota assignment.',
    `effective_from` DATE COMMENT 'The effective from of the quota record',
    `effective_until` DATE COMMENT 'The effective until of the quota record',
    `fiscal_month` STRING COMMENT 'Fiscal month within the year (1-12) for which the quota is assigned.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the year (1-4) for which the quota is assigned.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the quota is assigned.',
    `geographic_scope` STRING COMMENT 'Geographic region or market to which this quota applies (e.g., Northeast Region, California, National).',
    `minimum_threshold` DECIMAL(18,2) COMMENT 'Minimum performance threshold required for quota credit or commission eligibility.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified the quota record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quota record was last modified.',
    `quota_name` STRING COMMENT 'Descriptive name for the quota assignment.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the quota assignment.',
    `period` STRING COMMENT 'The period of the quota record',
    `period_end_date` DATE COMMENT 'End date of the quota period.',
    `period_start_date` DATE COMMENT 'Start date of the quota period.',
    `period_type` STRING COMMENT 'Time period granularity for the quota (monthly, quarterly, semi-annual, or annual).. Valid values are `monthly|quarterly|semi_annual|annual`',
    `product_scope` STRING COMMENT 'Scope of products covered by this quota (all products, specific category, specific brand, or specific SKU).. Valid values are `all_products|category|brand|sku`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the quota record',
    `quota_number` STRING COMMENT 'Business identifier or reference number for the quota assignment.',
    `quota_status` STRING COMMENT 'Current lifecycle status of the quota assignment. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `quota_type` STRING COMMENT 'Type of quota being assigned. Revenue = monetary sales target, Volume = unit/case target, New Distribution = new store/outlet target, TDP (Total Distribution Points) = weighted distribution target, ACV (All Commodity Volume) = market coverage target, Unit Sales = individual unit target, Gross Margin = profitability target. [ENUM-REF-CANDIDATE: revenue|volume|new_distribution|tdp|acv|unit_sales|gross_margin — 7 candidates stripped; promote to reference product]',
    `sales_organization` STRING COMMENT 'Sales organization code responsible for this quota assignment.',
    `source` STRING COMMENT 'Method by which the quota was determined. Top-down = allocated from corporate targets, Bottom-up = aggregated from field input, Negotiated = agreed between management and rep, Algorithmic = calculated by predictive model.. Valid values are `top_down|bottom_up|negotiated|algorithmic`',
    `source_system_code` STRING COMMENT 'The source system code of the quota record',
    `stretch_target` DECIMAL(18,2) COMMENT 'Aspirational or stretch goal beyond the base quota value, used for incentive compensation.',
    `uom` STRING COMMENT 'Unit of measure for the quota value (e.g., USD, cases, units, stores, points).',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the quota record',
    `value` DECIMAL(18,2) COMMENT 'Target value for the quota. Interpretation depends on quota_type: monetary amount for revenue quotas, unit count for volume quotas, store count for distribution quotas.',
    `created_by` STRING COMMENT 'User or system identifier that created the quota record.',
    CONSTRAINT pk_quota PRIMARY KEY(`quota_id`)
) COMMENT 'Sales quota assignment record defining revenue, volume, and distribution targets for sales representatives, territories, or account teams for a given planning period. Captures quota period (month/quarter/year), quota type (revenue/volume/new distribution/TDP), assigned rep or territory, product category or brand, quota value, stretch target, currency, approval status, and quota source (top-down/bottom-up/negotiated). Enables field sales KPI attainment tracking and S&OP alignment.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` (
    `distribution_point_id` BIGINT COMMENT 'Unique identifier for the distribution point record. Primary key.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Distribution points are managed per brand to ensure correct shelf placement and brand‑level inventory control.',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store location where the SKU is available for sale.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Distribution points record which SKU is allocated to each retail location; required for inventory allocation and shelf‑stocking dashboards.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: VMI programs tie a store distribution point to the supplier site that replenishes it, enabling inventory‑level monitoring.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Distribution Point Inventory Planning uses the supplying network node to compute safety stock, replenishment, and service level targets.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail trade account or customer where the SKU is distributed.',
    `activation_date` DATE COMMENT 'Date when the SKU became actively distributed and available for sale at this point.',
    `actual_retail_price` DECIMAL(18,2) COMMENT 'Current actual retail selling price observed at this distribution point, may differ from RSP/MSRP.',
    `acv_percentage` DECIMAL(18,2) COMMENT 'The ACV percentage contribution of this retail location to the total category volume, used for weighted distribution metrics.',
    `acv_weighted_flag` BOOLEAN COMMENT 'Indicates whether this distribution point is included in ACV-weighted distribution calculations (True/False). ACV-weighted stores represent a significant portion of category sales volume.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the distribution point record',
    `authorization_date` DATE COMMENT 'Date when the SKU was authorized for distribution at this retail location or account.',
    `channel_type` STRING COMMENT 'Retail channel classification for this distribution point (grocery, mass merchandiser, drug, convenience, club, e-commerce, specialty). [ENUM-REF-CANDIDATE: grocery|mass_merchandiser|drug|convenience|club|ecommerce|specialty — 7 candidates stripped; promote to reference product]',
    `distribution_point_code` STRING COMMENT 'The distribution point code of the distribution point record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution point record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for pricing at this distribution point.. Valid values are `^[A-Z]{3}$`',
    `delist_date` DATE COMMENT 'Date when the SKU was delisted or removed from distribution at this location. Null if still active.',
    `distribution_point_description` STRING COMMENT 'The distribution point description of the distribution point record',
    `distribution_channel` STRING COMMENT 'SAP SD distribution channel code representing the route-to-market for this distribution point.',
    `distribution_point_status` STRING COMMENT 'The distribution point status of the distribution point record',
    `distribution_source` STRING COMMENT 'Source system or method used to confirm distribution at this point (sell-in confirmed from ERP, POS verified from transaction data, syndicated data from Nielsen/IRI, field audit from sales force, retailer feed from EDI).. Valid values are `sell_in_confirmed|pos_verified|syndicated_data|field_audit|retailer_feed`',
    `distribution_status` STRING COMMENT 'Current lifecycle status of the SKU at this distribution point. Active indicates the product is currently distributed and available for sale; authorized indicates approval but not yet active; delisted indicates removal from distribution; inactive indicates temporary suspension.. Valid values are `active|inactive|authorized|delisted|pending|suspended`',
    `distribution_verification_date` DATE COMMENT 'Date when the distribution status was last verified or confirmed through the distribution source.',
    `division` STRING COMMENT 'SAP division code representing the product line or business unit for this distribution.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this distribution point is serviced via Direct Store Delivery (True) or warehouse distribution (False).',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this distribution point supports EDI transactions for order and inventory management (True/False).',
    `effective_from` DATE COMMENT 'The effective from of the distribution point record',
    `effective_until` DATE COMMENT 'The effective until of the distribution point record',
    `facing_count` STRING COMMENT 'Number of product facings (front-facing units) allocated to this SKU on the retail shelf at this location.',
    `geographic_market` STRING COMMENT 'Geographic market or region code for this distribution point, used for regional distribution analysis.',
    `is_active` BOOLEAN COMMENT 'The is active of the distribution point record',
    `last_pos_sale_date` DATE COMMENT 'Most recent date when a POS transaction was recorded for this SKU at this location, used to verify active distribution.',
    `launch_wave` STRING COMMENT 'Launch wave or phase identifier for new product rollouts, indicating the sequence of distribution expansion.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this distribution point record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution point record was last modified or updated.',
    `msrp_price` DECIMAL(18,2) COMMENT 'Manufacturer suggested retail price for this SKU at this distribution point.',
    `distribution_point_name` STRING COMMENT 'The distribution point name of the distribution point record',
    `new_product_flag` BOOLEAN COMMENT 'Indicates whether this distribution point represents a new product introduction (True/False). Used for NPD distribution tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding special conditions, exceptions, or context for this distribution point.',
    `osa_status` STRING COMMENT 'Current on-shelf availability status of the SKU at this location, indicating whether the product is physically available for purchase.. Valid values are `in_stock|out_of_stock|low_stock|unknown`',
    `planogram_slot_reference` STRING COMMENT 'Reference to the planogram slot or shelf position where this SKU is merchandised at the store.',
    `pog_compliance_flag` BOOLEAN COMMENT 'Indicates whether the SKU placement at this location is compliant with the authorized planogram (True/False).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the distribution point record',
    `rsp_price` DECIMAL(18,2) COMMENT 'Manufacturer recommended selling price for this SKU at this distribution point.',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for this distribution point.',
    `shelf_position` STRING COMMENT 'Vertical and horizontal shelf position classification for the SKU at this location (eye level, top shelf, middle shelf, bottom shelf, end cap, promotional display).. Valid values are `eye_level|top_shelf|middle_shelf|bottom_shelf|end_cap|promotional_display`',
    `source_system_code` STRING COMMENT 'The source system code of the distribution point record',
    `tdp_count_flag` BOOLEAN COMMENT 'Indicates whether this distribution point is counted in TDP metrics (True/False). Used to calculate numeric distribution reach.',
    `uom` STRING COMMENT 'The uom of the distribution point record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the distribution point record',
    `vmi_flag` BOOLEAN COMMENT 'Indicates whether this distribution point operates under a Vendor Managed Inventory agreement (True/False).',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this distribution point record.',
    CONSTRAINT pk_distribution_point PRIMARY KEY(`distribution_point_id`)
) COMMENT 'Total Distribution Points (TDP) record tracking which SKUs are actively distributed and available for sale at specific retail accounts or store locations. Captures store/account reference, SKU/GTIN, distribution status (active/inactive/authorized/delisted), authorization date, delist date, channel, planogram slot reference, ACV-weighted distribution flag, and distribution source (sell-in confirmed/POS verified). Core entity for ACV/TDP metric computation and new product distribution tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record. Primary key.',
    `employee_id` BIGINT COMMENT 'User ID of the pricing manager or analyst responsible for maintaining this price list. Defines accountability for price list accuracy and updates.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Price lists are often brand‑specific, enabling brand‑level pricing strategy and compliance.',
    `region_id` BIGINT COMMENT 'The region id of the price list record',
    `superseded_by_price_list_id` BIGINT COMMENT 'Reference to the newer price list that replaces this one when status is superseded. Enables price list succession tracking and historical pricing analysis.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the price list record',
    `approval_status` STRING COMMENT 'Current approval workflow status for the price list. Tracks progression through pricing governance approval process before activation.. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the pricing manager or executive who approved this price list for activation. Required for audit trail and pricing governance compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the price list was approved for activation. Critical for audit trail and compliance with pricing governance policies.',
    `price_list_code` STRING COMMENT 'Unique business identifier code for the price list used in SAP SD pricing procedures and condition records. Externally-known identifier used in pricing agreements and sales documents.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this price list record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all prices in this list are denominated. Critical for multi-currency pricing operations and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `price_list_description` STRING COMMENT 'Detailed description of the price list purpose, scope, and applicability including target customer segments and product categories covered.',
    `distribution_channel` STRING COMMENT 'Distribution channel to which this price list applies. Enables channel-specific pricing strategies for retail stores, wholesale distributors, direct-to-consumer (DTC), e-commerce platforms, foodservice operators, and institutional buyers.. Valid values are `retail|wholesale|dtc|ecommerce|foodservice|institutional`',
    `division` STRING COMMENT 'SAP SD division code representing the product line or business unit to which this price list applies. Enables division-specific pricing strategies across product portfolios.',
    `effective_end_date` DATE COMMENT 'Date when the price list expires and is no longer valid for new pricing calculations. Nullable for open-ended price lists. Aligns with SAP SD condition record validity period.',
    `effective_from` DATE COMMENT 'The effective from of the price list record',
    `effective_start_date` DATE COMMENT 'Date when the price list becomes valid and active for pricing calculations in sales orders and quotations. Aligns with SAP SD condition record validity period.',
    `effective_until` DATE COMMENT 'The effective until of the price list record',
    `external_reference_code` STRING COMMENT 'External system identifier or reference number for this price list in the source system. Enables cross-system reconciliation and data lineage tracking.',
    `freight_inclusion_flag` BOOLEAN COMMENT 'Indicates whether freight costs are included in the prices in this list. True when prices are freight-inclusive (delivered pricing), false when prices are ex-works or FOB.',
    `geographic_scope` STRING COMMENT 'Geographic region, country, or territory to which this price list applies. Supports region-specific pricing strategies and regulatory compliance with local pricing regulations.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) code defining delivery and risk transfer terms associated with prices in this list (e.g., FOB, CIF, DDP). Clarifies freight and insurance responsibilities.. Valid values are `^[A-Z]{3}$`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required for prices in this list to apply. Used to enforce volume thresholds and support tiered pricing strategies.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this price list record. Required for audit trail and accountability in pricing governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this price list record was last modified. Supports change tracking and audit trail for pricing governance compliance.',
    `moq_uom` STRING COMMENT 'Unit of measure for the minimum order quantity threshold. May differ from price UoM to support different ordering and pricing units.. Valid values are `^[A-Z]{2,3}$`',
    `msrp_flag` BOOLEAN COMMENT 'Indicates whether this price list contains manufacturer suggested retail prices (MSRP). True when prices represent official MSRP for consumer-facing pricing and promotional compliance.',
    `price_list_name` STRING COMMENT 'Descriptive business name of the price list for identification and reporting purposes.',
    `notes` STRING COMMENT 'Free-form notes and comments about the price list including special conditions, exceptions, or business context for pricing decisions.',
    `payment_terms` STRING COMMENT 'Standard payment terms associated with this price list (e.g., Net 30, 2/10 Net 30). Defines credit period and early payment discount eligibility for customers purchasing under this list.',
    `price_basis` STRING COMMENT 'Pricing methodology or basis used to establish prices in this list. List price indicates standard published pricing, cost plus indicates markup over cost, market based indicates alignment with market rates, competitive indicates positioning relative to competitors, value based indicates pricing tied to customer value perception.. Valid values are `list_price|cost_plus|market_based|competitive|value_based`',
    `price_list_status` STRING COMMENT 'Current lifecycle status of the price list. Draft indicates under development, pending approval indicates awaiting authorization, active indicates currently in use, inactive indicates temporarily disabled, expired indicates past validity period, superseded indicates replaced by newer version.. Valid values are `draft|pending_approval|active|inactive|expired|superseded`',
    `price_list_type` STRING COMMENT 'Classification of the price list by its business purpose and application context. Standard lists provide baseline pricing, promotional lists support time-limited campaigns, contract lists support negotiated agreements, channel-specific lists apply to distribution channels, seasonal lists support seasonal pricing strategies, and clearance lists support inventory liquidation.. Valid values are `standard|promotional|contract|channel_specific|seasonal|clearance`',
    `price_protection_days` STRING COMMENT 'Number of days of price protection coverage offered under this price list. Defines the lookback period for retroactive price adjustments when price protection is enabled.',
    `price_protection_flag` BOOLEAN COMMENT 'Indicates whether price protection provisions apply to this price list. When true, customers who purchased at higher prices may be eligible for retroactive credits if prices decrease during the protection period.',
    `price_rounding_rule` STRING COMMENT 'Rounding rule applied to calculated prices from this list. Supports psychological pricing strategies and currency denomination constraints.. Valid values are `none|nearest_cent|nearest_nickel|nearest_dime|nearest_dollar|up_to_99`',
    `price_uom` STRING COMMENT 'Standard unit of measure in which prices are expressed in this list (e.g., EA for each, CS for case, PAL for pallet). Aligns with SAP MM material master UoM configuration.. Valid values are `^[A-Z]{2,3}$`',
    `pricing_condition_type` STRING COMMENT 'SAP SD condition type code that defines how prices from this list are applied in pricing procedures (e.g., PR00 for base price, K004 for material price). Links price list to SAP pricing schema configuration.. Valid values are `^[A-Z0-9]{4}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the price list record',
    `rsp_flag` BOOLEAN COMMENT 'Indicates whether this price list contains recommended selling prices (RSP) for retail partners. True when prices represent manufacturer-suggested retail pricing guidance.',
    `sales_organization` STRING COMMENT 'SAP SD sales organization code to which this price list applies. Defines the organizational scope for pricing applicability in the sales and distribution structure.. Valid values are `^[A-Z0-9]{4}$`',
    `source_system_code` STRING COMMENT 'The source system code of the price list record',
    `tax_classification` STRING COMMENT 'Tax category or classification code applicable to prices in this list. Determines tax treatment for products priced under this list in compliance with jurisdictional tax regulations.',
    `trade_class` STRING COMMENT 'Customer trade class or customer pricing group to which this price list applies. Used to segment pricing by customer type such as mass merchandisers, drug stores, grocery chains, convenience stores, or specialty retailers.',
    `uom` STRING COMMENT 'The uom of the price list record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the price list record',
    `version_number` STRING COMMENT 'Sequential version number of the price list. Increments with each revision to support version control and change tracking for pricing history and audit purposes.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this price list record. Required for audit trail and accountability in pricing governance.',
    CONSTRAINT pk_price_list PRIMARY KEY(`price_list_id`)
) COMMENT 'Standard price list master defining list prices, RSP/MSRP, and channel-specific base prices for SKUs across different trade classes and geographies. Contains both header-level metadata (price list code, name, currency, effective dates, channel applicability, type, approval status) and SKU-level price entries (unit price, MOQ, price UoM, effective dates, override flags) for each product in the list. Serves as the pricing baseline from which customer-specific pricing agreements and trade discounts are derived in SAP SD condition records.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` (
    `price_list_item_id` BIGINT COMMENT 'Unique identifier for the price list item record. Primary key for this entity.',
    `price_list_id` BIGINT COMMENT 'Reference to the parent price list that contains this item. Links this SKU-level price entry to its governing price list header.',
    `sku_id` BIGINT COMMENT 'Reference to the product (SKU) for which this price is defined. Identifies the specific finished good or SKU being priced.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Price list items are derived from supplier contracts; linking ensures contract‑based pricing compliance.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the price list item record',
    `approval_status` STRING COMMENT 'The approval workflow status for this price list item. Tracks whether the price has been reviewed and approved by pricing management.. Valid values are `draft|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The user ID or name of the person who approved this price list item. Supports audit trail and accountability for pricing decisions.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this price list item was approved. Part of the pricing governance audit trail.',
    `channel_type` STRING COMMENT 'The sales channel or distribution channel for which this price applies (e.g., retail, wholesale, DTC, e-commerce). Enables channel-specific pricing strategies.. Valid values are `retail|wholesale|dtc|ecommerce|foodservice|export`',
    `price_list_item_code` STRING COMMENT 'The price list item code of the price list item record',
    `condition_type` STRING COMMENT 'The SAP SD condition type code that defines the pricing logic for this item (e.g., PR00 for base price, K004 for customer discount). Maps to SAP pricing procedure.',
    `cost_price` DECIMAL(18,2) COMMENT 'The standard cost or COGS for this SKU in the specified currency. Used for margin analysis and profitability calculations. Business-confidential data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this price list item record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all price amounts in this record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment or pricing group for which this price applies (e.g., national accounts, regional chains, independent retailers). Supports segment-based pricing.',
    `price_list_item_description` STRING COMMENT 'The price list item description of the price list item record',
    `distribution_channel` STRING COMMENT 'The SAP distribution channel code for this price list item. Defines the route-to-market for which this price applies.',
    `division` STRING COMMENT 'The SAP division code for this price list item. Represents the product line or business unit responsible for this pricing.',
    `effective_end_date` DATE COMMENT 'The date on which this price list item expires and is no longer valid for new sales transactions. Null indicates open-ended validity.',
    `effective_from` DATE COMMENT 'The effective from of the price list item record',
    `effective_start_date` DATE COMMENT 'The date from which this price list item becomes active and can be used in sales transactions. Part of the items validity period.',
    `effective_until` DATE COMMENT 'The effective until of the price list item record',
    `geographic_scope` STRING COMMENT 'The geographic region, country, or market for which this price is valid. Supports regional pricing strategies and multi-country operations.',
    `gtin` STRING COMMENT 'The globally unique GTIN (UPC, EAN, or GTIN-14) for the product. Supports EDI transactions and retail POS integration.. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `item_sequence` STRING COMMENT 'Sequential line number of this item within the parent price list. Used for ordering and display purposes.',
    `list_price` DECIMAL(18,2) COMMENT 'The base list price for this SKU in the specified currency and unit of measure. Represents the standard selling price before any discounts or promotions.',
    `margin_percentage` DECIMAL(18,2) COMMENT 'The target gross margin percentage for this price list item, calculated as (list_price - cost_price) / list_price * 100. Business-confidential data.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered for this SKU at this price. Used to enforce order minimums and support volume-based pricing tiers.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this price list item record. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this price list item record was last modified. Part of the audit trail for tracking changes.',
    `moq_uom` STRING COMMENT 'The unit of measure for the minimum order quantity (e.g., EA, CS, PAL).',
    `msrp_price` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price for this SKU. Used for retail channel pricing guidance and price protection calculations.',
    `price_list_item_name` STRING COMMENT 'The price list item name of the price list item record',
    `notes` STRING COMMENT 'Free-text notes or comments about this price list item. Used to document special pricing conditions, exceptions, or business rationale.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this price list item represents a manual override of standard pricing logic. True if this is an exception price.',
    `price_list_item_status` STRING COMMENT 'Current lifecycle status of this price list item. Controls whether the item can be used in pricing calculations.. Valid values are `active|inactive|pending|expired|superseded`',
    `price_uom` STRING COMMENT 'The unit of measure for which the price is quoted (e.g., EA for each, CS for case, PAL for pallet). Aligns with product packaging hierarchy.',
    `pricing_unit_quantity` DECIMAL(18,2) COMMENT 'The quantity of base units represented by one pricing unit. For example, if price is per case and a case contains 12 units, this value is 12.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this price is part of a promotional campaign. True if this is a temporary promotional price rather than standard list price.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the price list item record',
    `rsp_price` DECIMAL(18,2) COMMENT 'The recommended selling price for this SKU in the target market. May differ from MSRP based on regional pricing strategies.',
    `sales_organization` STRING COMMENT 'The SAP sales organization code responsible for this price list item. Aligns with organizational hierarchy and reporting structure.',
    `sap_condition_record_number` STRING COMMENT 'The unique SAP SD condition record number for this price list item. Enables traceability back to the source ERP system.',
    `scale_basis` STRING COMMENT 'The basis for volume-based pricing scales (e.g., quantity, order value, weight, volume). Defines how tiered pricing thresholds are measured.. Valid values are `quantity|value|weight|volume`',
    `scale_quantity_from` DECIMAL(18,2) COMMENT 'The lower bound of the quantity range for which this price applies in a tiered pricing structure. Used for volume discount calculations.',
    `scale_quantity_to` DECIMAL(18,2) COMMENT 'The upper bound of the quantity range for which this price applies in a tiered pricing structure. Null indicates no upper limit for the highest tier.',
    `source_system_code` STRING COMMENT 'The source system code of the price list item record',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price of the price list item record',
    `uom` STRING COMMENT 'The uom of the price list item record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the price list item record',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this price list item record. Supports audit trail and accountability.',
    CONSTRAINT pk_price_list_item PRIMARY KEY(`price_list_item_id`)
) COMMENT 'Individual SKU-level price entry within a price list, capturing the specific list price or MSRP/RSP for a given product in a given channel and currency. Records SKU/GTIN reference, price list reference, unit price, minimum order quantity (MOQ), price unit of measure, effective dates, and override flag. Enables granular SKU-level pricing management and supports SAP SD condition record maintenance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` (
    `sales_deduction_id` BIGINT COMMENT 'Unique identifier for the sales deduction record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the accounts receivable analyst or deduction specialist responsible for investigating and resolving the deduction.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Deduction accounting entries must reference a GL account to post adjustments in the general ledger.',
    `invoice_id` BIGINT COMMENT 'Reference to the originating invoice against which the deduction was raised.',
    `pricing_agreement_id` BIGINT COMMENT 'Reference to the pricing agreement that may be relevant to the deduction, particularly for pricing dispute claims.',
    `promotion_deduction_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_deduction. Business justification: Audit trail linking sales deductions to their originating promotion deduction is required for compliance and dispute resolution.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account or distributor that raised the deduction.',
    `trade_promotion_id` BIGINT COMMENT 'Reference to the trade promotion or promotional agreement that the deduction claim is associated with, if applicable.',
    `aging_days` STRING COMMENT 'The number of days the deduction has been open since the deduction date, used for aging analysis and collection prioritization.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sales deduction record',
    `approved_amount` DECIMAL(18,2) COMMENT 'The amount approved by the business for write-off or credit after review and validation of the deduction claim.',
    `claimed_amount` DECIMAL(18,2) COMMENT 'The total amount claimed or deducted by the customer or distributor from the invoice payment.',
    `sales_deduction_code` STRING COMMENT 'The sales deduction code of the sales deduction record',
    `company_code` STRING COMMENT 'The legal entity or company code in the ERP system that owns the accounts receivable and deduction record.',
    `cost_center` STRING COMMENT 'The cost center responsible for absorbing the deduction expense, used for internal cost allocation and management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the deduction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deduction amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_reference_number` STRING COMMENT 'The reference number or claim number provided by the customer or distributor for tracking the deduction on their side.',
    `deduction_amount` DECIMAL(18,2) COMMENT 'The deduction amount of the sales deduction record',
    `deduction_date` DATE COMMENT 'The date on which the deduction was raised or recorded by the customer or distributor.',
    `deduction_number` STRING COMMENT 'Externally-known unique business identifier for the deduction, often provided by the customer or generated by the accounts receivable system.',
    `deduction_status` STRING COMMENT 'Current lifecycle status of the deduction: open, under review, approved, rejected, written off, or partially approved.. Valid values are `open|under review|approved|rejected|written off|partially approved`',
    `deduction_type` STRING COMMENT 'Classification of the deduction reason: trade promotion claim, pricing dispute, shortage claim, quality claim, freight allowance, or damaged goods claim.. Valid values are `trade promotion|pricing dispute|shortage claim|quality claim|freight allowance|damaged goods`',
    `sales_deduction_description` STRING COMMENT 'The sales deduction description of the sales deduction record',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The portion of the claimed amount that is under dispute and has not been approved or rejected.',
    `distribution_channel` STRING COMMENT 'The distribution channel through which the sale and subsequent deduction occurred (e.g., retail, wholesale, DTC, e-commerce).',
    `division` STRING COMMENT 'The product division or business unit associated with the deduction, aligned with SAP SD organizational structure.',
    `effective_from` DATE COMMENT 'The effective from of the sales deduction record',
    `effective_until` DATE COMMENT 'The effective until of the sales deduction record',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the deduction has been escalated to senior management or a specialized resolution team due to complexity or high value.',
    `modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified the deduction record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the deduction record was last modified or updated.',
    `sales_deduction_name` STRING COMMENT 'The sales deduction name of the sales deduction record',
    `notes` STRING COMMENT 'The notes of the sales deduction record',
    `payment_reference_number` STRING COMMENT 'The reference number of the customer payment or remittance advice where the deduction was taken.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sales deduction record',
    `resolution_date` DATE COMMENT 'The date on which the deduction was resolved (approved, rejected, or written off).',
    `resolution_notes` STRING COMMENT 'Detailed notes and comments captured by the analyst during the investigation and resolution process, including rationale for approval or rejection.',
    `root_cause` STRING COMMENT 'Detailed explanation or categorization of the underlying root cause identified during deduction investigation (e.g., system pricing error, promotional terms misalignment, delivery shortage).',
    `sales_deduction_status` STRING COMMENT 'The sales deduction status of the sales deduction record',
    `sales_organization` STRING COMMENT 'The sales organization code responsible for the transaction and deduction, aligned with SAP SD organizational structure.',
    `sap_fi_document_number` STRING COMMENT 'The SAP FI document number generated when the deduction is posted to the general ledger for financial accounting.',
    `source_system_code` STRING COMMENT 'The source system code of the sales deduction record',
    `supporting_document_reference` STRING COMMENT 'Reference to supporting documentation provided by the customer or generated during investigation (e.g., proof of delivery, promotional agreement, quality report).',
    `uom` STRING COMMENT 'The uom of the sales deduction record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sales deduction record',
    `valid_claim_flag` BOOLEAN COMMENT 'Indicates whether the deduction claim was determined to be valid based on investigation and supporting documentation.',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created the deduction record.',
    CONSTRAINT pk_sales_deduction PRIMARY KEY(`sales_deduction_id`)
) COMMENT 'Short-payment or deduction record raised by a retail account or distributor against an invoice, representing disputed amounts, unauthorized deductions, or trade promotion claims. Captures deduction number, originating invoice reference, deduction date, deduction type (trade promotion/pricing dispute/shortage claim/quality claim/freight allowance), claimed amount, approved amount, status (open/under review/approved/rejected/written off), resolution date, and responsible analyst. Critical for accounts receivable management and trade spend reconciliation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` (
    `sales_rebate_agreement_id` BIGINT COMMENT 'Unique identifier for the sales rebate agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rebate agreements need an employee approver to satisfy financial compliance and audit requirements.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.product_hierarchy. Business justification: Rebate agreements are scoped to product hierarchies to calculate rebate amounts per product family; needed for rebate settlement reports.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Rebate agreements are negotiated per brand; brand‑specific rebate tracking is needed for financial reporting.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account or distributor participating in this rebate agreement.',
    `accrual_method` STRING COMMENT 'Method used to accrue rebate liabilities: at invoice creation, upon payment receipt, at shipment, or periodic batch calculation.. Valid values are `invoice_based|payment_based|shipment_based|periodic`',
    `accrued_rebate_amount` DECIMAL(18,2) COMMENT 'Total rebate amount accrued to date under this agreement but not yet settled or paid.',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the rebate agreement for business reference and reporting.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the rebate agreement, typically generated by SAP SD rebate processing module.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sales rebate agreement record',
    `approval_status` STRING COMMENT 'Current approval workflow status of the rebate agreement before it becomes active.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the business user who approved this rebate agreement.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rebate agreement was approved for activation.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this rebate agreement automatically renews at the end of its term.',
    `calculation_basis` STRING COMMENT 'The metric used to calculate rebate eligibility and amounts: revenue value, unit volume, gross sales, or net sales.. Valid values are `revenue|units|gross_sales|net_sales`',
    `sales_rebate_agreement_code` STRING COMMENT 'The sales rebate agreement code of the sales rebate agreement record',
    `contract_document_reference` STRING COMMENT 'Reference to the legal contract document or attachment that governs this rebate agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rebate agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rebate agreement.. Valid values are `^[A-Z]{3}$`',
    `sales_rebate_agreement_description` STRING COMMENT 'The sales rebate agreement description of the sales rebate agreement record',
    `distribution_channel` STRING COMMENT 'SAP distribution channel code indicating the route-to-market for this rebate agreement (e.g., retail, wholesale, DTC).',
    `division` STRING COMMENT 'SAP division code representing the product line or business unit for this rebate agreement.',
    `effective_end_date` DATE COMMENT 'Date when the rebate agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_from` DATE COMMENT 'The effective from of the sales rebate agreement record',
    `effective_start_date` DATE COMMENT 'Date when the rebate agreement becomes active and eligible for accrual calculations.',
    `effective_until` DATE COMMENT 'The effective until of the sales rebate agreement record',
    `geographic_scope` STRING COMMENT 'Geographic regions, countries, or sales territories where this rebate agreement applies.',
    `last_settlement_date` DATE COMMENT 'Date of the most recent rebate settlement payment made under this agreement.',
    `maximum_rebate_amount` DECIMAL(18,2) COMMENT 'Cap on the total rebate amount that can be earned under this agreement during its term. Nullable if no cap applies.',
    `minimum_qualification_amount` DECIMAL(18,2) COMMENT 'Minimum purchase amount or volume required for the customer to qualify for any rebate under this agreement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rebate agreement record was last modified or updated.',
    `sales_rebate_agreement_name` STRING COMMENT 'The sales rebate agreement name of the sales rebate agreement record',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special terms, or business context related to this rebate agreement.',
    `payment_method` STRING COMMENT 'Method by which rebate amounts are paid to the customer: credit memo, check, electronic funds transfer, or offset against receivables.. Valid values are `credit_memo|check|eft|offset`',
    `product_scope` STRING COMMENT 'Description or reference to the product categories, SKUs, or product hierarchy levels included in this rebate agreement.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sales rebate agreement record',
    `rebate_pct` DECIMAL(18,2) COMMENT 'The rebate pct of the sales rebate agreement record',
    `rebate_type` STRING COMMENT 'Classification of the rebate agreement based on the performance criteria: volume-based, growth-based, new product introduction, category performance, product mix, or customer loyalty.. Valid values are `volume|growth|new_product|category_performance|mix|loyalty`',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal or termination notice must be provided.',
    `retroactive_flag` BOOLEAN COMMENT 'Indicates whether rebate rate increases apply retroactively to all prior purchases when a higher tier is reached.',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for managing this rebate agreement.',
    `sales_rebate_agreement_status` STRING COMMENT 'Current lifecycle status of the rebate agreement indicating its operational state.. Valid values are `draft|active|suspended|expired|terminated|pending_approval`',
    `sap_rebate_agreement_number` STRING COMMENT 'Native SAP SD rebate agreement document number from the source ERP system.',
    `settled_rebate_amount` DECIMAL(18,2) COMMENT 'Total rebate amount that has been settled and paid to the customer under this agreement.',
    `settlement_frequency` STRING COMMENT 'Frequency at which rebate payments are calculated and settled with the customer.. Valid values are `monthly|quarterly|semi_annual|annual|on_demand`',
    `source_system_code` STRING COMMENT 'The source system code of the sales rebate agreement record',
    `termination_reason` STRING COMMENT 'Business reason or explanation for early termination of the rebate agreement, if applicable.',
    `termination_timestamp` TIMESTAMP COMMENT 'Date and time when the rebate agreement was terminated before its scheduled end date.',
    `tier_structure_flag` BOOLEAN COMMENT 'Indicates whether this rebate agreement uses a tiered threshold structure with escalating rebate rates.',
    `uom` STRING COMMENT 'The uom of the sales rebate agreement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sales rebate agreement record',
    CONSTRAINT pk_sales_rebate_agreement PRIMARY KEY(`sales_rebate_agreement_id`)
) COMMENT 'Volume-based or performance-based rebate agreement with a retail account or distributor defining the conditions under which financial rebates are earned and paid. Captures agreement number, customer reference, rebate type (volume/growth/new product/category performance), calculation basis (revenue/units), threshold tiers, rebate percentage or fixed amount per tier, accrual method, settlement frequency (monthly/quarterly/annual), effective dates, and approval status. Manages trade spend accruals and settlement in SAP SD rebate processing.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` (
    `sales_dsd_route_id` BIGINT COMMENT 'Unique identifier for the DSD route record. Primary key for the sales_dsd_route product.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: DSD routes are assigned to carriers for transport; linking enables carrier SLA tracking and cost management.',
    `distribution_dsd_route_id` BIGINT COMMENT 'Resolves this deprecated duplicate to its authoritative SSOT record in distribution.distribution_dsd_route.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center from which this DSD route originates for inventory loading and dispatch.',
    `employee_id` BIGINT COMMENT 'Identifier of the DSD driver or sales representative assigned to execute deliveries on this route.',
    `network_lane_id` BIGINT COMMENT 'Foreign key linking to supply.network_lane. Business justification: DSD Route Planning tracks which network lane (origin‑destination, carrier, lead time) a route follows; lane attributes are needed for cost and service calculations.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Assigning a sales rep to a DSD route clarifies responsibility for route execution.',
    `sales_owning_rep_id` BIGINT COMMENT 'The sales owning rep id of the sales dsd route record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sales dsd route record',
    `sales_dsd_route_code` STRING COMMENT 'The sales dsd route code of the sales dsd route record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the sales dsd route record',
    `currency_code` STRING COMMENT 'The currency code of the sales dsd route record',
    `sales_dsd_route_description` STRING COMMENT 'The sales dsd route description of the sales dsd route record',
    `effective_from` DATE COMMENT 'The effective from of the sales dsd route record',
    `effective_until` DATE COMMENT 'The effective until of the sales dsd route record',
    `sales_dsd_route_name` STRING COMMENT 'The sales dsd route name of the sales dsd route record',
    `notes` STRING COMMENT 'The notes of the sales dsd route record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sales dsd route record',
    `route_code` STRING COMMENT 'The route code of the sales dsd route record',
    `route_day` STRING COMMENT 'The route day of the sales dsd route record',
    `sales_dsd_route_status` STRING COMMENT 'The sales dsd route status of the sales dsd route record',
    `source_system_code` STRING COMMENT 'The source system code of the sales dsd route record',
    `uom` STRING COMMENT 'The uom of the sales dsd route record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sales dsd route record',
    CONSTRAINT pk_sales_dsd_route PRIMARY KEY(`sales_dsd_route_id`)
) COMMENT 'Direct Store Delivery (DSD) route master and delivery execution record. Defines the sequence of retail store stops, delivery frequency, and assigned DSD driver/vehicle for direct delivery operations. Also captures actual delivery execution events including delivery date, SKUs/quantities delivered, quantities returned (empties/unsold), delivery confirmation status, store receiver signature, exceptions, and settlement amounts. Supports DSD channel order management, field execution planning, and delivery settlement. [SSOT: authoritative table is distribution.distribution_dsd_route; this table is a deprecated duplicate.] [SSOT] Superseded by authoritative table distribution.distribution_dsd_route for concept dsd_route. SSOT: canonical table is distribution.distribution_dsd_route. [SSOT for concept dsd_route.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` (
    `sales_dsd_delivery_id` BIGINT COMMENT 'Unique identifier for the DSD delivery record. Primary key for the sales_dsd_delivery product.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Each DSD delivery is performed by a carrier; linking enables carrier performance and cost allocation reporting.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center from which the delivery was dispatched. Links to warehouse master for inventory and logistics tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the DSD driver who executed the delivery. Links to workforce or driver master for performance tracking.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store where the delivery was made. Links to the retail store master for account and location details.',
    `route_id` BIGINT COMMENT 'Foreign key linking to logistics.route. Business justification: Delivery follows a defined route; the FK supports route efficiency analysis and exception handling.',
    `sales_dsd_route_id` BIGINT COMMENT 'Reference to the DSD route this delivery is part of. Links to the route master for planning and optimization.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: DSD delivery records should be tied to the originating sales order for fulfillment tracking.',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account associated with this delivery. Links to the customer trade account for billing and settlement.',
    `distribution_dsd_delivery_id` BIGINT COMMENT 'Resolves this deprecated duplicate to its authoritative SSOT record in distribution.distribution_dsd_delivery.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sales dsd delivery record',
    `sales_dsd_delivery_code` STRING COMMENT 'The sales dsd delivery code of the sales dsd delivery record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the sales dsd delivery record',
    `currency_code` STRING COMMENT 'The currency code of the sales dsd delivery record',
    `delivered_units` STRING COMMENT 'The delivered units of the sales dsd delivery record',
    `delivery_date` DATE COMMENT 'The delivery date of the sales dsd delivery record',
    `sales_dsd_delivery_description` STRING COMMENT 'The sales dsd delivery description of the sales dsd delivery record',
    `effective_from` DATE COMMENT 'The effective from of the sales dsd delivery record',
    `effective_until` DATE COMMENT 'The effective until of the sales dsd delivery record',
    `sales_dsd_delivery_name` STRING COMMENT 'The sales dsd delivery name of the sales dsd delivery record',
    `notes` STRING COMMENT 'The notes of the sales dsd delivery record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sales dsd delivery record',
    `sales_dsd_delivery_status` STRING COMMENT 'The sales dsd delivery status of the sales dsd delivery record',
    `source_system_code` STRING COMMENT 'The source system code of the sales dsd delivery record',
    `uom` STRING COMMENT 'The uom of the sales dsd delivery record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sales dsd delivery record',
    CONSTRAINT pk_sales_dsd_delivery PRIMARY KEY(`sales_dsd_delivery_id`)
) COMMENT 'Direct Store Delivery (DSD) execution record capturing the actual delivery of products to a retail store by a DSD driver. Records delivery date, route reference, store/account, driver reference, vehicle reference, SKUs delivered, quantities delivered, quantities returned (empties/unsold), delivery confirmation status, store receiver signature captured flag, delivery exception notes, and settlement amount. Operational record for DSD channel order fulfillment and settlement. [SSOT: authoritative table is distribution.distribution_dsd_delivery; this table is a deprecated duplicate.] [SSOT] Superseded by authoritative table distribution.distribution_dsd_delivery for concept dsd_delivery. SSOT: canonical table is distribution.distribution_dsd_delivery. [SSOT for concept dsd_delivery.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` (
    `account_onboarding_id` BIGINT COMMENT 'Unique surrogate key for each account onboarding record.',
    `account_assortment_id` BIGINT COMMENT 'Reference to the first product assortment agreement created during onboarding.',
    `account_pricing_agreement_id` BIGINT COMMENT 'Reference to the first pricing agreement established during onboarding.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal employee responsible for managing the onboarding process.',
    `resubmitted_account_onboarding_id` BIGINT COMMENT 'Self-referencing FK on account_onboarding (resubmitted_account_onboarding_id)',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Onboarding records belong to a specific trade account; linking enables traceability of the onboarding lifecycle to the account.',
    `account_onboarding_status` STRING COMMENT 'The account onboarding status of the account onboarding record',
    `actual_activation_date` DATE COMMENT 'Date the trade account was officially activated and began transacting.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account onboarding record',
    `applicant_duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the applicant organization.',
    `applicant_legal_entity` STRING COMMENT 'Legal name of the organization applying for a trade account.',
    `assortment_agreement_status` STRING COMMENT 'Status of the product assortment agreement with the trade account.. Valid values are `pending|signed|not_required`',
    `account_onboarding_code` STRING COMMENT 'The account onboarding code of the account onboarding record',
    `completion_date` DATE COMMENT 'The completion date of the account onboarding record',
    `compliance_checklist_completed_flag` BOOLEAN COMMENT 'Indicates whether all required compliance documents have been submitted and approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding record was first created in the lakehouse.',
    `credit_application_status` STRING COMMENT 'Lifecycle status of the credit application submitted during onboarding.. Valid values are `pending|approved|rejected|under_review`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code used for all monetary amounts in the onboarding agreement.',
    `account_onboarding_description` STRING COMMENT 'The account onboarding description of the account onboarding record',
    `dsd_enabled_flag` BOOLEAN COMMENT 'Indicates whether the account uses Direct Store Delivery logistics.',
    `edi_setup_milestone_date` DATE COMMENT 'Date the Electronic Data Interchange (EDI) configuration was completed for the account.',
    `effective_from` DATE COMMENT 'Date from which the onboarding agreement becomes effective (often same as target_go_live_date).',
    `effective_until` DATE COMMENT 'Date the onboarding agreement ends or is superseded; null if open‑ended.',
    `kyb_status` STRING COMMENT 'Current status of KYB verification for the applicant.. Valid values are `pending|completed|failed`',
    `kyc_status` STRING COMMENT 'Current status of KYC verification for the applicant.. Valid values are `pending|completed|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the onboarding record.',
    `account_onboarding_name` STRING COMMENT 'The account onboarding name of the account onboarding record',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the onboarding team.',
    `onboarding_request_date` DATE COMMENT 'Date the onboarding request was submitted by the prospective trade account.',
    `onboarding_stage` STRING COMMENT 'Current stage of the onboarding lifecycle.. Valid values are `application|verification|credit_approval|setup|testing|active`',
    `onboarding_status` STRING COMMENT 'The onboarding status of the account onboarding record',
    `onboarding_type` STRING COMMENT 'Classification of the onboarding effort (e.g., brand‑new account, transfer from another system, reinstatement after suspension).. Valid values are `new_account|account_transfer|reinstatement`',
    `overall_status` STRING COMMENT 'High‑level status indicating whether onboarding is ongoing, finished, or halted.. Valid values are `in_progress|completed|cancelled|on_hold`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code (e.g., NET30, NET45) agreed for the account.',
    `pricing_agreement_status` STRING COMMENT 'Status of the pricing agreement (price list, discounts) for the trade account.. Valid values are `pending|signed|not_required`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account onboarding record',
    `required_documents_completed_flag` BOOLEAN COMMENT 'True when all mandatory legal and compliance documents have been received and validated.',
    `risk_assessment_level` STRING COMMENT 'Risk tier derived from the risk assessment score.. Valid values are `low|medium|high`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score (0‑100) representing the overall risk of onboarding this account.',
    `sla_target_osa_percent` DECIMAL(18,2) COMMENT 'Target On‑Shelf‑Availability service level agreement percentage for the account.',
    `sla_target_otif_percent` DECIMAL(18,2) COMMENT 'Target On‑Time‑In‑Full service level agreement percentage for the account.',
    `source_system_code` STRING COMMENT 'Unique identifier of the onboarding request in the source system.',
    `start_date` DATE COMMENT 'The start date of the account onboarding record',
    `target_go_live_date` DATE COMMENT 'Planned date for the trade account to become active in the system.',
    `uom` STRING COMMENT 'The uom of the account onboarding record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the account onboarding record',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether the account participates in a VMI program.',
    CONSTRAINT pk_account_onboarding PRIMARY KEY(`account_onboarding_id`)
) COMMENT 'Tracks the end-to-end onboarding lifecycle for new trade accounts from initial application through full activation. Captures onboarding request date, applicant legal entity, KYC/KYB verification status, credit application status, compliance document checklist completion, EDI setup milestone, initial assortment agreement status, pricing agreement status, assigned onboarding coordinator, target go-live date, actual activation date, and onboarding stage (application, verification, credit approval, setup, testing, active). Enables CPG manufacturers to manage the multi-week new account setup process and measure time-to-trade for new retail and distributor partners.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` (
    `sales_vmi_agreement_id` BIGINT COMMENT 'Primary key for the vmi_agreement association',
    `inventory_vmi_agreement_id` BIGINT COMMENT 'add column inventory_vmi_agreement_id (BIGINT) with FK to inventory.inventory_vmi_agreement.inventory_vmi_agreement_id - sales-side VMI must link to the inventory VMI master record',
    `procurement_vmi_agreement_id` BIGINT COMMENT 'FK to authoritative SSOT table procurement.procurement_vmi_agreement (cross-domain duplicate resolution).',
    `retail_store_id` BIGINT COMMENT 'add column retail_store_id (BIGINT) with FK to sales.retail_store.retail_store_id - VMI agreements often operate at store level',
    `sku_id` BIGINT COMMENT 'SKU under VMI agreement.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to the trade account',
    `agreement_end_date` DATE COMMENT 'The agreement end date of the sales vmi agreement record',
    `agreement_number` STRING COMMENT 'The agreement number of the sales vmi agreement record',
    `agreement_start_date` DATE COMMENT 'The agreement start date of the sales vmi agreement record',
    `agreement_status` STRING COMMENT 'The agreement status of the sales vmi agreement record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sales vmi agreement record',
    `auto_replenish_flag` BOOLEAN COMMENT 'The auto replenish flag of the sales vmi agreement record',
    `sales_vmi_agreement_code` STRING COMMENT 'The sales vmi agreement code of the sales vmi agreement record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the sales vmi agreement record',
    `currency_code` STRING COMMENT 'The currency code of the sales vmi agreement record',
    `sales_vmi_agreement_description` STRING COMMENT 'The sales vmi agreement description of the sales vmi agreement record',
    `effective_date` DATE COMMENT 'The effective date of the sales vmi agreement record',
    `effective_end_date` DATE COMMENT 'The effective end date of the sales vmi agreement record',
    `effective_from` DATE COMMENT 'The effective from of the sales vmi agreement record',
    `effective_start_date` DATE COMMENT 'The effective start date of the sales vmi agreement record',
    `effective_until` DATE COMMENT 'The effective until of the sales vmi agreement record',
    `expiration_date` DATE COMMENT 'Date the VMI agreement expires.',
    `expiry_date` DATE COMMENT 'The expiry date of the sales vmi agreement record',
    `forecast_sharing_cadence` STRING COMMENT 'The forecast sharing cadence of the sales vmi agreement record',
    `max_inventory_target` DECIMAL(18,2) COMMENT 'Maximum inventory target at the customer site.',
    `max_inventory_weeks` DECIMAL(18,2) COMMENT 'The max inventory weeks of the sales vmi agreement record',
    `max_stock_level` DECIMAL(18,2) COMMENT 'The max stock level of the sales vmi agreement record',
    `min_inventory_target` DECIMAL(18,2) COMMENT 'Minimum inventory target at the customer site.',
    `min_inventory_weeks` DECIMAL(18,2) COMMENT 'The min inventory weeks of the sales vmi agreement record',
    `min_stock_level` DECIMAL(18,2) COMMENT 'The min stock level of the sales vmi agreement record',
    `sales_vmi_agreement_name` STRING COMMENT 'The sales vmi agreement name of the sales vmi agreement record',
    `notes` STRING COMMENT 'The notes of the sales vmi agreement record',
    `ownership_transfer_point` STRING COMMENT 'The ownership transfer point of the sales vmi agreement record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sales vmi agreement record',
    `reorder_point` DECIMAL(18,2) COMMENT 'The reorder point of the sales vmi agreement record',
    `replenishment_frequency` STRING COMMENT 'The replenishment frequency of the sales vmi agreement record',
    `replenishment_method` STRING COMMENT 'The replenishment method of the sales vmi agreement record',
    `replenishment_model` STRING COMMENT 'The replenishment model of the sales vmi agreement record',
    `review_frequency` STRING COMMENT 'The review frequency of the sales vmi agreement record',
    `review_frequency_days` STRING COMMENT 'The review frequency days of the sales vmi agreement record',
    `safety_stock_weeks` DECIMAL(18,2) COMMENT 'The safety stock weeks of the sales vmi agreement record',
    `sales_vmi_agreement_status` STRING COMMENT 'The sales vmi agreement status of the sales vmi agreement record',
    `service_level_target` DECIMAL(18,2) COMMENT 'Target service level percentage.',
    `service_level_target_pct` DECIMAL(18,2) COMMENT 'The service level target pct of the sales vmi agreement record',
    `source_system_code` STRING COMMENT 'The source system code of the sales vmi agreement record',
    `uom` STRING COMMENT 'The uom of the sales vmi agreement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sales vmi agreement record',
    `vmi_model_type` STRING COMMENT 'The vmi model type of the sales vmi agreement record',
    CONSTRAINT pk_sales_vmi_agreement PRIMARY KEY(`sales_vmi_agreement_id`)
) COMMENT 'Represents a VMI agreement between a trade account and a supplier, capturing the contractual terms and effective period for each partnership.. Existence Justification: Trade accounts can partner with multiple suppliers under VMI programs, and each supplier can serve multiple trade accounts. The VMI agreement is an operational entity that is created, updated, and terminated by business users and carries its own attributes such as agreement number, effective dates, status, and replenishment model. [SSOT: authoritative table is procurement.procurement_vmi_agreement; this table is a deprecated duplicate.] [SSOT] Superseded by authoritative table inventory.inventory_vmi_agreement for concept vmi_agreement. [SSOT] Superseded by authoritative table procurement.procurement_vmi_agreement for concept vmi_agreement. SSOT: canonical table is inventory.inventory_vmi_agreement. SSOT: canonical table is procurement.procurement_vmi_agreement. [SSOT: authoritative table is procurement.procurement_vmi_agreement; this is a deprecated duplicate for concept vmi_agreement.] [Non-authoritative; defers to SSOT procurement.procurement_vmi_agreement for concept vmi_agreement.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`call` (
    `call_id` BIGINT COMMENT 'Primary key for the sales_call association',
    `account_call_id` BIGINT COMMENT 'add column account_call_id (BIGINT) with FK to sales.account_call.account_call_id - sales.call appears to overlap account_call and should reference its parent record',
    `rep_id` BIGINT COMMENT 'Sales rep making the call.',
    `call_sales_rep_id` BIGINT COMMENT 'Foreign key linking to sales rep',
    `retail_store_id` BIGINT COMMENT 'The retail store id of the call record',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to trade account',
    `activities_completed` STRING COMMENT 'Activities performed during the call',
    `actual_end` TIMESTAMP COMMENT 'Actual end datetime',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual end timestamp of the call record',
    `actual_start` TIMESTAMP COMMENT 'Actual start datetime',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual start timestamp of the call record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the call record',
    `call_date` DATE COMMENT 'Date of the sales call',
    `call_status` STRING COMMENT 'Status of the call (e.g., completed, cancelled)',
    `call_type` STRING COMMENT 'Type of the call (e.g., visit, phone, virtual)',
    `call_code` STRING COMMENT 'The call code of the call record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the call record',
    `currency_code` STRING COMMENT 'The currency code of the call record',
    `call_description` STRING COMMENT 'The call description of the call record',
    `duration_minutes` BIGINT COMMENT 'Duration of the call in minutes',
    `effective_from` DATE COMMENT 'The effective from of the call record',
    `effective_until` DATE COMMENT 'The effective until of the call record',
    `end_time` TIMESTAMP COMMENT 'The end time of the call record',
    `follow_up_date` DATE COMMENT 'Date for follow-up',
    `follow_up_required` BOOLEAN COMMENT 'The follow up required of the call record',
    `follow_up_required_flag` BOOLEAN COMMENT 'The follow up required flag of the call record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the call record',
    `location` STRING COMMENT 'Call location',
    `location_type` STRING COMMENT 'The location type of the call record',
    `call_name` STRING COMMENT 'The call name of the call record',
    `next_action` STRING COMMENT 'Recommended next action',
    `next_action_date` DATE COMMENT 'The next action date of the call record',
    `next_call_date` DATE COMMENT 'The next call date of the call record',
    `next_step` STRING COMMENT 'The next step of the call record',
    `notes` STRING COMMENT 'Call notes.',
    `objective` STRING COMMENT 'Objective of the call (e.g., product demo, order taking)',
    `orders_taken_count` STRING COMMENT 'The orders taken count of the call record',
    `outcome` STRING COMMENT 'Call outcome.',
    `outcome_notes` STRING COMMENT 'The outcome notes of the call record',
    `planned_flag` BOOLEAN COMMENT 'The planned flag of the call record',
    `purpose` STRING COMMENT 'Purpose of call.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the call record',
    `scheduled_end` TIMESTAMP COMMENT 'Scheduled end datetime',
    `scheduled_start` TIMESTAMP COMMENT 'Scheduled start datetime',
    `scheduled_timestamp` TIMESTAMP COMMENT 'The scheduled timestamp of the call record',
    `source_system_code` STRING COMMENT 'The source system code of the call record',
    `start_time` TIMESTAMP COMMENT 'The start time of the call record',
    `uom` STRING COMMENT 'The uom of the call record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the call record',
    CONSTRAINT pk_call PRIMARY KEY(`call_id`)
) COMMENT 'Represents an interaction (call/visit) between a trade account and a sales representative. Captures details of each sales call such as date, type, status, objectives, activities performed, and duration.. Existence Justification: In the consumer goods business, a trade account can be visited or contacted by multiple sales representatives (field, inside, DSD) and each sales rep serves many trade accounts across territories. The interaction is recorded as a sales call with its own attributes (date, type, status, objectives, activities, duration), which are managed by users for performance reporting and territory management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` (
    `compliance_assignment_id` BIGINT COMMENT 'Primary key for the compliance_assignment association',
    `account_compliance_record_id` BIGINT COMMENT 'add column account_compliance_record_id (BIGINT) with FK to sales.account_compliance_record.account_compliance_record_id - assignment should link to the compliance record being assigned',
    `employee_id` BIGINT COMMENT 'Assigned employee.',
    `compliance_assigned_by_employee_id` BIGINT COMMENT 'The compliance assigned by employee id of the compliance assignment record',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to the compliance_obligation master record',
    `rep_id` BIGINT COMMENT 'The owning rep id of the compliance assignment record',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to the trade_account master record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the compliance assignment record',
    `assigned_by` STRING COMMENT 'The assigned by of the compliance assignment record',
    `assigned_date` DATE COMMENT 'Date the compliance task was assigned.',
    `assigned_to` STRING COMMENT 'Person or role assigned',
    `assignment_date` DATE COMMENT 'The assignment date of the compliance assignment record',
    `assignment_status` STRING COMMENT 'The assignment status of the compliance assignment record',
    `assignment_type` STRING COMMENT 'Type of compliance assignment',
    `compliance_assignment_code` STRING COMMENT 'The compliance assignment code of the compliance assignment record',
    `completed_date` DATE COMMENT 'Date the compliance assignment was completed.',
    `completion_date` DATE COMMENT 'The completion date of the compliance assignment record',
    `completion_pct` DECIMAL(18,2) COMMENT 'Percent completion of the compliance assignment.',
    `completion_status` STRING COMMENT 'The completion status of the compliance assignment record',
    `compliance_assignment_status` STRING COMMENT 'The compliance assignment status of the compliance assignment record',
    `compliance_score` DECIMAL(18,2) COMMENT 'The compliance score of the compliance assignment record',
    `compliance_status` STRING COMMENT 'Current status of the obligation for this account (e.g., pending, compliant, non‑compliant)',
    `compliance_type` STRING COMMENT 'Type of compliance activity for this account (e.g., registration, reporting)',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the compliance assignment record',
    `currency_code` STRING COMMENT 'The currency code of the compliance assignment record',
    `compliance_assignment_description` STRING COMMENT 'The compliance assignment description of the compliance assignment record',
    `due_date` DATE COMMENT 'The due date of the compliance assignment record',
    `effective_from` DATE COMMENT 'The effective from of the compliance assignment record',
    `effective_until` DATE COMMENT 'The effective until of the compliance assignment record',
    `evidence_reference` STRING COMMENT 'Reference to supporting evidence',
    `expiry_date` DATE COMMENT 'Date the license/permit expires for the account',
    `issue_date` DATE COMMENT 'Date the license/permit was issued to the account',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the compliance assignment record',
    `license_number` STRING COMMENT 'License or permit number issued to the account for this obligation',
    `compliance_assignment_name` STRING COMMENT 'The compliance assignment name of the compliance assignment record',
    `notes` STRING COMMENT 'The notes of the compliance assignment record',
    `priority` STRING COMMENT 'The priority of the compliance assignment record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the compliance assignment record',
    `requirement_description` STRING COMMENT 'The requirement description of the compliance assignment record',
    `source_system_code` STRING COMMENT 'The source system code of the compliance assignment record',
    `uom` STRING COMMENT 'The uom of the compliance assignment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the compliance assignment record',
    `verified_by` STRING COMMENT 'Verifier of compliance',
    CONSTRAINT pk_compliance_assignment PRIMARY KEY(`compliance_assignment_id`)
) COMMENT 'This association captures the operational relationship between a trade_account and a compliance_obligation. It records which obligations each account must meet and stores compliance-specific details that belong to the link, such as status, license numbers, and relevant dates.. Existence Justification: Each B2B trade account must satisfy a set of regulatory compliance obligations, and each regulatory obligation applies to many trade accounts. The compliance team actively creates, updates, and deletes records that link a trade_account to a compliance_obligation, tracking status, dates, and license information for each link.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` (
    `account_team_id` BIGINT COMMENT 'Primary key for account_team',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who leads the team.',
    `rep_id` BIGINT COMMENT 'The owning rep id of the account team record',
    `parent_account_team_id` BIGINT COMMENT 'Self-referencing FK on account_team (parent_account_team_id)',
    `trade_account_id` BIGINT COMMENT 'The trade account id of the account team record',
    `account_team_status` STRING COMMENT 'Current lifecycle state of the team.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the account team record',
    `associated_account_count` STRING COMMENT 'Number of customer accounts currently assigned to the team.',
    `average_deal_size` DECIMAL(18,2) COMMENT 'Average monetary value of deals closed by the team.',
    `account_team_code` STRING COMMENT 'The account team code of the account team record',
    `compliance_status` STRING COMMENT 'Current compliance standing of the team with internal policies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the team record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary fields.',
    `data_classification` STRING COMMENT 'Classification level for the team record data.',
    `account_team_description` STRING COMMENT 'Free‑form description of the teams purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the team became operational.',
    `effective_until` DATE COMMENT 'Date when the team ceased operation (null if still active).',
    `external_system_code` STRING COMMENT 'Identifier of the team in an external CRM or ERP system.',
    `is_cross_functional` BOOLEAN COMMENT 'True if the team spans multiple functional areas.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this team is the default assignment for new accounts.',
    `is_lead` BOOLEAN COMMENT 'The is lead of the account team record',
    `is_virtual` BOOLEAN COMMENT 'True if the team operates without a physical office.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent sales activity logged for the team.',
    `last_modified_by` STRING COMMENT 'User identifier who last updated the team record.',
    `last_review_date` DATE COMMENT 'Date of the most recent performance review for the team.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent synchronization with external systems.',
    `manager_email` STRING COMMENT 'Email address of the team manager.',
    `manager_name` STRING COMMENT 'Full name of the manager responsible for the team.',
    `account_team_name` STRING COMMENT 'The account team name of the account team record',
    `notes` STRING COMMENT 'Additional free‑form notes about the team.',
    `offboarding_date` DATE COMMENT 'Date the team was officially retired or dissolved.',
    `onboarding_date` DATE COMMENT 'Date the team was formally onboarded into the organization.',
    `performance_rating` STRING COMMENT 'Internal performance rating for the team.',
    `primary_contact_email` STRING COMMENT 'Email address for the teams primary point of contact.',
    `primary_contact_phone` STRING COMMENT 'Phone number for the teams primary point of contact.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the account team record',
    `quota_amount` DECIMAL(18,2) COMMENT 'Annual sales quota assigned to the team, in local currency.',
    `region` STRING COMMENT 'Primary geographic region the team serves.',
    `review_cycle` STRING COMMENT 'Frequency at which the team is formally reviewed.',
    `sales_channel` STRING COMMENT 'Primary sales channel the team operates in.',
    `source_system_code` STRING COMMENT 'The source system code of the account team record',
    `team_code` STRING COMMENT 'Business identifier code used in external systems for the team.',
    `team_color` STRING COMMENT 'Hex code or name used for UI representation of the team.',
    `team_logo_url` STRING COMMENT 'Web URL pointing to the teams logo image.',
    `team_name` STRING COMMENT 'Human‑readable name of the sales account team.',
    `team_role` STRING COMMENT 'The team role of the account team record',
    `team_size` STRING COMMENT 'Number of members assigned to the team.',
    `team_type` STRING COMMENT 'Classification of the team by scope or specialty.',
    `total_accounts` STRING COMMENT 'Total number of distinct customer accounts ever managed by the team.',
    `total_sales_amount` DECIMAL(18,2) COMMENT 'Cumulative sales revenue generated by the team.',
    `uom` STRING COMMENT 'The uom of the account team record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the team record.',
    `created_by` STRING COMMENT 'User identifier who created the team record.',
    CONSTRAINT pk_account_team PRIMARY KEY(`account_team_id`)
) COMMENT 'Master reference table for account_team. Referenced by account_team_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_parent_trade_account_id` FOREIGN KEY (`parent_trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ADD CONSTRAINT `fk_sales_account_contact_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ADD CONSTRAINT `fk_sales_account_address_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ADD CONSTRAINT `fk_sales_account_hierarchy_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ADD CONSTRAINT `fk_sales_account_hierarchy_child_trade_account_id` FOREIGN KEY (`child_trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ADD CONSTRAINT `fk_sales_account_hierarchy_parent_trade_account_id` FOREIGN KEY (`parent_trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ADD CONSTRAINT `fk_sales_account_hierarchy_primary_trade_account_id` FOREIGN KEY (`primary_trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_edi_trading_partner_id` FOREIGN KEY (`edi_trading_partner_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner`(`edi_trading_partner_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ADD CONSTRAINT `fk_sales_edi_trading_partner_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ADD CONSTRAINT `fk_sales_customer_vmi_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ADD CONSTRAINT `fk_sales_account_sla_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ADD CONSTRAINT `fk_sales_account_segment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ADD CONSTRAINT `fk_sales_account_assortment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ADD CONSTRAINT `fk_sales_account_credit_profile_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ADD CONSTRAINT `fk_sales_account_pricing_agreement_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ADD CONSTRAINT `fk_sales_account_pricing_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ADD CONSTRAINT `fk_sales_account_status_history_reversed_history_account_status_history_id` FOREIGN KEY (`reversed_history_account_status_history_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_status_history`(`account_status_history_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ADD CONSTRAINT `fk_sales_account_status_history_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ADD CONSTRAINT `fk_sales_account_compliance_record_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_order_sales_rep_id` FOREIGN KEY (`order_sales_rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_source_order_id` FOREIGN KEY (`source_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_contact_id` FOREIGN KEY (`account_contact_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_contact`(`account_contact_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_opportunity_owning_rep_id` FOREIGN KEY (`opportunity_owning_rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_account_sales_rep_id` FOREIGN KEY (`account_sales_rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ADD CONSTRAINT `fk_sales_planogram_compliance_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ADD CONSTRAINT `fk_sales_planogram_compliance_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_source_order_id` FOREIGN KEY (`source_order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_manager_rep_id` FOREIGN KEY (`manager_rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_account_team_id` FOREIGN KEY (`account_team_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_team`(`account_team_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_quota_sales_rep_id` FOREIGN KEY (`quota_sales_rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_superseded_by_price_list_id` FOREIGN KEY (`superseded_by_price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ADD CONSTRAINT `fk_sales_sales_deduction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ADD CONSTRAINT `fk_sales_sales_deduction_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ADD CONSTRAINT `fk_sales_sales_deduction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ADD CONSTRAINT `fk_sales_sales_rebate_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ADD CONSTRAINT `fk_sales_sales_dsd_route_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ADD CONSTRAINT `fk_sales_sales_dsd_route_sales_owning_rep_id` FOREIGN KEY (`sales_owning_rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_sales_dsd_route_id` FOREIGN KEY (`sales_dsd_route_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route`(`sales_dsd_route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ADD CONSTRAINT `fk_sales_sales_dsd_delivery_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ADD CONSTRAINT `fk_sales_account_onboarding_account_assortment_id` FOREIGN KEY (`account_assortment_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_assortment`(`account_assortment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ADD CONSTRAINT `fk_sales_account_onboarding_account_pricing_agreement_id` FOREIGN KEY (`account_pricing_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement`(`account_pricing_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ADD CONSTRAINT `fk_sales_account_onboarding_resubmitted_account_onboarding_id` FOREIGN KEY (`resubmitted_account_onboarding_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_onboarding`(`account_onboarding_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ADD CONSTRAINT `fk_sales_account_onboarding_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ADD CONSTRAINT `fk_sales_sales_vmi_agreement_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ADD CONSTRAINT `fk_sales_sales_vmi_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_account_call_id` FOREIGN KEY (`account_call_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_call`(`account_call_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_call_sales_rep_id` FOREIGN KEY (`call_sales_rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ADD CONSTRAINT `fk_sales_call_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ADD CONSTRAINT `fk_sales_compliance_assignment_account_compliance_record_id` FOREIGN KEY (`account_compliance_record_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_compliance_record`(`account_compliance_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ADD CONSTRAINT `fk_sales_compliance_assignment_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ADD CONSTRAINT `fk_sales_compliance_assignment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ADD CONSTRAINT `fk_sales_account_team_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ADD CONSTRAINT `fk_sales_account_team_parent_account_team_id` FOREIGN KEY (`parent_account_team_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_team`(`account_team_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ADD CONSTRAINT `fk_sales_account_team_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `parent_trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Classification Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|credit_hold|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'tier_1_national|tier_2_regional|tier_3_local|tier_4_independent');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'retailer|distributor|wholesaler|foodservice_operator|broker');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `acv_total` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Total');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `acv_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `trade_account_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `trade_account_description` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `dsd_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `dun_number` SET TAGS ('dbx_business_glossary_term' = 'Dun Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `trade_account_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `otif_sla_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Service Level Agreement (SLA) Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|edi_payment|credit_card');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `status_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `status_changed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Status Changed By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tax_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tdp_count` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `trade_account_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `trade_channel` SET TAGS ('dbx_business_glossary_term' = 'Trade Channel Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `account_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Contact Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `account_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Account Contact Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `assistant_name` SET TAGS ('dbx_business_glossary_term' = 'Assistant Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_business_glossary_term' = 'Assistant Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `account_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Account Contact Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_value_regex' = 'primary_buyer|secondary_buyer|decision_maker|influencer|gatekeeper|end_user');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated|transferred');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'buyer|category_manager|logistics_coordinator|finance_contact|marketing_contact|operations_manager');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `account_contact_description` SET TAGS ('dbx_business_glossary_term' = 'Account Contact Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Is Decision Maker Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `account_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Account Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `account_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `account_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_business_glossary_term' = 'Phone Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|portal|in_person');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_id` SET TAGS ('dbx_business_glossary_term' = 'Account Address Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_name` SET TAGS ('dbx_business_glossary_term' = 'Address Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'headquarters|billing|ship_to|sold_to|returns|warehouse');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_validation_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_validation_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|invalid|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_code` SET TAGS ('dbx_business_glossary_term' = 'Account Address Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `country_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_description` SET TAGS ('dbx_business_glossary_term' = 'Account Address Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_description` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `dsd_route_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `edi_location_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Location Qualifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `inactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Inactivation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_name` SET TAGS ('dbx_business_glossary_term' = 'Account Address Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `account_address_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `receiving_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Receiving Hours End Time');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `receiving_hours_end` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `receiving_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Receiving Hours Start Time');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `receiving_hours_start` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `standardized_address_flag` SET TAGS ('dbx_business_glossary_term' = 'Standardized Address Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `standardized_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `standardized_address_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `parent_trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `primary_trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `account_hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `acv_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Roll-Up Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `account_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `consolidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `account_hierarchy_description` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'store|banner|chain|parent_corporation|division|region');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'commercial|logistics|financial|reporting|legal|operational');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `account_hierarchy_name` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `primary_hierarchy_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Hierarchy Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_code` SET TAGS ('dbx_business_glossary_term' = 'Relationship Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_name` SET TAGS ('dbx_business_glossary_term' = 'Relationship Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `rollup_weight` SET TAGS ('dbx_business_glossary_term' = 'Roll-Up Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `sales_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Sales Roll-Up Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `tdp_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Roll-Up Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `trade_spend_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Roll-Up Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `edi_trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Trading Partner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Store Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `acv_weight` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `banner_name` SET TAGS ('dbx_business_glossary_term' = 'Banner Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Store Close Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `retail_store_code` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `retail_store_description` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `dsd_route_code` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `last_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Visit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `retail_store_name` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `next_scheduled_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Visit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Store Open Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `osa_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `otif_sla_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Service Level Agreement (SLA) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `planogram_zone` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `pos_system_type` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) System Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `retail_store_status` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_format` SET TAGS ('dbx_business_glossary_term' = 'Store Format');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_name` SET TAGS ('dbx_business_glossary_term' = 'Store Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_number` SET TAGS ('dbx_business_glossary_term' = 'Store Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_phone` SET TAGS ('dbx_business_glossary_term' = 'Store Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_size_sq_ft` SET TAGS ('dbx_business_glossary_term' = 'Store Size (Square Feet)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_status` SET TAGS ('dbx_business_glossary_term' = 'Store Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_opening|temporarily_closed|permanently_closed|under_renovation');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_tier` SET TAGS ('dbx_business_glossary_term' = 'Store Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `store_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `tdp_weight` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `trading_area` SET TAGS ('dbx_business_glossary_term' = 'Trading Area');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Trading Partner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `acknowledgment_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Service Level Agreement (SLA) Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `as2_identifier` SET TAGS ('dbx_business_glossary_term' = 'Applicability Statement 2 (AS2) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Edi Trading Partner Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Communication Protocol');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'AS2|SFTP|FTPS|VAN|HTTP/S|Direct Connect');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_description` SET TAGS ('dbx_business_glossary_term' = 'Edi Trading Partner Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `digital_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Go-Live Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Partner Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_standard` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Standard');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_standard` SET TAGS ('dbx_value_regex' = 'ANSI X12|UN/EDIFACT|TRADACOMS|VDA|ODETTE');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Trading Partner Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Version');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `encryption_required` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `environment_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Environment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `environment_type` SET TAGS ('dbx_value_regex' = 'production|test|development');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `gs_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Functional Group Sender/Receiver (GS) Qualifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `gs_qualifier` SET TAGS ('dbx_value_regex' = '01|14|ZZ');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `gs_receiver_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Group Receiver (GS) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `gs_sender_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Group Sender (GS) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `isa_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Interchange Sender/Receiver (ISA) Qualifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `isa_receiver_code` SET TAGS ('dbx_business_glossary_term' = 'Interchange Receiver (ISA) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `isa_sender_code` SET TAGS ('dbx_business_glossary_term' = 'Interchange Sender (ISA) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `mdn_requested` SET TAGS ('dbx_business_glossary_term' = 'Message Disposition Notification (MDN) Requested Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `edi_trading_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Edi Trading Partner Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Configuration Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `partner_id_value` SET TAGS ('dbx_business_glossary_term' = 'Partner Id Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `partner_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Partner Qualifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `processing_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Processing Service Level Agreement (SLA) Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `sftp_directory_inbound` SET TAGS ('dbx_business_glossary_term' = 'Secure File Transfer Protocol (SFTP) Inbound Directory Path');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `sftp_directory_outbound` SET TAGS ('dbx_business_glossary_term' = 'Secure File Transfer Protocol (SFTP) Outbound Directory Path');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `sftp_host` SET TAGS ('dbx_business_glossary_term' = 'Secure File Transfer Protocol (SFTP) Host Address');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `sftp_host` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `sftp_port` SET TAGS ('dbx_business_glossary_term' = 'Secure File Transfer Protocol (SFTP) Port Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `sftp_username` SET TAGS ('dbx_business_glossary_term' = 'Secure File Transfer Protocol (SFTP) Username');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `sftp_username` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `transaction_set_810_enabled` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set 810 Invoice Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `transaction_set_846_enabled` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set 846 Inventory Inquiry/Advice Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `transaction_set_850_enabled` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set 850 Purchase Order (PO) Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `transaction_set_852_enabled` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set 852 Point of Sale (POS) Data Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `transaction_set_855_enabled` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set 855 Purchase Order (PO) Acknowledgment Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `transaction_set_856_enabled` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set 856 Advanced Ship Notice (ASN) Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `transaction_set_867_enabled` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set 867 Product Transfer and Resale Report Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `transaction_set_997_enabled` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set 997 Functional Acknowledgment Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `van_mailbox_code` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Network (VAN) Mailbox Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`edi_trading_partner` ALTER COLUMN `van_provider` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Network (VAN) Provider Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` SET TAGS ('dbx_subdomain' = 'direct_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `customer_vmi_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Vendor Managed Inventory (VMI) Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Demand Planner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `tertiary_customer_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `tertiary_customer_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `tertiary_customer_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^VMI-[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Auto-Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `customer_vmi_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Vmi Agreement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'VMI Contract Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `covered_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Covered Stock Keeping Unit (SKU) Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `customer_vmi_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Vmi Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `customer_vmi_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Customer Vmi Agreement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `forecast_sharing_cadence` SET TAGS ('dbx_business_glossary_term' = 'Forecast Sharing Cadence');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `forecast_sharing_cadence` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi_weekly|monthly|quarterly|none');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `inventory_ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Inventory Ownership Model');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `inventory_ownership_model` SET TAGS ('dbx_value_regex' = 'customer_owned|supplier_owned_consignment|shared_risk|pay_on_scan');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|weighted_average|standard_cost');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `inventory_visibility_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Visibility Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `inventory_visibility_method` SET TAGS ('dbx_value_regex' = 'edi_846|api_integration|portal_access|manual_report|wms_integration|none');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last VMI Performance Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `max_inventory_weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Maximum Inventory Weeks of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Max Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `min_inventory_weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Minimum Inventory Weeks of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Min Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `customer_vmi_agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Vmi Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next VMI Performance Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `order_transmission_method` SET TAGS ('dbx_business_glossary_term' = 'Order Transmission Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `order_transmission_method` SET TAGS ('dbx_value_regex' = 'edi_850|api|portal|email|fax|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `penalty_amount_per_incident` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount Per Incident');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `penalty_amount_per_incident` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `penalty_clause_enabled` SET TAGS ('dbx_business_glossary_term' = 'VMI Penalty Clause Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'VMI Performance Review Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `pos_data_sharing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Data Sharing Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'VMI Agreement Renewal Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'VMI Replenishment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'VMI Replenishment Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `safety_stock_weeks` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Weeks of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `sku_scope_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Scope Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `sku_scope_type` SET TAGS ('dbx_value_regex' = 'all_skus|product_category|brand|specific_sku_list|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `sla_target_fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Fill Rate Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `sla_target_oos_incidents_per_month` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Out of Stock (OOS) Incidents Per Month');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `sla_target_otif_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target On Time In Full (OTIF) Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Trade Partner Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Partner Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Trade Partner Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `trade_partner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `vmi_program_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Program Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`customer_vmi_agreement` ALTER COLUMN `vmi_program_type` SET TAGS ('dbx_value_regex' = 'full_vmi|co_managed_inventory|consignment|supplier_managed_replenishment|continuous_replenishment|vendor_owned_inventory');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `account_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Account Service Level Agreement (SLA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `account_sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `account_sla_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `account_sla_code` SET TAGS ('dbx_business_glossary_term' = 'Account Sla Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `account_sla_description` SET TAGS ('dbx_business_glossary_term' = 'Account Sla Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `exclusion_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Conditions');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `fill_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `incentive_terms` SET TAGS ('dbx_business_glossary_term' = 'Incentive Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `incentive_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `minimum_performance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Performance Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `account_sla_name` SET TAGS ('dbx_business_glossary_term' = 'Account Sla Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Otif Target Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Commercial Team');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `penalty_terms` SET TAGS ('dbx_business_glossary_term' = 'Penalty Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `penalty_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|biennial|as_needed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `sla_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `sla_number` SET TAGS ('dbx_value_regex' = '^SLA-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'otif|fill_rate|lead_time|invoice_accuracy|claims_resolution|order_accuracy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `target_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `target_metric_unit` SET TAGS ('dbx_value_regex' = 'percentage|days|hours|count|ratio');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `target_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_sla` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `account_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Account Segment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `account_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Account Segment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `acv_tier` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `acv_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_measured');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `assigned_sales_region` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Region');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `channel_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `channel_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|unassigned');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `account_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Account Segment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `credit_limit_tier` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `credit_limit_tier` SET TAGS ('dbx_value_regex' = 'unlimited|high|medium|low|restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `customer_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `customer_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `account_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Account Segment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `edi_trading_partner_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Trading Partner Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `field_sales_call_frequency` SET TAGS ('dbx_business_glossary_term' = 'Field Sales Call Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `field_sales_call_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|annual|as_needed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `account_segment_name` SET TAGS ('dbx_business_glossary_term' = 'Account Segment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `otif_sla_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Service Level Agreement (SLA) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'edlp|hi_lo|hybrid|custom|standard');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `primary_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `primary_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `primary_channel_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `secondary_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `secondary_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `secondary_channel_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Channel Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `segment_assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_business_glossary_term' = 'Segment Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `segmentation_model_version` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Model Version');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `segmentation_model_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `strategic_priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `tdp_tier` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `tdp_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_measured');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `trade_promotion_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Eligibility');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `trade_promotion_eligibility` SET TAGS ('dbx_value_regex' = 'full|limited|excluded|pending_review');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_segment` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `account_assortment_id` SET TAGS ('dbx_business_glossary_term' = 'Account Assortment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `product_lca_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lca Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `account_assortment_status` SET TAGS ('dbx_business_glossary_term' = 'Account Assortment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `assortment_type` SET TAGS ('dbx_business_glossary_term' = 'Assortment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `assortment_type` SET TAGS ('dbx_value_regex' = 'core_range|seasonal|promotional|new_item|limited_edition|test_market');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `authorized_distribution_points` SET TAGS ('dbx_business_glossary_term' = 'Authorized Total Distribution Points (TDP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `category_role` SET TAGS ('dbx_business_glossary_term' = 'Category Role');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `category_role` SET TAGS ('dbx_value_regex' = 'destination|routine|occasional|convenience');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `account_assortment_code` SET TAGS ('dbx_business_glossary_term' = 'Account Assortment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `delist_date` SET TAGS ('dbx_business_glossary_term' = 'Delist Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `account_assortment_description` SET TAGS ('dbx_business_glossary_term' = 'Account Assortment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Assortment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `last_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Shipment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `launch_wave` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Launch Wave');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `listing_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `listing_status` SET TAGS ('dbx_value_regex' = 'listed|delisted|pending|suspended|discontinued');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `moq_unit` SET TAGS ('dbx_value_regex' = 'each|case|pallet|layer|inner_pack');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `account_assortment_name` SET TAGS ('dbx_business_glossary_term' = 'Account Assortment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assortment Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `planogram_slot_count` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Slot Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Assortment Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Item Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_assortment` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `account_credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Profile ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `account_credit_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Profile Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `available_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Credit Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `available_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `bankruptcy_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Filing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `bankruptcy_filing_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `account_credit_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Profile Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_analyst_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_hold_status` SET TAGS ('dbx_value_regex' = 'active|released|manual_review|blocked');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Coverage Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Coverage Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Policy Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Provider');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_limit_override_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Override Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_limit_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Override Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_limit_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Override Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `credit_used` SET TAGS ('dbx_business_glossary_term' = 'Credit Used');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `current_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Credit Exposure Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `current_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `account_credit_profile_description` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Profile Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `dso_actual_days` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO) Actual Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `dso_actual_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `dso_target_days` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO) Target Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `external_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `external_credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `external_credit_score` SET TAGS ('dbx_business_glossary_term' = 'External Credit Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `external_credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `internal_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `internal_credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `account_credit_profile_name` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Profile Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `next_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credit Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `payment_method_preference` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `payment_method_preference` SET TAGS ('dbx_value_regex' = 'ach|wire|check|edi|credit_card');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `payment_terms_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `risk_class` SET TAGS ('dbx_business_glossary_term' = 'Risk Class');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_credit_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `account_pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Account Pricing Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `primary_account_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `primary_account_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `primary_account_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `account_pricing_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Account Pricing Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `base_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Base Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `base_discount_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `account_pricing_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Account Pricing Agreement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `account_pricing_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Account Pricing Agreement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `early_payment_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `msrp_guidance_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Guidance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `account_pricing_agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Account Pricing Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy (EDLP vs Hi-Lo)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'edlp|hi_lo|hybrid|cost_plus|market_based');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `promotional_allowance_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Allowance Cap Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `promotional_allowance_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `promotional_allowance_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotional Allowance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `promotional_allowance_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `rsp_guidance_amount` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP) Guidance Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_enabled` SET TAGS ('dbx_business_glossary_term' = 'Volume Rebate Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_percent_1` SET TAGS ('dbx_business_glossary_term' = 'Volume Rebate Percentage 1');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_percent_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_percent_2` SET TAGS ('dbx_business_glossary_term' = 'Volume Rebate Percentage 2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_percent_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_percent_3` SET TAGS ('dbx_business_glossary_term' = 'Volume Rebate Percentage 3');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_percent_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_threshold_1` SET TAGS ('dbx_business_glossary_term' = 'Volume Rebate Threshold 1');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_threshold_2` SET TAGS ('dbx_business_glossary_term' = 'Volume Rebate Threshold 2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_pricing_agreement` ALTER COLUMN `volume_rebate_threshold_3` SET TAGS ('dbx_business_glossary_term' = 'Volume Rebate Threshold 3');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `account_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Account Status History ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Changed By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `reversed_history_account_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed History ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `account_status_history_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status History Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `change_method` SET TAGS ('dbx_business_glossary_term' = 'Change Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `change_method` SET TAGS ('dbx_value_regex' = 'manual|automated|batch|api|edi');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `change_source_system` SET TAGS ('dbx_business_glossary_term' = 'Change Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Changed By User Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `account_status_history_code` SET TAGS ('dbx_business_glossary_term' = 'Account Status History Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `compliance_violation_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `compliance_violation_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `compliance_violation_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `credit_limit_at_change` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit at Change');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `credit_limit_at_change` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `days_sales_outstanding_at_change` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO) at Change');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `days_sales_outstanding_at_change` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `account_status_history_description` SET TAGS ('dbx_business_glossary_term' = 'Account Status History Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `edi_control_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Control Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'credit_hold|compliance_hold|quality_hold|legal_hold|payment_hold|general_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `account_status_history_name` SET TAGS ('dbx_business_glossary_term' = 'Account Status History Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Status Change Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `outstanding_balance_at_change` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance at Change');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `outstanding_balance_at_change` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `sla_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `status_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `status_change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_status_history` ALTER COLUMN `change_date` SET TAGS ('dbx_business_glossary_term' = 'Change Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `account_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Account Compliance Record Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `account_compliance_record_status` SET TAGS ('dbx_business_glossary_term' = 'Account Compliance Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `account_compliance_record_code` SET TAGS ('dbx_business_glossary_term' = 'Account Compliance Record Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Compliance Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|suspended|revoked|renewed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `compliance_type` SET TAGS ('dbx_value_regex' = 'business_license|food_handler_permit|alcohol_license|import_export_license|gdpr_dpa|ccpa_opt_out');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `account_compliance_record_description` SET TAGS ('dbx_business_glossary_term' = 'Account Compliance Record Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `issuing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Issuing State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `issuing_state_province` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `issuing_state_province` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License or Certification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `account_compliance_record_name` SET TAGS ('dbx_business_glossary_term' = 'Account Compliance Record Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|approved|rejected|overdue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_compliance_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` SET TAGS ('dbx_subdomain' = 'order_revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Warehouse Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving User Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|distributor');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_code` SET TAGS ('dbx_business_glossary_term' = 'Order Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_description` SET TAGS ('dbx_business_glossary_term' = 'Order Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `division` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_name` SET TAGS ('dbx_business_glossary_term' = 'Order Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rush|drop_ship|direct_store_delivery|promotional|sample');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late|partial|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `sales_office` SET TAGS ('dbx_business_glossary_term' = 'Sales Office Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `sales_office` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `sap_sd_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `sap_sd_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|rail|courier|dsd');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Order Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'web_portal|edi|sales_rep|call_center|mobile_app|marketplace');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Subtotal Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` SET TAGS ('dbx_subdomain' = 'order_revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `account_address_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `source_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Document Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `billing_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|proforma|intercompany|consignment');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Cancellation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `invoice_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Product Division Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `edi_document_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|transmitted|acknowledged|rejected|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight and Shipping Charge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Lifecycle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `invoice_name` SET TAGS ('dbx_business_glossary_term' = 'Invoice Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes and Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Receivable Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid to Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Settlement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|overpaid|written_off');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|deferred|subscription|service');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `trade_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` SET TAGS ('dbx_subdomain' = 'order_revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'standard|volume_tiered|promotional|rebate|contract|spot');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `base_list_price` SET TAGS ('dbx_business_glossary_term' = 'Base List Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `contracted_net_price` SET TAGS ('dbx_business_glossary_term' = 'Contracted Net Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `msrp_price` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `price_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `product_scope` SET TAGS ('dbx_value_regex' = 'all_products|product_category|specific_skus|brand');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `promotional_allowance` SET TAGS ('dbx_business_glossary_term' = 'Promotional Allowance');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `rsp_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `volume_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `volume_threshold_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `volume_threshold_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `account_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Contact ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_owning_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|dsd|foodservice');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `competitive_displacement_context` SET TAGS ('dbx_business_glossary_term' = 'Competitive Displacement Context');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_description` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_acv_gain` SET TAGS ('dbx_business_glossary_term' = 'Estimated ACV (All Commodity Volume) Gain');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Incremental Annual Revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated SKU (Stock Keeping Unit) Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_tdp_gain` SET TAGS ('dbx_business_glossary_term' = 'Estimated TDP (Total Distribution Points) Gain');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = '^Q[1-4]sd{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|best_case|commit|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `jbp_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'JBP (Joint Business Planning) Alignment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_value_regex' = 'inbound_inquiry|field_sales_prospecting|trade_show|referral|marketing_campaign|existing_account_expansion');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `next_step_description` SET TAGS ('dbx_business_glossary_term' = 'Next Step Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_status` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Probability Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `product_category_focus` SET TAGS ('dbx_business_glossary_term' = 'Product Category Focus');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`opportunity` ALTER COLUMN `win_reason` SET TAGS ('dbx_business_glossary_term' = 'Win Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `account_call_id` SET TAGS ('dbx_business_glossary_term' = 'Account Call Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `account_sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `account_call_status` SET TAGS ('dbx_business_glossary_term' = 'Account Call Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `activities_completed` SET TAGS ('dbx_business_glossary_term' = 'Activities Completed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Call Duration in Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_notes` SET TAGS ('dbx_business_glossary_term' = 'Call Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_number` SET TAGS ('dbx_business_glossary_term' = 'Call Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_objective` SET TAGS ('dbx_business_glossary_term' = 'Call Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_outcome` SET TAGS ('dbx_business_glossary_term' = 'Call Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_outcome` SET TAGS ('dbx_value_regex' = 'successful|partially_successful|unsuccessful|rescheduled');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_status` SET TAGS ('dbx_business_glossary_term' = 'Call Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_type` SET TAGS ('dbx_business_glossary_term' = 'Call Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `call_type` SET TAGS ('dbx_value_regex' = 'routine|promotional|merchandising|compliance_audit|new_product_introduction|problem_resolution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `account_call_code` SET TAGS ('dbx_business_glossary_term' = 'Account Call Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `competitor_activity_observed` SET TAGS ('dbx_business_glossary_term' = 'Competitor Activity Observed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `competitor_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitor Pricing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `corrective_actions_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Completed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `account_call_description` SET TAGS ('dbx_business_glossary_term' = 'Account Call Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `display_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Display Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `display_type` SET TAGS ('dbx_business_glossary_term' = 'Display Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `display_type` SET TAGS ('dbx_value_regex' = 'end_cap|floor_stand|pallet|shelf_talker|cooler|none');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `facings_actual` SET TAGS ('dbx_business_glossary_term' = 'Facings Actual');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `facings_required` SET TAGS ('dbx_business_glossary_term' = 'Facings Required');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `account_call_name` SET TAGS ('dbx_business_glossary_term' = 'Account Call Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `next_call_date` SET TAGS ('dbx_business_glossary_term' = 'Next Call Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `oos_items_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Items Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `oos_items_list` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Items List');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `photo_evidence_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `photo_storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Storage Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `pog_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Call Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `shelf_position_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Shelf Position Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Signature Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `store_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Store Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `store_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `store_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `sync_status` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `sync_status` SET TAGS ('dbx_value_regex' = 'synced|pending|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_call` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `planogram_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Compliance Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `actual_facings_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Facings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `audit_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'scheduled|ad_hoc|follow_up|promotional');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `planogram_compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Planogram Compliance Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `compliance_pct` SET TAGS ('dbx_business_glossary_term' = 'Compliance Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `compliance_trend` SET TAGS ('dbx_business_glossary_term' = 'Compliance Trend');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `compliance_trend` SET TAGS ('dbx_value_regex' = 'improving|stable|declining');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `corrective_action_priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `corrective_action_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `planogram_compliance_description` SET TAGS ('dbx_business_glossary_term' = 'Planogram Compliance Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `display_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Display Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `facings_variance` SET TAGS ('dbx_business_glossary_term' = 'Facings Variance');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `planogram_compliance_name` SET TAGS ('dbx_business_glossary_term' = 'Planogram Compliance Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `oos_items_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Items Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `oos_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) SKU (Stock Keeping Unit) List');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `osa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `photo_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `planogram_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Planogram Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `pog_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `pog_version_code` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Version Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `previous_audit_score` SET TAGS ('dbx_business_glossary_term' = 'Previous Audit Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `required_facings_count` SET TAGS ('dbx_business_glossary_term' = 'Required Facings Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated|deferred');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `shelf_level` SET TAGS ('dbx_business_glossary_term' = 'Shelf Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `shelf_level` SET TAGS ('dbx_value_regex' = 'eye_level|top_shelf|middle_shelf|bottom_shelf|end_cap');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `shelf_position_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Shelf Position Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `store_manager_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Store Manager Notified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `unauthorized_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Unauthorized SKU (Stock Keeping Unit) List');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `unauthorized_substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Unauthorized Substitution Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`planogram_compliance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Sale (POS) Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `acv_flag` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `baseline_sales_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Sales Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `pos_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'nielsen_iq|iri_circana|retailer_edi|retailer_portal|tradeedge|internal');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `data_source_file_code` SET TAGS ('dbx_business_glossary_term' = 'Data Source File ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `pos_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^d{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `extended_retail_value` SET TAGS ('dbx_business_glossary_term' = 'Extended Retail Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^d{8}$|^d{12}$|^d{13}$|^d{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `pos_transaction_name` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `out_of_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `pos_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'temporary_price_reduction|multi_buy|coupon|loyalty_discount|clearance|none');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `retail_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Retail Selling Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `retailer_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_city` SET TAGS ('dbx_business_glossary_term' = 'Store City');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_country_code` SET TAGS ('dbx_business_glossary_term' = 'Store Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_format` SET TAGS ('dbx_business_glossary_term' = 'Store Format');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_name` SET TAGS ('dbx_business_glossary_term' = 'Store Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Store Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_state_province` SET TAGS ('dbx_business_glossary_term' = 'Store State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_state_province` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_state_province` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `week_ending_date` SET TAGS ('dbx_business_glossary_term' = 'Week Ending Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` SET TAGS ('dbx_subdomain' = 'order_revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Sales Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Product Complaint Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `source_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `waste_generation_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_code` SET TAGS ('dbx_business_glossary_term' = 'Return Order Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `credit_memo_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Issued Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `credit_memo_posted_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Posted Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `credit_memo_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `customer_responsible_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Responsible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_description` SET TAGS ('dbx_business_glossary_term' = 'Return Order Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instruction');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `division` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `goods_received_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `inspection_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `lot_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `lot_batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_name` SET TAGS ('dbx_business_glossary_term' = 'Return Order Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `original_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Original Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|not_inspected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_value_regex' = '^RMA-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_status` SET TAGS ('dbx_business_glossary_term' = 'Return Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_type` SET TAGS ('dbx_business_glossary_term' = 'Return Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_type` SET TAGS ('dbx_value_regex' = 'retail_account_return|distributor_return|dtc_consumer_return|wholesale_return');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_reason` SET TAGS ('dbx_business_glossary_term' = 'Return Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_request_date` SET TAGS ('dbx_business_glossary_term' = 'Return Request Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_value_gross` SET TAGS ('dbx_business_glossary_term' = 'Return Value Gross');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_value_net` SET TAGS ('dbx_business_glossary_term' = 'Return Value Net');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `returned_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `account_count` SET TAGS ('dbx_business_glossary_term' = 'Account Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `acv_coverage` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Coverage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Quota Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `call_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Call Frequency in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `channel_assignment` SET TAGS ('dbx_business_glossary_term' = 'Channel Assignment');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `district` SET TAGS ('dbx_business_glossary_term' = 'Sales District');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `edi_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capability Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `pog_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Compliance Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `postal_code_list` SET TAGS ('dbx_business_glossary_term' = 'Postal Code List');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `postal_code_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `postal_code_list` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic|standard');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `state_province_list` SET TAGS ('dbx_business_glossary_term' = 'State or Province List');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `state_province_list` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `state_province_list` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `tdp_coverage` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Coverage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'field|key_account|national_account|regional|district|channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `trade_class` SET TAGS ('dbx_business_glossary_term' = 'Trade Class');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `manager_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Sales Representative ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `badge_number` SET TAGS ('dbx_business_glossary_term' = 'Badge Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `channel_specialization` SET TAGS ('dbx_business_glossary_term' = 'Channel Specialization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_code` SET TAGS ('dbx_business_glossary_term' = 'Rep Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `current_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Quota Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_description` SET TAGS ('dbx_business_glossary_term' = 'Rep Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `last_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Certification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_business_glossary_term' = 'Rep Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|below|new_hire');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `quota_period` SET TAGS ('dbx_business_glossary_term' = 'Quota Period');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `quota_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|suspended|terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_type` SET TAGS ('dbx_value_regex' = 'field_sales|key_account_manager|national_account_manager|inside_sales|dsd_driver|regional_manager');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `sales_group` SET TAGS ('dbx_business_glossary_term' = 'Sales Group');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `sales_office` SET TAGS ('dbx_business_glossary_term' = 'Sales Office');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `sfa_user_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Force Automation (SFA) User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `sfa_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `sfa_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `vehicle_assigned` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assigned Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `quota_id` SET TAGS ('dbx_business_glossary_term' = 'Quota ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `account_team_id` SET TAGS ('dbx_business_glossary_term' = 'Account Team ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `quota_sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `accelerator_rate` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|dsd');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `quota_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `quota_description` SET TAGS ('dbx_business_glossary_term' = 'Quota Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `minimum_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `quota_name` SET TAGS ('dbx_business_glossary_term' = 'Quota Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `product_scope` SET TAGS ('dbx_value_regex' = 'all_products|category|brand|sku');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `quota_number` SET TAGS ('dbx_business_glossary_term' = 'Quota Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `quota_status` SET TAGS ('dbx_business_glossary_term' = 'Quota Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `quota_type` SET TAGS ('dbx_business_glossary_term' = 'Quota Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Quota Source');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'top_down|bottom_up|negotiated|algorithmic');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `stretch_target` SET TAGS ('dbx_business_glossary_term' = 'Stretch Target');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Quota Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Quota Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`quota` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_point_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `actual_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Actual Retail Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `acv_percentage` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `acv_weighted_flag` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Weighted Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_point_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `delist_date` SET TAGS ('dbx_business_glossary_term' = 'Delist Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_point_description` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_point_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_source` SET TAGS ('dbx_business_glossary_term' = 'Distribution Source');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_source` SET TAGS ('dbx_value_regex' = 'sell_in_confirmed|pos_verified|syndicated_data|field_audit|retailer_feed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'active|inactive|authorized|delisted|pending|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Verification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `facing_count` SET TAGS ('dbx_business_glossary_term' = 'Shelf Facing Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `geographic_market` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `geographic_market` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `last_pos_sale_date` SET TAGS ('dbx_business_glossary_term' = 'Last Point of Sale (POS) Sale Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `launch_wave` SET TAGS ('dbx_business_glossary_term' = 'Product Launch Wave');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `msrp_price` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `distribution_point_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `new_product_flag` SET TAGS ('dbx_business_glossary_term' = 'New Product Distribution Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `osa_status` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `osa_status` SET TAGS ('dbx_value_regex' = 'in_stock|out_of_stock|low_stock|unknown');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `planogram_slot_reference` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Slot Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `pog_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `rsp_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `shelf_position` SET TAGS ('dbx_business_glossary_term' = 'Shelf Position');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `shelf_position` SET TAGS ('dbx_value_regex' = 'eye_level|top_shelf|middle_shelf|bottom_shelf|end_cap|promotional_display');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `tdp_count_flag` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Count Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `vmi_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`distribution_point` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` SET TAGS ('dbx_subdomain' = 'order_revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `superseded_by_price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price List ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_code` SET TAGS ('dbx_business_glossary_term' = 'Price List Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|foodservice|institutional');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `freight_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Freight Inclusion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `moq_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure (UoM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `moq_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `msrp_flag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'list_price|cost_plus|market_based|competitive|value_based');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|inactive|expired|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_type` SET TAGS ('dbx_business_glossary_term' = 'Price List Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_type` SET TAGS ('dbx_value_regex' = 'standard|promotional|contract|channel_specific|seasonal|clearance');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_protection_days` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Price Rounding Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_rounding_rule` SET TAGS ('dbx_value_regex' = 'none|nearest_cent|nearest_nickel|nearest_dime|nearest_dollar|up_to_99');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UoM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `pricing_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `pricing_condition_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `rsp_flag` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `trade_class` SET TAGS ('dbx_business_glossary_term' = 'Trade Class');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` SET TAGS ('dbx_subdomain' = 'order_revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|foodservice|export');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_code` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Condition Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `cost_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `item_sequence` SET TAGS ('dbx_business_glossary_term' = 'Item Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `moq_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `msrp_price` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Override Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `pricing_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pricing Unit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `rsp_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `sap_condition_record_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Condition Record Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `scale_basis` SET TAGS ('dbx_value_regex' = 'quantity|value|weight|volume');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `scale_quantity_from` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `scale_quantity_to` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity To');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` SET TAGS ('dbx_subdomain' = 'order_revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `sales_deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Deduction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Analyst ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `promotion_deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Deduction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `sales_deduction_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Deduction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `customer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `deduction_date` SET TAGS ('dbx_business_glossary_term' = 'Deduction Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `deduction_number` SET TAGS ('dbx_business_glossary_term' = 'Deduction Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `deduction_status` SET TAGS ('dbx_business_glossary_term' = 'Deduction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `deduction_status` SET TAGS ('dbx_value_regex' = 'open|under review|approved|rejected|written off|partially approved');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `deduction_type` SET TAGS ('dbx_business_glossary_term' = 'Deduction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `deduction_type` SET TAGS ('dbx_value_regex' = 'trade promotion|pricing dispute|shortage claim|quality claim|freight allowance|damaged goods');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `sales_deduction_description` SET TAGS ('dbx_business_glossary_term' = 'Sales Deduction Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `sales_deduction_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Deduction Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `sales_deduction_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Deduction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `valid_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Valid Claim Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_deduction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` SET TAGS ('dbx_subdomain' = 'order_revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sales_rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rebate Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'invoice_based|payment_based|shipment_based|periodic');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `accrued_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'revenue|units|gross_sales|net_sales');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sales_rebate_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Rebate Agreement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sales_rebate_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Sales Rebate Agreement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `last_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Settlement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `maximum_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `minimum_qualification_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualification Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sales_rebate_agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Rebate Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_memo|check|eft|offset');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `rebate_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebate Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `rebate_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `rebate_type` SET TAGS ('dbx_value_regex' = 'volume|growth|new_product|category_performance|mix|loyalty');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `retroactive_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sales_rebate_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sales_rebate_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|pending_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `sap_rebate_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Rebate Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `settled_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|on_demand');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `termination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Termination Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `tier_structure_flag` SET TAGS ('dbx_business_glossary_term' = 'Tier Structure Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_rebate_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_subdomain' = 'direct_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_deprecated_ssot_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_ssot_alias_of' = 'distribution.distribution_dsd_route');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_ssot_concept' = 'dsd_route');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_ssot_role' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_ssot_canonical' = 'distribution.distribution_dsd_route');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `sales_dsd_route_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Direct Store Delivery (DSD) Route ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `distribution_dsd_route_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Dsd Route Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `distribution_dsd_route_id` SET TAGS ('dbx_ssot_link' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `sales_owning_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `sales_dsd_route_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Dsd Route Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `sales_dsd_route_description` SET TAGS ('dbx_business_glossary_term' = 'Sales Dsd Route Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `sales_dsd_route_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Dsd Route Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `route_day` SET TAGS ('dbx_business_glossary_term' = 'Route Day');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `sales_dsd_route_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Dsd Route Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_route` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_subdomain' = 'direct_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_deprecated_ssot_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_ssot_alias_of' = 'distribution.distribution_dsd_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_ssot_concept' = 'dsd_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_ssot_role' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_ssot_canonical' = 'distribution.distribution_dsd_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `sales_dsd_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Direct Store Delivery (DSD) Delivery ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `sales_dsd_route_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `distribution_dsd_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Dsd Delivery Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `distribution_dsd_delivery_id` SET TAGS ('dbx_ssot_link' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `sales_dsd_delivery_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Dsd Delivery Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `delivered_units` SET TAGS ('dbx_business_glossary_term' = 'Delivered Units');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `sales_dsd_delivery_description` SET TAGS ('dbx_business_glossary_term' = 'Sales Dsd Delivery Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `sales_dsd_delivery_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Dsd Delivery Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `sales_dsd_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Dsd Delivery Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_dsd_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `account_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Account Onboarding Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `account_assortment_id` SET TAGS ('dbx_business_glossary_term' = 'Initial Assortment Agreement Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `account_pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Initial Pricing Agreement Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Coordinator Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `resubmitted_account_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Resubmitted Account Onboarding Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `resubmitted_account_onboarding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `account_onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Account Onboarding Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `actual_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Activation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `applicant_duns_number` SET TAGS ('dbx_business_glossary_term' = 'Applicant DUNS Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `applicant_legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Applicant Legal Entity Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `assortment_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Assortment Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `assortment_agreement_status` SET TAGS ('dbx_value_regex' = 'pending|signed|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `account_onboarding_code` SET TAGS ('dbx_business_glossary_term' = 'Account Onboarding Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `compliance_checklist_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Checklist Completed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `credit_application_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Application Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `credit_application_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `account_onboarding_description` SET TAGS ('dbx_business_glossary_term' = 'Account Onboarding Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `dsd_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `edi_setup_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'EDI Setup Milestone Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `kyb_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Business (KYB) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `kyb_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `account_onboarding_name` SET TAGS ('dbx_business_glossary_term' = 'Account Onboarding Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `onboarding_request_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Request Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_value_regex' = 'application|verification|credit_approval|setup|testing|active');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_value_regex' = 'new_account|account_transfer|reinstatement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Onboarding Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `pricing_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `pricing_agreement_status` SET TAGS ('dbx_value_regex' = 'pending|signed|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `required_documents_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Required Documents Completed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `sla_target_osa_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Target OSA Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `sla_target_otif_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Target OTIF Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `target_go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Target Go-Live Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_onboarding` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_subdomain' = 'direct_delivery');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_association_edges' = 'customer.trade_account,procurement.supplier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_deprecated_ssot_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_ssot_alias_of' = 'procurement.procurement_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_ssot_role' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_ssot_canonical' = 'procurement.procurement_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_deprecated_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_ssot_concept' = 'vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_ssot_duplicate_of' = 'procurement.procurement_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_ssot_status' = 'deprecated_duplicate');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` SET TAGS ('dbx_ssot_authoritative' = 'procurement.procurement_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `sales_vmi_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement - Vmi Agreement Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `inventory_vmi_agreement_id` SET TAGS ('dbx_ssot_reference' = 'inventory.inventory_vmi_agreement');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vmi Agreement Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `procurement_vmi_agreement_id` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement - Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Agreement - Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `auto_replenish_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Replenish Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `sales_vmi_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Vmi Agreement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `sales_vmi_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Sales Vmi Agreement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `forecast_sharing_cadence` SET TAGS ('dbx_business_glossary_term' = 'Forecast Sharing Cadence');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `max_inventory_target` SET TAGS ('dbx_business_glossary_term' = 'Max Inventory Target');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `max_inventory_weeks` SET TAGS ('dbx_business_glossary_term' = 'Max Inventory Weeks');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Max Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `min_inventory_target` SET TAGS ('dbx_business_glossary_term' = 'Min Inventory Target');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `min_inventory_weeks` SET TAGS ('dbx_business_glossary_term' = 'Min Inventory Weeks');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Min Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `sales_vmi_agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Vmi Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `ownership_transfer_point` SET TAGS ('dbx_business_glossary_term' = 'Ownership Transfer Point');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `replenishment_model` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Model');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `safety_stock_weeks` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Weeks');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `sales_vmi_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Vmi Agreement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `service_level_target` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `service_level_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`sales_vmi_agreement` ALTER COLUMN `vmi_model_type` SET TAGS ('dbx_business_glossary_term' = 'Vmi Model Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` SET TAGS ('dbx_association_edges' = 'customer.trade_account,sales.rep');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Call - Sales Call Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `call_sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Call - Sales Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Call - Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `activities_completed` SET TAGS ('dbx_business_glossary_term' = 'Activities Completed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual End');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Start');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `call_status` SET TAGS ('dbx_business_glossary_term' = 'Call Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `call_type` SET TAGS ('dbx_business_glossary_term' = 'Call Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `call_code` SET TAGS ('dbx_business_glossary_term' = 'Call Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `call_description` SET TAGS ('dbx_business_glossary_term' = 'Call Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Call Duration');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Required');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `call_name` SET TAGS ('dbx_business_glossary_term' = 'Call Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next Action');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `next_call_date` SET TAGS ('dbx_business_glossary_term' = 'Next Call Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `next_step` SET TAGS ('dbx_business_glossary_term' = 'Next Step');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Call Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `orders_taken_count` SET TAGS ('dbx_business_glossary_term' = 'Orders Taken Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Outcome Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `planned_flag` SET TAGS ('dbx_business_glossary_term' = 'Planned Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Purpose');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `scheduled_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `scheduled_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`call` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` SET TAGS ('dbx_association_edges' = 'customer.trade_account,regulatory.compliance_obligation');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assignment - Compliance Assignment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assignee Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_assigned_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_assigned_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_assigned_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assignment - Compliance Obligation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assignment - Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assignment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `completion_pct` SET TAGS ('dbx_business_glossary_term' = 'Completion Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assignment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_assignment_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assignment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `compliance_assignment_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assignment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`compliance_assignment` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `account_team_id` SET TAGS ('dbx_business_glossary_term' = 'Account Team Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `parent_account_team_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Team Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `parent_account_team_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `account_team_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `associated_account_count` SET TAGS ('dbx_business_glossary_term' = 'Associated Account Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `average_deal_size` SET TAGS ('dbx_business_glossary_term' = 'Average Deal Size');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `account_team_code` SET TAGS ('dbx_business_glossary_term' = 'Account Team Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `account_team_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `is_cross_functional` SET TAGS ('dbx_business_glossary_term' = 'Is Cross Functional');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `is_lead` SET TAGS ('dbx_business_glossary_term' = 'Is Lead');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sync Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `account_team_name` SET TAGS ('dbx_business_glossary_term' = 'Account Team Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `offboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Quota Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `team_color` SET TAGS ('dbx_business_glossary_term' = 'Team Color');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `team_logo_url` SET TAGS ('dbx_business_glossary_term' = 'Team Logo Url');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `team_role` SET TAGS ('dbx_business_glossary_term' = 'Team Role');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Team Size');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `total_accounts` SET TAGS ('dbx_business_glossary_term' = 'Total Accounts');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `total_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_team` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
