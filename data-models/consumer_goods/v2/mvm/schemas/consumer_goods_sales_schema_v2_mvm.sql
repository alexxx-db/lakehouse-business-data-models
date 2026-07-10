-- Schema for Domain: sales | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-07-10 14:48:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`sales` COMMENT 'Owns commercial sales execution, order management, and revenue transactions across all channels (retail, wholesale, DTC, e-commerce). Manages sales orders, pricing agreements, sales force automation (SFA), retail account call records, POG compliance, RSP/MSRP price management, ACV/TDP/SOM metrics, and field sales KPIs. Integrates with Salesforce Consumer Goods Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` (
    `trade_account_id` BIGINT COMMENT 'Unique identifier for the B2B trade account. Primary key for the trade account master record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis assigns each customer to a profit center to aggregate revenue and margin in financial reporting.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Trade accounts (retailers, distributors, wholesalers) are assigned to sales territories for field coverage and quota management. Adding territory_id to trade_account directly captures the primary terr',
    `account_close_date` DATE COMMENT 'The date when this trade account was permanently closed or terminated, if applicable.',
    `account_open_date` DATE COMMENT 'The date when this trade account was first established and approved for business transactions.',
    `account_status` STRING COMMENT 'The current lifecycle status of the trade account: active (operational), inactive (dormant), suspended (temporarily blocked), pending approval (new account under review), credit hold (payment issues), or closed (permanently terminated).. Valid values are `active|inactive|suspended|pending_approval|credit_hold|closed`',
    `account_tier` STRING COMMENT 'Strategic tier classification based on account size, coverage, and business importance: Tier 1 (national key accounts), Tier 2 (regional chains), Tier 3 (local/metro accounts), Tier 4 (independent operators).. Valid values are `tier_1_national|tier_2_regional|tier_3_local|tier_4_independent`',
    `account_type` STRING COMMENT 'The business model classification of the trade partner: retailer (sells to end consumers), distributor (logistics and fulfillment), wholesaler (bulk reseller), foodservice operator (restaurants/catering), or broker (sales intermediary).. Valid values are `retailer|distributor|wholesaler|foodservice_operator|broker`',
    `acv_total` DECIMAL(18,2) COMMENT 'The total All Commodity Volume representing the annual dollar sales volume across all product categories for this retail account, used for market coverage analysis.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding accounts receivable balance allowed for this trade account before credit hold is applied.',
    `credit_rating` STRING COMMENT 'The credit risk rating assigned to this trade account by internal credit management or external credit bureau (e.g., AAA, AA, A, BBB, BB, B, CCC, D).',
    `currency_code` STRING COMMENT 'The 3-letter ISO 4217 currency code for all financial transactions with this trade account (e.g., USD, CAD, EUR, MXN).. Valid values are `^[A-Z]{3}$`',
    `dba_name` STRING COMMENT 'The trade name or DBA name under which the account operates in the market, if different from legal entity name.',
    `dsd_delivery_flag` BOOLEAN COMMENT 'Indicates whether this trade account receives direct store delivery (DSD) shipments bypassing the retailers distribution center.',
    `duns_number` STRING COMMENT 'The 9-digit DUNS number assigned by Dun & Bradstreet for unique identification of the business entity.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether this trade account has EDI connectivity enabled for electronic exchange of purchase orders, invoices, and advance ship notices.',
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
    `otif_sla_target_percent` DECIMAL(18,2) COMMENT 'The contractual OTIF service level agreement target percentage for order fulfillment performance (e.g., 95.00 represents 95% of orders delivered on time and in full).',
    `payment_method` STRING COMMENT 'The primary payment instrument used by this account: ACH (automated clearing house), wire transfer, check, EDI payment (electronic funds transfer via EDI 820), or credit card.. Valid values are `ach|wire_transfer|check|edi_payment|credit_card`',
    `payment_terms_code` STRING COMMENT 'The standard payment terms code governing invoice payment due dates and early payment discounts (e.g., Net 30, Net 60, 2/10 Net 30).',
    `previous_status` STRING COMMENT 'The account status immediately prior to the most recent status change, maintained for audit trail and lifecycle analysis.',
    `primary_contact_email` STRING COMMENT 'The business email address of the primary contact for order management, invoicing, and account communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact or account manager at the trade partner organization.',
    `primary_contact_phone` STRING COMMENT 'The business phone number of the primary contact, including country code and extension if applicable.',
    `primary_language_code` STRING COMMENT 'The 2-letter ISO 639-1 language code for the preferred communication language with this trade account (e.g., en, es, fr, de).. Valid values are `^[a-z]{2}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this trade account master record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this trade account master record was most recently modified.',
    `status_change_reason` STRING COMMENT 'The business reason or justification for the most recent account status change (e.g., payment default, business closure, credit improvement, contract renewal).',
    `status_change_timestamp` TIMESTAMP COMMENT 'The date and time when the most recent account status change occurred.',
    `status_changed_by_user` STRING COMMENT 'The user ID or name of the person who executed the most recent account status change, for audit and accountability purposes.',
    `tax_exemption_flag` BOOLEAN COMMENT 'Indicates whether this trade account holds a valid tax exemption certificate for sales tax or VAT purposes.',
    `tax_number` STRING COMMENT 'The government-issued tax identification number for this legal entity (e.g., EIN in USA, VAT number in EU, GST number in other jurisdictions).',
    `tdp_count` STRING COMMENT 'The total number of distribution points (store locations or outlets) operated by this trade account where products can be sold.',
    `trade_channel` STRING COMMENT 'The primary retail or distribution channel through which this trade account operates: grocery (supermarkets), mass (mass merchandisers), club (warehouse clubs), drug (pharmacy chains), convenience stores, foodservice (restaurants/institutions), or e-commerce (online retailers). [ENUM-REF-CANDIDATE: grocery|mass|club|drug|convenience|foodservice|e-commerce — 7 candidates stripped; promote to reference product]',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this trade account participates in a VMI program where the supplier manages inventory replenishment based on POS or warehouse data.',
    CONSTRAINT pk_trade_account PRIMARY KEY(`trade_account_id`)
) COMMENT 'SSOT master record for all B2B trade customers including retailers, distributors, wholesalers, and foodservice operators. Captures authoritative account identity: legal entity name, trade channel classification (grocery, mass, club, drug, foodservice, e-commerce), account tier, credit rating, payment terms, currency, tax identifiers, DUNS number, GLN (GS1 Global Location Number), primary language, account status, lifecycle dates, and full status change audit history (previous status, new status, change reason, change timestamp, changed-by user). This is the golden record for all trade partner identity — every other customer domain entity references this product via FK.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` (
    `account_contact_id` BIGINT COMMENT 'Unique identifier for the account contact record. Primary key.',
    `reports_to_contact_account_contact_id` BIGINT COMMENT 'Reference to another account contact record representing this contacts direct manager or supervisor within the trade account organization. Enables organizational hierarchy mapping.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: account_contact already has a denormalized territory_code (STRING) field. Replacing this with a proper FK territory_id -> territory.territory_id normalizes the territory reference and enables JOIN-bas',
    `trade_account_id` BIGINT COMMENT 'Reference to the parent trade account (retailer, distributor, wholesaler, or foodservice operator) to which this contact belongs.',
    `assistant_name` STRING COMMENT 'The name of the contacts administrative assistant or executive assistant, if applicable. Used for scheduling and communication routing.',
    `assistant_phone` STRING COMMENT 'The phone number of the contacts administrative assistant. Used for scheduling and communication routing.',
    `contact_notes` STRING COMMENT 'Free-form text field for capturing additional notes, preferences, or context about the contact. Used by sales representatives to document relationship insights.',
    `contact_role` STRING COMMENT 'The contacts role in the buying decision process. Distinguishes between primary decision-makers, influencers, and administrative contacts. Critical for sales force automation and account planning.. Valid values are `primary_buyer|secondary_buyer|decision_maker|influencer|gatekeeper|end_user`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record. Active contacts are currently employed and engaged with the account. Inactive or terminated contacts are retained for historical reference.. Valid values are `active|inactive|on_leave|terminated|transferred`',
    `contact_type` STRING COMMENT 'Classification of the contacts primary functional role at the trade account. Determines which business processes and communications this contact participates in.. Valid values are `buyer|category_manager|logistics_coordinator|finance_contact|marketing_contact|operations_manager`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact record was first created in the system. Used for audit trail and data lineage tracking.',
    `department` STRING COMMENT 'The organizational department or functional area within the trade account where this contact works. Examples include Procurement, Logistics, Finance, Marketing.',
    `effective_end_date` DATE COMMENT 'The date when this contacts role at the trade account ended, if applicable. Null for currently active contacts. Used for historical tracking and relationship continuity.',
    `effective_start_date` DATE COMMENT 'The date when this contact became active in their current role at the trade account. Used for tracking tenure and relationship history.',
    `email_address` STRING COMMENT 'Primary business email address for the contact. Used for commercial communications, order confirmations, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the contact, if applicable. Still used in some trade channels for purchase orders and formal documentation.',
    `first_name` STRING COMMENT 'The given name of the individual contact at the trade account.',
    `full_name` STRING COMMENT 'The complete formatted name of the contact, typically concatenated as first name and last name. Used for display and reporting purposes.',
    `is_decision_maker` BOOLEAN COMMENT 'Boolean flag indicating whether this contact has purchasing authority and decision-making power for the account. True if decision maker, False otherwise.',
    `is_primary_contact` BOOLEAN COMMENT 'Boolean flag indicating whether this contact is the primary point of contact for the trade account. True if primary, False otherwise.',
    `job_title` STRING COMMENT 'The official job title or position held by the contact at the trade account organization. Examples include Senior Buyer, Category Manager, Supply Chain Director.',
    `language_preference` STRING COMMENT 'The contacts preferred language for business communications, represented as a 3-letter ISO 639-2 language code. Examples: ENG (English), SPA (Spanish), FRA (French).. Valid values are `^[A-Z]{3}$`',
    `last_contact_date` DATE COMMENT 'The date of the most recent interaction or communication with this contact. Used to track engagement frequency and identify dormant relationships.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact record was most recently updated. Used for audit trail and change tracking.',
    `last_name` STRING COMMENT 'The family name or surname of the individual contact at the trade account.',
    `linkedin_profile_url` STRING COMMENT 'The URL of the contacts LinkedIn professional profile. Used for social selling and relationship intelligence.',
    `mobile_number` STRING COMMENT 'Mobile or cellular phone number for the contact. Used for urgent communications and field-based retail execution activities.',
    `next_follow_up_date` DATE COMMENT 'The scheduled date for the next planned follow-up or interaction with this contact. Supports proactive account management and sales cadence planning.',
    `opt_in_email` BOOLEAN COMMENT 'Boolean flag indicating whether the contact has opted in to receive commercial email communications. True if opted in, False if opted out. Required for GDPR and CCPA compliance.',
    `opt_in_phone` BOOLEAN COMMENT 'Boolean flag indicating whether the contact has opted in to receive commercial phone communications. True if opted in, False if opted out. Required for telemarketing compliance.',
    `opt_in_sms` BOOLEAN COMMENT 'Boolean flag indicating whether the contact has opted in to receive commercial SMS or text message communications. True if opted in, False if opted out.',
    `phone_number` STRING COMMENT 'Primary business telephone number for the contact. Includes country code, area code, and local number.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method for receiving business communications. Supports personalized engagement strategies in SFA and retail execution workflows.. Valid values are `email|phone|mobile|fax|portal|in_person`',
    `salesforce_user_code` STRING COMMENT 'The Salesforce user ID of the sales representative or account manager responsible for this contact. Links to the internal sales team member managing the relationship.',
    `source_system_code` STRING COMMENT 'The unique identifier for this contact in the source operational system. Used for data reconciliation and integration traceability.',
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
    `city` STRING COMMENT 'City or municipality name for the address location. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code (e.g., USA, CAN, MEX, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field for data governance and compliance.',
    `delivery_instructions` STRING COMMENT 'Special instructions for delivery personnel including receiving hours, dock locations, access codes, contact requirements, and handling instructions. Critical for On Time In Full (OTIF) performance.',
    `dock_door_number` STRING COMMENT 'Specific dock door or bay number for deliveries at warehouse or distribution center locations. Used by carriers and Direct Store Delivery (DSD) drivers.',
    `dsd_route_eligible_flag` BOOLEAN COMMENT 'Indicates whether this location is eligible for Direct Store Delivery (DSD) routing (True) or requires warehouse distribution (False). Critical for route planning and logistics optimization.',
    `edi_location_qualifier` STRING COMMENT 'EDI X12 location qualifier code used in Electronic Data Interchange (EDI) transactions to identify the address role (e.g., ST for ship-to, BT for bill-to, SF for ship-from). Supports automated order processing and Advanced Shipping Notice (ASN) generation.',
    `effective_end_date` DATE COMMENT 'Date when this address was deactivated or replaced. Null indicates the address is currently active. Format: yyyy-MM-dd. Supports address history tracking and audit compliance.',
    `effective_start_date` DATE COMMENT 'Date when this address became active and valid for use in transactions. Format: yyyy-MM-dd. Supports address history tracking and audit compliance.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying this physical location in the global supply chain. 13-digit numeric identifier used for EDI transactions and supply chain visibility.. Valid values are `^[0-9]{13}$`',
    `inactivation_reason` STRING COMMENT 'Business reason for address inactivation (e.g., location closed, address changed, account terminated, consolidation). Used for audit trails and business intelligence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field for data governance and compliance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for geospatial analysis, route optimization, and Direct Store Delivery (DSD) planning. Range: -90.0000000 to +90.0000000.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for geospatial analysis, route optimization, and Direct Store Delivery (DSD) planning. Range: -180.0000000 to +180.0000000.',
    `postal_code` STRING COMMENT 'Postal code, ZIP code, or postcode for mail delivery routing. Format varies by country (e.g., 5-digit ZIP in USA, alphanumeric in Canada/UK). Organizational contact data classified as confidential.',
    `primary_address_flag` BOOLEAN COMMENT 'Indicates whether this is the primary address for the account (True) or a secondary/alternate address (False). Used for default shipping and billing operations.',
    `receiving_hours_end` STRING COMMENT 'End time for receiving deliveries at this location in 24-hour format (HH:mm). Used for delivery scheduling and On Time In Full (OTIF) compliance.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]$`',
    `receiving_hours_start` STRING COMMENT 'Start time for receiving deliveries at this location in 24-hour format (HH:mm). Used for delivery scheduling and On Time In Full (OTIF) compliance.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]$`',
    `source_system_code` STRING COMMENT 'Unique identifier for this address in the source system of record. Used for data reconciliation and bidirectional synchronization.',
    `standardized_address_flag` BOOLEAN COMMENT 'Indicates whether the address has been standardized to postal authority format (True) or remains in original input format (False).',
    `state_province` STRING COMMENT 'State, province, or administrative region code or name. Uses standard postal abbreviations (e.g., CA, NY, ON, QC). Organizational contact data classified as confidential.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction identifier for sales tax, value-added tax (VAT), or goods and services tax (GST) calculation. Used in invoice generation and financial reporting.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for this location (e.g., America/New_York, America/Chicago, Europe/London). Used for delivery scheduling, service level agreement (SLA) tracking, and On Time In Full (OTIF) calculations.',
    CONSTRAINT pk_account_address PRIMARY KEY(`account_address_id`)
) COMMENT 'Physical and mailing addresses associated with a trade account, including headquarters, billing address, ship-to locations, and sold-to locations. Captures address type (HQ, billing, ship-to, sold-to, returns), street, city, state/province, postal code, country, GS1 GLN for the location, geo-coordinates, time zone, and address validation status. Supports EDI ship-to/bill-to mapping and DSD route planning.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` (
    `retail_store_id` BIGINT COMMENT 'Unique identifier for the retail store location. Primary key.',
    `account_address_id` BIGINT COMMENT 'Foreign key linking to sales.account_address. Business justification: retail_store contains a full set of physical address fields (address_line_1, address_line_2, city, state_province, postal_code, country_code, latitude, longitude) that are already modeled in account_a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Store‑level budgeting and expense tracking use a cost center per retail store for internal cost accounting.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Store replenishment process requires an assigned distribution center to schedule deliveries and calculate OTIF performance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Store profitability reporting aggregates sales and costs by profit center, requiring a link from store to profit_center.',
    `trade_account_id` BIGINT COMMENT 'Reference to the parent trade account, banner, or retail chain that owns or operates this store.',
    `acv_weight` DECIMAL(18,2) COMMENT 'All Commodity Volume (ACV) weighting factor representing this stores share of total market volume, used for distribution and market share calculations.',
    `banner_name` STRING COMMENT 'The retail banner or brand under which this store operates (e.g., Walmart Supercenter, Target, Kroger).',
    `close_date` DATE COMMENT 'Date when the store permanently closed or is scheduled to close. Null if store is active.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail store record was first created in the system.',
    `dsd_route_code` STRING COMMENT 'Route code or identifier for Direct Store Delivery (DSD) logistics and delivery scheduling.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying this physical store location for Electronic Data Interchange (EDI) and supply chain transactions.. Valid values are `^[0-9]{13}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail store record was last updated or modified.',
    `last_visit_date` DATE COMMENT 'Date of the most recent retail execution visit or sales call to this store location.',
    `next_scheduled_visit_date` DATE COMMENT 'Date of the next planned retail execution visit or sales call to this store location.',
    `open_date` DATE COMMENT 'Date when the store first opened for business operations.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the store (e.g., Mon-Fri 8am-10pm, Sat-Sun 9am-9pm) used for retail execution visit planning.',
    `osa_target_pct` DECIMAL(18,2) COMMENT 'Target On Shelf Availability (OSA) percentage for this store indicating expected in-stock performance for key Stock Keeping Units (SKUs).',
    `otif_sla_target_pct` DECIMAL(18,2) COMMENT 'Target On Time In Full (OTIF) service level percentage agreed with this store for delivery performance measurement.',
    `planogram_zone` STRING COMMENT 'Planogram zone or cluster assignment indicating which shelf layout and assortment plan applies to this store.',
    `pos_system_type` STRING COMMENT 'Type or vendor of the Point of Sale (POS) system used at this store for transaction processing and sales data capture.',
    `store_format` STRING COMMENT 'The retail format classification of the store indicating size, assortment, and operational model. [ENUM-REF-CANDIDATE: hypermarket|supermarket|convenience|club|drug|dollar|specialty|e-commerce_fulfillment_center — 8 candidates stripped; promote to reference product]',
    `store_name` STRING COMMENT 'The official name or designation of the retail store location.',
    `store_number` STRING COMMENT 'The retailer-assigned unique store number or code used for operational identification and Direct Store Delivery (DSD) routing.',
    `store_phone` STRING COMMENT 'Primary contact phone number for the retail store location.',
    `store_size_sq_ft` STRING COMMENT 'Total retail selling space of the store measured in square feet, used for All Commodity Volume (ACV) and Total Distribution Points (TDP) calculations.',
    `store_status` STRING COMMENT 'Current operational status of the retail store location.. Valid values are `active|inactive|pending_opening|temporarily_closed|permanently_closed|under_renovation`',
    `store_tier` STRING COMMENT 'Strategic tier classification (e.g., Tier 1, Tier 2) indicating store importance based on volume, profitability, or strategic value for prioritized retail execution.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `tdp_weight` DECIMAL(18,2) COMMENT 'Total Distribution Points (TDP) weighting factor representing this stores contribution to numeric distribution metrics.',
    `trading_area` STRING COMMENT 'Geographic trading area or market designation (e.g., metro area, region) used for sales territory and distribution planning.',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this store participates in a Vendor Managed Inventory (VMI) program where the manufacturer manages replenishment.',
    CONSTRAINT pk_retail_store PRIMARY KEY(`retail_store_id`)
) COMMENT 'Individual physical retail store or outlet location associated with a trade account banner or chain. Captures store number, store name, banner, format (hypermarket, supermarket, convenience, club, drug, dollar, e-commerce fulfillment center), store size (sq ft), trading area, store open/close dates, store manager, operating hours, and planogram zone assignment. Used for retail execution, OSA tracking, and DSD route management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`order` (
    `order_id` BIGINT COMMENT 'Unique system identifier for the sales order record. Primary key for the order entity.',
    `account_address_id` BIGINT COMMENT 'Reference to the customer location that receives the invoice and is responsible for payment. May differ from ship-to location.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost Center Allocation report requires each sales order to be charged to a cost center for internal expense tracking.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center assigned to fulfill this order. Determines inventory allocation and shipping origin.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Order‑level Promotion Event Attribution report requires linking each order to the specific promotion event that generated the sale.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.pricing_agreement. Business justification: Orders are governed by a pricing agreement; linking captures contract context.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Required for linking each sales order to the R&D project that created the product, enabling ROI and product launch performance reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales orders must be attributed to profit centers for channel/brand P&L reporting — a core consumer goods finance process. SAP SD-based models always link sales orders to profit centers for revenue re',
    `retail_store_id` BIGINT COMMENT 'Reference to the customer location where goods should be delivered. May differ from bill-to location for multi-site customers.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account manager who created or owns this order. Used for commission calculation and SFA reporting.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Order Fulfillment Allocation report requires linking each order to the supply network node that will source inventory for accurate ATP/CTP calculations.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Directly assigning a territory to an order simplifies reporting and analytics.',
    `trade_account_id` BIGINT COMMENT 'Reference to the customer or retail account that placed this order. Links to the customer master record.',
    `actual_delivery_date` DATE COMMENT 'The actual date when the order was delivered to the customer. Used to calculate OTIF performance and delivery variance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was approved for fulfillment. Marks transition from draft/pending to confirmed status in the order lifecycle.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason for order cancellation if status is cancelled. Used for root cause analysis and process improvement.',
    `channel_type` STRING COMMENT 'The commercial channel through which the order was received. Critical for channel-specific analytics and revenue attribution.. Valid values are `retail|wholesale|dtc|ecommerce|distributor`',
    `cogs_amount` DECIMAL(18,2) COMMENT 'Total cost of goods sold for all items on this order. Used for gross margin calculation and profitability analysis.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by supply chain and logistics based on ATP/CTP availability. Committed date for OTIF tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was first created in the database. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this order. Determines currency for pricing, tax, and totals.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the order including trade promotions, volume discounts, and negotiated price reductions.',
    `distribution_channel` STRING COMMENT 'The distribution channel through which products are sold. Defines the route-to-market and channel-specific pricing rules.. Valid values are `^[A-Z0-9]{2,10}$`',
    `division` STRING COMMENT 'The product division or business unit for this order. Used for divisional P&L reporting and product line segmentation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight and shipping charges applied to the order. May be customer-paid or supplier-absorbed depending on terms.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Gross profit on the order calculated as total revenue less COGS. Key profitability metric for order-level margin analysis.',
    `incoterm` STRING COMMENT 'Three-letter Incoterm code defining the transfer of risk and cost responsibility between buyer and seller. Examples: FOB, CIF, DDP.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was last updated. Used for change tracking and data synchronization across systems.',
    `order_date` DATE COMMENT 'The date when the sales order was placed or created by the customer. Primary business event timestamp for order lifecycle.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the sales order. Used for customer communication and order tracking across systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the sales order indicating its position in the order-to-cash workflow. [ENUM-REF-CANDIDATE: draft|open|confirmed|in_fulfillment|shipped|delivered|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the order based on fulfillment method and business process. Determines routing, pricing, and delivery rules.. Valid values are `standard|rush|drop_ship|direct_store_delivery|promotional|sample`',
    `otif_status` STRING COMMENT 'Indicates whether the order was delivered on time and in full per customer commitment. Key supply chain KPI for customer service measurement.. Valid values are `on_time_in_full|late|partial|not_applicable`',
    `payment_terms` STRING COMMENT 'The payment terms code defining the credit period and discount conditions for this order. Examples: NET30, 2/10NET30.. Valid values are `^[A-Z0-9]{2,10}$`',
    `priority` STRING COMMENT 'Priority classification for order fulfillment. Determines sequencing in warehouse picking and expedited shipping eligibility.. Valid values are `standard|high|urgent|critical`',
    `purchase_order_number` STRING COMMENT 'The customers purchase order number provided at order placement. Required for EDI transactions and invoice matching.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `requested_delivery_date` DATE COMMENT 'The delivery date requested by the customer at the time of order placement. Used for OTIF performance measurement.',
    `sales_office` STRING COMMENT 'The sales office or branch that originated this order. Used for territory management and sales force performance tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sales_organization` STRING COMMENT 'The sales organization responsible for this order. Defines the selling entity and organizational hierarchy for reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sap_sd_document_number` STRING COMMENT 'The native SAP SD sales order document number. Used for system-to-system integration and ERP traceability.. Valid values are `^[0-9]{10}$`',
    `shipping_method` STRING COMMENT 'The transportation mode selected for order delivery. Impacts delivery time, cost, and carrier selection.. Valid values are `ground|air|ocean|rail|courier|dsd`',
    `source` STRING COMMENT 'The system or channel through which the order was originally captured. Used for channel attribution and system integration tracking.. Valid values are `web_portal|edi|sales_rep|call_center|mobile_app|marketplace`',
    `special_instructions` STRING COMMENT 'Free-text field for customer-specific delivery instructions, packaging requirements, or handling notes for warehouse and logistics teams.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before taxes, discounts, and freight charges. Base revenue amount for the order.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the order including sales tax, VAT, GST, and other applicable taxes per jurisdiction.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount for the order including subtotal, taxes, freight, less discounts. The invoiced amount for revenue recognition.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Core sales order record capturing all commercial sales transactions across retail, wholesale, DTC, and e-commerce channels. Contains order header details (order number, date, channel type, status, delivery dates, OTIF status, payment terms, currency, totals, SAP SD document number) and line-level detail (SKU/GTIN, quantities ordered/confirmed/shipped, unit pricing, discounts, trade promotion references, line status, COGS, gross margin, delivery schedule). Serves as the primary transactional backbone of the sales domain enabling both order-level and SKU-level revenue and margin analysis.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system identifier for the invoice record. Primary key.',
    `account_address_id` BIGINT COMMENT 'Reference to the billing address location for this invoice. The address where invoice is sent and payment is remitted from.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: In multi-entity consumer goods companies, invoices are issued by a specific legal entity (company code) — a fundamental SAP SD billing requirement. Company code determines tax jurisdiction, currency, ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial consolidation needs each invoice posted to the responsible cost center for accurate profit analysis.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Invoice‑level trade spend reconciliation needs to reference the promotion event responsible for the invoiced sales.',
    `gl_account_id` BIGINT COMMENT 'add column gl_account_id (BIGINT) with FK to finance.gl_account.gl_account_id - invoices need GL account posting references for revenue recognition',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.pricing_agreement. Business justification: Invoice billing often follows a pricing agreement; linking provides traceability.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Invoices must be assigned to profit centers for revenue recognition and P&L reporting by brand/channel/division. Consumer goods finance teams require invoice-level profit center attribution for trade ',
    `retail_store_id` BIGINT COMMENT 'Reference to the physical delivery location where goods were shipped. May differ from bill-to account for multi-site customers.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order that this invoice fulfills. Links invoice to order for order-to-cash reconciliation.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: Invoices reference specific shipments for freight charge reconciliation, proof-of-delivery disputes, and billing validation. Essential for consumer goods accounts receivable and logistics billing proc',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distributor, or DTC consumer who is billed on this invoice. The sold-to party in the order-to-cash process.',
    `billing_period_end_date` DATE COMMENT 'End date of the period covered by this invoice. Used for period-based billing and revenue allocation.',
    `billing_period_start_date` DATE COMMENT 'Start date of the period covered by this invoice. Relevant for subscription, service, or recurring billing scenarios.',
    `billing_type` STRING COMMENT 'Classification of the invoice document type: standard invoice for goods/services, credit memo for returns/adjustments, debit memo for additional charges, proforma for advance notice, intercompany for internal transfers, or consignment for stock-based billing.. Valid values are `standard|credit_memo|debit_memo|proforma|intercompany|consignment`',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was cancelled or voided. Null for active invoices. Used for cancelled invoice reporting and audit.',
    `cost_of_goods_sold_amount` DECIMAL(18,2) COMMENT 'Total standard cost of all products billed on this invoice. Used for gross margin calculation and profitability analysis at invoice level.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was first created in the billing system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). All monetary amounts on this invoice are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `days_sales_outstanding` STRING COMMENT 'Number of days between invoice date and payment date (or current date if unpaid). Key metric for working capital management and customer payment behavior analysis.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator that the customer has raised a dispute or deduction claim against this invoice. Triggers collections hold and dispute resolution workflow.',
    `dispute_reason_code` STRING COMMENT 'Standardized code categorizing the reason for invoice dispute. Enables root cause analysis of deductions and customer dissatisfaction. [ENUM-REF-CANDIDATE: pricing|quantity|quality|delivery|promotion|damaged_goods|not_received — 7 candidates stripped; promote to reference product]',
    `distribution_channel_code` STRING COMMENT 'Code representing the distribution channel through which the sale was made (e.g., retail, wholesale, DTC, e-commerce). Enables channel-specific revenue analysis.. Valid values are `^[A-Z0-9]{2,4}$`',
    `division_code` STRING COMMENT 'Code identifying the product division or business unit to which invoice revenue is attributed. Supports divisional P&L reporting.. Valid values are `^[A-Z0-9]{2,4}$`',
    `due_date` DATE COMMENT 'The date by which payment is expected per the agreed payment terms. Used for DSO tracking and collections management.',
    `edi_document_number` STRING COMMENT 'Unique EDI transaction control number assigned when invoice is transmitted via EDI 810. Used for EDI audit trail and error resolution.',
    `edi_transmission_status` STRING COMMENT 'Status of EDI 810 invoice transmission to customers system. Tracks electronic invoice delivery for large retail and distributor accounts.. Valid values are `not_applicable|pending|transmitted|acknowledged|rejected|failed`',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight, shipping, and logistics charges added to the invoice. May be separately itemized for customer transparency.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice value before any deductions, including all line items, charges, and fees but before trade discounts and taxes.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Gross profit on this invoice, calculated as net_amount minus cost_of_goods_sold_amount. Key profitability metric for customer and product analysis.',
    `incoterm_code` STRING COMMENT 'Three-letter Incoterm code defining the division of costs and risks between buyer and seller (e.g., FOB, CIF, DDP). Critical for international trade invoicing.. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'The date the invoice was officially issued to the customer. This is the accounting date used for revenue recognition and aging calculations.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice document number used for customer communication, payment reconciliation, and accounts receivable tracking. Typically follows company-specific numbering scheme.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current state of the invoice in the accounts receivable lifecycle. Tracks progression from draft through payment completion or dispute resolution. [ENUM-REF-CANDIDATE: draft|issued|sent|partially_paid|paid|overdue|cancelled|disputed — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this invoice record. Tracks changes for audit and data quality monitoring.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final invoice total after all discounts, charges, and taxes. This is the amount due from the customer and recorded in accounts receivable.',
    `notes` STRING COMMENT 'Free-text field for special instructions, billing notes, dispute comments, or customer-specific messaging that appears on the invoice document.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Calculated as net_amount minus paid_amount. Used for aging analysis and collections prioritization.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Cumulative amount received against this invoice across all payment transactions. Used to calculate outstanding balance.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used (or expected) for settling this invoice. Influences payment processing and reconciliation workflows. [ENUM-REF-CANDIDATE: wire_transfer|ach|check|credit_card|edi_payment|cash|direct_debit — 7 candidates stripped; promote to reference product]',
    `payment_reference_number` STRING COMMENT 'External payment reference number provided by the customer or payment processor for reconciliation. Links invoice to bank statement or remittance advice.',
    `payment_status` STRING COMMENT 'Current payment settlement status indicating whether the invoice has been paid in full, partially, or remains outstanding.. Valid values are `unpaid|partially_paid|paid|overpaid|written_off`',
    `payment_terms_code` STRING COMMENT 'Standard code representing the payment terms agreement (e.g., Net 30, Net 60, 2/10 Net 30). Determines due date calculation and early payment discount eligibility.. Valid values are `^[A-Z0-9]{2,10}$`',
    `purchase_order_number` STRING COMMENT 'Customers purchase order number that authorized this invoice. Required for PO-based invoicing and three-way match reconciliation.',
    `revenue_recognition_category` STRING COMMENT 'Classification determining how revenue from this invoice is recognized per accounting standards (ASC 606 / IFRS 15). Drives financial reporting and revenue allocation logic.. Valid values are `point_in_time|over_time|deferred|subscription|service`',
    `sales_organization_code` STRING COMMENT 'Code identifying the sales organization unit responsible for this invoice. Used for revenue attribution and sales performance reporting.. Valid values are `^[A-Z0-9]{2,6}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Sum of all tax amounts (sales tax, VAT, GST, excise) applied to the invoice. Calculated based on tax jurisdiction and product tax classification.',
    `trade_discount_amount` DECIMAL(18,2) COMMENT 'Total trade promotion discounts, volume rebates, and negotiated price reductions applied at invoice level. Reduces gross amount to arrive at net taxable amount.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Commercial billing document issued to retail accounts, distributors, or DTC consumers upon order fulfillment. Contains invoice header (invoice number, date, billing type, payment terms, gross/net values, tax, currency, payment status, DSO tracking, EDI status) and line-level detail (SKU/GTIN, billed quantities, unit prices, trade discounts, net line values, tax codes, revenue recognition categories, COGS allocation). Links to the originating sales order and serves as the accounts receivable source record enabling SKU-level revenue and profitability reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` (
    `pricing_agreement_id` BIGINT COMMENT 'Unique identifier for the pricing agreement record. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand-level pricing agreements are a named business construct in consumer goods — retailers negotiate brand-wide promotional allowances, brand-level rebates, and brand distribution commitments. This l',
    `funding_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.funding_agreement. Business justification: Pricing agreements for promotional allowances and rebates are financially backed by funding agreements. Finance teams reconcile contracted pricing terms against funded trade spend commitments for accu',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pricing agreements are negotiated per brand for trade accounts; brand-level pricing is required for contract management.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.product_hierarchy. Business justification: Pricing agreements are defined per product hierarchy to set prices for all SKUs within that hierarchy; essential for price‑setting reports.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: A pricing agreement is a negotiated deviation from a standard price list. Linking pricing_agreement.price_list_id -> price_list.price_list_id establishes the base price list from which the contractual',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Trade pricing agreements (volume discounts, promotional allowances) are scoped to profit centers for trade spend budgeting and accrual management — a critical consumer goods finance process. Finance t',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Pricing agreements in consumer goods are negotiated and owned by specific sales representatives or key account managers. Adding rep_id to pricing_agreement captures the accountable rep for the contrac',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-level pricing agreements are standard in consumer goods trade terms — account-specific net prices, promotional prices, and volume discounts are negotiated per SKU. This link enables SKU-level pric',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Pricing agreements for ingredients or co-manufacturing contracts specify quality requirements (e.g., Grade A only, meets Spec XYZ). Links commercial terms to enforceable quality standards for supp',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: In CPG private-label and exclusive-supply arrangements, a customer pricing agreement is tied to a specific supplier who manufactures the product. Supply risk assessment, margin analysis, and sourcing ',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distributor, or wholesale customer with whom this pricing agreement is established.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Pricing agreements define contracted net prices and allowances; trade promotions drive promotional pricing for the same account. Revenue management teams link these to ensure promotional discounts don',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the pricing agreement for business reference and reporting.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the pricing agreement, used in contracts and SAP SD condition records.. Valid values are `^[A-Z0-9]{8,20}$`',
    `agreement_type` STRING COMMENT 'Classification of the pricing agreement structure: standard pricing, volume-based tiered discounts, promotional allowances, rebate structures, long-term contract, or spot pricing.. Valid values are `standard|volume_tiered|promotional|rebate|contract|spot`',
    `approval_status` STRING COMMENT 'Current approval workflow status indicating whether the pricing agreement has been reviewed and authorized by management.. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or executive who approved the pricing agreement.',
    `approved_date` DATE COMMENT 'Date when the pricing agreement was formally approved by authorized personnel.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the pricing agreement automatically renews upon expiration unless terminated by either party.',
    `base_list_price` DECIMAL(18,2) COMMENT 'Standard manufacturer list price before any discounts, allowances, or negotiated reductions are applied.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the legal contract document or master agreement associated with this pricing agreement.',
    `contracted_net_price` DECIMAL(18,2) COMMENT 'Agreed net price per unit after applying all negotiated discounts and allowances as defined in the pricing agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all pricing amounts in this agreement are denominated.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount off the base list price granted to the customer under this pricing agreement.',
    `distribution_channel` STRING COMMENT 'Distribution channel through which products under this pricing agreement are sold (e.g., retail, wholesale, DTC, e-commerce).',
    `division` STRING COMMENT 'Product division or business unit to which this pricing agreement applies.',
    `effective_end_date` DATE COMMENT 'Date when the pricing agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the pricing agreement becomes active and enforceable for order pricing.',
    `geographic_scope` STRING COMMENT 'Geographic region or territory where this pricing agreement is valid and enforceable.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required per transaction to qualify for the contracted pricing under this agreement.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum monetary value required per order to qualify for the contracted pricing terms.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the pricing agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing agreement record was last modified or updated.',
    `msrp_price` DECIMAL(18,2) COMMENT 'Manufacturer suggested retail price for consumer-facing pricing, used for price positioning and margin calculation.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or clarifications related to the pricing agreement.',
    `payment_terms` STRING COMMENT 'Agreed payment terms defining the due date and discount conditions (e.g., Net 30, 2/10 Net 30).',
    `price_protection_flag` BOOLEAN COMMENT 'Indicates whether the customer is protected from price increases during the agreement period.',
    `pricing_agreement_status` STRING COMMENT 'Current lifecycle status of the pricing agreement indicating its operational state and enforceability.. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `pricing_tier` STRING COMMENT 'Tiered pricing level assigned to the customer based on volume commitments, strategic importance, or negotiated terms.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|custom`',
    `product_scope` STRING COMMENT 'Defines the breadth of product coverage: all products, specific product category, individual SKUs, or brand-level pricing.. Valid values are `all_products|product_category|specific_skus|brand`',
    `promotional_allowance` DECIMAL(18,2) COMMENT 'Additional allowance or discount provided to support trade promotions, in-store displays, or marketing activities.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Fixed monetary rebate amount granted per unit or per transaction under the pricing agreement terms.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Percentage rebate granted to the customer upon achieving volume thresholds or other performance criteria defined in the agreement.',
    `rsp_price` DECIMAL(18,2) COMMENT 'Manufacturer recommended selling price to be used by the retailer or distributor at point of sale.',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for managing and executing this pricing agreement.',
    `volume_threshold_quantity` DECIMAL(18,2) COMMENT 'Minimum order or cumulative purchase quantity required to qualify for the contracted pricing tier or volume-based discount.',
    `volume_threshold_uom` STRING COMMENT 'Unit of measure for the volume threshold quantity (e.g., EA for each, CS for case, PAL for pallet).. Valid values are `^[A-Z]{2,3}$`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the pricing agreement record.',
    CONSTRAINT pk_pricing_agreement PRIMARY KEY(`pricing_agreement_id`)
) COMMENT 'Contractual pricing arrangement established with a retail account, distributor, or wholesale customer defining agreed RSP/MSRP, net pricing, volume-based tiered discounts, promotional allowances, and rebate structures. Captures agreement number, effective start/end dates, pricing tier, base list price, contracted net price, volume thresholds, rebate percentage, payment terms, currency, and approval status. Source of truth for customer-specific pricing in SAP SD condition records.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` (
    `pos_transaction_id` BIGINT COMMENT 'Unique identifier for the point-of-sale transaction record. Primary key for the POS transaction entity.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Post-event ROI analysis requires reconciling POS scan-level actuals (units_sold, retail_selling_price) against promotion_event planned/actual volumes. TPM analysts use this link to validate promotiona',
    `order_id` BIGINT COMMENT 'add column order_id (BIGINT) with FK to sales.order.order_id - POS transactions should trace back to sales orders where applicable',
    `promoted_price_id` BIGINT COMMENT 'Foreign key linking to promotion.promoted_price. Business justification: Trade promotion compliance verification requires confirming the retailer scanned at the contracted promoted price. Linking POS transactions to promoted_price enables price compliance audits, scan-back',
    `retail_store_id` BIGINT COMMENT 'Identifier of the specific retail store or outlet where the consumer purchase occurred.',
    `sku_id` BIGINT COMMENT 'Identifier of the product sold in this transaction. Links to the product master.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retail account or customer where the transaction occurred. Links to the trade account master.',
    `acv_flag` BOOLEAN COMMENT 'Indicates whether this store is included in the All Commodity Volume (ACV) universe for weighted distribution calculations. Used for Total Distribution Points (TDP) and ACV metrics.',
    `baseline_sales_flag` BOOLEAN COMMENT 'Indicates whether the transaction represents baseline (non-promotional) sales. Used to separate baseline from incremental promotional volume in Trade Promotion Management (TPM) analysis.',
    `channel_type` STRING COMMENT 'The retail channel classification where the transaction occurred (e.g., Grocery, Mass Merchandiser, Drug, Convenience, Club, Dollar, Online, Specialty). Used for channel performance analysis. [ENUM-REF-CANDIDATE: grocery|mass_merchandiser|drug|convenience|club|dollar|online|specialty — 8 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the transaction monetary values.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A quality score (0-100) assigned to the transaction record based on completeness, accuracy, and timeliness of the source data. Used for data reliability assessment.',
    `data_source` STRING COMMENT 'The source system or provider from which the POS transaction data was obtained (e.g., Nielsen IQ, IRI/Circana, Retailer EDI, Retailer Portal, TradeEdge, Internal).. Valid values are `nielsen_iq|iri_circana|retailer_edi|retailer_portal|tradeedge|internal`',
    `data_source_file_code` STRING COMMENT 'The identifier of the source data file or feed from which this transaction record was extracted. Used for data lineage and reconciliation.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to this transaction due to promotional activity. Used for promotional effectiveness analysis.',
    `ean` STRING COMMENT 'The 13-digit European Article Number identifying the product. International standard barcode identifier.. Valid values are `^d{13}$`',
    `extended_retail_value` DECIMAL(18,2) COMMENT 'The total retail sales value for this transaction line (units sold multiplied by retail selling price). Core metric for revenue and market share analysis.',
    `gtin` STRING COMMENT 'The Global Trade Item Number (GTIN-8, GTIN-12, GTIN-13, or GTIN-14) identifying the product sold. Standardized product identifier for cross-retailer analysis.. Valid values are `^d{8}$|^d{12}$|^d{13}$|^d{14}$`',
    `market_name` STRING COMMENT 'The designated market area or geographic market classification for the store location. Used for market-level Share of Market (SOM) analysis.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, annotations, or data quality observations related to the transaction record.',
    `out_of_stock_flag` BOOLEAN COMMENT 'Indicates whether an out-of-stock condition was detected at the store during the transaction period. Used for On-Shelf Availability (OSA) monitoring.',
    `processed_timestamp` TIMESTAMP COMMENT 'The timestamp when the POS transaction record was processed and loaded into the lakehouse silver layer. Used for data pipeline monitoring.',
    `product_description` STRING COMMENT 'Textual description of the product as provided by the data source. May include brand, variant, and size information.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether the product was sold under a promotional offer or trade promotion at the time of transaction. Used for Trade Promotion Optimization (TPO) analysis.',
    `received_timestamp` TIMESTAMP COMMENT 'The timestamp when the POS transaction data was received from the source system or data provider. Used for data latency monitoring.',
    `reporting_period` STRING COMMENT 'The granularity or aggregation period of the POS data as provided by the source (e.g., Daily, Weekly, Monthly). Varies by syndicated data provider.. Valid values are `daily|weekly|monthly`',
    `retail_selling_price` DECIMAL(18,2) COMMENT 'The per-unit retail price at which the product was sold to the consumer. Used for price compliance monitoring against Recommended Selling Price (RSP) and Manufacturer Suggested Retail Price (MSRP).',
    `retailer_name` STRING COMMENT 'The name of the retail chain or banner where the transaction occurred. Used for retailer scorecard reporting.',
    `sku` STRING COMMENT 'The retailer-specific Stock Keeping Unit code identifying the product variant sold. May differ from manufacturer SKU.',
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
    `upc` STRING COMMENT 'The 12-digit Universal Product Code scanned at the point of sale. North American standard barcode identifier.. Valid values are `^d{12}$`',
    `week_ending_date` DATE COMMENT 'The Saturday date marking the end of the reporting week for weekly aggregated POS data. Standard for Nielsen IQ and IRI/Circana weekly reporting.',
    CONSTRAINT pk_pos_transaction PRIMARY KEY(`pos_transaction_id`)
) COMMENT 'Point-of-sale sell-through transaction representing consumer purchases at retail outlets, capturing secondary sales (offtake) data sourced from syndicated data providers (Nielsen IQ, IRI/Circana), retailer EDI/portal feeds, or TradeEdge. Records transaction date, store/retailer, SKU/GTIN, units sold, retail selling price, extended retail value, promotional flag, channel type, and data source. Enables demand sensing, on-shelf availability (OSA) monitoring, ACV/TDP/SOM metric computation, and retailer scorecard reporting. Granularity varies by source from store-day-SKU to week-account-SKU.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` (
    `return_order_id` BIGINT COMMENT 'Unique identifier for the return order record. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Return processing requires identifying the original batch for quality assessment and potential recall actions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for recall processing: return orders must reference active product recall to manage returned items per compliance.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Returns of promoted goods must be reconciled against the originating promotion_event to adjust accrual balances, reverse promotional allowances, and resolve deduction disputes. Trade finance teams req',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Return orders generate credit memos posted to specific GL accounts (sales returns, allowances). Consumer goods finance requires direct GL account assignment on return orders for accurate revenue rever',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt. Business justification: Returned goods create inbound receipts at the DC for putaway and inventory reconciliation. Essential for tracking return disposition, quality inspection results, and restocking decisions.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: A return order generates a credit memo, which is represented as an invoice (credit type) in the sales domain. Linking return_order.invoice_id -> invoice.invoice_id normalizes the credit memo reference',
    `order_id` BIGINT COMMENT 'Reference to the original sales order that this return is associated with.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Connects returns to the originating R&D project for post‑launch quality and satisfaction analysis.',
    `product_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.product_complaint. Business justification: Return processing links to product complaints for root‑cause analysis and corrective action tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Return orders reduce net revenue and must be attributed to profit centers for accurate brand/channel P&L. Consumer goods finance teams track returns by profit center to measure net revenue and gross m',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Return orders originate from specific retail store locations. While the originating_sales_order_id -> order -> retail_store_id path exists, a direct FK on return_order enables efficient store-level re',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Returns must be routed to specific DCs for inspection, restocking, or disposal. Critical for reverse logistics, quality control, and inventory management in consumer goods operations.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Consumer goods returns must be routed to specific network nodes (distribution centers, co-packers, disposal facilities) for quality inspection, restocking, or destruction. Critical for reverse logisti',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Return orders must reference the exact SKU being returned for warranty, credit, and compliance processing; used in return analytics.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distributor, or DTC consumer initiating the return.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Additional adjustments applied to the return value (e.g., damage deductions, handling fees, promotional credits).',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier used for reverse shipment of the returned goods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return order record was first created in the system.',
    `credit_memo_issued_date` DATE COMMENT 'Date when the credit memo was officially issued to the customer.',
    `credit_memo_posted_date` DATE COMMENT 'Date when the credit memo was posted to the general ledger for financial settlement.',
    `credit_memo_status` STRING COMMENT 'Current status of the credit memo in the accounts receivable settlement process. [ENUM-REF-CANDIDATE: not_requested|requested|approved|issued|posted|rejected|cancelled — 7 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this return order.. Valid values are `^[A-Z]{3}$`',
    `customer_responsible_flag` BOOLEAN COMMENT 'Indicates whether the customer is financially responsible for the return (True) or the business absorbs the cost (False).',
    `disposition_instruction` STRING COMMENT 'Instruction for handling the returned goods based on inspection results and business rules. [ENUM-REF-CANDIDATE: return_to_stock|destroy|rework|donate|quarantine|return_to_vendor|scrap — 7 candidates stripped; promote to reference product]',
    `distribution_channel` STRING COMMENT 'SAP distribution channel code through which the original sale and return are processed.. Valid values are `^[A-Z0-9]{2}$`',
    `division` STRING COMMENT 'SAP division code representing the product line or business unit.. Valid values are `^[A-Z0-9]{2}$`',
    `goods_received_date` DATE COMMENT 'Date when the returned goods were physically received at the return processing facility or warehouse.',
    `inspection_completed_date` DATE COMMENT 'Date when quality inspection of the returned goods was completed.',
    `inspector_name` STRING COMMENT 'Name of the quality inspector who performed the inspection of returned goods.',
    `lot_batch_number` STRING COMMENT 'Manufacturing lot or batch number of the returned product for traceability.. Valid values are `^[A-Z0-9]{6,20}$`',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this return order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this return order record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the return.',
    `original_unit_price` DECIMAL(18,2) COMMENT 'Original unit price at which the product was sold in the originating sales order.',
    `quality_inspection_result` STRING COMMENT 'Result of the quality inspection performed on the returned goods.. Valid values are `passed|failed|partial|not_inspected`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing and restocking the returned goods, if applicable.',
    `return_authorization_date` DATE COMMENT 'Date when the return was officially authorized by the business for processing.',
    `return_authorization_number` STRING COMMENT 'Externally-known unique authorization number issued for this return request. Format: RMA-XXXXXXXX.. Valid values are `^RMA-[A-Z0-9]{8,12}$`',
    `return_order_type` STRING COMMENT 'Classification of the return based on the originating channel: retail account, distributor, direct-to-consumer, or wholesale.. Valid values are `retail_account_return|distributor_return|dtc_consumer_return|wholesale_return`',
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
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by the carrier for the return shipment.. Valid values are `^[A-Z0-9]{10,30}$`',
    `warehouse_location_code` STRING COMMENT 'Code identifying the warehouse or distribution center where the returned goods were received.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this return order record.',
    CONSTRAINT pk_return_order PRIMARY KEY(`return_order_id`)
) COMMENT 'Sales return authorization and credit memo request capturing product returns from retail accounts, distributors, or DTC consumers. Records return authorization number, return reason code (damaged in transit/expired/shelf-life rejection/overstock/quality defect/wrong item shipped/recall), return date, originating order reference, returned SKU/GTIN, returned quantity, return value, restocking fee if applicable, credit memo status (requested/approved/issued/posted), and disposition instruction (return to stock/destroy/rework/donate). Tracks reverse logistics triggers and financial credit processing for AR settlement.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Primary key for territory',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Sales territories are aligned to specific DCs for logistics efficiency, service level commitments, and route planning. Essential for territory design, OTIF performance tracking, and DSD route assignme',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: In consumer goods field sales, territories are frequently defined by category scope (e.g., personal care territory vs. home care territory). This link drives category-specific quota assignment, territ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales territories map to profit centers for regional P&L reporting and quota-to-profit-center alignment. Consumer goods companies structure territories to mirror financial reporting units, enabling te',
    `account_count` STRING COMMENT 'Total number of retail trade accounts assigned to this territory. Used for workload balancing and territory design.',
    `acv_coverage` DECIMAL(18,2) COMMENT 'Estimated All Commodity Volume (ACV) represented by the retail accounts in this territory, expressed in currency. ACV measures the total sales volume of all products sold through the retail outlets in the territory, used for market potential assessment.',
    `annual_quota_amount` DECIMAL(18,2) COMMENT 'Annual sales quota or revenue target assigned to this territory, expressed in the companys reporting currency. Used for sales performance management and incentive compensation.',
    `call_frequency_days` STRING COMMENT 'Standard call frequency in days for sales representative visits to accounts in this territory (e.g., 7 for weekly, 14 for bi-weekly, 30 for monthly). Used for SFA route planning.',
    `channel_assignment` STRING COMMENT 'Primary retail channel or trade class that this territory covers. Aligns with consumer goods distribution channels including grocery, drug, mass merchandiser, club, convenience, e-commerce, and Direct-to-Consumer (DTC). [ENUM-REF-CANDIDATE: grocery|drug|mass|club|convenience|e_commerce|foodservice|wholesale|dtc|multi_channel — 10 candidates stripped; promote to reference product]',
    `territory_code` STRING COMMENT 'Business identifier code for the territory used in sales force automation and reporting systems. Typically alphanumeric and unique across the organization.. Valid values are `^[A-Z0-9]{3,12}$`',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the primary country of the territory (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system. Used for audit trail and data lineage.',
    `distribution_channel` STRING COMMENT 'Distribution channel code from the ERP system representing the route-to-market for this territory (e.g., Retail, Wholesale, E-Commerce). Aligns with SAP distribution channel master data.',
    `district` STRING COMMENT 'Mid-level geographic or organizational district within a region. Represents a grouping of territories managed by a district sales manager.',
    `division` STRING COMMENT 'Business division or product line that this territory supports (e.g., Personal Care, Home Care, Beauty). Used for division-level sales reporting and product scope definition.',
    `dsd_eligible_flag` BOOLEAN COMMENT 'Indicates whether the territory includes accounts eligible for Direct Store Delivery (DSD) distribution model, where products are delivered directly to retail stores bypassing distribution centers.',
    `edi_capability_flag` BOOLEAN COMMENT 'Indicates whether the majority of accounts in this territory support Electronic Data Interchange (EDI) for automated order processing, invoicing, and inventory management.',
    `effective_end_date` DATE COMMENT 'Date when the territory definition expires or is deactivated. Null for open-ended territories.',
    `effective_start_date` DATE COMMENT 'Date when the territory definition becomes active and operational for sales assignment and quota allocation.',
    `geographic_scope` STRING COMMENT 'Textual description of the geographic boundaries or coverage area of the territory (e.g., New York, New Jersey, Connecticut, California North, National - Walmart).',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the territory record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was last modified. Used for audit trail and change tracking.',
    `territory_name` STRING COMMENT 'Human-readable name of the sales territory, typically reflecting geographic region or account grouping (e.g., Northeast Metro, California Key Accounts).',
    `notes` STRING COMMENT 'Free-text notes or comments about the territory, including special handling instructions, account nuances, or historical context.',
    `pog_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether field sales representatives in this territory are required to monitor and enforce Planogram (POG) compliance for product placement and shelf merchandising.',
    `postal_code_list` STRING COMMENT 'Comma-separated or structured list of postal codes included in this territory. Used for precise geographic assignment and routing optimization.',
    `priority_tier` STRING COMMENT 'Strategic priority classification of the territory based on revenue potential, account importance, or growth opportunity. Tier 1 or Strategic territories receive higher resource allocation and management attention.. Valid values are `tier_1|tier_2|tier_3|strategic|standard`',
    `quota_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `region` STRING COMMENT 'Higher-level geographic or organizational region to which this territory belongs (e.g., Northeast, West Coast, EMEA). Used for regional sales rollup and management hierarchy.',
    `sales_organization` STRING COMMENT 'Sales organization code or identifier from the ERP system (e.g., SAP Sales Organization) that owns this territory. Used for financial and organizational reporting.',
    `state_province_list` STRING COMMENT 'Comma-separated list of states or provinces covered by this territory (e.g., NY,NJ,CT or CA,NV,AZ). Used for state-level sales reporting and compliance.',
    `store_count` STRING COMMENT 'Total number of retail store locations (points of distribution) within this territory. Key metric for coverage planning and Sales Force Automation (SFA) routing.',
    `tdp_coverage` STRING COMMENT 'Total Distribution Points (TDP) covered by this territory, representing the number of stores where the companys products are authorized for distribution. Critical metric for distribution reach and On-Shelf Availability (OSA).',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory. Active territories are operational and assigned to sales representatives; inactive territories are no longer in use; pending territories are being set up.. Valid values are `active|inactive|pending|suspended|archived`',
    `territory_type` STRING COMMENT 'Classification of the territory based on sales coverage model. Field territories cover geographic regions with multiple accounts; key account territories focus on strategic retail partners; national account territories manage enterprise-wide relationships.. Valid values are `field|key_account|national_account|regional|district|channel`',
    `trade_class` STRING COMMENT 'Detailed trade classification or sub-channel segmentation within the primary channel (e.g., Supermarket, Drug Chain, Dollar Store, Online Pure Play). Used for granular channel analytics.',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether accounts in this territory participate in Vendor Managed Inventory (VMI) programs where the manufacturer manages inventory replenishment at retail locations.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the territory record. Used for audit trail and accountability.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Geographic and account-based sales territory definition used to assign field sales representatives and key account managers to specific retail accounts, geographic regions, or channel segments. Captures territory code, name, region, district, channel assignment (grocery/drug/mass/club/convenience/e-commerce), territory type (field/key account/national account), channel characteristics (trade class, EDI capability, DSD eligibility), active status, effective dates, and assigned quota. Master reference for SFA routing, field sales KPI attribution, and channel-level segmentation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key for rep',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: HR reporting aligns each sales rep with an org unit for headcount, budgeting, and compensation.',
    `manager_rep_id` BIGINT COMMENT 'Reference to the sales representative record of this reps direct manager. Supports hierarchical reporting and approval workflows in the sales organization.',
    `product_category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Consumer goods sales reps are routinely specialized by product category (personal care rep, home care rep, food & beverage rep). This link enables category-specific quota setting, commission calculati',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales reps are assigned to profit centers for sales force cost allocation and quota-to-P&L mapping. Consumer goods companies attribute rep compensation and quota attainment to profit centers for brand',
    `territory_id` BIGINT COMMENT 'Reference to the assigned sales territory. Defines the geographic or account-based scope of responsibility for this sales representative.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Field sales reps are accountable for executing trade promotions in their assigned accounts. Linking rep to trade_promotion enables promotion execution compliance reporting, rep performance scoring aga',
    `badge_number` STRING COMMENT 'Physical security badge or identification number issued to the sales representative. Used for facility access and field audit verification.',
    `certification_status` STRING COMMENT 'Status of required sales certifications or training completions (e.g., product knowledge, compliance training, safety certifications). Certified indicates all requirements met; pending indicates training in progress; expired indicates recertification needed; not_required for roles without certification mandates.. Valid values are `certified|pending|expired|not_required`',
    `channel_specialization` STRING COMMENT 'Primary sales channel focus for this representative. Retail covers traditional grocery and drug stores; wholesale covers distributors; DTC (Direct to Consumer) covers company-owned stores and online; e-commerce covers digital marketplaces; foodservice covers restaurants and institutions; convenience covers c-stores and gas stations; mass merchandise covers big-box retailers. [ENUM-REF-CANDIDATE: retail|wholesale|dtc|ecommerce|foodservice|convenience|mass_merchandise — 7 candidates stripped; promote to reference product]',
    `commission_plan_code` STRING COMMENT 'Identifier for the commission or incentive compensation plan assigned to this sales representative. Links to the compensation management system for payout calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_quota_amount` DECIMAL(18,2) COMMENT 'Current sales quota target amount for the active quota period. Measured in the sales organizations reporting currency. Used for performance tracking and commission calculation.',
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
    `notes` STRING COMMENT 'Free-text field for additional information about the sales representative, such as special skills, territory transition notes, or temporary assignments.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the sales representative. Exceeds indicates above-quota performance; meets indicates on-target; below indicates under-performing; new_hire indicates insufficient tenure for rating.. Valid values are `exceeds|meets|below|new_hire`',
    `quota_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the quota amount. Typically matches the sales organizations reporting currency.. Valid values are `^[A-Z]{3}$`',
    `quota_period` STRING COMMENT 'Frequency at which sales quotas are assigned and measured for this representative. Monthly quotas are typical for field sales; quarterly for key accounts; annual for national accounts.. Valid values are `monthly|quarterly|annual`',
    `rep_number` STRING COMMENT 'Business identifier for the sales representative, typically assigned by the sales organization. Used in Salesforce Consumer Goods Cloud and SAP S/4HANA SD module for sales force automation and order capture.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rep_status` STRING COMMENT 'Current lifecycle status of the sales representative. Active reps are assigned territories and quotas; inactive reps are temporarily not selling; on_leave indicates approved absence; suspended indicates disciplinary hold; terminated indicates employment ended.. Valid values are `active|inactive|on_leave|suspended|terminated`',
    `rep_type` STRING COMMENT 'Classification of the sales representative role. Field sales covers territory-based retail execution; key account manager handles strategic retail accounts; national account manager manages top-tier national chains; inside sales supports telesales and e-commerce; DSD (Direct Store Delivery) driver combines delivery and merchandising; regional manager oversees field teams.. Valid values are `field_sales|key_account_manager|national_account_manager|inside_sales|dsd_driver|regional_manager`',
    `sales_group` STRING COMMENT 'SAP S/4HANA SD sales group code. Represents the functional team or product line focus within the sales organization (e.g., health and beauty, household care, personal care).',
    `sales_office` STRING COMMENT 'SAP S/4HANA SD sales office code. Represents the physical office or regional hub to which this sales representative is assigned.',
    `sales_organization` STRING COMMENT 'SAP S/4HANA SD sales organization code. Represents the legal entity or business unit responsible for sales transactions executed by this representative.',
    `sfa_user_code` STRING COMMENT 'User identifier in the Sales Force Automation system (Salesforce Consumer Goods Cloud). Used to link mobile app activity, retail execution records, and call reports to this sales representative.',
    `termination_date` DATE COMMENT 'Date the sales representative left the organization or was terminated. Null for active employees. Used for historical sales attribution and territory transition analysis.',
    `vehicle_assigned` BOOLEAN COMMENT 'Indicates whether a company vehicle has been assigned to this sales representative. True for DSD drivers and field sales reps with company cars; false for inside sales and office-based roles.',
    `created_by` STRING COMMENT 'User identifier of the person or system that created this sales representative record. Used for audit trail and data governance.',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'Sales representative master record for field sales, key account management, and inside sales personnel operating within the sales domain. Captures employee ID reference, rep name, rep type (field sales/key account manager/national account manager/inside sales/DSD driver), assigned territory, channel specialization, hire date, active status, SFA user ID, and current quota period. Distinct from the workforce domain employee record — this is the sales-domain operational view of the selling resource.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record. Primary key.',
    `superseded_by_price_list_id` BIGINT COMMENT 'Reference to the newer price list that replaces this one when status is superseded. Enables price list succession tracking and historical pricing analysis.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: In CPG cost-plus and contract-manufacturing pricing, an entire price list is governed by a master supplier contract that sets cost floors. Finance and category management teams need this link to enfor',
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
    `effective_start_date` DATE COMMENT 'Date when the price list becomes valid and active for pricing calculations in sales orders and quotations. Aligns with SAP SD condition record validity period.',
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
    `rsp_flag` BOOLEAN COMMENT 'Indicates whether this price list contains recommended selling prices (RSP) for retail partners. True when prices represent manufacturer-suggested retail pricing guidance.',
    `sales_organization` STRING COMMENT 'SAP SD sales organization code to which this price list applies. Defines the organizational scope for pricing applicability in the sales and distribution structure.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_classification` STRING COMMENT 'Tax category or classification code applicable to prices in this list. Determines tax treatment for products priced under this list in compliance with jurisdictional tax regulations.',
    `trade_class` STRING COMMENT 'Customer trade class or customer pricing group to which this price list applies. Used to segment pricing by customer type such as mass merchandisers, drug stores, grocery chains, convenience stores, or specialty retailers.',
    `version_number` STRING COMMENT 'Sequential version number of the price list. Increments with each revision to support version control and change tracking for pricing history and audit purposes.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this price list record. Required for audit trail and accountability in pricing governance.',
    CONSTRAINT pk_price_list PRIMARY KEY(`price_list_id`)
) COMMENT 'Standard price list master defining list prices, RSP/MSRP, and channel-specific base prices for SKUs across different trade classes and geographies. Contains both header-level metadata (price list code, name, currency, effective dates, channel applicability, type, approval status) and SKU-level price entries (unit price, MOQ, price UoM, effective dates, override flags) for each product in the list. Serves as the pricing baseline from which customer-specific pricing agreements and trade discounts are derived in SAP SD condition records.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` (
    `price_list_item_id` BIGINT COMMENT 'Unique identifier for the price list item record. Primary key for this entity.',
    `price_list_id` BIGINT COMMENT 'Reference to the parent price list that contains this item. Links this SKU-level price entry to its governing price list header.',
    `promoted_price_id` BIGINT COMMENT 'Foreign key linking to promotion.promoted_price. Business justification: Price waterfall analysis (list price → promoted price → net realized price) is a standard revenue management report in consumer goods. Linking price_list_item to promoted_price enables margin impact a',
    `sku_id` BIGINT COMMENT 'Reference to the product (SKU) for which this price is defined. Identifies the specific finished good or SKU being priced.',
    `approval_status` STRING COMMENT 'The approval workflow status for this price list item. Tracks whether the price has been reviewed and approved by pricing management.. Valid values are `draft|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The user ID or name of the person who approved this price list item. Supports audit trail and accountability for pricing decisions.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this price list item was approved. Part of the pricing governance audit trail.',
    `channel_type` STRING COMMENT 'The sales channel or distribution channel for which this price applies (e.g., retail, wholesale, DTC, e-commerce). Enables channel-specific pricing strategies.. Valid values are `retail|wholesale|dtc|ecommerce|foodservice|export`',
    `condition_type` STRING COMMENT 'The SAP SD condition type code that defines the pricing logic for this item (e.g., PR00 for base price, K004 for customer discount). Maps to SAP pricing procedure.',
    `cost_price` DECIMAL(18,2) COMMENT 'The standard cost or COGS for this SKU in the specified currency. Used for margin analysis and profitability calculations. Business-confidential data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this price list item record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all price amounts in this record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment or pricing group for which this price applies (e.g., national accounts, regional chains, independent retailers). Supports segment-based pricing.',
    `distribution_channel` STRING COMMENT 'The SAP distribution channel code for this price list item. Defines the route-to-market for which this price applies.',
    `division` STRING COMMENT 'The SAP division code for this price list item. Represents the product line or business unit responsible for this pricing.',
    `effective_end_date` DATE COMMENT 'The date on which this price list item expires and is no longer valid for new sales transactions. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'The date from which this price list item becomes active and can be used in sales transactions. Part of the items validity period.',
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
    `notes` STRING COMMENT 'Free-text notes or comments about this price list item. Used to document special pricing conditions, exceptions, or business rationale.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this price list item represents a manual override of standard pricing logic. True if this is an exception price.',
    `price_list_item_status` STRING COMMENT 'Current lifecycle status of this price list item. Controls whether the item can be used in pricing calculations.. Valid values are `active|inactive|pending|expired|superseded`',
    `price_uom` STRING COMMENT 'The unit of measure for which the price is quoted (e.g., EA for each, CS for case, PAL for pallet). Aligns with product packaging hierarchy.',
    `pricing_unit_quantity` DECIMAL(18,2) COMMENT 'The quantity of base units represented by one pricing unit. For example, if price is per case and a case contains 12 units, this value is 12.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this price is part of a promotional campaign. True if this is a temporary promotional price rather than standard list price.',
    `rsp_price` DECIMAL(18,2) COMMENT 'The recommended selling price for this SKU in the target market. May differ from MSRP based on regional pricing strategies.',
    `sales_organization` STRING COMMENT 'The SAP sales organization code responsible for this price list item. Aligns with organizational hierarchy and reporting structure.',
    `sap_condition_record_number` STRING COMMENT 'The unique SAP SD condition record number for this price list item. Enables traceability back to the source ERP system.',
    `scale_basis` STRING COMMENT 'The basis for volume-based pricing scales (e.g., quantity, order value, weight, volume). Defines how tiered pricing thresholds are measured.. Valid values are `quantity|value|weight|volume`',
    `scale_quantity_from` DECIMAL(18,2) COMMENT 'The lower bound of the quantity range for which this price applies in a tiered pricing structure. Used for volume discount calculations.',
    `scale_quantity_to` DECIMAL(18,2) COMMENT 'The upper bound of the quantity range for which this price applies in a tiered pricing structure. Null indicates no upper limit for the highest tier.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this price list item record. Supports audit trail and accountability.',
    CONSTRAINT pk_price_list_item PRIMARY KEY(`price_list_item_id`)
) COMMENT 'Individual SKU-level price entry within a price list, capturing the specific list price or MSRP/RSP for a given product in a given channel and currency. Records SKU/GTIN reference, price list reference, unit price, minimum order quantity (MOQ), price unit of measure, effective dates, and override flag. Enables granular SKU-level pricing management and supports SAP SD condition record maintenance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique identifier for this rep-to-account assignment record. Primary key.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to the sales representative assigned to cover this trade account',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to the trade account being covered by this sales representative',
    `assignment_role` STRING COMMENT 'The functional role this sales representative plays for this specific trade account. Primary rep is the main point of contact and quota owner. Secondary rep provides backup coverage. Key account manager handles strategic accounts. National account manager covers enterprise-level relationships. Inside sales support provides remote assistance. DSD driver handles direct store delivery accounts.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this assignment. Active assignments are operational. Inactive assignments are historical. Pending assignments are scheduled for future activation. Suspended assignments are temporarily paused (e.g., during account credit hold or rep leave of absence).',
    `call_frequency_days` STRING COMMENT 'The target number of days between sales calls or visits for this rep-account combination. Used by SFA route planning and call scheduling systems to generate visit plans. Varies by account tier, channel, and rep role (e.g., key accounts may require weekly visits while smaller accounts are monthly).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date when this rep-to-account assignment was terminated or superseded. Null indicates the assignment is currently active. Used for historical reporting and commission reconciliation.',
    `effective_start_date` DATE COMMENT 'The date when this rep-to-account assignment became active. Used for territory history tracking, quota allocation, and commission calculation. Assignments are effective-dated to support territory realignment and rep transitions.',
    `is_primary_rep` BOOLEAN COMMENT 'Indicates whether this rep is the primary/lead representative for this trade account. Used to determine quota ownership, commission splits, and default contact routing in SFA systems. Only one assignment per account should have this flag set to true at any given time.',
    `modified_by` STRING COMMENT 'User identifier of the person or system that last modified this assignment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last modified.',
    `created_by` STRING COMMENT 'User identifier of the person or system that created this assignment record. Typically a sales operations manager or territory management system.',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'This association product represents the operational assignment relationship between sales representatives and trade accounts. It captures the coverage model for field sales territory management, including role-based assignments (primary rep, secondary rep, key account manager), effective date ranges for assignment history, and call planning parameters. Each record links one rep to one trade account with attributes that exist only in the context of this specific assignment.. Existence Justification: In consumer goods field sales operations, sales representatives are assigned to cover multiple trade accounts simultaneously (a field rep may cover 50-200 accounts in their territory), and trade accounts are routinely covered by multiple sales representatives in different roles (e.g., a major grocery chain may have a primary rep, a key account manager, a national account manager, and inside sales support all assigned concurrently). The assignment relationship is actively managed by sales operations teams through territory planning, account reassignment, and coverage optimization processes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ADD CONSTRAINT `fk_sales_trade_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ADD CONSTRAINT `fk_sales_account_contact_reports_to_contact_account_contact_id` FOREIGN KEY (`reports_to_contact_account_contact_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_contact`(`account_contact_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ADD CONSTRAINT `fk_sales_account_contact_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ADD CONSTRAINT `fk_sales_account_contact_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ADD CONSTRAINT `fk_sales_account_address_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_account_address_id` FOREIGN KEY (`account_address_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`account_address`(`account_address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ADD CONSTRAINT `fk_sales_pos_transaction_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`order`(`order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_manager_rep_id` FOREIGN KEY (`manager_rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`territory`(`territory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_superseded_by_price_list_id` FOREIGN KEY (`superseded_by_price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ADD CONSTRAINT `fk_sales_assignment_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ADD CONSTRAINT `fk_sales_assignment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `vibe_consumer_goods_v1`.`sales`.`trade_account`(`trade_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|credit_hold|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'tier_1_national|tier_2_regional|tier_3_local|tier_4_independent');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'retailer|distributor|wholesaler|foodservice_operator|broker');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `acv_total` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Total');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `acv_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `dsd_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `otif_sla_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Service Level Agreement (SLA) Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|edi_payment|credit_card');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `status_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `status_changed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Status Changed By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tax_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `tdp_count` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `trade_channel` SET TAGS ('dbx_business_glossary_term' = 'Trade Channel Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`trade_account` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `account_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Account Contact Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `reports_to_contact_account_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Contact Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `assistant_name` SET TAGS ('dbx_business_glossary_term' = 'Assistant Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_business_glossary_term' = 'Assistant Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_value_regex' = 'primary_buyer|secondary_buyer|decision_maker|influencer|gatekeeper|end_user');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated|transferred');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'buyer|category_manager|logistics_coordinator|finance_contact|marketing_contact|operations_manager');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_business_glossary_term' = 'Phone Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|portal|in_person');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_contact` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` SET TAGS ('dbx_subdomain' = 'account_management');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `dsd_route_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `edi_location_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Location Qualifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`account_address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `account_address_id` SET TAGS ('dbx_business_glossary_term' = 'Account Address Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `acv_weight` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `banner_name` SET TAGS ('dbx_business_glossary_term' = 'Banner Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Store Close Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `dsd_route_code` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `last_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Visit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `next_scheduled_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Visit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Store Open Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `osa_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `otif_sla_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Service Level Agreement (SLA) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `planogram_zone` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `pos_system_type` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) System Type');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`retail_store` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Warehouse Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|distributor');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `division` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Subtotal Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `account_address_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `account_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `account_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Document Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `billing_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|proforma|intercompany|consignment');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Cancellation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|deferred|subscription|service');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`invoice` ALTER COLUMN `trade_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `funding_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Agreement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'standard|volume_tiered|promotional|rebate|contract|spot');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `base_list_price` SET TAGS ('dbx_business_glossary_term' = 'Base List Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `contracted_net_price` SET TAGS ('dbx_business_glossary_term' = 'Contracted Net Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `msrp_price` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `rsp_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `volume_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `volume_threshold_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `volume_threshold_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pricing_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Sale (POS) Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `promoted_price_id` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `acv_flag` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `baseline_sales_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Sales Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'nielsen_iq|iri_circana|retailer_edi|retailer_portal|tradeedge|internal');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `data_source_file_code` SET TAGS ('dbx_business_glossary_term' = 'Data Source File ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^d{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `extended_retail_value` SET TAGS ('dbx_business_glossary_term' = 'Extended Retail Value');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^d{8}$|^d{12}$|^d{13}$|^d{14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `out_of_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `retail_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Retail Selling Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `retailer_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_city` SET TAGS ('dbx_business_glossary_term' = 'Store City');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_country_code` SET TAGS ('dbx_business_glossary_term' = 'Store Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_format` SET TAGS ('dbx_business_glossary_term' = 'Store Format');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_name` SET TAGS ('dbx_business_glossary_term' = 'Store Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Store Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `store_state_province` SET TAGS ('dbx_business_glossary_term' = 'Store State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`pos_transaction` ALTER COLUMN `week_ending_date` SET TAGS ('dbx_business_glossary_term' = 'Week Ending Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Sales Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Product Complaint Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Return Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Return Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `credit_memo_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Issued Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `credit_memo_posted_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Posted Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `credit_memo_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `customer_responsible_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Responsible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instruction');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `division` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `goods_received_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `inspection_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `lot_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `lot_batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `original_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Original Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|not_inspected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_value_regex' = '^RMA-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_type` SET TAGS ('dbx_business_glossary_term' = 'Return Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `return_order_type` SET TAGS ('dbx_value_regex' = 'retail_account_return|distributor_return|dtc_consumer_return|wholesale_return');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`return_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `account_count` SET TAGS ('dbx_business_glossary_term' = 'Account Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `acv_coverage` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Coverage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Quota Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `call_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Call Frequency in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `channel_assignment` SET TAGS ('dbx_business_glossary_term' = 'Channel Assignment');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `district` SET TAGS ('dbx_business_glossary_term' = 'Sales District');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `edi_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capability Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `state_province_list` SET TAGS ('dbx_business_glossary_term' = 'State or Province List');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `tdp_coverage` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Coverage');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'field|key_account|national_account|regional|district|channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `trade_class` SET TAGS ('dbx_business_glossary_term' = 'Trade Class');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`territory` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `manager_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Sales Representative ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `product_category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `badge_number` SET TAGS ('dbx_business_glossary_term' = 'Badge Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `channel_specialization` SET TAGS ('dbx_business_glossary_term' = 'Channel Specialization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `current_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Quota Amount');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|below|new_hire');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `vehicle_assigned` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assigned Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`rep` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `superseded_by_price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price List ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `freight_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Freight Inclusion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `rsp_flag` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `trade_class` SET TAGS ('dbx_business_glossary_term' = 'Trade Class');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `promoted_price_id` SET TAGS ('dbx_business_glossary_term' = 'Promoted Price Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|foodservice|export');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Condition Type');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `cost_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
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
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Override Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `pricing_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pricing Unit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `rsp_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP)');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `sap_condition_record_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Condition Record Number');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `scale_basis` SET TAGS ('dbx_value_regex' = 'quantity|value|weight|volume');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `scale_quantity_from` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity From');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `scale_quantity_to` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity To');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`price_list_item` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` SET TAGS ('dbx_association_edges' = 'sales.rep,sales.trade_account');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Rep Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `call_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Call Frequency in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `is_primary_rep` SET TAGS ('dbx_business_glossary_term' = 'Primary Representative Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`sales`.`assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
