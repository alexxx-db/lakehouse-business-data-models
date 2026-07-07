-- Schema for Domain: customer | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`customer` COMMENT 'SSOT for B2B trade customer and retail account master data. Owns retailer, distributor, wholesaler, and foodservice account profiles, account hierarchies, ACV/TDP metrics, EDI trading partner configurations, VMI agreements, and SLA terms. Distinct from consumer (B2C) — this domain serves the trade channel.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` (
    `channel_classification_id` BIGINT COMMENT 'Unique identifier for the channel classification record. Primary key.',
    `parent_channel_classification_id` BIGINT COMMENT 'Reference to the parent channel classification in a hierarchical taxonomy, enabling multi-level channel rollups. Null for top-level classifications.',
    `trade_account_id` BIGINT COMMENT 'Trade account this channel classification applies to.',
    `active_status` STRING COMMENT 'Current lifecycle status of the channel classification. Active classifications are used for account assignment and reporting; inactive classifications are retained for historical reference.. Valid values are `active|inactive|deprecated|pending`',
    `acv_eligible_flag` BOOLEAN COMMENT 'Indicates whether accounts in this channel are eligible for ACV (All Commodity Volume) measurement and reporting. True if channel participates in syndicated retail measurement services.',
    `applicable_region` STRING COMMENT 'Three-letter ISO country code or regional code indicating the geographic scope where this channel classification applies (e.g., USA, CAN, MEX, EUR).. Valid values are `^[A-Z]{3}$`',
    `channel_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the trade channel. Used as a business key for integration and reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `channel_description` STRING COMMENT 'Detailed description of the channel classification, including business characteristics, typical account types, and operational considerations.',
    `channel_format` STRING COMMENT 'Store or outlet format descriptor providing additional context on the physical or digital format (e.g., superstore, neighborhood market, pure-play online, omnichannel).',
    `channel_name` STRING COMMENT 'Full business name of the trade channel (e.g., Grocery Retail, Mass Merchandise, E-Commerce, Quick Service Restaurant).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel classification record was first created in the system.',
    `distribution_model` STRING COMMENT 'Primary distribution model used for this channel: DSD (Direct Store Delivery), warehouse delivery, hybrid, drop ship, or VMI (Vendor Managed Inventory).. Valid values are `dsd|warehouse|hybrid|drop_ship|vmi`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether accounts in this channel typically support EDI (Electronic Data Interchange) for order processing, invoicing, and inventory management.',
    `effective_end_date` DATE COMMENT 'Date when this channel classification was retired or deprecated. Null for currently active classifications.',
    `effective_start_date` DATE COMMENT 'Date when this channel classification became effective and available for use in account classification and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel classification record was last updated.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from order placement to delivery for accounts in this channel.',
    `market_segment` STRING COMMENT 'Market positioning segment typically served by this channel (premium, mainstream, value, discount).. Valid values are `premium|mainstream|value|discount`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Typical MOQ (Minimum Order Quantity) requirement for accounts in this channel, expressed in cases or units.',
    `order_frequency` STRING COMMENT 'Typical order frequency pattern for accounts in this channel (daily, weekly, biweekly, monthly, on-demand).. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `otif_target_percentage` DECIMAL(18,2) COMMENT 'Target OTIF (On Time In Full) service level percentage for accounts in this channel, typically defined in SLA (Service Level Agreement) terms.',
    `payment_terms_standard` STRING COMMENT 'Standard payment terms typically negotiated with accounts in this channel (e.g., Net 30, Net 60, 2/10 Net 30).',
    `planogram_required_flag` BOOLEAN COMMENT 'Indicates whether accounts in this channel typically require POG (Planogram) compliance for shelf placement and merchandising.',
    `pos_data_available_flag` BOOLEAN COMMENT 'Indicates whether POS (Point of Sale) data is typically available from accounts in this channel for demand sensing and analytics.',
    `pricing_strategy` STRING COMMENT 'Typical pricing strategy employed by accounts in this channel: EDLP (Everyday Low Price), Hi-Lo (High-Low promotional pricing), hybrid, or dynamic pricing.. Valid values are `edlp|hi_lo|hybrid|dynamic`',
    `primary_tier` STRING COMMENT 'Top-level classification of the trade channel. Primary tier segments the market into major channel categories.. Valid values are `retail|foodservice|wholesale|dtc|distributor`',
    `return_policy` STRING COMMENT 'Standard return and unsaleables policy applicable to accounts in this channel (e.g., full credit, partial credit, no returns).',
    `secondary_tier` STRING COMMENT 'Sub-classification within the primary tier providing granular channel segmentation (e.g., grocery, mass, club, drug, convenience, e-commerce, QSR - Quick Service Restaurant, institutional, cash and carry, broker). [ENUM-REF-CANDIDATE: grocery|mass|club|drug|convenience|ecommerce|qsr|institutional|cash_and_carry|broker — 10 candidates stripped; promote to reference product]',
    `sort_order` STRING COMMENT 'Numeric value controlling the display sequence of channel classifications in reports and user interfaces.',
    `tdp_eligible_flag` BOOLEAN COMMENT 'Indicates whether accounts in this channel are eligible for TDP (Total Distribution Points) calculation. True if channel is included in weighted distribution metrics.',
    `tertiary_tier` STRING COMMENT 'Optional third-level classification for highly specialized channel segments or sub-formats within secondary tier (e.g., natural/organic grocery, dollar stores, online marketplace).',
    `trade_promotion_eligible_flag` BOOLEAN COMMENT 'Indicates whether accounts in this channel are eligible for trade promotion programs, TPM (Trade Promotion Management), and promotional funding.',
    CONSTRAINT pk_channel_classification PRIMARY KEY(`channel_classification_id`)
) COMMENT 'Reference taxonomy defining the trade channel hierarchy used to classify trade accounts and retail stores. Captures channel code, channel name, channel tier (primary: retail, foodservice, wholesale, DTC; secondary: grocery, mass, club, drug, convenience, e-commerce, QSR, institutional), channel description, applicable region, and active status. Used as a standardized classification across sales, promotion, and distribution domains.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ADD CONSTRAINT `fk_customer_channel_classification_parent_channel_classification_id` FOREIGN KEY (`parent_channel_classification_id`) REFERENCES `vibe_consumer_goods_v1`.`customer`.`channel_classification`(`channel_classification_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Classification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `parent_channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Channel Classification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `acv_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `applicable_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `channel_format` SET TAGS ('dbx_business_glossary_term' = 'Channel Format');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `distribution_model` SET TAGS ('dbx_business_glossary_term' = 'Distribution Model');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `distribution_model` SET TAGS ('dbx_value_regex' = 'dsd|warehouse|hybrid|drop_ship|vmi');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'premium|mainstream|value|discount');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `order_frequency` SET TAGS ('dbx_business_glossary_term' = 'Order Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `order_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `otif_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `payment_terms_standard` SET TAGS ('dbx_business_glossary_term' = 'Standard Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `planogram_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `pos_data_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Data Available Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'edlp|hi_lo|hybrid|dynamic');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `primary_tier` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `primary_tier` SET TAGS ('dbx_value_regex' = 'retail|foodservice|wholesale|dtc|distributor');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `return_policy` SET TAGS ('dbx_business_glossary_term' = 'Return Policy');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `secondary_tier` SET TAGS ('dbx_business_glossary_term' = 'Secondary Channel Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `tdp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `tertiary_tier` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Channel Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`customer`.`channel_classification` ALTER COLUMN `trade_promotion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Eligible Flag');
